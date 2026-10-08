# Bài Tập Thực Hành Thiết Kế Web & UX/UI

> **Khoá học**: Thiết kế Trải nghiệm Người dùng (UX) & Giao diện Người dùng (UI)  
> **Sinh viên thực hiện**: Nguyễn Tuấn Đạt  
> **Kho lưu trữ (Repository)**: `https://github.com/proyctk03-eng/git-final-practice`

---

## Danh mục Bài tập hoàn thành

| STT | Tên bài tập | Thư mục mã nguồn | Công nghệ sử dụng | Trạng thái |
|:---:|---|---|---|:---:|
| 1 | **[Bài tập] Phối màu cho newsletter** | Gốc repository (`./`) | HTML5, CSS3 Variables, Bootstrap 5.3.3, Adobe Color | Hoàn thành |
| 2 | **[Bài tập] Xây dựng Landing Page (CodeGym Career)** | `landing-page/` | Bootstrap Material Design (MDBootstrap 4.19.1), Bootstrap 4.5.0, jQuery, Font Awesome | Hoàn thành |
| 3 | **[Thực hành] Sử dụng thẻ HTML cơ bản** | `halong_bay.html` | HTML5 (`h1`, `p`, `img`, `a`) | Hoàn thành |
| 4 | **[Thực hành] Định dạng văn bản với HTML Styles** | `text_formatting.html` | HTML5, CSS Inline Styles | Hoàn thành |
| 5 | **[Thực hành] Tạo danh sách trong HTML** | `html_lists.html` | HTML5 (`ul`, `ol`, `li`, nested list) | Hoàn thành |
| 6 | **[Bài tập] Sử dụng các thẻ tiêu đề và đoạn văn** | `headings-paragraphs/index.html` | HTML5 (`h1`, `h2`, `p`) | Hoàn thành |
| 7 | **[Bài tập] Sử dụng danh sách trong HTML** | `html-lists-exercise/index.html` | HTML5 (`h1`, `h2`, `ul`, `ol`) | Hoàn thành |
| 8 | **[Bài tập] Tạo liên kết trong HTML** | `html-links-exercise/index.html` | HTML5 (`a`, `target="_blank"`, `mailto:`, internal link) | Hoàn thành |
| 9 | **[Bài tập] Định dạng văn bản với HTML Styles** | `html-styles-exercise/index.html` | HTML5, CSS Inline Styles | Hoàn thành |
| 10 | **[Bài tập] Sử dụng thẻ hình ảnh** | `html-images-exercise/index.html` | HTML5 (`img`, `src`, `alt`, `width`) | Hoàn thành |
| 11 | **[Thực hành] Tạo form cơ bản** | `simpleform.html` / `simpleform/` | HTML5 Form (`form`, `select`, `radio`, `text`, `button`, CSS Font) | Hoàn thành |
| 12 | **[Thực hành] Quản lý đơn đặt hàng** | `erd-order-management/` | Sơ đồ ERD Ký pháp Chen, Mô hình quan hệ 3NF Crow's Foot, SQL DDL | Hoàn thành |
| 13 | **[Thực hành] Tạo bảng trong CSDL** | `sql-create-table-practice/` | SQL DDL (`CREATE DATABASE`, `TABLE`, `ALTER TABLE`), ERD | Hoàn thành |
| 14 | **[Bài tập] Chuyển đổi ERD sang mô hình quan hệ** | `erd-to-relational/` | Ký pháp Chen, Xử lý quan hệ 1-n, n-m, Thuộc tính đa trị, SQL DDL | Hoàn thành |
| 15 | **[Bài tập] Sự Cố Bốc Hơi Lợi Nhuận Tại AutoRide** | `autoride-profit-leak-fix/` | MySQL DDL, ENUM, DECIMAL(12,2), Trigger, ERD, 3NF | Hoàn thành |
| 16 | **[Thực hành] Thêm dữ liệu vào CSDL Quản lý sinh viên** | `sql-student-management-insert-data/` | SQL DML (`INSERT INTO`, Batch Insert, NULL, CURRENT_DATE), ERD | Hoàn thành |
| 17 | **[Bài tập & Thực hành] Truy vấn dữ liệu CSDL Quản lý sinh viên** | `sql-student-management-query/` | SQL DQL & DML (`LIKE`, `MONTH`, `BETWEEN`, `UPDATE`, `ORDER BY`, `JOIN`), ERD | Hoàn thành (100/100) |

