# Mini Project: Xây dựng Component Thẻ sản phẩm (Product Card)

- **Học viên**: Nguyễn Tuấn Đạt
- **Email**: proyctk03@gmail.com
- **Khóa học**: Module 1 - Thiết Kế Web Cơ Bản (HTML5 & CSS3)
- **Chủ đề**: Mô hình Hộp (Box Model) & Thuộc tính Display trong CSS

---

## 1. Mục tiêu bài tập

1. Áp dụng thành thạo `padding`, `border`, và `margin` để kiểm soát không gian của component.
2. Sử dụng `width`, `max-width`, và `box-sizing: border-box` để tạo khối giao diện có kích thước chuẩn xác.
3. Vận dụng thuộc tính `display` (`display: block`) để biến đổi hành vi của các phần tử nội tuyến.
4. Xây dựng một component Thẻ sản phẩm (`.product-card`) hoàn chỉnh, chuyên nghiệp và sẵn sàng tái sử dụng trong hệ thống thương mại điện tử.

---

## 2. Bảng đối chiếu yêu cầu bài toán (Checklist)

| Mục | Yêu cầu kỹ thuật | Trạng thái | Chi tiết triển khai |
| :--- | :--- | :--- | :--- |
| **1. HTML** | Khối bao bọc `div.product-card` | Đạt | Thẻ `<div class="product-card">` làm container chính |
| **1. HTML** | Thẻ `<img>` cho ảnh sản phẩm | Đạt | `<img src="images/product.jpg" alt="...">` |
| **1. HTML** | Thẻ `<h2>`/`<h3>` cho tên sản phẩm | Đạt | `<h3>Tai nghe Sony WH-1000XM5</h3>` |
| **1. HTML** | Thẻ `<p class="price">` cho giá | Đạt | `<p class="price">8.490.000 đ</p>` |
| **1. HTML** | Thẻ `<a class="btn">` hoặc `<button>` | Đạt | `<a href="#" class="btn">Thêm vào giỏ hàng</a>` |
| **2. CSS** | Reset `box-sizing: border-box` | Đạt | `* { box-sizing: border-box; }` ở đầu tệp `style.css` |
| **2. CSS** | Thẻ `body` có màu nền nhạt | Đạt | `background-color: #f4f6f8;` |
| **3. Card** | Chiều rộng cố định | Đạt | `width: 300px;` |
| **3. Card** | Màu nền trắng | Đạt | `background-color: #ffffff;` |
| **3. Card** | Đường viền nhẹ | Đạt | `border: 1px solid #dddddd;` kèm `border-radius: 8px;` |
| **3. Card** | Đệm nội dung bên trong | Đạt | `padding: 20px;` |
| **3. Card** | Căn giữa trang web | Đạt | `margin: 50px auto;` |
| **3. Card** | Thử thách đổ bóng `box-shadow` | Đạt | `box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);` |
| **4. Phần tử** | Ảnh chiếm toàn bộ chiều rộng nội dung | Đạt | `width: 100%; height: 200px; object-fit: cover; display: block;` |
| **4. Phần tử** | Tiêu đề có khoảng cách margin | Đạt | `font-size: 1.25rem; margin-bottom: 12px;` |
| **4. Phần tử** | Giá nổi bật, in đậm, cách nút | Đạt | `color: #e53935; font-weight: bold; margin-bottom: 20px;` |
| **4. Phần tử** | Nút bấm chuyển sang `display: block` | Đạt | `display: block; width: 100%;` |
| **4. Phần tử** | Nút bấm bỏ gạch chân, có padding | Đạt | `text-decoration: none; padding: 12px 20px; text-align: center;` |
| **4. Phần tử** | Hiệu ứng rê chuột `:hover` cho nút | Đạt | `background-color: #1d4ed8;` chuyển màu mượt mà |

---

## 3. Phân tích kỹ thuật chuyên sâu về Box Model

### 3.1. Cơ chế hoạt động của `box-sizing: border-box`

Trong chế độ mặc định (`content-box`):
$$\text{Tổng chiều rộng} = \text{width} + \text{padding-left} + \text{padding-right} + \text{border-left} + \text{border-right}$$

Khi áp dụng `box-sizing: border-box`:
$$\text{Tổng chiều rộng bên ngoài} = \text{width} = 300\text{px}$$

Do đó, vùng không gian thực tế dành cho nội dung bên trong (ảnh, chữ, nút) được tính bằng:
$$\text{Content Width} = 300\text{px} - (\text{padding: } 20\text{px} \times 2) - (\text{border: } 1\text{px} \times 2) = 258\text{px}$$

Nhờ vậy, thẻ sản phẩm giữ nguyên kích thước chính xác 300px trên mọi màn hình, không bị tràn viền hay vỡ bố cục khi thay đổi padding.

### 3.2. Vai trò của `display: block` đối với thẻ `<a>`

Thẻ `<a>` theo mặc định của trình duyệt là một phần tử nội tuyến (`inline`):
- Không thể thiết lập chiều rộng (`width`), chiều cao (`height`).
- Các thuộc tính `margin-top` và `margin-bottom` không tạo ra khoảng đẩy đối với các phần tử khối xung quanh.

Khi khai báo `display: block;`:
- Thẻ `<a>` mở rộng chiếm trọn 100% chiều rộng của vùng chứa (ở đây là 258px).
- Nút bấm tạo thành một vùng chạm lớn, dễ tương tác trên màn hình cảm ứng hoặc chuột.
- Áp dụng đầy đủ padding và margin theo tiêu chuẩn của Box Model.

### 3.3. Cơ chế căn giữa với `margin: 50px auto`

- `50px`: Tạo khoảng cách 50px ở phía trên (top) và phía dưới (bottom).
- `auto`: Trình duyệt tự động chia đều toàn bộ phần không gian trống còn lại ở hai bên trái và phải của cửa sổ hiển thị, giúp phần tử có `width: 300px` luôn nằm chính xác ở trục tâm của trang web.

---

## 4. Cấu trúc thư mục dự án

```text
product-card/
├── index.html          # Trang trưng bày tổng quan và phân tích Box Model
├── product-card.html   # Trang component đơn lẻ theo đúng yêu cầu đề bài
├── style.css           # Quy tắc định dạng CSS với box-sizing: border-box
├── README.md           # Tài liệu kỹ thuật chi tiết của dự án
└── images/             # Thư mục hình ảnh sản phẩm
    ├── product.jpg     # Ảnh sản phẩm mặc định (Tai nghe Sony WH-1000XM5)
    ├── headphone.jpg   # Ảnh tai nghe
    ├── smartwatch.jpg  # Ảnh đồng hồ thông minh Apple Watch Series 9
    └── camera.jpg      # Ảnh máy ảnh mirrorless Fujifilm X-T5
```

---

## 5. Hướng dẫn kiểm tra và chạy thử

1. Mở tệp `product-card.html` hoặc `index.html` trực tiếp bằng trình duyệt Google Chrome, Edge hoặc Firefox.
2. Nhấn phím `F12` để mở công cụ DevTools.
3. Chọn thẻ `Elements`, click chọn `<div class="product-card">`.
4. Quan sát tab `Computed` để thấy sơ đồ Box Model trực quan:
   - Content: `258 x ...`
   - Padding: `20 20 20 20`
   - Border: `1 1 1 1`
   - Margin: `50 auto 50 auto`
