# Nhật Ký Tương Tác Kỹ Thuật Với AI (AI Technical Prompt Log)

**Học viên**: Nguyễn Tuấn Đạt  
**Dự án**: AutoRide - Tối ưu hóa Cơ sở dữ liệu Quản lý Thuê xe  
**Vai trò**: Data Architect  

---

## 1. Phiên tương tác 1: Lựa chọn kiểu dữ liệu tối ưu cho các cột tài chính

### Câu hỏi học viên gửi AI (User Prompt):
> "Trong MySQL, tại sao các cột lưu trữ tiền tệ như `security_deposit`, `late_fee`, `damage_fee` bắt buộc phải sử dụng kiểu dữ liệu `DECIMAL` thay vì `FLOAT` hoặc `DOUBLE`? Nguy cơ tiềm ẩn về sai số làm tròn khi thực hiện phép trừ tiền hoàn cọc là gì?"

### Phản hồi kỹ thuật của AI (AI Response Summary):
- **Bản chất kỹ thuật**: `FLOAT` và `DOUBLE` là các kiểu dữ liệu dấu phẩy động xấp xỉ nhị phân theo chuẩn IEEE 754. Hệ nhị phân không thể biểu diễn chính xác các phân số thập phân (ví dụ: `0.1` hay `0.2`), dẫn đến sai số tích lũy làm tròn không thể kiểm soát (rounding errors).
- **Giải pháp chuẩn hóa**: Kiểu dữ liệu `DECIMAL(M, D)` (Fixed-Point Data Type) lưu trữ dữ liệu dưới dạng chuỗi byte nhị phân chính xác tuyệt đối từng chữ số thập phân.
- **Khuyến nghị kiến trúc**: Sử dụng `DECIMAL(12, 2)` hỗ trợ hạn mức giao dịch lên đến 9.999.999.999,99 VNĐ, bảo đảm tính toàn vẹn 100% cho mọi phép tính cộng trừ quyết toán cọc.

---

## 2. Phiên tương tác 2: Đánh giá quan hệ 1-1 và 1-N cho bảng `Inspections`

### Câu hỏi học viên gửi AI (User Prompt):
> "Tôi đang phân vân giữa việc thiết kế bảng `Inspections` theo quan hệ 1-1 với `Rentals` (mỗi hợp đồng có duy nhất 1 biên bản) hay quan hệ 1-N. Xét theo quy trình thực tế cho thuê xe tự lái, kiến trúc nào tối ưu và mở rộng tốt hơn?"

### Phản hồi kỹ thuật của AI (AI Response Summary):
- **Phân tích thực tế**: Một chu kỳ thuê xe luôn có ít nhất 2 thời điểm kiểm tra: (1) Kiểm tra lúc giao xe cho khách (Check-out inspection) và (2) Kiểm tra lúc nhận lại xe (Check-in return inspection).
- **Hạn chế của quan hệ 1-1**: Nếu dùng 1-1, hệ thống chỉ lưu được tình trạng lúc trả xe mà mất dấu tình trạng xe ban đầu, dẫn đến tranh chấp pháp lý khi khách khẳng định vết xước đã có từ trước.
- **Lợi thế của quan hệ 1-N**: Cho phép ghi nhận nhiều biên bản kiểm tra theo từng mốc thời gian, từng hạng mục kiểm tra độc lập và hỗ trợ nhiều nhân viên giám định khác nhau.
- **Kết luận**: Chọn mô hình `1-N` (`Rentals` 1 --- N `Inspections`) với ràng buộc khóa ngoại `ON DELETE RESTRICT` để bảo toàn lịch sử kiểm toán tài sản.

---

## 3. Phiên tương tác 3: Xử lý giá trị NULL trong biểu thức tính tiền hoàn cọc

### Câu hỏi học viên gửi AI (User Prompt):
> "Khi khách trả xe đúng hạn và không có hư hỏng, các trường `late_fee` hoặc `damage_fee` có thể mang giá trị NULL nếu không có giá trị mặc định. Trong SQL, biểu thức `security_deposit - late_fee - damage_fee` sẽ trả về kết quả gì nếu một trong các trường là NULL? Cách xử lý an toàn nhất?"

### Phản hồi kỹ thuật của AI (AI Response Summary):
- **Bản chất SQL**: Mọi phép toán số học cộng, trừ, nhân, chia với giá trị `NULL` trong SQL đều trả về kết quả `NULL` (`x - NULL = NULL`). Điều này sẽ làm toàn bộ số tiền hoàn lại của khách bị biến thành rỗng.
- **Biện pháp phòng ngừa 2 lớp**:
  1. *Lớp ràng buộc Schema (DDL)*: Khai báo `NOT NULL DEFAULT 0.00` cho tất cả các cột chi phí phạt.
  2. *Lớp truy vấn an toàn (DML)*: Sử dụng hàm `COALESCE()` hoặc `IFNULL()`:
     `SELECT (COALESCE(security_deposit, 0) - COALESCE(late_fee, 0) - COALESCE(damage_fee, 0)) AS refund_amount;`

---

## 4. Phiên tương tác 4: Cơ chế chặn ghi nhận biên bản kiểm tra ở trạng thái BOOKED

### Câu hỏi học viên gửi AI (User Prompt):
> "Làm thế nào để ở tầng Database chặn hoàn toàn hành động thêm dữ liệu vào bảng `Inspections` nếu hợp đồng tại bảng `Rentals` vẫn đang ở trạng thái 'BOOKED' (khách chưa nhận xe)?"

### Phản hồi kỹ thuật của AI (AI Response Summary):
- **Phương án 1 (CHECK Constraint)**: Trong MySQL 8.0.16+, ràng buộc CHECK chỉ kiểm tra được các cột trong cùng 1 bảng, không thể tham chiếu sang bảng khác (Cross-table check).
- **Phương án tối ưu (Trigger BEFORE INSERT)**:
  Sử dụng Trigger kích hoạt trước khi ghi dữ liệu vào bảng `Inspections`:
  - Truy vấn trạng thái `status` của `Rentals` ứng với `NEW.rental_id`.
  - Nếu `status = 'BOOKED'`, thực thi lệnh `SIGNAL SQLSTATE '45000'` kèm thông báo lỗi nghiệp vụ để hủy bỏ giao dịch thêm dữ liệu.
