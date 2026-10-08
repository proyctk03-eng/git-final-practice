# Báo Cáo Đánh Giá Hiệu Năng & Chi Phí Lưu Trữ (Index Trade-Off Report)

> **Dự án**: Hệ thống IoT Nhà máy thông minh SmartFactory  
> **Người thực hiện**: Nguyễn Tuấn Đạt (Database Optimization Expert)  
> **Người đánh giá**: Cloud Financial Controller  
> **Cơ sở dữ liệu**: `smartfactory_db` (Bảng `SensorLogs`)  
> **Kho lưu trữ**: `https://github.com/proyctk03-eng/git-final-practice/tree/master/smartfactory-index-tradeoff`

---

## 1. Tóm Tắt Đánh Giá: Sự Đánh Đổi Giữa Read - Write - Storage

Trong hệ thống IoT SmartFactory với 10,000 cảm biến gửi hàng chục nghìn bản ghi mỗi giây, việc kỹ sư cũ tạo ra một "Fat Covering Index" bao trùm toàn bộ các cột `(sensor_id, recorded_at, temperature, humidity, status)` là một sai lầm kiến trúc nghiêm trọng do tối ưu hóa mù quáng cho một truy vấn Dashboard duy nhất.

Mặc dù Covering Index giúp câu lệnh `SELECT` đọc trực tiếp từ bộ nhớ đệm Index mà không cần chạm vào ổ cứng (`Using index`), nhưng nó đã phá hủy hoàn toàn thông lượng Ghi (Write Throughput). Mỗi dòng Index bị nhồi nhét lên tới ~50-55 byte, khiến kích thước cây Index phình to lớn hơn cả bảng dữ liệu gốc, làm hóa đơn SSD trên AWS tăng gấp 4 lần. Nghiêm trọng hơn, do nhiệt độ và độ ẩm liên tục biến động ngẫu nhiên, mỗi lệnh `INSERT` kích hoạt hiện tượng phân mảnh và tách trang (Page Splits) trên cây B-Tree, gây nghẽn I/O khiến Data Pipeline bị rớt dữ liệu (Data Loss).

Tôi quyết định thay thế bằng **Lean Search Index** chỉ gồm 2 cột điều kiện lọc: `(sensor_id, recorded_at)`:
- Chấp nhận sự đánh đổi: Thao tác `SELECT` của Dashboard mất đi trạng thái "Using index" và phải thực hiện Bookmark Lookup vào bảng gốc, làm thời gian đọc tăng thêm khoảng 0.2 mili-giây (hoàn toàn không thể nhận biết bằng mắt thường trên Dashboard).
- Đổi lại: Tốc độ `INSERT` tăng vọt gấp 5 lần, triệt tiêu hoàn toàn lỗi rớt dữ liệu, đồng thời cắt giảm hơn 65% dung lượng Index trên ổ đĩa SSD AWS.

---

## 2. Bảng Tính Toán Dung Lượng Byte & Đối Chiếu Thực Tế

### 2.1. Phân tích kích thước byte của từng trường dữ liệu trong Secondary Index:
- `sensor_id`: Kiểu `INT` = **4 bytes**.
- `recorded_at`: Kiểu `DATETIME` (MySQL 5.6+) = **5 bytes**.
- `temperature`: Kiểu `DECIMAL(5,2)` (3 chữ số nguyên + 2 thập phân) = **3 bytes**.
- `humidity`: Kiểu `DECIMAL(5,2)` = **3 bytes**.
- `status`: Kiểu `VARCHAR(20)` (bộ mã `utf8mb4`) = 1 byte độ dài + trung bình 8 đến 15 bytes = **~16 bytes**.
- `log_id` (Khóa chính Clustered Key tự động gán vào nút lá của Secondary Index): Kiểu `BIGINT` = **8 bytes**.
- Header & B-Tree pointer overhead: **~6 - 8 bytes**.

