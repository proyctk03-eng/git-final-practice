# [Bài tập] Xây dựng Landing Page - CodeGym Career

Dự án Landing Page hoàn chỉnh cho chương trình đào tạo lập trình viên **CodeGym Career (Coding Bootcamp)** được xây dựng theo phong cách **Material Design** sử dụng thư viện **Bootstrap Material Design (MDBootstrap 4.19.1)** kết hợp với Bootstrap 4.5.0.

---

## 1. Mục tiêu và Yêu cầu bài tập

- **Luyện tập xây dựng trang web hoàn chỉnh**: Phân tích nội dung thực tế từ `https://codegym.vn/codegym-career/`, chuyển dịch bố cục và tái cấu trúc sang ngôn ngữ thiết kế Material Design.
- **Áp dụng thư viện Bootstrap Material Design**: Khai thác tối đa các component đặc trưng của MDBootstrap: Card elevation (`z-depth`), sóng phản hồi xúc giác (`Waves effect`), form nhãn nổi (`md-form floating labels`), hệ thống tab (`md-tabs`), và thanh điều hướng linh hoạt (`scrolling-navbar`).
- **Tối ưu trải nghiệm người dùng (UX/UI)**: Bố cục trực quan, phân cấp thông tin rõ ràng theo quy tắc F-Pattern, màu sắc nhận diện thương hiệu CodeGym và độ tương phản cao đạt chuẩn WCAG.
- **Hỗ trợ Responsive 100%**: Tương thích mượt mà trên mọi kích thước màn hình từ điện thoại di động, máy tính bảng đến màn hình máy tính để bàn.

---

## 2. Công nghệ và Thư viện sử dụng

- **HTML5 & CSS3 & JavaScript (ES6)**
- **Bootstrap Core 4.5.0**: Hệ thống lưới Grid System, tiện ích Flexbox, Spacing, Typography.
- **Material Design for Bootstrap (MDBootstrap 4.19.1)**: Component Material, hiệu ứng đổ bóng `z-depth`, Waves ripple.
- **Font Awesome 5.11.2**: Bộ icon vector chuẩn Material.
- **Google Fonts Roboto (300, 400, 500, 700)**: Phông chữ chuẩn của ngôn ngữ thiết kế Material Design Google.
- **jQuery 3.5.1 & Popper.js 1.14.4**: Xử lý tương tác DOM, hiệu ứng cuộn mượt và kích hoạt component.

---

## 3. Cấu trúc thư mục

```
codegym-career-landing-page/
├── index.html          # Khung giao diện chính tích hợp toàn bộ các khối nội dung
├── css/
│   └── style.css       # Tùy biến bảng màu Material, hiệu ứng nổi bật, responsive
├── js/
│   └── script.js       # Xử lý cuộn mượt mà, kiểm tra hợp lệ form, thanh điều hướng
└── README.md           # Thuyết minh kỹ thuật và hướng dẫn sử dụng
```

---

## 4. Các khối chức năng và Component Material Design

1. **Thanh điều hướng (Navbar)**:
   - Dính trên đầu trang (`fixed-top scrolling-navbar`), tự động thêm đổ bóng khi cuộn trang.
   - Menu liên kết cuộn mượt đến từng phần tương ứng và tự động thu gọn trên thiết bị di động.
2. **Hero Intro Section (Jumbotron Material)**:
   - Khối mở đầu với dải màu gradient công nghệ sâu (`#0d1b2a` đến `#283593`).
   - Tiêu đề nổi bật: *"Trở thành lập trình viên Full-Stack chỉ sau 5 tháng (20 tuần)"*.
   - Khối huy hiệu cam kết vàng: 100% việc làm trong 45 ngày, hoàn 100% học phí, cường độ 70-90h/tuần.
3. **Thanh chỉ số nổi bật (Stats Impact Bar)**:
   - 4 thẻ card đổ bóng `z-depth-2` hiển thị các con số bảo chứng: 100% có việc làm, 20 tuần bứt phá, 70-90h/tuần, mức lương khởi điểm 6 - 12 triệu/tháng.
4. **6 Trụ cột đào tạo thực chiến (6 Pillars Grid)**:
   - Thẻ Material Card đổ bóng với hiệu ứng nâng (`transform: translateY(-6px)`), biểu tượng gradient nổi bật.
   - Nội dung chi tiết: Kỷ luật nhân viên tập sự, cường độ bứt phá, trải nghiệm doanh nghiệp, học qua làm (Pair Programming), giảng viên kèm 1-1 và công nghệ giáo dục hiện đại.
5. **Lộ trình đào tạo Coding Bootcamp (Material Stepper)**:
   - Trục dòng thời gian trực quan phân nhánh 5 giai đoạn: Nền tảng thuật toán -> Lập trình OOP & MySQL -> Backend MVC (Spring/Laravel) -> Dự án Scrum 2 tuần -> Hồ sơ năng lực & Tuyển dụng.
6. **Chương trình đào tạo chuyên sâu (Material Tabs)**:
   - Tab 1: **CGC Java Full-Stack** (Java Core, Spring MVC, Spring Boot, MySQL, RESTful API, Scrum, TDD).
   - Tab 2: **CGC PHP Full-Stack** (PHP Core, Laravel, TypeScript, Angular, UX/UI, RESTful API, Scrum, TDD).
7. **Dịch vụ việc làm & Cam kết hợp đồng**:
   - Khối cam kết hoàn 100% học phí nếu không nhận được việc làm trong 45 ngày.
   - Quy trình 5 bước ứng tuyển: Tinh chỉnh kỹ năng -> Xây dựng CV -> Hoàn tất hồ sơ -> Thuần thục phỏng vấn -> Nhận việc.
8. **Hệ thống phần mềm hỗ trợ đào tạo**:
   - 4 nền tảng số: LMS trực tuyến, Bob Coding Platform (chấm tự động), Agile Project Tracker, E-Portfolio.
9. **Mạng lưới đối tác tuyển dụng & Cảm nhận cựu học viên**:
   - Huy hiệu các tập đoàn công nghệ lớn: Viettel, FPT Software, VNPT, VNPAY, NashTech, Rikkeisoft, CMC Global, TMA Solutions.
   - Câu chuyện thực tế từ cựu học viên chuyển ngành thành công.
10. **Biểu mẫu đăng ký tư vấn & Nhận tài liệu (Material Floating Form)**:
    - Thẻ Card nhãn nổi `.md-form`, tích hợp icon tiền tố.
    - Kiểm tra hợp lệ dữ liệu (Validation) và phép tính bảo mật chống spam `15 + 7 = 22`.
11. **Footer chuẩn Material Design**:
    - Địa chỉ 2 cơ sở (Hà Nội, Đà Nẵng), hotline, email, giấy phép đăng ký hoạt động giáo dục nghề nghiệp.

---

## 5. Hướng dẫn xem trực tiếp và nộp bài

- **Xem trên trình duyệt**: Mở tệp `index.html` trực tiếp bằng trình duyệt (Google Chrome, Microsoft Edge, Firefox).
- **Mã nguồn trên GitHub**:
  - Toàn bộ dự án đã được đồng bộ lên kho lưu trữ GitHub: `https://github.com/proyctk03-eng/git-final-practice` (thư mục `landing-page/`).
