# [Thực hành] Sử Dụng Box Model

> **Khóa học**: Lập trình Web & Thiết kế Giao diện Người dùng (CodeGym)  
> **Học viên thực hiện**: Nguyễn Tuấn Đạt  
> **Kho lưu trữ (Repository)**: `https://github.com/proyctk03-eng/git-final-practice`  
> **Thư mục bài tập**: `using-box-model/`  
> **Mã nguồn tham khảo**: `https://github.com/codegym-vn/jwbd-using-box-model` (nhánh `develop`)

---

## 1. Mục Tiêu Bài Thực Hành

1. **Làm chủ mô hình hộp CSS (The CSS Box Model)**:
   - **Nội dung (Content)**: Vùng văn bản hiển thị cốt lõi của phần tử.
   - **Phần đệm (Padding)**: Khoảng cách đệm từ nội dung đến đường viền (`padding: 10px;`).
   - **Đường viền (Border)**: Đường bao bọc phần tử với độ dày, kiểu dáng và màu sắc đa dạng (`border: 10px solid;`, viền 4 màu).
   - **Lề ngoài (Margin)**: Khoảng cách phân cách giữa phần tử với các phần tử xung quanh và mép cửa sổ hiển thị (`margin: 0 auto;`, `margin-bottom`).
2. **Nắm vững quy tắc chiều kim đồng hồ (Clockwise Rule)**:
   - Cú pháp khai báo 4 giá trị: `border-color: chartreuse aqua blue blueviolet;` (Top &rarr; Right &rarr; Bottom &rarr; Left).
3. **Kỹ thuật căn giữa khối phần tử trên màn hình**:
   - Sử dụng `margin: 0 auto;` kết hợp với kích thước chiều rộng cố định `width: 800px;`.
4. **Phân cấp bộ chọn và ghi đè thuộc tính**:
   - Kết hợp giữa bộ chọn lớp (`.boxmodel`), bộ chọn phần tử con (`.boxmodel p`), và bộ chọn định danh (`#boxmodel1`, `#boxmodel2`, `#boxmodel3`).

---

## 2. Quá Trình Thực Hiện Qua 4 Bước Chi Tiết

### Bước 1: Khởi tạo khung tài liệu HTML
Tạo khung HTML5 tiêu chuẩn gồm phần tử `<div>` bao bọc bên ngoài và 3 phần tử đoạn văn `<p>` bên trong chứa nội dung giải thích về mô hình hộp:

```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Sử dụng Boxmodel</title>
</head>
<body>
<div>
    <p>Mô hình hộp trong CSS về cơ bản là một hộp bao quanh phần tử HTML.
        Nó bao gồm: lề (margin), viền (border), phần đệm (padding) và nội dung (content)</p>
    <p>Mô hình hộp trong CSS về cơ bản là một hộp bao quanh phần tử HTML.
        Nó bao gồm: lề (margin), viền (border), phần đệm (padding) và nội dung (content)</p>
    <p>Mô hình hộp trong CSS về cơ bản là một hộp bao quanh phần tử HTML.
        Nó bao gồm: lề (margin), viền (border), phần đệm (padding) và nội dung (content)</p>
</div>
</body>
</html>
```

---

### Bước 2: Nhúng CSS định dạng khối bao bọc `.boxmodel`
Gán lớp `class="boxmodel"` cho thẻ `<div>` và khai báo các thuộc tính hộp trong khối `<style>`:

```html
<style>
    .boxmodel{
        margin: 0 auto;
        width: 800px;
        border: 10px;
        padding: 10px;
        border-color: chartreuse aqua blue blueviolet;
        border-style: solid;
    }
</style>
```

**Ý nghĩa các thuộc tính:**
- `width: 800px`: Giới hạn chiều rộng của khối hộp là 800 pixel.
- `margin: 0 auto`: Căn lề trên/dưới bằng 0 và lề trái/phải tự động co giãn (`auto`), giúp căn giữa khối hộp ra giữa màn hình.
- `border: 10px`: Thiết lập độ dày đường viền 10 pixel.
- `border-style: solid`: Đường viền nét liền.
- `border-color: chartreuse aqua blue blueviolet`: 4 màu tương ứng cho 4 cạnh theo chiều kim đồng hồ.
- `padding: 10px`: Khoảng cách đệm từ viền vào vùng nội dung là 10 pixel.

---

### Bước 3: Định dạng các đoạn văn con `.boxmodel p`
Thêm đường viền nét chấm tròn (`dotted`) màu đỏ thẫm (`darkred`) và khoảng đệm 10px cho các đoạn văn:

```css
.boxmodel p{
    border: 3px dotted darkred;
    padding: 10px;
}
```

---

### Bước 4: Thiết lập khoảng lề dưới tăng dần với bộ chọn ID
Gán `id` tương ứng cho từng đoạn văn (`boxmodel1`, `boxmodel2`, `boxmodel3`) để tạo các khoảng cách lề dưới (`margin-bottom`) khác nhau:

