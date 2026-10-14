# Báo Cáo Thực Hành: "Nâng Cấp" Trang "About Me" Với Các Thẻ Semantic HTML

## 1. Giới Thiệu & Mục Tiêu Đạt Được
- [x] Phân tích cấu trúc phân cấp và các vùng logic của một trang web (Header, Main, Section, Footer).
- [x] Áp dụng chuẩn Semantic HTML5 với các thẻ ngữ nghĩa: `<header>`, `<main>`, `<section>`, `<footer>`.
- [x] Tái cấu trúc (refactoring) mã nguồn giúp tăng khả năng đọc hiểu, khả năng bảo trì và hỗ trợ SEO.
- [x] Hiểu rõ bản chất: Semantic HTML tối ưu hóa cấu trúc và ý nghĩa logic của tài liệu "dưới mui xe", không phá vỡ hay làm biến dạng giao diện hiển thị thị giác.

---

## 2. Ghi Chú Kiến Thức Cốt Lõi (Nội Dung Nộp Bài Thực Hành)

### 2.1. Phân tích cấu trúc phân cấp tài liệu (Document Outline)

```text
<body>
├── <header>                      # Khu vực đầu trang
│   ├── <h1>Nguyễn Thị Bê</h1>    # Tiêu đề chính duy nhất
│   └── <img class="avatar">      # Ảnh đại diện cá nhân
├── <main>                        # Vùng nội dung trọng tâm của trang
│   ├── <section>                 # Phần 1: Giới thiệu bản thân (h2 + p)
│   ├── <section>                 # Phần 2: Sở thích cá nhân (h2 + ul)
│   └── <section>                 # Phần 3: Kết nối mạng xã hội (h2 + ul)
└── <footer>                      # Chân trang chứa bản quyền (&copy;)
```

### 2.2. Ý nghĩa và Lợi ích của các thẻ Semantic HTML

| Thẻ Semantic | Ý Nghĩa Ngữ Nghĩa | Lợi Ích Cụ Thể |
| :--- | :--- | :--- |
| `<header>` | Đại diện cho phần mở đầu, tiêu đề trang hoặc nhóm điều hướng giới thiệu. | Giúp các công nghệ trợ thính (Screen Reader) nhận diện ngay đây là phần đầu tài liệu. |
| `<main>` | Chứa nội dung chính, độc nhất của trang (mỗi tài liệu chỉ có duy nhất một `<main>`). | Cho phép người dùng khiếm thị dùng phím tắt nhảy thẳng đến nội dung chính (Skip to content). |
| `<section>` | Phân chia tài liệu thành các khối chủ đề độc lập có liên kết logic. | Giúp thuật toán tìm kiếm (Google, Bing) lập chỉ mục (indexing) từng đoạn nội dung chính xác hơn. |
| `<footer>` | Đại diện cho phần kết thúc của trang hoặc phần tử chứa thông tin tác giả, bản quyền, liên hệ. | Chuẩn hóa thông tin bản quyền và liên hệ cuối trang. |

---

## 3. Cấu Trúc Mã Nguồn Hoàn Chỉnh (`index.html`)

```html
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Trang About Me - Cấu Trúc Semantic HTML</title>
</head>
<body>
    <div class="container">
        <!-- Khu vực đầu trang: Tên và Ảnh đại diện -->
        <header>
            <h1>Nguyễn Thị Bê</h1>
            <img class="avatar" src="images/avatar.jpg" alt="Ảnh chân dung của Nguyễn Thị Bê" width="200">
        </header>

        <!-- Nội dung chính của trang web -->
        <main>
            <!-- Phần 1: Giới thiệu bản thân -->
            <section>
                <h2>Giới thiệu bản thân</h2>
                <p>
                    Xin chào! Tôi là một <strong>lập trình viên</strong> đang trên hành trình học hỏi về thế giới phát triển web. Tôi có niềm đam mê với công nghệ và thích tạo ra những sản phẩm <em>đẹp mắt</em> và hữu ích.
                </p>
            </section>

            <!-- Phần 2: Sở thích cá nhân -->
            <section>
                <h2>Sở thích</h2>
                <ul>
                    <li>Đọc sách khoa học viễn tưởng</li>
                    <li>Chơi cờ vua</li>
                    <li>Đi bộ đường dài</li>
                </ul>
            </section>

            <!-- Phần 3: Kết nối mạng xã hội -->
            <section>
                <h2>Kết nối với tôi</h2>
                <ul>
                    <li>
                        <a href="https://www.facebook.com/your-username" target="_blank" rel="noopener noreferrer">Facebook</a>
                    </li>
                    <li>
                        <a href="https://www.linkedin.com/in/your-username" target="_blank" rel="noopener noreferrer">LinkedIn</a>
                    </li>
                    <li>
                        <a href="https://github.com/proyctk03-eng" target="_blank" rel="noopener noreferrer">Github</a>
                    </li>
                </ul>
            </section>
        </main>

        <!-- Chân trang: Thông tin bản quyền -->
        <footer>
            <p>&copy; 2025 Nguyễn Thị Bê. Bảo lưu mọi quyền.</p>
        </footer>
    </div>
</body>
</html>
```

---

## 4. Ghi Chú Kinh Nghiệm Sau Khi Tái Cấu Trúc
1. **So sánh trước và sau khi refactor:** Giao diện trực quan trên Live Server hoàn toàn không bị xáo trộn, nhưng cấu trúc cây DOM trong tab `Elements` của DevTools trở nên rõ ràng, sạch sẽ và chuyên nghiệp hơn rất nhiều.
2. **Ký tự thực thể HTML (`&copy;`):** Dùng `&copy;` để hiển thị ký tự bản quyền `©` một cách chuẩn hóa trên mọi bảng mã trình duyệt mà không sợ lỗi font.
3. **Tính mở rộng:** Khi cần thêm thanh điều hướng `<nav>` hoặc thanh bên `<aside>`, ta có thể tích hợp mượt mà vào cấu trúc Semantic đã được thiết lập sẵn.
