# Nhật Ký Tương Tác Kỹ Thuật Với AI (AI Prompt Log)

> **Dự án**: Tối ưu hóa Index mạng xã hội QuickFeed  
> **Người thực hiện**: Nguyễn Tuấn Đạt (DBA)  
> **Trợ lý AI**: Storage & Performance Profiler  
> **Mục tiêu**: Nghiên cứu sâu về cấu trúc lưu trữ InnoDB, quản lý Data Pages vs Index Pages, chỉ số Cardinality và cơ chế Query Optimizer trong MySQL.

---

## Prompt 1: Đo Lường Kích Thước Bảng Trong MySQL Bằng MB

### Câu hỏi (Prompt):
> "Trong MySQL, làm thế nào để tôi có thể truy vấn bảng hệ thống `information_schema.TABLES` để xem dung lượng chi tiết của dữ liệu thực (Data Length) và cây chỉ mục (Index Length) của bảng 'Posts' tính theo đơn vị Megabyte (MB)?"

### Phản hồi của AI (Synthesis):
Trong MySQL, hệ quản trị lưu trữ siêu dữ liệu về kích thước bảng trong bảng `TABLES` của CSDL `information_schema`. Các trường `DATA_LENGTH` và `INDEX_LENGTH` được lưu theo đơn vị Byte. Để chuyển đổi sang Megabyte (MB), ta chia cho `(1024 * 1024)` và làm tròn bằng hàm `ROUND()`:

```sql
SELECT 
    TABLE_NAME,
    TABLE_ROWS,
    ROUND(DATA_LENGTH / (1024 * 1024), 4) AS Data_Size_MB,
    ROUND(INDEX_LENGTH / (1024 * 1024), 4) AS Index_Size_MB,
    ROUND((DATA_LENGTH + INDEX_LENGTH) / (1024 * 1024), 4) AS Total_Size_MB,
    ROUND(INDEX_LENGTH / DATA_LENGTH, 2) AS Index_to_Data_Ratio
FROM information_schema.TABLES
WHERE TABLE_SCHEMA = 'quickfeed_db' AND TABLE_NAME = 'Posts';
```

**Ý nghĩa quản trị**:
- Nếu `Index_to_Data_Ratio > 1.0` (nghĩa là dung lượng Index lớn hơn dung lượng Data thực tế), bảng này đang có dấu hiệu rõ rệt của hiện tượng **Over-Indexing** (lạm dụng chỉ mục), gây lãng phí bộ nhớ và nghẽn I/O khi ghi.

---

## Prompt 2: Tác Hại Của Việc Lập Index Trên Cột TEXT Và Cột BOOLEAN

### Câu hỏi (Prompt):
> "Trong MySQL, nếu tôi tạo Index trên một cột chứa văn bản dài (`TEXT`) và một cột kiểu `BOOLEAN` (chỉ có 0 và 1), thì điều này gây hại như thế nào đến bộ nhớ RAM, dung lượng Disk và bộ tối ưu hóa truy vấn (Query Optimizer)?"

### Phản hồi của AI (Synthesis):
1. **Đối với cột `TEXT` (`content(255)`):**
   - **Tốn dung lượng đĩa và RAM**: Mỗi nút lá trong cây B-Tree phải lưu trữ tiền tố 255 byte cộng với con trỏ khóa chính. Với hàng triệu dòng, cây Index này ngốn hàng trăm MB đến hàng GB bộ nhớ.
   - **Gia tăng phân mảnh (Fragmentation)**: Chuỗi ký tự có độ dài biến thiên dẫn đến việc các trang nhớ 16KB của InnoDB nhanh chóng bị đầy và gây ra **Page Split** liên tục khi chèn bài viết mới.
   - **Kém hiệu quả khi tìm kiếm**: B-Tree chỉ hỗ trợ tìm kiếm theo tiền tố khớp từ đầu (`LIKE 'abc%'`). Nó hoàn toàn vô dụng cho việc tìm từ khóa ở giữa đoạn văn (`LIKE '%keyword%'`). Muốn tìm kiếm văn bản, giải pháp chuẩn là sử dụng **FULLTEXT Index**.
