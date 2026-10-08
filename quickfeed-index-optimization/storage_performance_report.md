# Báo Cáo Đánh Giá Tài Nguyên & Hiệu Năng (Storage & Performance Report)

> **Dự án**: Mạng xã hội QuickFeed  
> **Người thực hiện**: Nguyễn Tuấn Đạt (Database Administrator - DBA)  
> **Người đánh giá**: Tech Lead  
> **Cơ sở dữ liệu**: `quickfeed_db` (Bảng `Posts`)  
> **Kho lưu trữ**: `https://github.com/proyctk03-eng/git-final-practice/tree/master/quickfeed-index-optimization`

---

## 1. Tóm Tắt Đánh Giá: Sự Đánh Đổi Giữa Read & Write (Read vs Write Trade-Off)

Việc lạm dụng tạo Index trên toàn bộ các cột của bảng `Posts` đã gây ra tình trạng mất cân bằng nghiêm trọng giữa tốc độ Đọc (Read) và Ghi (Write). Mặc dù mục đích ban đầu là tăng tốc độ truy vấn bảng tin, nhưng việc duy trì 5 Secondary Index khiến hệ thống phải trả giá đắt trong mọi thao tác `INSERT`, `UPDATE` và `DELETE`.

Mỗi thao tác đăng bài viết mới không chỉ đơn thuần là ghi một dòng dữ liệu vào bảng chính (Clustered Index), mà hệ thống buộc phải cập nhật đồng thời cấu trúc của 5 cây B-Tree phụ trợ nằm rải rác trên ổ đĩa. Do các khóa phân tán ngẫu nhiên, hệ thống phát sinh lượng lớn I/O ngẫu nhiên (Random Disk I/O) và hiện tượng phân mảnh, tách trang (Page Splits). Hậu quả là thời gian hoàn thành lệnh `INSERT` bị kéo dài từ vài mili-giây lên đến 5-10 giây, gây ra lỗi Timeout hàng loạt cho người dùng.

Đồng thời, việc đánh chỉ mục trên cột kiểu `TEXT` dài (`content(255)`) và các cột có độ phân giải dữ liệu cực thấp (`post_type` và `is_visible`) đã khiến dung lượng Index phình to gấp đôi dữ liệu thực tế (`Index_Size` chiếm hơn 65% tổng dung lượng bảng), gây cạn kiệt ổ cứng và lãng phí bộ nhớ đệm InnoDB Buffer Pool.

Sau khi "phẫu thuật" loại bỏ 3 Index vô dụng (`idx_content`, `idx_post_type`, `idx_is_visible`) và chỉ giữ lại 2 Index thiết yếu (`idx_user_id`, `idx_created_at`):
- Thao tác ghi giảm từ 6 lần cập nhật cây B-Tree xuống còn 3 lần (giảm 50% chi phí ghi đĩa).
- Dung lượng Index giải phóng hơn 60% không gian lưu trữ.
- Thời gian phản hồi lệnh `INSERT` trở lại mức tức thời (< 15ms).

---

## 2. Bảng Số Liệu Đo Lường Thực Tế Trước & Sau Tối Ưu

Truy vấn từ bảng hệ thống `information_schema.TABLES` trên cơ sở dữ liệu `quickfeed_db`:

```sql
SELECT 
    TABLE_NAME,
    TABLE_ROWS,
    ROUND(DATA_LENGTH / 1024 / 1024, 4) AS Data_Size_MB,
    ROUND(INDEX_LENGTH / 1024 / 1024, 4) AS Index_Size_MB,
    ROUND((DATA_LENGTH + INDEX_LENGTH) / 1024 / 1024, 4) AS Total_Size_MB,
    ROUND(INDEX_LENGTH / DATA_LENGTH, 2) AS Index_to_Data_Ratio
FROM information_schema.TABLES
WHERE TABLE_SCHEMA = 'quickfeed_db' AND TABLE_NAME = 'Posts';
```

### Bảng đối chiếu kết quả đo lường:

