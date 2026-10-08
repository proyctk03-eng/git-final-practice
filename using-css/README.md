# [Thực hành] Sử dụng CSS

> **Khóa học**: Lập trình Web & Thiết kế Giao diện Người dùng (CodeGym)  
> **Học viên thực hiện**: Nguyễn Tuấn Đạt  
> **Kho lưu trữ (Repository)**: `https://github.com/proyctk03-eng/git-final-practice`  
> **Thư mục bài tập**: `using-css/`  
> **Mã nguồn tham khảo**: `https://github.com/codegym-vn/jwbd-using-css` (nhánh `develop`)

---

## 1. Mục Tiêu Bài Thực Hành

1. **Luyện tập các thuộc tính cơ bản của CSS**:
   - `color`: Thay đổi màu sắc chữ (văn bản).
   - `font-family`: Thiết lập kiểu phông chữ hiển thị (`Tahoma`, `Arial`).
   - `font-size`: Quy định kích thước phông chữ theo tỷ lệ phần trăm tương đối (`200%`, `120%`).
   - `border`: Tạo đường viền bao bọc khối phần tử (`1px solid grey`).
   - `padding`: Thiết lập khoảng cách đệm từ đường viền đến nội dung bên trong (`10px`).
2. **Nắm vững mô hình hộp (The CSS Box Model)**:
   - Hiểu rõ sự tương quan giữa Content, Padding, Border và Margin.
3. **Hiểu cơ chế độ ưu tiên Selector (CSS Specificity)**:
   - Áp dụng bộ chọn thẻ (`p`) cho tập hợp phần tử chung.
   - Sử dụng bộ chọn định danh (`#element1`) để ghi đè thuộc tính cho một phần tử cụ thể.

---

## 2. Quá Trình Thực Hiện Qua 5 Bước Chi Tiết

### Bước 1: Khởi tạo tài liệu HTML cơ bản
Tạo cấu trúc khung HTML5 tiêu chuẩn gồm một tiêu đề cấp 1 (`<h1>`) và một đoạn văn bản (`<p>`):

```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Title</title>
</head>
<body>
<h1>Đây là đề mục</h1>
<p>Đây là đoạn văn bản.</p>
</body>
</html>
```

---

### Bước 2: Khai báo thẻ `<style>`, định dạng phông chữ và màu sắc
Nhúng khối CSS nội bộ (Internal CSS) bên trong phần tử `<head>`:
- `h1`: Đổi màu chữ sang xanh dương (`color: blue`), phông chữ `Tahoma`, kích thước phóng to gấp đôi kích thước mặc định (`font-size: 200%`).
- `p`: Đổi màu chữ sang đỏ (`color: red`), phông chữ `Arial`, kích thước tăng 120% (`font-size: 120%`).

```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Title</title>
    <style>
        h1 {
            color: blue;
            font-family: Tahoma;
            font-size: 200%;
        }
        p {
            color: red;
            font-family: Arial;
            font-size: 120%;
        }
    </style>
</head>
<body>
<h1>Đây là đề mục</h1>
<p>Đây là đoạn văn bản.</p>
</body>
</html>
```

---

### Bước 3: Sử dụng thuộc tính `border` vẽ viền cho thẻ `<p>`
Bổ sung đường viền nét liền màu xám có độ dày 1 pixel bao quanh đoạn văn:
```css
border: 1px solid grey;
```

```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Title</title>
    <style>
        h1 {
            color: blue;
            font-family: Tahoma;
            font-size: 200%;
        }
        p {
            color: red;
            font-family: Arial;
            font-size: 120%;
            border: 1px solid grey;
        }
    </style>
</head>
<body>
<h1>Đây là đề mục</h1>
<p>Đây là đoạn văn bản.</p>
</body>
</html>
```

---

### Bước 4: Sử dụng thuộc tính `padding` tạo khoảng đệm và thêm nhiều đoạn văn
Thiết lập khoảng trống 10 pixel giữa chữ và đường viền bao quanh thẻ `<p>` để văn bản không bị dính sát mép viền, đồng thời thêm 3 đoạn văn bản để kiểm tra tính nhất quán:

```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Title</title>
    <style>
        h1 {
            color: blue;
            font-family: Tahoma;
            font-size: 200%;
        }

        p {
            color: red;
            font-family: Arial;
            font-size: 120%;
            border: 1px solid grey;
            padding: 10px;
        }
    </style>
</head>
<body>

<h1>Đây là đề mục</h1>

<p>Đây là đoạn văn bản.</p>
<p>Đây là đoạn văn bản.</p>
<p>Đây là đoạn văn bản.</p>

</body>
</html>
```