---

## 1. Bài tập 1: Phối màu cho newsletter (Trello Sample)

### 1.1. Mục tiêu
Ứng dụng công cụ **Adobe Color** để nghiên cứu và lựa chọn 2 bộ màu sắc hài hòa, sau đó áp dụng vào khung mẫu **Trello Newsletter** trên nền tảng **Bootstrap 5.3.3**.

### 1.2. Hai phiên bản phối màu
- **Phiên bản 1 ("Atlassian Trello Cool Productivity")**:
  - Mã nguồn: `newsletter_v1.html`, `css/style1.css`
  - Bảng màu: Primary `#0065FF`, Secondary `#00A3BF`, Accent `#36B37E`, Text `#172B4D` (WCAG AAA 12.8:1), Canvas `#F4F5F7`.
- **Phiên bản 2 ("Sunset Terracotta & Creative Energy")**:
  - Mã nguồn: `newsletter_v2.html`, `css/style2.css`
  - Bảng màu: Primary `#E65100`, Secondary `#6A1B9A`, Accent `#00897B`, Text `#261C14` (WCAG AAA 13.5:1), Canvas `#FFF8F0`.
- **Trang Hub so sánh**: `index.html` tích hợp bộ chuyển đổi bảng màu trực tiếp và bảng phân tích thông số màu.

---

## 2. Bài tập 2: Xây dựng Landing Page CodeGym Career

### 2.1. Mục tiêu
Chuyển đổi toàn bộ nội dung từ trang chính thức `https://codegym.vn/codegym-career/` sang giao diện chuẩn **Material Design** sử dụng thư viện **Bootstrap Material Design (MDBootstrap 4.19.1)**.

### 2.2. Cấu trúc thư mục (`landing-page/`)
```
landing-page/
├── index.html          # Giao diện Landing Page hoàn chỉnh
├── css/
│   └── style.css       # Tùy biến kiểu dáng Material Design, màu sắc thương hiệu CodeGym
├── js/
│   └── script.js       # Xử lý cuộn mượt, kiểm tra form đăng ký, hiệu ứng navbar
└── README.md           # Thuyết minh kỹ thuật chi tiết
```

### 2.3. Các khối chức năng chuẩn Material Design
1. **Thanh điều hướng (Navbar)**: `fixed-top scrolling-navbar` với menu liên kết cuộn mượt và nút CTA tư vấn.
2. **Hero Intro Section (Jumbotron Material)**: Tiêu đề bứt phá 5 tháng (20 tuần), huy hiệu cam kết việc làm 100% trong 45 ngày hoặc hoàn 100% học phí.
3. **Thanh chỉ số ấn tượng (Stats Impact Bar)**: 4 thẻ card đổ bóng `z-depth-2` minh chứng kết quả đào tạo.
4. **6 Trụ cột đào tạo thực chiến (Material Cards Grid)**: Thẻ card nâng cao (`transform: translateY(-6px)`), icon gradient và hiệu ứng waves.
5. **Lộ trình đào tạo Coding Bootcamp (Material Stepper Timeline)**: Trục dòng thời gian 5 giai đoạn từ số 0 đến lập trình viên full-stack.
6. **Hai khóa học chuyên sâu (Material Tabs System)**: CGC Java Full-Stack và CGC PHP Full-Stack.
7. **Dịch vụ việc làm & Cam kết hợp đồng**: Quy trình 5 bước ứng tuyển nhận việc và cam kết hoàn học phí.
8. **Hệ thống phần mềm hỗ trợ đào tạo**: Nền tảng LMS, Bob chấm code tự động, Agile Scrum Tracker, E-Portfolio.
9. **Mạng lưới đối tác & Lời chứng thực học viên**: Viettel, FPT Software, VNPT, VNPAY, NashTech, Rikkeisoft, CMC Global,...
10. **Form đăng ký tư vấn & Nhận tài liệu (Material Floating Form)**: Nhãn nổi `.md-form`, kiểm tra hợp lệ dữ liệu và câu hỏi bảo mật `15 + 7 = 22`.
11. **Footer chuẩn Material Design**: Đầy đủ thông tin pháp lý, cơ sở Hà Nội, Đà Nẵng, hotline và mạng xã hội.

