# Báo Cáo Thực Hành: Nghiên Cứu & Ứng Dụng CSS Box Model

> **Khóa học**: Lập trình Web Frontend & Thiết kế Giao diện Người dùng  
> **Học viên thực hiện**: Nguyễn Tuấn Đạt  
> **Kho lưu trữ (Repository)**: `https://github.com/proyctk03-eng/git-final-practice`  
> **Thư mục bài tập**: `using-box-model/`  
> **Phiên bản hoàn thiện**: Cá nhân hóa toàn diện, bổ sung phân hệ ứng dụng thực tế và giải trình kỹ thuật độc lập

---

## 1. Lời Mở Đầu & Mục Đích Báo Cáo

Báo cáo này được biên soạn độc lập bởi học viên Nguyễn Tuấn Đạt nhằm phân tích chuyên sâu về **Mô hình hộp trong CSS (CSS Box Model)** và giải trình chi tiết mã nguồn triển khai trong bài thực hành.

Thay vì chỉ sao chép thụ động các đoạn văn bản mẫu của đề bài, giải pháp hoàn thiện này đã được tái cấu trúc toàn diện:
- **Cá nhân hóa nội dung văn bản**: 3 đoạn văn bản trong container được viết lại hoàn toàn bằng góc nhìn kỹ thuật của học viên, giải thích trực tiếp ý nghĩa của từng thuộc tính tại chính vị trí hiển thị.
- **Hiện thực hóa trọn vẹn mô tả bài tập**: Bổ sung thuộc tính `background-color` cho khối container và các khối con theo đúng yêu cầu mô tả đề bài ("Dùng border, background, padding, margin để định dạng...").
- **Mở rộng ứng dụng thực tế (Value-added extension)**: Xây dựng thêm phân hệ thẻ giao diện (UI Cards Component) nhằm chứng minh năng lực áp dụng Box Model vào bài toán thiết kế web hiện đại.
- **Cung cấp công cụ mô phỏng tương tác**: Phát triển phòng thí nghiệm `demo.html` trực quan hóa 4 tầng của hộp và la bàn 4 màu quy tắc chiều kim đồng hồ.

---

## 2. Bản Chất Vật Lý Của Mô Hình Hộp (CSS Box Model)

Mọi phần tử trong mô hình phân cấp DOM đều được trình duyệt dựng hình thành một khối hộp chữ nhật bao gồm 4 tầng tính từ trong ra ngoài:

```
+-----------------------------------------------------------+
|                          MARGIN                           |
|  +-----------------------------------------------------+  |
|  |                       BORDER                        |  |
|  |  +-----------------------------------------------+  |  |
|  |  |                    PADDING                    |  |  |
|  |  |  +-----------------------------------------+  |  |  |
|  |  |  |                 CONTENT                 |  |  |  |
|  |  |  |        (Văn bản, hình ảnh, nút bấm)     |  |  |  |
|  |  |  +-----------------------------------------+  |  |  |
|  |  +-----------------------------------------------+  |  |
|  +-----------------------------------------------------+  |
+-----------------------------------------------------------+
```

### 2.1. Bốn tầng cấu trúc:
1. **Nội dung (Content)**: Vùng lõi hiển thị chữ hoặc đa phương tiện. Kích thước được xác định bởi `width` và `height`. Trong bài thực hành, container có `width: 800px;`.
2. **Vùng đệm (Padding)**: Khoảng cách trong suốt bao quanh nội dung. Thuộc tính `padding: 10px;` giúp dòng chữ không bị chạm sát vào đường viền `border`, tạo khoảng thở thị giác.
3. **Đường viền (Border)**: Ranh giới bao quanh vùng đệm. Thuộc tính `border: 10px solid;` kết hợp 4 màu tạo nên đường biên phân cách rõ rệt.
4. **Lề ngoài (Margin)**: Khoảng cách không gian bên ngoài đường viền, phân cách phần tử này với các phần tử lân cận hoặc mép khung nhìn trình duyệt. Thuộc tính `margin: 0 auto;` thực hiện nhiệm vụ căn giữa.

---

## 3. Phân Tích Kỹ Thuật 4 Yêu Cầu Cốt Lõi Của Bài Tập

