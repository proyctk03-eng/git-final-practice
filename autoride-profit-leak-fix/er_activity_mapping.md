# Đối Chiếu UML Activity Diagram & ERD: Vai Trò Cột `damage_fee`

Trong lưu đồ hoạt động (UML Activity Diagram) trả xe của AutoRide, khi xe bị trầy xước hoặc hư hỏng, hệ thống bắt buộc phải tính phí sửa chữa. Cột `damage_fee` trong bảng `Rentals` là trường dữ liệu thiết yếu để bảo đảm toàn vẹn hệ thống vì hai lý do:

1. **Khép kín luồng nghiệp vụ**: `damage_fee` là điểm chốt tài chính liên kết biên bản hiện trường (`Inspections`) với công thức hoàn tiền (`Hoàn lại = Cọc - Phí trễ - Phí sửa chữa`). Thiếu cột này gây ra đứt gãy dữ liệu (Data Gap), khiến hệ thống phải hoàn 100% tiền cọc dù xe hư hỏng, trực tiếp làm doanh nghiệp bốc hơi lợi nhuận.

2. **Minh bạch kiểm toán kế toán**: Cột này số hóa khoản bồi thường tức thời, chấm dứt ghi chép sổ tay, ngăn chặn thất thoát nội bộ và cung cấp căn cứ khấu trừ rõ ràng cho khách hàng.