## 3. Bài tập 3: [Thực hành] Sử dụng thẻ HTML cơ bản (Vịnh Hạ Long)

### 3.1. Mục tiêu
Luyện tập xây dựng tài liệu HTML5 hoàn chỉnh, sử dụng các thẻ HTML cơ bản:
- `<h1>`: Định nghĩa tiêu đề chính của trang.
- `<p>`: Tạo các đoạn văn bản giới thiệu và mô tả.
- `<img>`: Chèn hình ảnh Vịnh Hạ Long kèm các thuộc tính `src`, `alt`, `width="600"`.
- `<a>`: Tạo siêu liên kết dẫn đến trang Wikipedia của Vịnh Hạ Long.

### 3.2. Mã nguồn
- File thực hành: `halong_bay.html`

## 4. Bài tập 4: [Thực hành] Định dạng văn bản với HTML Styles

### 4.1. Mục tiêu
Luyện tập sử dụng các thẻ định dạng văn bản và thuộc tính CSS nội tuyến (inline style):
- Các thẻ định dạng: `<b>` (chữ in đậm), `<i>` (chữ in nghiêng), `<u>` (chữ gạch chân).
- Các thuộc tính CSS nội tuyến (`style`): `color`, `font-size`, `text-align`, `font-family`, `font-weight`.

### 4.2. Mã nguồn
- File thực hành: `text_formatting.html`

## 5. Bài tập 5: [Thực hành] Tạo danh sách trong HTML

### 5.1. Mục tiêu
Luyện tập sử dụng các thẻ danh sách trong HTML:
- `<ul>`: Danh sách không có thứ tự (hiển thị dấu chấm tròn bullet).
- `<ol>`: Danh sách có thứ tự (đánh số tự động 1, 2, 3...).
- `<li>`: Phần tử danh sách.
- Danh sách lồng nhau (Nested List): Kết hợp `<ul>` bên trong `<li>` của `<ol>`.

### 5.2. Mã nguồn
- File thực hành: `html_lists.html`

## 6. Bài tập 6: [Bài tập] Sử dụng các thẻ tiêu đề và đoạn văn

### 6.1. Mục tiêu
Luyện tập sử dụng các thẻ tiêu đề và đoạn văn trong HTML:
- `<h1>`: "Chào mừng đến với trang web của tôi"
- `<h2>`: "Giới thiệu bản thân"
- `<p>` (Đoạn 1): Mô tả sở thích cá nhân.
- `<p>` (Đoạn 2): Mô tả mục tiêu học lập trình.

### 6.2. Mã nguồn
- File thực hành: `headings-paragraphs/index.html`

## 7. Bài tập 7: [Bài tập] Sử dụng danh sách trong HTML

### 7.1. Mục tiêu
Luyện tập sử dụng danh sách có thứ tự (`<ol>`) và danh sách không có thứ tự (`<ul>`):
- `<h1>`: "Những món ăn yêu thích của tôi".
- `<ul>`: Liệt kê 5 món ăn yêu thích.
- `<h2>`: "Các bước chuẩn bị cho một chuyến du lịch".
- `<ol>`: Liệt kê 5 bước chuẩn bị trước khi đi du lịch.

### 7.2. Mã nguồn
- File thực hành: `html-lists-exercise/index.html`

## 8. Bài tập 8: [Bài tập] Tạo liên kết trong HTML

