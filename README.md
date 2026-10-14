# Báo Cáo Thực Hành: Trực quan hóa Box Model với các khối div nhiều màu sắc

> Khóa học: Thiết Kế Web & Lập Trình Cơ Bản (Module 1 - CodeGym)  
> Sinh viên thực hiện: Nguyễn Tuấn Đạt  
> Email: proyctk03@gmail.com  
> Repository: `https://github.com/proyctk03-eng/git-final-practice`  
> Thư mục bài tập: `visualize-box-model/` (và tệp `box-model.html` trong `my-first-website/`)  

---

## 1. Giới thiệu bài thực hành & Mục tiêu đạt được

1. Tạo các phần tử `<div>` ngữ nghĩa và áp dụng các thuộc tính CSS cơ bản.
2. Trực quan hóa và phân biệt rõ ràng 4 lớp cấu thành mô hình hộp (Box Model): **Content**, **Padding**, **Border**, và **Margin**.
3. Hiểu rõ cơ chế tính toán kích thước vật lý hiển thị của phần tử trên màn hình theo chuẩn W3C.
4. Nắm vững sự khác biệt giữa `box-sizing: content-box` (mặc định) và `box-sizing: border-box` (chuẩn công nghiệp hiện đại).

---

## 2. Bốn lớp thành phần của CSS Box Model

```
+-------------------------------------------------------+
|                       MARGIN (40px)                   |
|   +-----------------------------------------------+   |
|   |                   BORDER (10px)               |   |
|   |   +---------------------------------------+   |   |
|   |   |               PADDING (20px)          |   |   |
|   |   |   +-------------------------------+   |   |   |
|   |   |   |            CONTENT            |   |   |   |
|   |   |   |       (250px x 150px)         |   |   |   |
|   |   |   +-------------------------------+   |   |   |
|   |   +---------------------------------------+   |   |
|   +-----------------------------------------------+   |
+-------------------------------------------------------+
```

1. **Content (Nội dung)**:
   - Kích thước: `width: 250px`, `height: 150px`.
   - Là vùng chứa văn bản (`Đây là Hộp 1`, `Đây là Hộp 2`).
2. **Padding (Vùng đệm bên trong)**:
   - Kích thước: `padding: 20px` (áp dụng cho cả 4 phía: top, right, bottom, left).
   - Là khoảng đệm trong suốt nằm giữa nội dung và đường viền, mang màu nền của phần tử (`lightskyblue` hoặc `lightsalmon`).
   - Giúp văn bản không bị dính sát vào đường viền.
3. **Border (Đường viền)**:
   - Kích thước: `border: 10px solid #333`.
   - Bao bọc bên ngoài vùng đệm, là một đường kẻ màu đen đậm nét dày 10px.
4. **Margin (Lề bên ngoài)**:
   - Kích thước: `margin: 40px`.
   - Là khoảng không gian hoàn toàn trong suốt nằm ngoài đường viền.
   - Đẩy hai hộp `box-1` và `box-2` cách xa nhau và cách xa mép trang web, không làm thay đổi kích thước nhìn thấy được của hộp.

---

## 3. Bảng công thức tính kích thước hiển thị thực tế (Computed Box Dimensions)

Với thuộc tính mặc định `box-sizing: content-box`:

| Chiều | Thành phần công thức tính toán | Giá trị (px) |
| :--- | :--- | :---: |
| **Chiều rộng thực tế (Total Width)** | `width` + `padding-left` + `padding-right` + `border-left` + `border-right` = 250 + 20 + 20 + 10 + 10 | **310px** |
| **Chiều cao thực tế (Total Height)** | `height` + `padding-top` + `padding-bottom` + `border-top` + `border-bottom` = 150 + 20 + 20 + 10 + 10 | **210px** |
| **Khoảng cách chiếm dụng trên Layout** | Chiều rộng tổng kèm margin (`total width + margin-left + margin-right` = 310 + 40 + 40) | **390px** |

> **Khám phá mở rộng**: Khi áp dụng quy tắc `box-sizing: border-box;`, trình duyệt sẽ ép kích thước tổng thể (`content + padding + border`) luôn cố định đúng bằng `width: 250px` và `height: 150px`. Vùng content bên trong sẽ tự động co nhỏ lại ($250 - 40 - 20 = 190\text{px}$).

---

## 4. Chi tiết mã nguồn triển khai

### Tệp `box-model.html` (hoặc `index.html`)
```html
<!DOCTYPE html>
<html lang="vi">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Thí nghiệm Box Model</title>
  <link rel="stylesheet" href="style.css">
</head>
<body>
  <div class="box box-1">Đây là Hộp 1</div>
  <div class="box box-2">Đây là Hộp 2</div>
</body>
</html>
```

### Tệp `style.css`
```css
.box {
  width: 250px;
  height: 150px;
  padding: 20px;
  border: 10px solid #333;
  margin: 40px;
}

.box-1 {
  background-color: lightskyblue;
}

.box-2 {
  background-color: lightsalmon;
}
```

---

## 5. Nội dung ghi chú thực hành (Dán vào phần Nội dung nộp bài LMS)

```markdown
Báo cáo quan sát thực hành: Trực quan hóa Box Model với các khối div

1. Các bước đã thực hiện:
- Bước 1: Tạo tệp box-model.html và style.css trong thư mục dự án.
- Bước 2: Thiết lập cấu trúc HTML với 2 phần tử <div class="box box-1"> và <div class="box box-2">.
- Bước 3: Định dạng kích thước cơ bản (content) với width: 250px và height: 150px.
- Bước 4: Tô màu nền bằng class box-1 (lightskyblue) và box-2 (lightsalmon) để phân biệt trực quan.
- Bước 5: Thêm padding: 20px, quan sát văn bản được đẩy vào trong và vùng màu của hộp mở rộng thêm 40px mỗi chiều.
- Bước 6: Thêm border: 10px solid #333, tạo khung viền đen dày bao quanh hộp, làm tăng tổng kích thước nhìn thấy được lên 310px x 210px.
- Bước 7: Thêm margin: 40px, tạo khoảng đệm trong suốt bao quanh bên ngoài, đẩy hai hộp cách xa nhau và cách xa mép trang.

2. Đúc kết lý thuyết Box Model:
- Padding và Border trực tiếp làm tăng kích thước nhìn thấy được (Rendered Size) của phần tử trên màn hình.
- Margin tạo không gian trống vô hình bên ngoài đường viền để điều phối khoảng cách giữa các phần tử trên trang.
- Công thức tính kích thước tổng:
  + Chiều rộng = width + padding-left + padding-right + border-left + border-right.
  + Chiều cao = height + padding-top + padding-bottom + border-top + border-bottom.
- Để kiểm soát kích thước chính xác trong thiết kế giao diện phức tạp, thuộc tính box-sizing: border-box thường được sử dụng làm chuẩn thiết kế.
```

---

## 6. Tác giả & Bản quyền

- Sinh viên: **Nguyễn Tuấn Đạt**
- Email: **proyctk03@gmail.com**
- GitHub: [proyctk03-eng](https://github.com/proyctk03-eng)
- Khóa học: CodeGym Java Web Developer Bootcamp