```html
<div class="boxmodel">
    <p id="boxmodel1">Mô hình hộp trong CSS về cơ bản là một hộp bao quanh phần tử HTML.
        Nó bao gồm: lề (margin), viền (border), phần đệm (padding) và nội dung (content)</p>
    <p id="boxmodel2">Mô hình hộp trong CSS về cơ bản là một hộp bao quanh phần tử HTML.
        Nó bao gồm: lề (margin), viền (border), phần đệm (padding) và nội dung (content)</p>
    <p id="boxmodel3">Mô hình hộp trong CSS về cơ bản là một hộp bao quanh phần tử HTML.
        Nó bao gồm: lề (margin), viền (border), phần đệm (padding) và nội dung (content)</p>
</div>
```

Định nghĩa CSS:
```css
#boxmodel1{
    margin-bottom: 20px;
}
#boxmodel2{
    margin-bottom: 40px;
}
#boxmodel3{
    margin-bottom: 60px;
}
```

---

## 3. Phân Tích Kỹ Thuật Chuyên Sâu

### 3.1. Quy tắc chiều kim đồng hồ trong thuộc tính viết tắt (Shorthand)
Khi một thuộc tính định dạng viền, đệm hoặc lề nhận 4 giá trị cách nhau bằng khoảng trắng:
$$\text{Thuộc tính} = [\text{Top}] \quad [\text{Right}] \quad [\text{Bottom}] \quad [\text{Left}]$$

Trong bài tập này:
- Cạnh trên (Top): `chartreuse` (Xanh nõn chuối).
- Cạnh phải (Right): `aqua` (Xanh ngọc lơ).
- Cạnh dưới (Bottom): `blue` (Xanh dương đậm).
- Cạnh trái (Left): `blueviolet` (Tím lam).

### 3.2. Cơ chế căn giữa với `margin: 0 auto;`
- Để `margin: auto` có thể tự động tính toán khoảng trống hai bên và căn giữa một phần tử block-level, phần tử đó **bắt buộc phải có kích thước chiều rộng xác định** (`width: 800px;` hoặc `max-width`).
- Nếu không khai báo `width`, phần tử dạng khối sẽ mặc định chiếm toàn bộ 100% bề ngang của phần tử cha, khi đó hai bên không còn khoảng trống dư thừa để căn giữa.

### 3.3. Tính toán kích thước vật lý tổng thể (Box Sizing)
Trong mô hình hộp tiêu chuẩn (`box-sizing: content-box`), tổng chiều rộng thực tế hiển thị trên trình duyệt của khối `.boxmodel` được tính theo công thức:
$$\text{Total Width} = \text{width} + (\text{padding-left} + \text{padding-right}) + (\text{border-left} + \text{border-right})$$
$$\text{Total Width} = 800\text{px} + (10\text{px} + 10\text{px}) + (10\text{px} + 10\text{px}) = 840\text{px}$$

---

## 4. Cấu Trúc Mã Nguồn Hoàn Chỉnh (`index.html`)

```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Sử dụng Boxmodel</title>
    <style>
        .boxmodel{
            margin: 0 auto;
            width: 800px;
            border: 10px;
            padding: 10px;
            border-color: chartreuse aqua blue blueviolet;
            border-style: solid;
        }
        .boxmodel p{
            border: 3px dotted darkred;
            padding: 10px;
        }
        #boxmodel1{
            margin-bottom: 20px;
        }
        #boxmodel2{
            margin-bottom: 40px;
        }
        #boxmodel3{
            margin-bottom: 60px;
        }
    </style>
</head>
<body>
<div class="boxmodel">
    <p id="boxmodel1">Mô hình hộp trong CSS về cơ bản là một hộp bao quanh phần tử HTML.
        Nó bao gồm: lề (margin), viền (border), phần đệm (padding) và nội dung (content)</p>
    <p id="boxmodel2">Mô hình hộp trong CSS về cơ bản là một hộp bao quanh phần tử HTML.
        Nó bao gồm: lề (margin), viền (border), phần đệm (padding) và nội dung (content)</p>
    <p id="boxmodel3">Mô hình hộp trong CSS về cơ bản là một hộp bao quanh phần tử HTML.
        Nó bao gồm: lề (margin), viền (border), phần đệm (padding) và nội dung (content)</p>
</div>
</body>
</html>
```

---

## 5. Cấu Trúc Thư Mục & Bàn Giao

```
using-box-model/
├── index.html       # Mã nguồn chuẩn CodeGym (Hoàn thành Bước 4, trùng khớp nhánh develop)
├── demo.html        # Giao diện thí nghiệm tương tác trực quan 4 bước và Sandbox điều khiển Box Model
└── README.md        # Thuyết minh kỹ thuật chi tiết về cơ chế Box Model và quy tắc Clockwise
```

---

## 6. Hướng Dẫn Mở & Kiểm Tra

1. **Kiểm tra mã nguồn chuẩn bài tập**:
   - Mở tệp `index.html` trong bất kỳ trình duyệt nào.
   - Quan sát:
     - Khung hộp rộng 800px nằm chính giữa màn hình.
     - Viền hộp 10px với 4 cạnh mang 4 màu sắc phân biệt: Trên (chartreuse), Phải (aqua), Dưới (blue), Trái (blueviolet).
     - 3 đoạn văn bản có viền chấm tròn đỏ thẫm 3px và khoảng cách giữa các đoạn tăng dần đều (20px, 40px, 60px).
2. **Kiểm tra phòng thí nghiệm tương tác**:
   - Mở tệp `demo.html` để theo dõi các lớp hộp phân tầng, sơ đồ la bàn 4 màu và thanh trượt điều chỉnh kích thước thời gian thực.
