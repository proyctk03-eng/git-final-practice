# [Bài tập] Tạo Ứng Dụng Quản Lý Sản Phẩm - Kiến Trúc MVC

Dự án Java Web Maven Webapp thực hiện bài tập xây dựng ứng dụng quản lý sản phẩm (CRUD & Search) theo chuẩn kiến trúc MVC (Model - View - Controller) của CodeGym.

## 1. Thông tin tác giả và bản quyền

- Tác giả: Nguyễn Tuấn Đạt
- Email: proyctk03@gmail.com
- Môn học: Lập trình Java Web (JSP / Servlet / JSTL / MVC)
- Hệ thống bài tập: CodeGym Java Web Developer

## 2. Mục tiêu kỹ thuật và Kiến trúc MVC

Dự án triển khai theo mô hình kiến trúc MVC hoàn chỉnh:
- **Model**:
  - `Product.java`: Lớp thực thể đóng gói các thuộc tính `id`, `name`, `price`, `description`, `manufacturer`.
- **Service Layer**:
  - `ProductService.java`: Interface định nghĩa các nghiệp vụ: `findAll()`, `save()`, `findById()`, `update()`, `remove()`, `findByName()`.
  - `ProductServiceImpl.java`: Triển khai nghiệp vụ lưu trữ trên bộ nhớ mô phỏng dữ liệu sản phẩm.
- **Controller**:
  - `ProductServlet.java`: Tiếp nhận các HTTP Request (`GET`, `POST`), phân tích tham số `action`, điều phối tầng Service và điều hướng (forward / redirect) sang View tương ứng.
- **View (JSP & JSTL)**:
  - `list.jsp`: Hiển thị bảng danh sách sản phẩm, thanh tìm kiếm, và các nút điều hướng CRUD.
  - `create.jsp`: Biểu mẫu thêm mới sản phẩm có kiểm tra tính hợp lệ.
  - `edit.jsp`: Biểu mẫu cập nhật thông tin sản phẩm (khóa trường ID không cho chỉnh sửa).
  - `delete.jsp`: Màn hình cảnh báo và xác nhận xóa sản phẩm an toàn.
  - `view.jsp`: Xem chi tiết thông số và mô tả sản phẩm.
  - `index.jsp`: Chuyển hướng người dùng từ trang gốc sang `/products`.
  - `error-404.jsp`: Trang thông báo lỗi khi không tìm thấy mã sản phẩm.

## 3. Cấu trúc thư mục dự án

```text
product-management-mvc/
├── pom.xml
├── README.md
└── src/
    └── main/
        ├── java/
        │   └── com/
        │       └── codegym/
        │           ├── controller/
        │           │   └── ProductServlet.java
        │           ├── model/
        │           │   └── Product.java
        │           └── service/
        │               ├── ProductService.java
        │               └── ProductServiceImpl.java
        └── webapp/
            ├── error-404.jsp
            ├── index.jsp
            ├── product/
            │   ├── create.jsp
            │   ├── delete.jsp
            │   ├── edit.jsp
            │   ├── list.jsp
            │   └── view.jsp
            └── WEB-INF/
                └── web.xml
```

## 4. Danh sách chức năng chính

| STT | Chức năng | Action | Phương thức | Mô tả |
|:---:|:---|:---:|:---:|:---|
| 1 | Hiển thị danh sách | `action=""` | GET | Hiển thị toàn bộ sản phẩm bằng bảng JSTL `<c:forEach>` |
| 2 | Tìm kiếm theo tên | `action="search"` | GET/POST | Lọc sản phẩm theo từ khóa tên hoặc nhà sản xuất |
| 3 | Thêm mới sản phẩm | `action="create"` | GET (form), POST (lưu) | Nhập và lưu thông tin sản phẩm mới vào danh sách |
| 4 | Cập nhật thông tin | `action="edit"` | GET (form), POST (cập nhật) | Chỉnh sửa tên, giá, mô tả và hãng sản xuất |
| 5 | Xóa sản phẩm | `action="delete"` | GET (xác nhận), POST (xóa) | Xóa sản phẩm khỏi danh sách |
| 6 | Xem chi tiết | `action="view"` | GET | Hiển thị toàn bộ thông tin chi tiết của sản phẩm |

## 5. Dữ liệu mẫu ban đầu

1. **iPhone 15 Pro** - Giá: 27,990,000 VNĐ - Hãng: Apple - Mô tả: Titan tự nhiên, chip A17 Pro mạnh mẽ
2. **Samsung Galaxy S24 Ultra** - Giá: 29,990,000 VNĐ - Hãng: Samsung - Mô tả: Galaxy AI, màn hình 6.8 inch Dynamic AMOLED 2X
3. **MacBook Air M3** - Giá: 26,490,000 VNĐ - Hãng: Apple - Mô tả: Màn hình 13.6 inch Liquid Retina, pin 18 giờ
4. **Sony WH-1000XM5** - Giá: 7,990,000 VNĐ - Hãng: Sony - Mô tả: Tai nghe chống ồn chủ động không dây cao cấp
5. **Dell XPS 13 Plus** - Giá: 34,500,000 VNĐ - Hãng: Dell - Mô tả: Core i7 1360P, màn hình OLED 3.5K cảm ứng
6. **iPad Pro M2** - Giá: 21,990,000 VNĐ - Hãng: Apple - Mô tả: Màn hình 11 inch 120Hz Liquid Retina ProMotion

## 6. Hướng dẫn cài đặt và triển khai

### 6.1. Đóng gói với Maven

```bash
mvn clean package
```

Tệp `product-management-mvc.war` sẽ được sinh ra trong thư mục `target/`.

### 6.2. Chạy ứng dụng trên Apache Tomcat 10.1+

1. Đặt tệp `.war` vào thư mục `webapps/` của Tomcat.
2. Khởi chạy máy chủ Tomcat.
3. Truy cập trình duyệt theo địa chỉ: `http://localhost:8080/product-management-mvc/products`.