2. **Đối với cột `BOOLEAN` (`is_visible`):**
   - **Cardinality cực thấp**: Cột chỉ có 2 giá trị duy nhất (0 và 1). Độ chọn lọc (Selectivity) gần như bằng 0.
   - **Bị Query Optimizer bỏ qua**: Khi lọc `WHERE is_visible = 1`, do đại đa số bài viết là hiển thị, chi phí duyệt Index và tra ngược lại Clustered Index (Bookmark Lookup) tốn kém hơn nhiều so với quét tuần tự toàn bảng. Vì vậy, Optimizer luôn chọn **Full Table Scan**.
   - **Lãng phí chi phí bảo trì**: Mặc dù không bao giờ được dùng để tìm kiếm, mỗi lệnh `INSERT` hoặc `UPDATE is_visible` vẫn bắt buộc hệ thống phải khóa và cập nhật cây B-Tree tương ứng.

---

## Prompt 3: Giải Mã Hiện Tượng Query Optimizer Bỏ Qua Index (Full Table Scan)

### Câu hỏi (Prompt):
> "Tại sao khi tôi truy vấn `SELECT * FROM Posts WHERE is_visible = 1` trên một bảng có hàng triệu dòng (trong đó 95% bài viết là `is_visible = 1`), MySQL lại quyết định quét toàn bảng (Full Table Scan) thay vì sử dụng Index `idx_is_visible` đã tạo?"

### Phản hồi của AI (Synthesis):
Hiện tượng này bắt nguồn từ mô hình tính toán chi phí (Cost-based Optimizer - CBO) của MySQL:
1. **Chi phí khi dùng Secondary Index (`idx_is_visible`):**
   - Bước 1: Quét cây `idx_is_visible` để tìm danh sách các `post_id` thỏa mãn điều kiện `is_visible = 1`. Do 95% dòng thỏa mãn, bước này tìm ra 950,000 khóa chính.
   - Bước 2: Với mỗi khóa trong số 950,000 khóa đó, MySQL phải thực hiện một thao tác đọc đĩa ngẫu nhiên (Random Disk I/O) vào cây Clustered Index để lấy toàn bộ các cột dữ liệu còn lại (`user_id`, `content`, `created_at`,...).
   - Tổng chi phí: `950,000 lần Random I/O` &rarr; Chi phí cực kỳ khổng lồ!
2. **Chi phí khi Quét toàn bảng (Full Table Scan):**
   - MySQL chỉ cần đọc tuần tự từ đầu đến cuối các trang dữ liệu của Clustered Index theo cơ chế **Sequential I/O** kết hợp đọc trước khối (Read-ahead buffer).
   - Đọc tuần tự trên ổ cứng (kể cả SSD) luôn nhanh hơn gấp nhiều lần so với hàng triệu lượt đọc ngẫu nhiên rải rác.
3. **Quy tắc vàng của Optimizer**: Nếu số lượng bản ghi thỏa mãn điều kiện vượt quá ngưỡng **15% đến 20%** tổng số dòng của bảng, MySQL Optimizer sẽ tự động từ chối Secondary Index và chuyển sang quét toàn bộ bảng (`type: ALL`). Do đó, Index trên cột có độ phân giải thấp là hoàn toàn vô giá trị.

---

## Prompt 4: Cấu Trúc Lưu Trữ InnoDB: Data Pages So Với Index Pages

### Câu hỏi (Prompt):
> "Hãy phân tích sâu về cấu trúc lưu trữ nội tại của InnoDB Engine: Cách nó quản lý không gian của Data Pages (Clustered Index) so với Index Pages (Secondary Index), và hiện tượng Page Split gây suy giảm hiệu năng ghi như thế nào?"

