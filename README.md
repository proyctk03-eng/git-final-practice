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

---

## 7. Hướng dẫn mở và kiểm tra trực tiếp

1. **Mở Bài tập Phối màu Newsletter**: Mở file `index.html` tại thư mục gốc.
2. **Mở Landing Page CodeGym Career**: Mở file `landing-page/index.html` trong trình duyệt.
3. **Mở Thực hành Thẻ HTML cơ bản**: Mở file `halong_bay.html` trong trình duyệt.
4. **Mở Thực hành Định dạng văn bản với HTML Styles**: Mở file `text_formatting.html` trong trình duyệt.
5. **Mở Thực hành Tạo danh sách trong HTML**: Mở file `html_lists.html` trong trình duyệt.
6. **Mở Bài tập Sử dụng các thẻ tiêu đề và đoạn văn**: Mở file `headings-paragraphs/index.html` trong trình duyệt.
