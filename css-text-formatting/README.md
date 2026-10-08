# [Bài tập] Định Dạng Văn Bản Với CSS

> **Khóa học**: Lập trình Web & Thiết kế Giao diện Người dùng (CodeGym)  
> **Học viên thực hiện**: Nguyễn Tuấn Đạt  
> **Kho lưu trữ (Repository)**: `https://github.com/proyctk03-eng/git-final-practice`  
> **Thư mục bài tập**: `css-text-formatting/`  
> **Cơ sở bài học**: CSS Typography & Text Formatting

---

## 1. Mục Tiêu Bài Tập

1. **Luyện tập các thuộc tính định dạng văn bản cốt lõi trong CSS**:
   - `font-style`: Thiết lập kiểu chữ thường (`normal`), in nghiêng (`italic`), hoặc xiên nghiêng (`oblique`).
   - `text-align`: Căn lề văn bản theo chiều ngang (`left`, `center`, `right`, `justify`).
   - `font-size`: Điều chỉnh kích cỡ phông chữ theo các đơn vị độ dài tương đối (`rem`, `em`, `%`) và tuyệt đối (`px`).
   - `text-indent`: Tạo độ thụt lề cho dòng đầu tiên của khối đoạn văn bản.
   - `color`: Lựa chọn mã màu văn bản đảm bảo độ tương phản cao và thẩm mỹ hiện đại.
2. **Mở rộng các thuộc tính bổ trợ nâng cao**:
   - `line-height`: Kiểm soát khoảng cách giữa các dòng để tối ưu hóa khả năng đọc (Readability).
   - `font-family`: Kết hợp hài hòa giữa phông Serif cổ điển cho nội dung dài và Sans-serif cho tiêu đề.
   - `letter-spacing`: Tinh chỉnh khoảng cách giữa các ký tự.
3. **Ứng dụng vào bài viết thực tế**:
   - Xây dựng một trang bài viết hoàn chỉnh với tiêu đề chính căn giữa, thông tin tác giả in nghiêng, đoạn dẫn nhập nổi bật, đoạn văn bản thân bài thụt đầu dòng căn đều hai bên và khối trích dẫn sang trọng.

---

## 2. Phân Tích Kỹ Thuật Các Thuộc Tính CSS Sử Dụng

### 2.1. Thuộc tính `text-indent` (Thụt đầu dòng)
- **Cú pháp**: `text-indent: <length | percentage>;`
- **Cơ chế hoạt động**: Thuộc tính này chỉ áp dụng duy nhất lên **dòng đầu tiên** của một khối văn bản block-level (như `<p>`, `<div>`). Các dòng tiếp theo trong cùng đoạn văn vẫn căn thẳng lề bình thường.
- **Giá trị áp dụng trong bài tập**:
  ```css
  p.content-paragraph {
      text-indent: 2.2em; /* Thut vao tuong duong do rong cua 2.2 ky tu 'M' */
  }
  ```
- **Ý nghĩa thực tế**: Giúp phân tách trực quan giữa các đoạn văn liên tiếp trong phong cách trình bày bài báo, luận văn học thuật mà không cần phải tăng khoảng cách margin quá mức.

---

### 2.2. Thuộc tính `text-align` (Căn lề văn bản)
- **Cú pháp**: `text-align: left | right | center | justify;`
- **So sánh các giá trị thực tế trong bài tập**:
  - `text-align: center`: Áp dụng cho tiêu đề `h1.main-title` và khối trích dẫn `blockquote` nhằm tạo trọng tâm thị giác ở chính giữa trang.
  - `text-align: justify`: Áp dụng cho đoạn văn `p.content-paragraph`. Trình duyệt tự động tính toán và co giãn khoảng trắng giữa các từ để hai bên mép lề trái và phải đều thẳng hàng tuyệt đối, tạo nên vẻ vuông vức và chỉnh chu cho khối văn bản.
  - `text-align: right`: Áp dụng cho phần ghi chú kết bài `.article-footer`.

---

### 2.3. Thuộc tính `font-style` (Kiểu dáng chữ)
- **Cú pháp**: `font-style: normal | italic | oblique;`
- **Phân biệt kỹ thuật**:
  - `normal`: Phông chữ đứng mặc định.
  - `italic`: Sử dụng phiên bản chữ nghiêng được thiết kế riêng của phông chữ (với các nét uốn lượn mang tính thư pháp).
  - `oblique`: Làm nghiêng hình học phông chữ đứng thông thường (thường dùng khi phông chữ không có bản thiết kế italic riêng).
