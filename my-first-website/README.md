# Báo Cáo Thực Hành: Tạo và liên kết file style.css đầu tiên của bạn

> Khóa học: Thiết Kế Web & Lập Trình Cơ Bản (Module 1 - CodeGym)  
> Sinh viên thực hiện: Nguyễn Tuấn Đạt  
> Email: proyctk03@gmail.com  
> Repository: `https://github.com/proyctk03-eng/git-final-practice`  
> Thư mục dự án: `my-first-website/`  

---

## 1. Mục tiêu bài thực hành

1. Tạo một tệp CSS bên ngoài độc lập: `style.css`.
2. Sử dụng thẻ `<link>` trong phần `<head>` để thiết lập "cầu nối" liên kết tệp CSS đó vào tệp `index.html`.
3. Viết quy tắc CSS đầu tiên (`body { background-color: #f0f8ff; }`) để kiểm tra liên kết thành công với màu xanh nhạt AliceBlue.
4. Nắm vững phương pháp **External CSS (CSS ngoài)** – phương pháp chuẩn mực công nghiệp giúp phân tách rành mạch cấu trúc nội dung (HTML) và phong cách trình bày (CSS).

---

## 2. Bảng kiểm tra thực hiện (Checklist)

| Bước | Nhiệm vụ thực hiện | Tệp tin tác động | Kết quả đạt được |
| :---: | :--- | :--- | :--- |
| **1** | Mở thư mục dự án `my-first-website` | Thư mục gốc | Sẵn sàng không gian làm việc |
| **2** | Tạo tệp CSS mới ngang hàng với `index.html` | `style.css` | Tệp định dạng chuẩn theo quy ước |
| **3** | Viết quy tắc CSS đổi màu nền toàn trang | `style.css` | `body { background-color: #f0f8ff; }` |
| **4** | Thêm thẻ `<link>` vào thẻ `<head>` của HTML | `index.html` | `<link rel="stylesheet" href="style.css">` |
| **5** | Kiểm tra hiển thị với Live Server | Trình duyệt web | Toàn bộ trang web nhận nền xanh nhạt AliceBlue |

---

## 3. Cấu trúc thư mục dự án

```
my-first-website/
├── index.html          # Cấu trúc nội dung ngữ nghĩa HTML5
├── style.css           # Bảng phong cách External CSS
├── README.md           # Báo cáo thực hành & hướng dẫn chi tiết
└── images/
    └── avatar.jpg      # Ảnh chân dung đại diện
```

---

## 4. Chi tiết mã nguồn triển khai

### 4.1. Thẻ `<link>` trong `index.html`
```html
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Giới thiệu về Nguyễn Tuấn Đạt</title>
    <!-- Liên kết tệp CSS bên ngoài (External CSS) -->
    <link rel="stylesheet" href="style.css">
</head>
```
- `link`: Khai báo liên kết đến tài nguyên bên ngoài.
- `rel="stylesheet"`: Xác định quan hệ tài nguyên là bảng định kiểu CSS.
- `href="style.css"`: Đường dẫn tương đối trỏ trực tiếp đến tệp CSS cùng cấp.

### 4.2. Quy tắc CSS trong `style.css`
```css
body {
  background-color: #f0f8ff; /* Màu xanh AliceBlue rất nhạt */
  font-family: Arial, Helvetica, sans-serif;
  line-height: 1.6;
  color: #333333;
  max-width: 800px;
  margin: 0 auto;
  padding: 20px;
}
```

---

## 5. Nội dung ghi chú thực hành (Dán vào phần Nội dung nộp bài LMS)

```markdown
Báo cáo thực hành: Tạo và liên kết file style.css đầu tiên

1. Các bước đã thực hiện:
- Bước 1: Mở thư mục dự án my-first-website trong VS Code.
- Bước 2: Tạo tệp style.css nằm cùng cấp thư mục với index.html.
- Bước 3: Viết quy tắc CSS kiểm tra trong style.css:
  body {
    background-color: #f0f8ff; /* Mã màu xanh AliceBlue */
  }
- Bước 4: Mở index.html, thêm thẻ liên kết vào bên trong phần <head>:
  <link rel="stylesheet" href="style.css">
- Bước 5: Mở trang web qua Live Server, kiểm tra nền trang web đã chuyển sang màu xanh nhạt AliceBlue thành công.

2. Ý nghĩa của phương pháp External CSS:
- Tách biệt hoàn toàn Cấu trúc (HTML) và Trình bày (CSS) theo nguyên lý Separation of Concerns.
- Một tệp CSS có thể được dùng chung cho nhiều trang HTML trong cùng website, giảm trùng lặp mã nguồn (DRY).
- Trình duyệt tự động lưu vào bộ nhớ đệm (Cache) tệp CSS, giúp tải trang nhanh hơn đáng kể ở các lần truy cập tiếp theo.
- Dự án trở nên khoa học, dễ bảo trì và dễ nâng cấp giao diện.
```

---

## 6. Tác giả & Bản quyền

- Sinh viên: **Nguyễn Tuấn Đạt**
- Email: **proyctk03@gmail.com**
- GitHub: [proyctk03-eng](https://github.com/proyctk03-eng)
- Khóa học: CodeGym Java Web Developer Bootcamp