### 8.1. Mục tiêu
Luyện tập sử dụng thẻ liên kết (`<a>`) để điều hướng giữa các trang web:
- `<h1>`: "Liên kết yêu thích của tôi".
- `<ul>`: Chứa 3 liên kết ngoài (Google, GitHub, Wikipedia).
- Mở tab mới: Thuộc tính `target="_blank"`.
- Liên kết nội bộ: Dẫn đến tệp `about.html` trong cùng thư mục.
- Liên kết gửi email: `mailto:proyctk03@gmail.com`.

### 8.2. Mã nguồn
- File thực hành: `html-links-exercise/index.html` và `html-links-exercise/about.html`

## 9. Bài tập 9: [Bài tập] Định dạng văn bản với HTML Styles

### 9.1. Mục tiêu
Luyện tập sử dụng CSS nội tuyến (`style`) để định dạng văn bản trong HTML:
- `<h1>`: "Bài viết của tôi" có màu xanh dương (`color: blue`).
- `<p>` 1: Màu đỏ và in đậm (`color: red; font-weight: bold`).
- `<p>` 2: Chữ in nghiêng và căn giữa (`font-style: italic; text-align: center`).
- `<p>` 3: Cỡ chữ 20px và gạch chân (`font-size: 20px; text-decoration: underline`).

### 9.2. Mã nguồn
- File thực hành: `html-styles-exercise/index.html`

## 10. Bài tập 10: [Bài tập] Sử dụng thẻ hình ảnh

### 10.1. Mục tiêu
Luyện tập sử dụng thẻ hiển thị hình ảnh (`<img>`) trong trang web HTML:
- Sử dụng thẻ `<img>` bên trong `<body>` để hiển thị hình ảnh phong cảnh.
- Chọn hình ảnh độ nét cao với thuộc tính `src`.
- Sử dụng thuộc tính `alt` mô tả hình ảnh đầy đủ ("Phong cảnh núi non hùng vĩ soi bóng xuống mặt hồ nước phẳng lặng").
- Thuộc tính `width="600"` để tối ưu hiển thị.

### 10.2. Mã nguồn
- File thực hành: `html-images-exercise/index.html`

## 11. Bài thực hành 11: [Thực hành] Tạo form cơ bản

### 11.1. Mục tiêu
Luyện tập tạo biểu mẫu (form) trong HTML với các phần tử giao diện cơ bản:
- Thẻ form sử dụng phương thức GET: `<form method="get" action="simpleform.html" class="wufoo">`.
- Định dạng kiểu chữ với CSS lớp `.wufoo`: `font-family: "Lucida Grande", "Lucida Sans Unicode", Tahoma, sans-serif`.
- Thẻ chọn thả xuống (`<select>`, `<option>`) để lựa chọn sản phẩm mua.
- Nút chọn một (`<input type="radio" name="rd">`) để chọn số lượng và mức giá.
- Ô nhập dữ liệu (`<input type="text">`) cho Họ và tên (`firstname`, `lastname`), `email`, `phone` kèm dấu bắt buộc (`*`).
- Nút gửi dữ liệu (`<input type="button" name="btSubmit" value="Submit">`).

### 11.2. Mã nguồn
- File thực hành: `simpleform.html` và `simpleform/index.html`

## 12. Bài thực hành 12: [Thực hành] Quản lý đơn đặt hàng

### 12.1. Mục tiêu
Thiết kế mô hình dữ liệu thực thể liên kết (ERD) và lược đồ cơ sở dữ liệu quan hệ chuẩn hóa 3NF cho bài toán Quản lý đơn đặt hàng và Phiếu giao hàng:
- Phân tích và chọn lọc thuộc tính của Đơn đặt hàng và Phiếu giao hàng.
- Xác định các thực thể: `ĐƠN VỊ KHÁCH`, `NGƯỜI ĐẶT`, `NGƯỜI NHẬN`, `NGƯỜI GIAO`, `NƠI GIAO`, `HÀNG`.
- Xác định các mối quan hệ: `THUỘC` (1 - N), `ĐẶT` (N - N), `GIAO` (N - N - N - N).
- Chuẩn hóa gộp `Đơn vị đặt hàng` và `Đơn vị khách hàng` thành thực thể `ĐƠN VỊ KHÁCH`.
- Chuyển đổi thành mô hình quan hệ 3NF với 10 bảng dữ liệu chuẩn hóa, đầy đủ khóa chính (PK) và khóa ngoại (FK).