### Phản hồi của AI (Synthesis):
Trong kiến trúc InnoDB:
1. **Đơn vị lưu trữ cơ sở là Trang nhớ (Page - 16KB)**: Tất cả bảng và chỉ mục đều được chia thành các trang 16KB.
2. **Clustered Index (Data Pages)**:
   - Dữ liệu thực tế của bảng được lưu trữ trực tiếp trong các nút lá của cây Clustered Index (theo khóa chính `PRIMARY KEY`).
   - Các nút lá này được liên kết đôi (Doubly-linked list) giúp duyệt tuần tự cực nhanh.
3. **Secondary Index (Index Pages)**:
   - Các chỉ mục phụ được tổ chức thành các cây B+Tree riêng biệt.
   - Nút lá của Secondary Index **không chứa toàn bộ dữ liệu hàng**, mà chỉ chứa: `[Secondary Key Value] + [Clustered Key (post_id)]`.
   - Càng tạo nhiều Secondary Index, dung lượng các Index Pages độc lập càng phình to và chiếm dụng không gian trong file `.ibd`.
4. **Hiện tượng Tách trang (Page Split) khi INSERT**:
   - Khi một nút lá trong cây B-Tree đã đầy dung lượng (đạt ngưỡng `PAGE_MERGE_THRESHOLD`, thông thường khoảng 15/16 dung lượng trang) và có một khóa mới cần chèn vào giữa, trang đó không thể chứa thêm.
   - InnoDB buộc phải cấp phát một trang 16KB hoàn toàn mới từ bảng không gian (Tablespace), di chuyển khoảng 50% bản ghi từ trang cũ sang trang mới.
   - Sau đó, con trỏ ở nút cha (Non-leaf node) phải được cập nhật lại.
   - Nếu bảng có 5 Secondary Index, một lần `INSERT` có thể kích hoạt Page Split đồng thời trên 2-3 cây B-Tree khác nhau, gây ra hiện tượng khóa hàng (Locking), bão hòa I/O và treo nghẽn máy chủ.

---

## Prompt 5: Giải Pháp Tìm Kiếm Văn Bản Thay Thế Cho B-Tree Index

### Câu hỏi (Prompt):
> "Nếu muốn tìm kiếm từ khóa bên trong cột `content` (kiểu `TEXT`) mà không bị tốn quá nhiều dung lượng và chậm như B-Tree Index, tôi nên sử dụng cơ chế nào của MySQL?"

### Phản hồi của AI (Synthesis):
Giải pháp tiêu chuẩn công nghiệp là sử dụng **FULLTEXT Index (Chỉ mục toàn văn)**:
1. **Nguyên lý Chỉ mục Đảo (Inverted Index)**:
   - Thay vì lưu nguyên cả đoạn văn 255 ký tự vào cây B-Tree thông thường, FULLTEXT Index phân tích văn bản (Tokenization), tách thành các từ đơn lẻ (Words/Tokens), loại bỏ các từ dừng vô nghĩa (Stopwords như 'là', 'và', 'của') và lập một bảng danh mục đảo ngược: `[Từ khóa] &rarr; [Danh sách các post_id chứa từ đó]`.
2. **Cú pháp triển khai**:
   ```sql
   ALTER TABLE Posts ADD FULLTEXT INDEX ft_idx_content (content);
   ```
3. **Cú pháp truy vấn tối ưu**:
   ```sql
   SELECT * FROM Posts 
   WHERE MATCH(content) AGAINST('CodeGym' IN NATURAL LANGUAGE MODE);
   ```
4. **Lợi ích vượt trội**:
   - Tốc độ tìm kiếm từ khóa bất kỳ ở giữa đoạn văn nhanh gấp hàng chục lần so với toán tử `LIKE '%keyword%'`.
   - Tiết kiệm dung lượng và không làm phình to cấu trúc nhánh của cây B-Tree chính.