**So sánh kích thước bản ghi Index trên mỗi dòng:**
- **Fat Covering Index (`idx_fat_covering`)**: `4 + 5 + 3 + 3 + 16 + 8 + 8 = ~47 - 55 bytes / dòng`.
- **Lean Search Index (`idx_lean_search`)**: `4 + 5 + 8 + 6 = ~23 bytes / dòng` (**Tiết kiệm 55% - 60% dung lượng trên mỗi khóa**).

### 2.2. Bảng số liệu đo lường từ `information_schema.TABLES`:

| Chỉ số đo lường (Metrics) | Trước tối ưu (Fat Covering Index) | Sau tối ưu (Lean Search Index) | Chênh lệch & Hiệu quả đạt được |
|---|:---:|:---:|---|
| **Cấu trúc khóa Index** | 5 cột + PK | 2 cột + PK | Cắt bỏ 3 cột payload |
| **Kích thước Data (MB)** | 0.3500 MB | 0.3500 MB | Dữ liệu gốc bảo toàn nguyên vẹn |
| **Kích thước Index (MB)** | 0.5200 MB (Lớn hơn cả Data!) | 0.1600 MB | **Giải phóng 69.2% dung lượng Index** |
| **Tỷ lệ Index / Data** | **1.48** (Bất thường, nguy hiểm) | **0.45** (Chuẩn tối ưu cho IoT) | Giảm áp lực chi phí AWS SSD |
| **Thông lượng ghi (INSERT / sec)** | ~2,500 rows/s (Nghẽn pipeline) | ~12,500+ rows/s | **Tăng tốc độ ghi gấp 5 lần** |
| **Trạng thái Data Pipeline** | Rớt dữ liệu (Data Loss) | Hoạt động ổn định 100% | Triệt tiêu lỗi rớt bản ghi cảm biến |
| **Thời gian truy vấn Dashboard** | 0.05 mili-giây (`Using index`) | 0.25 mili-giây (Table Lookup) | Vẫn đáp ứng xuất sắc trải nghiệm (< 1ms) |

---

## 3. Bảo Vệ Thiết Kế: Trả Lời 3 Câu Hỏi Vấn Đáp Chuyên Sâu (Cloud Financial Controller)

### Câu hỏi 1: Giả sử bảng dữ liệu của chúng ta không phải là IoT lưu liên tục, mà là bảng "Danh mục quốc gia" (Countries) cả năm không ai sửa, thì việc tạo Covering Index có còn là một "tội ác" hay không? Tại sao?

**Trả lời:**
**Không còn là một tội ác, mà ngược lại đó là một thiết kế kiến trúc chuẩn mực và tối ưu tuyệt vời.**
- **Lý do kỹ thuật**:
  - Bảng `Countries` là một bảng danh mục tra cứu (Lookup / Reference Table) có khối lượng dữ liệu tĩnh, số lượng dòng cố định (khoảng hơn 200 quốc gia) và tần suất ghi gần như bằng 0 (Read-mostly / Read-only).
  - Vì không có thao tác `INSERT`, `UPDATE` diễn ra liên tục, **chi phí Write Penalty hoàn toàn bị triệt tiêu**. Hệ thống không phải lo lắng về việc tái cân bằng cây B-Tree hay tách trang (Page Split).
  - Lúc này, một Covering Index (chứa mã quốc gia, tên quốc gia, mã vùng) cho phép mọi truy vấn tìm kiếm lấy 100% dữ liệu trực tiếp trong bộ nhớ đệm RAM mà không bao giờ cần nhảy vào Clustered Index (Bookmark Lookup).
- **Kết luận**: Tính đúng đắn của Covering Index phụ thuộc hoàn toàn vào **tỷ lệ Đọc/Ghi (Read/Write Ratio)**. Với hệ thống 99.9% Đọc như bảng `Countries`, Covering Index là tối ưu; nhưng với hệ thống 99% Ghi như IoT SmartFactory, Covering Index là thảm họa.

---

### Câu hỏi 2: Em hãy giải thích khái niệm "Write Penalty" (Hình phạt khi Ghi) của Index. Tại sao thêm 1 cột vào Index lại làm quá trình INSERT chậm lại?