### 12.2. Tài liệu và Mã nguồn
- Sơ đồ ERD ký pháp Chen: `erd-order-management/erd_chen_model.png`
- Mô hình quan hệ 3NF Crow's Foot: `erd-order-management/erd_relational_3nf.png`
- Ảnh tổng hợp nộp bài: `erd-order-management/erd_diagram.png`
- Mã nguồn SQL DDL: `erd-order-management/schema.sql`
- Giao diện web trực quan: `erd-order-management/index.html`

## 13. Bài thực hành 13: [Thực hành] Tạo bảng trong CSDL (QuanLyDiemThi)

### 13.1. Mục tiêu
Sử dụng các câu lệnh DDL để khởi tạo và liên kết 4 bảng cơ sở dữ liệu `QuanLyDiemThi`:
- Bảng `HocSinh`: Quản lý thông tin học sinh (`MaHS` [PK], `TenHS`, `NgaySinh`, `Lop`, `GT`).
- Bảng `MonHoc`: Quản lý danh mục môn học (`MaMH` [PK], `TenMH`, `MaGV` [FK]).
- Bảng `BangDiem`: Bảng trung gian giải quyết quan hệ n - n giữa học sinh và môn học (`MaHS` [PK, FK], `MaMH` [PK, FK], `DiemThi`, `NgayKT`).
- Bảng `GiaoVien`: Quản lý thông tin giáo viên phụ trách (`MaGV` [PK], `TenGV`, `SDT`).
- Ràng buộc khóa ngoại liên kết giữa `MonHoc` và `GiaoVien`.

### 13.2. Tài liệu và Mã nguồn
- Kịch bản SQL hoàn chỉnh: `sql-create-table-practice/create_database.sql`
- Sơ đồ quan hệ ERD: `sql-create-table-practice/erd_quanly_diemthi.png`
- Giao diện web trực quan: `sql-create-table-practice/index.html`

## 14. Bài tập 14: [Bài tập] Chuyển đổi ERD sang mô hình quan hệ (Quản lý Vật tư)

### 14.1. Mục tiêu
Thực hiện chuyển đổi toàn diện từ mô hình thực thể kết hợp (ERD) sang lược đồ dữ liệu quan hệ chuẩn 3NF:
- Bước 1: Xác định 5 thực thể chính: `PHIEUXUAT`, `VATTU`, `PHIEUNHAP`, `DONDH`, `NHACC`.
- Bước 2: Chuyển đổi quan hệ 1 - n (`CUNG_CAP` sinh khóa ngoại `MaNCC` trong `DONDH`) và các quan hệ n - m (`XUAT`, `NHAP`, `DAT_HANG` sinh các bảng chi tiết trung gian).
- Bước 3: Tách thuộc tính đa trị `SDT` của `NHACC` thành bảng độc lập `NHACC_SDT(MaNCC, SDT)` để chuẩn hóa về 1NF.
- Bước 4: Liệt kê danh sách 8 bảng quan hệ hoàn chỉnh với đầy đủ khóa chính và khóa ngoại.

### 14.2. Tài liệu và Mã nguồn
- Sơ đồ ERD đầu vào: `erd-to-relational/erd_input_model.png`
- Lược đồ quan hệ sau chuyển đổi: `erd-to-relational/erd_relational_schema.png`
- Ảnh tổng hợp nộp bài: `erd-to-relational/erd_conversion_overview.png`
- Kịch bản SQL DDL: `erd-to-relational/create_tables.sql`
- Giao diện web trực quan: `erd-to-relational/index.html`

## 15. Bài tập 15: [Bài tập] Sự Cố Bốc Hơi Lợi Nhuận Tại AutoRide - Khắc Phục Data Gaps

