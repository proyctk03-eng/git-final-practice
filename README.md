# [Thực hành] Thực Thi SQL Có Sử Dụng Transaction (User Management)

Dự án Java Web Maven Webapp thực hiện bài thực hành quản lý Transaction trong JDBC nhằm kiểm soát quá trình ghi dữ liệu, đảm bảo nguyên lý **All-or-Nothing** (Thành công tất cả, hoặc không có gì cả) theo chuẩn kiến trúc MVC của CodeGym, tương thích hoàn toàn với Apache Tomcat 10.1+ (Jakarta EE 10).

## 1. Thông tin tác giả và bản quyền

- Tác giả: Nguyễn Tuấn Đạt
- Email: proyctk03@gmail.com
- Môn học: Lập trình Java Web (JSP / Servlet / JDBC Transaction / MySQL Stored Procedures)
- Hệ thống bài tập: CodeGym Java Web Developer

## 2. Mục tiêu kỹ thuật

- **Kiểm soát JDBC Transaction**: Sử dụng `conn.setAutoCommit(false)` để tắt chế độ tự động ghi và gom nhóm các câu lệnh SQL vào một đơn vị giao dịch duy nhất (Unit of Work).
- **Nguyên lý All-or-Nothing**:
  - Khi mọi câu lệnh Insert và Update thực thi trót lọt: Gọi `conn.commit()` để xác nhận dữ liệu vĩnh viễn vào MySQL.
  - Khi có bất kỳ lỗi nào xảy ra: Khối catch bắt ngoại lệ, không gọi `commit()`, kết nối tự động hủy bỏ (rollback) toàn bộ các thay đổi chưa commit khi đóng kết nối.
- **Kịch bản thực nghiệm**:
  - `insertUpdateWithoutTransaction()`: Thao tác không dùng transaction, chứng minh lỗi rác dữ liệu (lệnh insert thành công nhưng lệnh update sau đó bị lỗi, gây sai lệch trạng thái hệ thống).
  - `insertUpdateUseTransaction()`: Thao tác có dùng transaction, chứng minh tính toàn vẹn (toàn bộ 2 bản ghi chèn và 1 bản ghi cập nhật đều hội tụ tại điểm commit duy nhất).
- **URL kiểm thử**:
  - `/users?action=test-use-tran`: Kích hoạt phương thức thực thi SQL có sử dụng Transaction.
  - `/users?action=test-without-tran`: Kích hoạt phương thức thực thi SQL không sử dụng Transaction.

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

## 4. Kịch bản SQL khởi tạo CSDL và bảng Employee (`database/init.sql`)

```sql
CREATE DATABASE IF NOT EXISTS demo CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE demo;

-- Bang users
CREATE TABLE IF NOT EXISTS users (
    id INT(3) NOT NULL AUTO_INCREMENT,
    name VARCHAR(120) NOT NULL,
    email VARCHAR(220) NOT NULL,
    country VARCHAR(120),
    PRIMARY KEY (id)
);

-- Bang Employee phuc vu kiem thu JDBC Transaction
CREATE TABLE IF NOT EXISTS Employee (
    id INT(11) AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    salary DECIMAL(15, 2) NOT NULL,
    created_Date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (id)
);

-- Du lieu mau ban dau
INSERT INTO users(name, email, country) VALUES('Minh', 'minh@codegym.vn', 'Viet Nam');
INSERT INTO users(name, email, country) VALUES('Kante', 'kante@che.uk', 'Kenia');
INSERT INTO users(name, email, country) VALUES('Nguyen Tuan Dat', 'proyctk03@gmail.com', 'Viet Nam');

-- Stored Procedures
DELIMITER $$
DROP PROCEDURE IF EXISTS get_user_by_id$$
CREATE PROCEDURE get_user_by_id(IN user_id INT)
BEGIN
    SELECT users.name, users.email, users.country
    FROM users
    WHERE users.id = user_id;
END$$
DELIMITER ;

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
   - Danh sách người dùng: `http://localhost:8080/user-management/users`
   - Kiểm thử Transaction: `http://localhost:8080/user-management/users?action=test-use-tran`