**Trả lời:**
- **Định nghĩa Write Penalty**: Write Penalty là cái giá đánh đổi về tài nguyên I/O đĩa, bộ nhớ và chu kỳ CPU mà cơ sở dữ liệu phải gánh chịu cho mỗi thao tác thay đổi dữ liệu (`INSERT`, `UPDATE`, `DELETE`) để duy trì tính toàn vẹn và thứ tự của các cây chỉ mục B-Tree.
- **Tại sao thêm 1 cột vào Index lại làm quá trình `INSERT` chậm lại?**:
  1. **Tăng kích thước bản ghi (Row Size Inflation)**: Thêm 1 cột làm kích thước mỗi nút lá trong cây B-Tree tăng lên. Với kích thước trang nhớ cố định là 16KB trong InnoDB, số lượng bản ghi nhét vừa trong một trang sẽ bị sụt giảm.
  2. **Gia tăng tần suất Tách trang (Page Split)**: Khi số lượng bản ghi trên mỗi trang giảm đi, trang nhớ sẽ nhanh chóng bị đầy hơn khi chèn dữ liệu mới. InnoDB buộc phải thực hiện thao tác tách trang (Page Split), cấp phát khối đĩa mới và điều chỉnh con trỏ của các nút cha.
  3. **Làm mất tính tuần tự khi chèn**: Nếu chỉ đánh index trên `(sensor_id, recorded_at)`, dữ liệu cảm biến đến theo dòng thời gian tăng dần, thao tác chèn diễn ra tuần tự ở mép phải của nhánh cây (Right-edge appends, chi phí rất thấp). Nhưng khi thêm các cột biến động liên tục như `temperature` và `humidity`, giá trị khóa ghép trở nên ngẫu nhiên, buộc MySQL phải dò và chèn vào giữa các trang ngẫu nhiên (Random Disk Writes), gây ra khóa trang (Page Locks) và làm suy giảm tốc độ ghi nghiêm trọng.

---

### Câu hỏi 3: Để tối ưu ổ cứng, có người đề xuất thay thế `VARCHAR(20)` của cột `status` thành `TINYINT`. Theo em việc này tác động thế nào đến Data Length và Index Length nếu ta lỡ đưa nó vào Index?

**Trả lời:**
- **Tác động đến Data Length (Bảng dữ liệu gốc)**:
  - Cột `status VARCHAR(20)` sử dụng bộ mã `utf8mb4` tiêu tốn 1 byte để lưu độ dài chuỗi và từ 6 đến 8 bytes cho các chuỗi như `'NORMAL'`, `'WARNING'`.
  - Nếu chuyển sang `TINYINT` (ví dụ: `1 = NORMAL`, `2 = WARNING`, `3 = CRITICAL`), dung lượng lưu trữ cố định chỉ tốn đúng **1 byte**.
  - Kết quả: `Data_Length` sẽ tiết kiệm được từ 6 đến 8 bytes trên mỗi dòng dữ liệu.
- **Tác động đến Index Length (Nếu lỡ đưa vào Index)**:
  - Nút lá của Index cũng sẽ tiết kiệm được 6 đến 8 bytes trên mỗi khóa con.
  - Tuy nhiên, trong bài toán hệ thống IoT SmartFactory với hàng tỷ dòng, việc giảm vài bytes cho cột `status` chỉ là giải pháp "chữa cháy bề mặt".
- **Lời khuyên của chuyên gia DBA**:
  - Dù có chuyển thành `TINYINT`, cột `status` bản chất chỉ có 3 trạng thái phân biệt (Cardinality cực thấp, tương tự trường hợp `post_type` của QuickFeed). Cột này không bao giờ được sử dụng hiệu quả trong B-Tree tìm kiếm phạm vi thời gian.
  - Giải pháp kiến trúc đúng đắn nhất **không phải là đổi kiểu dữ liệu rồi nhét vào Index**, mà là **loại bỏ hoàn toàn cột status ra khỏi cây Index**, chỉ giữ lại cặp khóa tinh gọn `(sensor_id, recorded_at)`.
