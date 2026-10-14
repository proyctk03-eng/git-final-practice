# [Bài tập] Hiển thị danh sách khách hàng - JSTL JSP

Dự án Java Web Maven Webapp thực hiện bài tập hiển thị danh sách khách hàng sử dụng thư viện JSTL (JavaServer Pages Standard Tag Library) kết hợp với JSP và Servlet theo chuẩn đào tạo của CodeGym.

## 1. Thông tin tác giả và bản quyền

- Tác giả: Nguyễn Tuấn Đạt
- Email: proyctk03@gmail.com
- Môn học: Lập trình Java Web (JSP / Servlet / JSTL)
- Hệ thống bài tập: CodeGym Java Web Developer

## 2. Mục tiêu kỹ thuật

- Luyện tập sử dụng thư viện JSTL Core trong trang JSP.
- Khai báo chỉ thị thư viện thẻ taglib: `<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>`.
- Sử dụng thẻ vòng lặp `<c:forEach>` để duyệt danh sách đối tượng khách hàng `customerList`.
- Kết hợp Expression Language (EL) `${...}` để hiển thị các thuộc tính: tên khách hàng, ngày sinh, địa chỉ, hình ảnh.
- Sử dụng biến trạng thái vòng lặp `varStatus="status"` và thuộc tính `${status.count}` để đánh số thứ tự (STT) tự động từ 1.
- Hỗ trợ mô hình MVC với `CustomerServlet` định tuyến dữ liệu và hỗ trợ khởi tạo trực tiếp tại `index.jsp` khi truy cập thẳng.
- Tương thích với Java 17, Apache Tomcat 10.1+ (Jakarta EE 10) và các máy chủ servlet tiêu chuẩn.

## 3. Cấu trúc thư mục dự án

```text
customer-list-jstl/
├── pom.xml
├── README.md
└── src/
    └── main/
        ├── java/
        │   └── com/
        │       └── codegym/
        │           ├── controller/
        │           │   └── CustomerServlet.java
        │           └── model/
        │               └── Customer.java
        └── webapp/
            ├── index.jsp
            ├── images/
            │   ├── customer1.svg
            │   ├── customer2.svg
            │   ├── customer3.svg
            │   ├── customer4.svg
            │   └── customer5.svg
            └── WEB-INF/
                └── web.xml
```

## 4. Dữ liệu khách hàng mẫu (CodeGym Dataset)

| STT | Tên khách hàng | Ngày sinh | Địa chỉ | Ảnh đại diện |
|:---:|:---|:---:|:---|:---:|
| 1 | Mai Văn Hoàn | 1983-08-20 | Hà Nội | `images/customer1.svg` |
| 2 | Nguyễn Văn Nam | 1983-08-21 | Bắc Giang | `images/customer2.svg` |
| 3 | Nguyễn Thái Hòa | 1983-08-22 | Nam Định | `images/customer3.svg` |
| 4 | Trần Đăng Khoa | 1983-08-17 | Hà Tây | `images/customer4.svg` |
| 5 | Nguyễn Đình Thi | 1983-08-19 | Hà Nội | `images/customer5.svg` |

## 5. Hướng dẫn cài đặt và chạy ứng dụng

### 5.1. Biên dịch dự án bằng Maven

Chạy lệnh sau tại thư mục gốc của dự án:

```bash
mvn clean package
```

Tệp lưu trữ triển khai `customer-list-jstl.war` sẽ được tạo trong thư mục `target/`.

### 5.2. Triển khai trên Apache Tomcat 10.1+

1. Sao chép tệp `customer-list-jstl.war` vào thư mục `webapps/` của Tomcat.
2. Khởi động Tomcat bằng `bin/startup.bat` (Windows) hoặc `bin/startup.sh` (Linux/macOS).
3. Mở trình duyệt web và truy cập theo một trong các địa chỉ sau:
   - Truy cập trực tiếp trang chủ JSP: `http://localhost:8080/customer-list-jstl/`
   - Truy cập qua Servlet điều khiển MVC: `http://localhost:8080/customer-list-jstl/customers`