---

### Bước 5: Gán thuộc tính `id` để tùy biến riêng từng phần tử
Thêm một đoạn văn bản thứ tư có định danh `id="element1"`. Trong CSS, khai báo bộ chọn định danh `#element1` để ghi đè màu chữ thành màu xanh dương (`color: blue`):

```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Title</title>
    <style>
        h1 {
            color: blue;
            font-family: Tahoma;
            font-size: 200%;
        }

        p {
            color: red;
            font-family: Arial;
            font-size: 120%;
            border: 1px solid grey;
            padding: 10px;
        }

        #element1 {
            color: blue;
        }
    </style>
</head>
<body>

<h1>Đây là đề mục</h1>

<p>Đây là đoạn văn bản.</p>
<p>Đây là đoạn văn bản.</p>
<p>Đây là đoạn văn bản.</p>
<p id="element1">Đoạn văn bản có thuộc tính id</p>

</body>
</html>
```

---

## 3. Phân Tích Kỹ Thuật Chuyên Sâu

### 3.1. Phân tích mô hình hộp (The CSS Box Model)
Mỗi thẻ block trong HTML (như `<p>`, `<h1>`) được trình duyệt render dưới dạng một hình hộp chữ nhật gồm 4 lớp tính từ trong ra ngoài:
1. **Content**: Vùng chứa văn bản thực tế (`Đây là đoạn văn bản.`).
2. **Padding (`padding: 10px;`)**: Khoảng không gian đệm trong suốt nằm giữa nội dung và đường viền.
3. **Border (`border: 1px solid grey;`)**: Đường biên phân cách bao bọc nội dung và padding.
4. **Margin**: Khoảng cách bên ngoài ngăn cách giữa các đoạn văn với nhau (mặc định trình duyệt cấp phát khoảng `1em`).

### 3.2. Trọng số ưu tiên của CSS Selector (Specificity)
Trong Bước 5, đoạn văn bản thứ tư vừa thỏa mãn bộ chọn thẻ `p`, vừa thỏa mãn bộ chọn định danh `#element1`:
- Bộ chọn thẻ `p` (Type Selector): Trọng số `(0, 0, 1)`.
- Bộ chọn định danh `#element1` (ID Selector): Trọng số `(1, 0, 0)`.

Do `(1, 0, 0) > (0, 0, 1)`, thuộc tính `color: blue` từ bộ chọn `#element1` được ưu tiên áp dụng, ghi đè hoàn toàn giá trị `color: red` của bộ chọn thẻ `p`. Tuy nhiên, các thuộc tính khác như `font-family: Arial`, `font-size: 120%`, `border: 1px solid grey` và `padding: 10px` không bị ghi đè nên vẫn được kế thừa đầy đủ.

### 3.3. Đơn vị kích thước phần trăm (`%`) trong CSS
- `font-size: 200%`: Kích thước chữ bằng 200% (gấp đôi) so với kích thước kế thừa từ phần tử cha hoặc mặc định của trình duyệt (`16px * 200% = 32px`).
- `font-size: 120%`: Kích thước chữ bằng 120% so với mặc định (`16px * 120% = 19.2px`).

---

## 4. Cấu Trúc Thư Mục & Tài Liệu Bàn Giao

```
using-css/
├── index.html       # Mã nguồn chuẩn CodeGym (Hoàn thành Bước 5, trùng khớp nhánh develop)
├── demo.html        # Giao diện thí nghiệm tương tác trực quan 5 bước và CSS Playground
└── README.md        # Thuyết minh kỹ thuật và phân tích cơ chế CSS Box Model
```

---

## 5. Hướng Dẫn Mở & Kiểm Tra

1. **Kiểm tra mã nguồn chuẩn bài tập**:
   - Mở trực tiếp tệp `index.html` trong trình duyệt bất kỳ (Chrome, Edge, Firefox).
   - Quan sát:
     - Tiêu đề chữ màu xanh dương, phông Tahoma, cỡ 200%.
     - Ba đoạn văn bản đầu có chữ màu đỏ, phông Arial, cỡ 120%, viền xám 1px, khoảng đệm 10px.
     - Đoạn văn thứ tư có cùng phông chữ, cỡ chữ, viền và khoảng đệm, nhưng chữ đổi sang màu xanh dương.
2. **Kiểm tra giao diện mô phỏng tương tác**:
   - Mở tệp `demo.html` để trải nghiệm chuyển đổi giữa 5 bước thực hành và bảng điều khiển tùy biến CSS trực tiếp.
