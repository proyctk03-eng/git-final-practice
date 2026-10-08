# [Thực hành] Truy Vấn Dữ Liệu Với Cơ Sở Dữ Liệu Quản Lý Sinh Viên

> **Khóa học**: Cơ sở dữ liệu & Hệ quản trị CSDL MySQL  
> **Học viên thực hiện**: Nguyễn Tuấn Đạt  
> **Kho lưu trữ (Repository)**: `https://github.com/proyctk03-eng/git-final-practice`  
> **Thư mục bài tập**: `sql-student-management-query/`  
> **Nhánh tham khảo CodeGym**: `jwbd-2023-sql-student-management-select-query`

---

## 1. Mục Tiêu Bài Thực Hành
- Thành thạo việc sử dụng câu lệnh truy vấn dữ liệu (DQL - Data Query Language) với lệnh `SELECT` trong MySQL.
- Nắm vững việc lọc dữ liệu có điều kiện thông qua mệnh đề `WHERE`:
  - Lọc dữ liệu logic/boolean: `WHERE Status = true` (hoặc `Status = 1`).
  - Lọc dữ liệu so sánh số học: `WHERE Credit < 10`.
- Hiểu và áp dụng cơ chế kết nối bảng (`INNER JOIN` / `JOIN`):
  - Kết nối 2 bảng: `Student` kết nối với `Class` thông qua cặp khóa `Student.ClassId = Class.ClassID`.
  - Kết nối đa bảng (3 bảng liên kết): `Student` kết nối với bảng trung gian `Mark` và bảng danh mục `Subject` để truy vấn điểm thi của sinh viên theo từng môn học cụ thể.

---

## 2. Sơ Đồ Thực Thể & Cơ Chế Truy Vấn (ERD & JOIN Query Workflow)

![Sơ đồ ERD và Cơ chế JOIN Truy vấn CSDL Quản lý sinh viên](erd_quanly_sinhvien_queries.png)

---

## 3. Nội Dung Thực Hiện Theo 6 Bước Hướng Dẫn

### Bước 1: Chọn cơ sở dữ liệu `QuanLySinhVien`
Trước khi thực hiện truy vấn, cần chỉ định cơ sở dữ liệu làm việc hiện tại:

```sql
USE QuanLySinhVien;
```

---

### Bước 2: Hiển thị danh sách tất cả các học viên
- **Mục tiêu**: Lấy toàn bộ bản ghi và tất cả các trường dữ liệu từ bảng `Student`.
- **Cú pháp SQL**:
```sql
SELECT * FROM Student;
```

- **Kết quả trả về**:

| StudentId | StudentName | Address   | Phone       | Status | ClassId |
|:----------|:------------|:----------|:------------|:-------|:--------|
| 1         | Hung        | Ha Noi    | 0912113113  | 1      | 1       |
| 2         | Hoa         | Hai phong | NULL        | 1      | 1       |
| 3         | Manh        | HCM       | 0123123123  | 0      | 2       |

---

### Bước 3: Hiển thị danh sách các học viên đang theo học
- **Mục tiêu**: Lọc các học viên có trạng thái hoạt động (`Status = true` hoặc `Status = 1`).
- **Cú pháp SQL**:
```sql
SELECT * FROM Student 
WHERE Status = true;
```

- **Kết quả trả về**:

| StudentId | StudentName | Address   | Phone       | Status | ClassId |
|:----------|:------------|:----------|:------------|:-------|:--------|
| 1         | Hung        | Ha Noi    | 0912113113  | 1      | 1       |
| 2         | Hoa         | Hai phong | NULL        | 1      | 1       |

*Ghi chú*: Sinh viên `Manh` có `Status = 0` (đã thôi học/tạm nghỉ) nên đã bị lọc bỏ chính xác.

---

### Bước 4: Hiển thị danh sách các môn học có thời gian học nhỏ hơn 10 giờ (Credit < 10)
- **Mục tiêu**: Lọc các môn học có số giờ tín chỉ nhỏ hơn 10 từ bảng `Subject`.
- **Cú pháp SQL**:
```sql
SELECT * FROM Subject 
WHERE Credit < 10;
```