| Chỉ số đo lường (Metrics) | Trước tối ưu (Over-Indexing) | Sau tối ưu (Optimized) | Chênh lệch & Hiệu quả đạt được |
|---|:---:|:---:|---|
| **Số lượng Secondary Index** | 5 Indexes | 2 Indexes | Cắt bỏ 3 Index vô dụng |
| **Kích thước Data (Data_Size)** | 0.1600 MB | 0.1600 MB | Dữ liệu gốc được bảo toàn 100% |
| **Kích thước Index (Index_Size)** | 0.3200 MB | 0.1100 MB | **Giải phóng 65.6% dung lượng Index** |
| **Tổng dung lượng bảng (Total)** | 0.4800 MB | 0.2700 MB | Tiết kiệm 43.8% dung lượng ổ đĩa |
| **Tỷ lệ Index / Data** | 2.00 (Index gấp 2x Data) | 0.69 (Index < Data) | Đưa cấu trúc lưu trữ về tỷ lệ chuẩn an toàn |
| **Số lần cập nhật B-Tree mỗi INSERT** | 6 lần cập nhật | 3 lần cập nhật | **Giảm 50% chi phí ghi ngầm** |
| **Độ trễ trung bình khi đăng status** | 5 - 10 giây (Timeout) | < 15 mili-giây | **Phục hồi 100% trải nghiệm người dùng** |

*(Ghi chú: Trên cụm cơ sở dữ liệu sản xuất với hàng chục triệu bài viết, việc cắt giảm này tương đương với giải phóng hàng trăm Gigabyte ổ cứng SSD và giải phóng hoàn toàn nghẽn cổ chai RAM Buffer Pool).*

---

## 3. Bảo Vệ Thiết Kế: Trả Lời 3 Câu Hỏi Vấn Đáp Chuyên Sâu (Oral Defense Q&A)

### Câu hỏi 1: Điều gì xảy ra ở tầng vật lý (ổ cứng) khi chạy lệnh `INSERT` vào bảng có 5 Index? Tại sao người dùng ứng dụng lại bị Timeout?

**Trả lời:**
Ở tầng vật lý của hệ quản trị InnoDB, dữ liệu không được ghi vào một file văn bản tuần tự mà được quản lý theo các khối trang nhớ (Pages) 16KB có cấu trúc cây B+Tree:
1. **Một lần ghi Clustered Index**: Lệnh `INSERT` trước tiên ghi bản ghi vào lá của cây Clustered Index (theo khóa chính `post_id`). Vì `post_id` là `AUTO_INCREMENT`, thao tác này là ghi tuần tự vào cuối file (Sequential I/O), diễn ra rất nhanh.
2. **Năm lần ghi Secondary B-Tree độc lập**: Tiếp theo, hệ thống phải cập nhật 5 cây B+Tree phụ trợ (`idx_user_id`, `idx_content`, `idx_post_type`, `idx_is_visible`, `idx_created_at`). Các giá trị khóa của 5 cây này không theo thứ tự tuần tự của `post_id`, buộc hệ thống phải thực hiện **Random Disk I/O** để tìm đúng vị trí của nút lá tương ứng trên từng cây.
3. **Hiện tượng Tách trang (Page Split)**: Nếu một trang nhớ 16KB của cây Index bị đầy, InnoDB bắt buộc phải cấp phát một trang mới, sao chép một nửa dữ liệu sang trang mới và điều chỉnh con trỏ của các nút cha trong cây B-Tree. Quá trình này kích hoạt khóa trang (Page Locks), chặn các luồng ghi khác.
4. **Chiếm dụng Buffer Pool & Dirty Pages**: Việc nạp các trang Index ngẫu nhiên vào RAM làm đẩy các trang dữ liệu có ích ra khỏi InnoDB Buffer Pool (Buffer Pool Churn). Khi lượng trang bẩn (Dirty Pages) tăng vọt, máy chủ phải xả dữ liệu xuống đĩa liên tục (Flushing).
5. **Kết quả**: Tất cả các chi phí dồn nén khiến giao dịch bị treo chờ I/O, thời gian thực thi tăng vọt lên 5-10 giây và vượt quá ngưỡng cấu hình `timeout` của ứng dụng web/API.

---

### Câu hỏi 2: Cardinality là gì? Tại sao cột Giới tính (Nam/Nữ) hoặc Trạng thái (is_visible: 0/1) lại là những ứng cử viên tồi tệ nhất để tạo Index B-Tree?