### 15.1. Mục tiêu
Giải quyết sự cố bốc hơi lợi nhuận do dữ liệu "lệch pha" với UML Activity Diagram:
- Chẩn đoán 4 khoảng trống dữ liệu (Data Gaps) nghiêm trọng trong Legacy Database.
- Tái cấu trúc bảng `Rentals`: Khóa chặt trạng thái bằng `ENUM('BOOKED', 'ACTIVE', 'COMPLETED', 'CANCELLED')`, bổ sung các cột tài chính `security_deposit`, `late_fee`, `damage_fee` với kiểu `DECIMAL(12, 2)` tránh sai số dấu phẩy động.
- Tạo bảng mới `Inspections` (quan hệ 1 - N) lưu vết biên bản kiểm tra xe kèm ràng buộc `ON DELETE RESTRICT`.
- Viết Trigger `BEFORE INSERT` trên `Inspections` chặn lập biên bản khi hợp đồng đang ở trạng thái `BOOKED`.
- Mô phỏng kịch bản thực tế khách "Nguyen Van A" vỡ đèn pha và tính toán quyết toán hoàn cọc chính xác 8.000.000 VNĐ.

### 15.2. Tài liệu và Mã nguồn
- Kịch bản SQL DDL & DML hoàn chỉnh: `autoride-profit-leak-fix/autoride_db.sql`
- Báo cáo đối chiếu nghiệp vụ (< 200 từ): `autoride-profit-leak-fix/er_activity_mapping.md`
- Nhật ký tương tác kỹ thuật AI: `autoride-profit-leak-fix/ai_prompt_log.md`
- Sơ đồ ERD tối ưu hóa: `autoride-profit-leak-fix/erd_autoride.png`
- Giao diện web mô phỏng & máy tính hoàn cọc: `autoride-profit-leak-fix/index.html`
- Thuyết minh chi tiết & trả lời 3 câu hỏi vấn đáp: `autoride-profit-leak-fix/README.md`

## 16. Bài thực hành 16: [Thực hành] Thêm Dữ Liệu Vào CSDL Quản Lý Sinh Viên

### 16.1. Mục tiêu
Thực hành các kỹ thuật chèn dữ liệu bằng câu lệnh `INSERT INTO` vào 4 bảng `Class`, `Student`, `Subject`, `Mark`:
- Chèn dữ liệu theo thứ tự cột mặc định của bảng `Class`.
- Chèn chỉ định cột trong bảng `Student`, xử lý trường `Phone` nhận giá trị `NULL` cho sinh viên 'Hoa'.
- Kỹ thuật Batch Insert chèn đồng thời 4 bản ghi môn học vào bảng `Subject`.
- Chèn bảng điểm `Mark` và kiểm tra toàn vẹn ràng buộc khóa ngoại.
- Thực hiện truy vấn kết hợp `JOIN` giữa 4 bảng để tổng hợp kết quả học tập.

### 16.2. Tài liệu và Mã nguồn
- Kịch bản SQL DDL & DML hoàn chỉnh: `sql-student-management-insert-data/student_management_data.sql`
- Sơ đồ ERD trực quan: `sql-student-management-insert-data/erd_quanly_sinhvien.png`
- Giao diện web tra cứu: `sql-student-management-insert-data/index.html`
- Thuyết minh chi tiết: `sql-student-management-insert-data/README.md`

## 17. Bài tập & Thực hành 17: [Bài tập & Thực hành] Truy Vấn Dữ Liệu Với CSDL Quản Lý Sinh Viên