- **Ứng dụng trong bài**:
  ```css
  .article-meta {
      font-style: italic; /* Danh cho thong tin phu ve tac gia va ngay dang */
  }
  blockquote.highlight-quote {
      font-style: italic; /* Danh cho loi trich dan danh ngon */
  }
  ```

---

### 2.4. Thuộc tính `font-size` (Kích cỡ phông chữ)
- **Hệ thống phân cấp thứ bậc thị giác (Visual Hierarchy)**:
  - Tiêu đề chính (`h1`): `font-size: 2.25rem` (~36px) - Lớn nhất, thu hút ánh nhìn đầu tiên.
  - Tiêu đề phân mục (`h2`): `font-size: 1.45rem` (~23px) - Định hình cấu trúc bài viết.
  - Đoạn dẫn nhập (`.lead-paragraph`): `font-size: 1.2rem` (~19.2px) - Nổi bật hơn nội dung thường.
  - Đoạn văn thân bài (`p`): `font-size: 1.05rem` (~17px) - Cỡ chữ tối ưu cho mắt khi đọc lâu trên màn hình máy tính và điện thoại.
  - Ghi chú phụ (`.article-meta`, `.article-footer`): `font-size: 0.95rem` / `0.85rem` - Nhỏ nhắn, không làm phân tán nội dung chính.

---

### 2.5. Thuộc tính `color` (Bảng màu văn bản)
- **Nguyên tắc độ tương phản**: Sử dụng bảng màu chuyên nghiệp thay vì màu đen thuần túy (`#000000`) để giảm hiện tượng chói mắt khi đọc trên nền trắng:
  - Màu tiêu đề chính: `#1E3A8A` (Xanh Navy đậm sang trọng).
  - Màu tiêu đề phân mục: `#0F766E` (Xanh Teal hiện đại).
  - Màu thân bài: `#1E293B` (Xanh Slate đen đậm, độ tương phản đạt chuẩn WCAG AAA > 12:1).
  - Màu thông tin phụ: `#64748B` (Xám trung tính dịu mắt).
  - Màu từ khóa nhấn mạnh: `#B91C1C` (Đỏ rượu nổi bật).

---

## 3. Cấu Trúc Mã Nguồn (`index.html`)

Trích đoạn quy tắc CSS chính được định nghĩa trong [index.html](file:///c:/Users/dathao/Downloads/AI/git-final-practice/css-text-formatting/index.html):

```css
/* Tieu de chinh can giua, co chu lon, mau xanh dam */
h1.main-title {
    font-family: 'Plus Jakarta Sans', Arial, sans-serif;
    font-size: 2.25rem;
    font-weight: 700;
    color: #1E3A8A;
    text-align: center;
    line-height: 1.3;
}

/* Thong tin tac gia in nghieng, can giua, mau xam */
.article-meta {
    font-size: 0.95rem;
    font-style: italic;
    text-align: center;
    color: #64748B;
}

/* Doan van ban thut dau dong, can deu hai ben, mau toi de doc */
p.content-paragraph {
    font-size: 1.05rem;
    color: #1E293B;
    text-align: justify;
    text-indent: 2.2em;
    line-height: 1.85;
}

/* Trich dan in nghieng, can giua, noi bat */
blockquote.highlight-quote {
    font-size: 1.15rem;
    font-style: italic;
    color: #1E40AF;
    text-align: center;
    line-height: 1.7;
}
```

---

## 4. Cấu Trúc Thư Mục & Tài Liệu Bàn Giao

```
css-text-formatting/
├── index.html       # Trang bài viết hoàn chỉnh áp dụng toàn diện các thuộc tính định dạng văn bản
├── demo.html        # Giao diện thí nghiệm tương tác trực tiếp (Playground) có bảng điều khiển slider
└── README.md        # Thuyết minh kỹ thuật chi tiết về các thuộc tính Typography trong CSS
```

---

## 5. Hướng Dẫn Mở & Kiểm Tra

1. **Kiểm tra giao diện bài viết chuẩn**:
   - Mở tệp `index.html` trong trình duyệt.
   - Quan sát tiêu đề chính căn giữa nổi bật, đoạn văn bản thân bài thụt đầu dòng 2.2em và căn lề đều hai bên, các từ khóa được làm nổi bật với màu sắc và phông nghiêng.
2. **Kiểm tra phòng thí nghiệm tương tác**:
   - Mở tệp `demo.html` trong trình duyệt.
   - Tự do kéo thanh trượt `text-indent`, đổi chế độ `text-align`, chọn bảng màu `color` hoặc đổi `font-style` để quan sát văn bản biến đổi theo thời gian thực và sao chép mã CSS sinh tự động.