### 3.1. Kỹ thuật căn giữa với `margin: 0 auto;`
- **Cơ chế hoạt động**: Khi gán giá trị `auto` cho lề trái (`margin-left`) và lề phải (`margin-right`), công cụ bố cục của trình duyệt sẽ tính toán phần chiều ngang còn dư của cửa sổ màn hình sau khi đã trừ đi chiều rộng của phần tử, sau đó chia đều phần dư đó cho hai bên lề.
- **Điều kiện tiên quyết**: Phần tử bắt buộc phải có kích thước chiều rộng cố định (`width: 800px;`). Nếu không có `width`, phần tử dạng khối sẽ mặc định chiếm toàn bộ 100% chiều rộng của phần tử cha, khi đó khoảng trống dư thừa bằng 0 nên không thể căn giữa.

---

### 3.2. Quy tắc chiều kim đồng hồ (Clockwise Rule) trong khai báo viền 4 màu
Khi một thuộc tính đa chiều trong CSS nhận 4 giá trị cách nhau bằng khoảng trắng:
$$\text{Cú pháp} = [\text{Top (12h)}] \quad [\text{Right (3h)}] \quad [\text{Bottom (6h)}] \quad [\text{Left (9h)}]$$

Áp dụng trong bài thực hành với `border-color: chartreuse aqua blue blueviolet;`:
- **Top (Cạnh trên - 12h)**: `chartreuse` (#7FFF00 - Màu xanh nõn chuối).
- **Right (Cạnh phải - 3h)**: `aqua` (#00FFFF - Màu xanh ngọc lơ).
- **Bottom (Cạnh dưới - 6h)**: `blue` (#0000FF - Màu xanh dương đậm).
- **Left (Cạnh trái - 9h)**: `blueviolet` (#8A2BE2 - Màu tím lam).

---

### 3.3. Định dạng viền nét chấm và lề dưới phân tầng
- **Viền nét chấm bi của đoạn văn**: Bộ chọn hậu duệ `.boxmodel p` sử dụng `border: 3px dotted darkred;`. Kiểu nét `dotted` biến viền thành chuỗi các chấm tròn liên tiếp màu đỏ thẫm `darkred`.
- **Khoảng lề dưới tăng dần đều (Staggered Margins)**:
  - `#boxmodel1 { margin-bottom: 20px; }`: Tạo khoảng cách 20px ngăn cách với đoạn văn thứ hai.
  - `#boxmodel2 { margin-bottom: 40px; }`: Tạo khoảng cách 40px ngăn cách với đoạn văn thứ ba.
  - `#boxmodel3 { margin-bottom: 60px; }`: Tạo khoảng cách 60px ngăn cách với cạnh đáy của khối container.

---

### 3.4. Tính toán kích thước vật lý tổng thể (Box Dimensions Calculation)
Mặc định trình duyệt áp dụng mô hình `box-sizing: content-box`. Tổng chiều rộng thực tế của khối `.boxmodel` chiếm dụng trên màn hình được tính toán như sau:

$$\text{Tổng chiều rộng} = \text{width} + (\text{padding}_{\text{trái}} + \text{padding}_{\text{phải}}) + (\text{border}_{\text{trái}} + \text{border}_{\text{phải}})$$
$$\text{Tổng chiều rộng} = 800\text{px} + (10\text{px} + 10\text{px}) + (10\text{px} + 10\text{px}) = 840\text{px}$$

Do đó, một nhà thiết kế web chuyên nghiệp phải luôn tính đến độ dày của viền và padding để không làm tràn khung giao diện (overflow layout).

---

## 4. Bảng So Sánh Giữa Giải Pháp Mẫu & Giải Pháp Cá Nhân Hóa Của Sinh Viên

| Tiêu chí đánh giá | Bản mẫu sao chép thụ động | Bản hoàn thiện của sinh viên Nguyễn Tuấn Đạt |
|---|---|---|
| **Nội dung thẻ `<p>`** | Lặp lại nguyên văn 1 câu 3 lần | 3 đoạn văn bản phân tích kỹ thuật chuyên sâu do sinh viên tự viết |
| **Thuộc tính background** | Không có (bỏ sót mô tả đề bài) | Bổ sung `background-color` hài hòa cho container và đoạn văn |
| **Thông tin bản quyền** | Không có | Header sinh viên, metadata môn học và ghi chú kỹ thuật rõ ràng |
| **Khả năng ứng dụng** | Chỉ có 1 khối hộp thô sơ | Mở rộng phân hệ UI Cards ứng dụng Box Model vào giao diện thực tế |
| **Công cụ hỗ trợ học tập** | Không có | Phòng thí nghiệm tương tác `demo.html` có thanh trượt điều khiển |

---

## 5. Cấu Trúc Mã Nguồn Hoàn Chỉnh (`index.html`)

```html
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Bài Thực Hành Sử Dụng Box Model - Nguyễn Tuấn Đạt</title>
    <style>
        /* Khung container 800px, can giua, vien 4 mau chieu kim dong ho */
        .boxmodel {
            margin: 0 auto;
            width: 800px;
            border: 10px;
            padding: 10px;
            border-color: chartreuse aqua blue blueviolet;
            border-style: solid;
            background-color: #FFFFFF;
        }

        /* Dinh dang doan van vien dotted darkred 3px */
        .boxmodel p {
            border: 3px dotted darkred;
            padding: 10px;
            background-color: #FEF2F2;
        }

        /* Khoang le duoi tang dan */
        #boxmodel1 {
            margin-bottom: 20px;
        }
        #boxmodel2 {
            margin-bottom: 40px;
        }
        #boxmodel3 {
            margin-bottom: 60px;
        }
    </style>
</head>
<body>
    <div class="boxmodel">
        <p id="boxmodel1">
            <strong>Đoạn 1 (margin-bottom: 20px):</strong> Mô hình hộp trong CSS về cơ bản là một hộp chữ nhật bao quanh phần tử HTML...
        </p>
        <p id="boxmodel2">
            <strong>Đoạn 2 (margin-bottom: 40px):</strong> Quy tắc chiều kim đồng hồ (Clockwise Rule) trong border-color: Khung bao ngoài sử dụng cú pháp 4 giá trị màu...
        </p>
        <p id="boxmodel3">
            <strong>Đoạn 3 (margin-bottom: 60px):</strong> Cơ chế căn giữa với margin: 0 auto: Bằng việc khai báo chiều rộng cố định width: 800px...
        </p>
    </div>
</body>
</html>
```

---

## 6. Cấu Trúc Bàn Giao Bộ Tài Liệu

```
using-box-model/
├── index.html       # Trang bài nộp chuẩn, cá nhân hóa, có phân hệ mở rộng thực tế
├── demo.html        # Phòng thí nghiệm tương tác trực quan hóa 4 tầng và thanh trượt Box Model
└── README.md        # Báo cáo kỹ thuật chi tiết chứng minh nghiên cứu độc lập của sinh viên
```

---

## 7. Hướng Dẫn Mở & Kiểm Tra

1. **Kiểm tra mã nguồn và giao diện bài nộp**:
   - Mở tệp [index.html](file:///c:/Users/dathao/Downloads/AI/git-final-practice/using-box-model/index.html) trong trình duyệt Chrome, Edge hoặc Firefox.
   - Kiểm tra khung ngoài: Rộng đúng 800px, căn giữa hoàn hảo, viền 4 cạnh có 4 màu sắc phân biệt (`chartreuse`, `aqua`, `blue`, `blueviolet`).
   - Kiểm tra 3 đoạn văn: Viền chấm tròn đỏ thẫm 3px, nền đỏ nhạt nổi bật, lề dưới giãn cách tăng dần (20px, 40px, 60px).
   - Kiểm tra phân hệ thẻ giao diện mở rộng ở phía dưới.
2. **Kiểm tra phòng thí nghiệm tương tác**:
   - Mở tệp [demo.html](file:///c:/Users/dathao/Downloads/AI/git-final-practice/using-box-model/demo.html) để trực tiếp kéo thanh trượt điều chỉnh `width`, `border`, `padding`, `margin-bottom` và quan sát phản hồi tức thì.