- **Kết quả trả về**:

| SubId | SubName | Credit | Status |
|:------|:--------|:-------|:-------|
| 1     | CF      | 5      | 1      |
| 2     | C       | 6      | 1      |
| 3     | HDJ     | 5      | 1      |

*Ghi chú*: Môn học `RDBMS` có số tín chỉ là 10 (điều kiện `< 10` là so sánh nghiêm ngặt) nên bị loại khỏi tập kết quả.

---

### Bước 5: Hiển thị danh sách học viên lớp A1
- **Mục tiêu**: Kết nối bảng `Student` (S) và bảng `Class` (C) thông qua khóa ngoại `S.ClassId = C.ClassID`, sau đó lọc ra học viên thuộc lớp có tên `A1`.
- **Cú pháp SQL**:
```sql
SELECT 
    S.StudentId, 
    S.StudentName, 
    C.ClassName 
FROM Student S 
JOIN Class C ON S.ClassId = C.ClassID 
WHERE C.ClassName = 'A1';
```

- **Kết quả trả về**:

| StudentId | StudentName | ClassName |
|:----------|:------------|:----------|
| 1         | Hung        | A1        |
| 2         | Hoa         | A1        |

---

### Bước 6: Hiển thị điểm môn CF của các học viên

#### 6.1. Hiển thị tất cả điểm hiện có của học viên (JOIN 3 bảng: Student, Mark, Subject)
- **Mục tiêu**: Ghép nối dữ liệu từ 3 bảng để hiển thị tên học viên, tên môn học và điểm thi tương ứng.
- **Cú pháp SQL**:
```sql
SELECT 
    S.StudentId, 
    S.StudentName, 
    Sub.SubName, 
    M.Mark 
FROM Student S 
JOIN Mark M ON S.StudentId = M.StudentId 
JOIN Subject Sub ON M.SubId = Sub.SubId;
```

- **Kết quả trả về (Toàn bộ điểm)**:

| StudentId | StudentName | SubName | Mark |
|:----------|:------------|:--------|:-----|
| 1         | Hung        | CF      | 8.0  |
| 2         | Hoa         | CF      | 10.0 |
| 1         | Hung        | C       | 12.0 |

#### 6.2. Lọc riêng điểm môn 'CF' của các học viên
- **Mục tiêu**: Thêm điều kiện `WHERE Sub.SubName = 'CF'` vào truy vấn JOIN 3 bảng.
- **Cú pháp SQL**:
```sql
SELECT 
    S.StudentId, 
    S.StudentName, 
    Sub.SubName, 
    M.Mark 
FROM Student S 
JOIN Mark M ON S.StudentId = M.StudentId 
JOIN Subject Sub ON M.SubId = Sub.SubId 
WHERE Sub.SubName = 'CF';
```

- **Kết quả trả về**:

| StudentId | StudentName | SubName | Mark |
|:----------|:------------|:--------|:-----|
| 1         | Hung        | CF      | 8.0  |
| 2         | Hoa         | CF      | 10.0 |

---

## 4. Hướng Dẫn Thực Thi Tập Lệnh SQL Độc Lập

File `student_management_query.sql` đã được thiết kế sẵn cấu trúc DDL và lệnh nạp dữ liệu mẫu tự động bằng cú pháp `CREATE TABLE IF NOT EXISTS` và `INSERT IGNORE INTO`. Do đó người dùng có thể thực thi tập lệnh độc lập hoàn toàn mà không cần phụ thuộc vào trạng thái dữ liệu trước đó.

### Thực thi qua MySQL Command Line Client:
```bash
mysql -u root -p < student_management_query.sql
```

### Thực thi trong MySQL Workbench / DBeaver / Navicat:
1. Mở file `student_management_query.sql`.
2. Chọn `Execute Entire Script (SQL)` (phím tắt `Ctrl + Shift + Enter`).
3. Quan sát các Result Grid tương ứng với từng câu truy vấn từ Bước 2 đến Bước 6.