### 17.1. Mục tiêu & 5 Tiêu chí chấm điểm (100/100 Điểm)
Triển khai toàn diện 5 yêu cầu nghiệp vụ chuyên sâu theo đúng nhận xét và barem đánh giá của giảng viên:
- **Tiêu chí 1 (+20đ)**: Lọc tất cả sinh viên có tên bắt đầu bằng ký tự 'h' bằng toán tử `LIKE 'h%'`.
- **Tiêu chí 2 (+20đ)**: Lọc các lớp học có thời gian bắt đầu vào tháng 12 bằng hàm trích xuất tháng `MONTH(StartDate) = 12`.
- **Tiêu chí 3 (+20đ)**: Lọc các môn học có credit trong khoảng từ 3 đến 5 bằng toán tử xác định khoảng giá trị `BETWEEN 3 AND 5`.
- **Tiêu chí 4 (+20đ)**: Thay đổi mã lớp (ClassId) của sinh viên có tên 'Hung' thành 2 bằng câu lệnh `UPDATE Student SET ClassId = 2 WHERE StudentName = 'Hung';`.
- **Tiêu chí 5 (+20đ)**: Hiển thị các trường `StudentName`, `SubName`, `Mark` từ 3 bảng (JOIN `Student`, `Mark`, `Subject`) sắp xếp giảm dần theo điểm thi và tăng dần theo tên bằng mệnh đề `ORDER BY M.Mark DESC, S.StudentName ASC`.
- Bảo lưu các câu truy vấn thực hành nền tảng (SELECT *, WHERE Status = true, Credit < 10, JOIN học viên lớp A1, JOIN điểm môn CF).

### 17.2. Tài liệu và Mã nguồn
- Kịch bản SQL DDL, DML & DQL hoàn chỉnh: `sql-student-management-query/student_management_query.sql`
- Sơ đồ ERD & luồng JOIN 5 truy vấn trọng tâm: `sql-student-management-query/erd_quanly_sinhvien_queries.png`
- Giao diện web tra cứu & sao chép truy vấn: `sql-student-management-query/index.html`
- Thuyết minh chi tiết & bảng ma trận đối chiếu tiêu chí: `sql-student-management-query/README.md`

---

## 18. Hướng dẫn mở và kiểm tra trực tiếp

1. **Mở Bài tập Phối màu Newsletter**: Mở file `index.html` tại thư mục gốc.
2. **Mở Landing Page CodeGym Career**: Mở file `landing-page/index.html` trong trình duyệt.
3. **Mở Thực hành Thẻ HTML cơ bản**: Mở file `halong_bay.html` trong trình duyệt.
4. **Mở Thực hành Định dạng văn bản với HTML Styles**: Mở file `text_formatting.html` trong trình duyệt.
5. **Mở Thực hành Tạo danh sách trong HTML**: Mở file `html_lists.html` trong trình duyệt.
6. **Mở Bài tập Sử dụng các thẻ tiêu đề và đoạn văn**: Mở file `headings-paragraphs/index.html` trong trình duyệt.
7. **Mở Bài tập Sử dụng danh sách trong HTML**: Mở file `html-lists-exercise/index.html` trong trình duyệt.
8. **Mở Bài tập Tạo liên kết trong HTML**: Mở file `html-links-exercise/index.html` trong trình duyệt.
9. **Mở Bài tập Định dạng văn bản với HTML Styles**: Mở file `html-styles-exercise/index.html` trong trình duyệt.
10. **Mở Bài tập Sử dụng thẻ hình ảnh**: Mở file `html-images-exercise/index.html` trong trình duyệt.
11. **Mở Thực hành Tạo form cơ bản**: Mở file `simpleform.html` hoặc `simpleform/index.html` trong trình duyệt.
12. **Mở Thực hành Quản lý đơn đặt hàng (ERD)**: Mở file `erd-order-management/index.html` trong trình duyệt.
13. **Mở Thực hành Tạo bảng trong CSDL**: Mở file `sql-create-table-practice/index.html` trong trình duyệt.
14. **Mở Bài tập Chuyển đổi ERD sang mô hình quan hệ**: Mở file `erd-to-relational/index.html` trong trình duyệt.
15. **Mở Bài tập Sự cố AutoRide**: Mở file `autoride-profit-leak-fix/index.html` trong trình duyệt.
16. **Mở Thực hành Thêm dữ liệu Quản lý sinh viên**: Mở file `sql-student-management-insert-data/index.html` trong trình duyệt.
17. **Mở Thực hành Truy vấn dữ liệu Quản lý sinh viên**: Mở file `sql-student-management-query/index.html` trong trình duyệt.
