# [Thực hành] Gọi MySQL Stored Procedures từ JDBC (User Management)

Dự án Java Web Maven Webapp thực hiện bài thực hành gọi các Stored Procedures trong MySQL từ ứng dụng Java Web thông qua giao tiếp `CallableStatement` của thư viện JDBC theo chuẩn kiến trúc MVC của CodeGym, tương thích hoàn toàn với Apache Tomcat 10.1+ (Jakarta EE 10).

## 1. Thông tin tác giả và bản quyền

- Tác giả: Nguyễn Tuấn Đạt
- Email: proyctk03@gmail.com
- Môn học: Lập trình Java Web (JSP / Servlet / JDBC / MySQL Stored Procedures)
- Hệ thống bài tập: CodeGym Java Web Developer

## 2. Mục tiêu kỹ thuật

- Luyện tập sử dụng Stored Procedures trong MySQL để tối ưu hóa hiệu năng và bảo mật cơ sở dữ liệu.
- Sử dụng đối tượng `CallableStatement` kết hợp cú pháp chuẩn `{CALL procedure_name(?, ...)}` để gọi thủ tục từ Java JDBC.
- Tích hợp 2 thủ tục Stored Procedures cốt lõi:
  - `get_user_by_id(IN user_id INT)`: Tìm kiếm và trích xuất thông tin người dùng theo khóa chính.
  - `insert_user(IN user_name VARCHAR, IN user_email VARCHAR, IN user_country VARCHAR)`: Thêm mới người dùng vào bảng `users`.
- Áp dụng mẫu PRG (Post-Redirect-Get) sau khi thêm mới dữ liệu để ngăn ngừa tình trạng submit lặp khi người dùng tải lại trang.
- Tương thích hoàn toàn với Java 17, `mysql-connector-j` 8.3.0, và Apache Tomcat 10.1+.

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

## 4. Kịch bản SQL khởi tạo CSDL và Stored Procedures (`database/init.sql`)

```sql
CREATE DATABASE IF NOT EXISTS demo CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE demo;

CREATE TABLE IF NOT EXISTS users (
    id INT(3) NOT NULL AUTO_INCREMENT,
    name VARCHAR(120) NOT NULL,
    email VARCHAR(220) NOT NULL,
    country VARCHAR(120),
    PRIMARY KEY (id)
);

INSERT INTO users(name, email, country) VALUES('Minh', 'minh@codegym.vn', 'Viet Nam');
INSERT INTO users(name, email, country) VALUES('Kante', 'kante@che.uk', 'Kenia');
INSERT INTO users(name, email, country) VALUES('Nguyen Tuan Dat', 'proyctk03@gmail.com', 'Viet Nam');

-- 1. Tao Stored Procedure get_user_by_id
DELIMITER $$
DROP PROCEDURE IF EXISTS get_user_by_id$$
CREATE PROCEDURE get_user_by_id(IN user_id INT)
BEGIN
    SELECT users.name, users.email, users.country
    FROM users
    WHERE users.id = user_id;
END$$
DELIMITER ;

-- 2. Tao Stored Procedure insert_user
DELIMITER $$
DROP PROCEDURE IF EXISTS insert_user$$
CREATE PROCEDURE insert_user(
    IN user_name VARCHAR(50),
    IN user_email VARCHAR(50),
    IN user_country VARCHAR(50)
)
BEGIN
    INSERT INTO users(name, email, country) VALUES(user_name, user_email, user_country);
END$$
DELIMITER ;
```

## 5. Hướng dẫn cấu hình JDBC

Trong tệp `UserDAO.java`, hãy kiểm tra và chỉnh sửa thông tin kết nối phù hợp với môi trường MySQL trên máy tính của bạn:

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


## 7. [Thực hành] MySQL JDBC Transaction (Quản lý User & Permission Đồng Thời)

### 7.1. Cơ chế hoạt động của Transaction
1. **Khởi tạo Transaction:** `connection.setAutoCommit(false);`
2. **Thao tác 1 (Ghi User):** Thực hiện `INSERT INTO users (name, email, country)` với cờ `Statement.RETURN_GENERATED_KEYS` để lấy về `id` của User vừa tạo.
3. **Thao tác 2 (Ghi Permission):** Chèn các quyền được chọn (`permissionIds`) vào bảng `user_permission` liên kết với `userId`.
4. **Cam kết (Commit):** Nếu cả 2 bước thành công, gọi `connection.commit();`.
5. **Hoàn tác (Rollback):** Nếu có bất kỳ ngoại lệ `SQLException` nào xảy ra, gọi `connection.rollback();` trong khối `catch` để đảm bảo tính toàn vẹn dữ liệu (ACID), không để lại dữ liệu rác.
6. **Khôi phục trạng thái:** Trong khối `finally`, luôn thiết lập lại `connection.setAutoCommit(true);` và đóng các tài nguyên `ResultSet`, `PreparedStatement`, `Connection`.

### 7.2. Kịch bản kiểm chứng Transaction
1. Truy cập `http://localhost:8080/user-management/users?action=create`.
2. Điền thông tin người dùng mới (ví dụ: `Nguyen Van A`, `a@gmail.com`, `VN`).
3. Tích chọn các quyền: **Thêm (Add - ID 1)** và **Xem (View - ID 4)**.
4. Bấm "Save User".
5. Kiểm tra CSDL:
   ```sql
   SELECT * FROM users ORDER BY id DESC LIMIT 1;
   SELECT * FROM user_permission WHERE user_id = [new_user_id];
   ```
   Cả hai bảng đều lưu trữ thành công các bản ghi tương ứng đồng thời.