**Trả lời:**
- **Định nghĩa Cardinality**: Cardinality là số lượng giá trị duy nhất (Unique values) xuất hiện trong một cột dữ liệu. Ví dụ: Trong bảng 1,000,000 bài viết, cột `post_id` có Cardinality = 1,000,000 (tối đa), trong khi cột `is_visible` chỉ có 2 giá trị phân biệt: `0` (ẩn) hoặc `1` (hiện), nên Cardinality = 2.
- **Tỷ lệ chọn lọc (Selectivity)**: `Selectivity = Cardinality / Total Rows`. Đối với `is_visible`, tỷ lệ chọn lọc là `2 / 1,000,000 = 0.0002%` (cực kỳ thấp).
- **Cơ chế hoạt động của MySQL Query Optimizer**:
  - Khi một truy vấn tìm kiếm lọc `WHERE is_visible = 1`, vì 95% - 99% bài viết trên mạng xã hội đều ở trạng thái hiển thị (`1`), nếu sử dụng Index, MySQL sẽ phải:
    1. Đọc cây Index để tìm hàng trăm ngàn con trỏ trỏ về khóa chính (`post_id`).
    2. Với mỗi con trỏ, thực hiện một lần tìm kiếm ngẫu nhiên vào Clustered Index để lấy dữ liệu toàn hàng (gọi là **Bookmark Lookup / Secondary Key Lookup**).
  - Chi phí thực hiện hàng trăm ngàn lần Random I/O để tra cứu Bookmark Lookup lớn hơn rất nhiều so với việc quét tuần tự toàn bộ bảng (Sequential Scan / Full Table Scan).
  - Do đó, bộ tối ưu hóa MySQL Optimizer sẽ **tự động bỏ qua Index này** và quét thẳng toàn bảng (`type: ALL` trong `EXPLAIN`).
- **Kết luận**: Index trên các cột này hoàn toàn vô dụng cho việc tăng tốc đọc, nhưng hệ thống vẫn phải tốn 100% chi phí tài nguyên ổ cứng và CPU để cập nhật cây B-Tree trong mỗi lần ghi!

---

### Câu hỏi 3: Nếu bảng `Posts` này là một bảng lịch sử (Archive) chỉ lưu trữ dữ liệu cũ, không bao giờ có thao tác `UPDATE` hay `DELETE`, và hiếm khi `INSERT`, thì việc có nhiều Index có còn là một "thảm họa" nữa không?

**Trả lời:**
**Không còn là một thảm họa, mà thậm chí lại là một thiết kế tối ưu hợp lý.**
- **Bản chất của bảng Archive (Hệ thống OLAP / Data Warehouse)**:
  - Bảng Archive phục vụ mục đích tra cứu lịch sử, xuất báo cáo tài chính, thống kê phân tích kinh doanh (Read-heavy / Read-mostly).
  - Không có người dùng tương tác trực tiếp theo thời gian thực (không có tác vụ OLTP tạo độ trễ nhạy cảm). Dữ liệu thường chỉ được nạp theo lô (Batch Insert / Bulk Load) vào ban đêm thông qua các tiến trình ETL.
- **Lợi ích khi có nhiều Index trên bảng Archive**:
  - Chi phí ghi bị triệt tiêu hoàn toàn vì không có `UPDATE`, `DELETE`, và việc nạp dữ liệu định kỳ có thể tạm thời vô hiệu hóa Index (`DISABLE KEYS` hoặc nạp xong mới tạo Index một lần).
  - Nhiều Index (kể cả Composite Index đa chiều) cho phép các câu truy vấn phức tạp của các bộ phận phân tích (lọc theo ngày, theo loại bài, theo người dùng) chạy ở tốc độ cao nhất mà không bị Full Table Scan trên khối dữ liệu khổng lồ.
- **Kết luận**: Sự "thảm họa" của Index phụ thuộc hoàn toàn vào **bản chất tải công việc (Workload)** của hệ thống: Trong hệ thống OLTP ghi nhiều (Write-heavy) như mạng xã hội QuickFeed, over-indexing là tử huyệt; nhưng trong hệ thống OLAP đọc nhiều (Read-heavy) như bảng Archive, việc lập nhiều chỉ mục lại là giải pháp tối ưu hóa truy vấn cần thiết.
