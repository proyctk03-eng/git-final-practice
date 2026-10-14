# [Thực hành] Quản Lý User Sử Dụng JSP-Servlet-JDBC-MySQL

Dự án Java Web Maven Webapp thực hiện bài thực hành quản lý người dùng (CRUD) kết nối cơ sở dữ liệu MySQL thông qua JDBC theo chuẩn kiến trúc MVC của CodeGym, tương thích hoàn toàn với Apache Tomcat 10.1+ (Jakarta EE 10).

## 1. Thông tin tác giả và bản quyền

- Tác giả: Nguyễn Tuấn Đạt
- Email: proyctk03@gmail.com
- Môn học: Lập trình Java Web (JSP / Servlet / JDBC / MySQL)
- Hệ thống bài tập: CodeGym Java Web Developer

## 2. Mục tiêu kỹ thuật

- Luyện tập sử dụng JDBC (Java Database Connectivity) để kết nối MySQL trong ứng dụng Java Web.
- Áp dụng mô hình kiến trúc MVC (Model - View - Controller):
  - **Model**: `User.java` đóng gói các thuộc tính `id`, `name`, `email`, `country`.
  - **DAO Layer**: `IUserDAO.java` định nghĩa các phương thức CRUD và `UserDAO.java` triển khai kết nối cơ sở dữ liệu qua `DriverManager`, `PreparedStatement`, `ResultSet`.
  - **Controller**: `UserServlet.java` tiếp nhận HTTP Request (`GET`, `POST`), phân tích tham số `action`, điều phối tầng DAO và chuyển hướng sang View.
  - **View**: Các trang JSP (`list.jsp`, `create.jsp`, `edit.jsp`, `delete.jsp`, `index.jsp`) sử dụng thẻ thư viện JSTL (`<c:forEach>`, `<c:out>`, `<c:choose>`).
- Thực hiện đầy đủ 4 thao tác CRUD:
  - Create: Thêm mới User.
  - Read: Hiển thị danh sách User.
  - Update: Sửa thông tin User.
  - Delete: Xóa User khỏi hệ thống với giao diện xác nhận.
- Cấu hình Maven tương thích Java 17, `mysql-connector-j` 8.3.0, và Tomcat 10.1+.

## 3. Cấu trúc thư mục dự án

```text
user-management/
├── database/
│   └── init.sql
├── pom.xml
├── README.md
└── src/
    └── main/
        ├── java/
        │   └── com/
        │       └── codegym/
        │           ├── controller/
        │           │   └── UserServlet.java
        │           ├── dao/
        │           │   ├── IUserDAO.java
        │           │   └── UserDAO.java
        │           └── model/
        │               └── User.java
        └── webapp/
            ├── index.jsp
            ├── user/
            │   ├── create.jsp
            │   ├── delete.jsp
            │   ├── edit.jsp
            │   └── list.jsp
            └── WEB-INF/
                └── web.xml
```

## 4. Kịch bản SQL khởi tạo cơ sở dữ liệu (`database/init.sql`)

```sql
CREATE DATABASE IF NOT EXISTS demo CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE demo;

CREATE TABLE users (
    id INT(3) NOT NULL AUTO_INCREMENT,
    name VARCHAR(120) NOT NULL,
    email VARCHAR(220) NOT NULL,
    country VARCHAR(120),
    PRIMARY KEY (id)
);

INSERT INTO users(name, email, country) VALUES('Minh', 'minh@codegym.vn', 'Viet Nam');
INSERT INTO users(name, email, country) VALUES('Kante', 'kante@che.uk', 'Kenia');
INSERT INTO users(name, email, country) VALUES('Nguyen Tuan Dat', 'proyctk03@gmail.com', 'Viet Nam');
```

## 5. Hướng dẫn cấu hình JDBC

Trong tệp `UserDAO.java`, hãy chỉnh sửa thông tin kết nối phù hợp với môi trường MySQL trên máy tính của bạn:

```java
private String jdbcURL = "jdbc:mysql://localhost:3306/demo?useSSL=false&allowPublicKeyRetrieval=true&useUnicode=true&characterEncoding=UTF-8&serverTimezone=UTC";
private String jdbcUsername = "root";
private String jdbcPassword = "your_mysql_password";
```

## 6. Hướng dẫn đóng gói và triển khai

### 6.1. Đóng gói Maven

Chạy lệnh sau tại thư mục gốc của dự án:

```bash
mvn clean package
```

Tệp lưu trữ `user-management.war` sẽ được sinh ra trong thư mục `target/`.

### 6.2. Triển khai lên Apache Tomcat 10.1+

1. Copy tệp `user-management.war` vào thư mục `webapps/` của Tomcat.
2. Khởi động Tomcat bằng `bin/startup.bat` (Windows) hoặc `bin/startup.sh` (Linux/macOS).
3. Truy cập vào ứng dụng qua địa chỉ:
   `http://localhost:8080/user-management/users`
