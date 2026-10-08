-- =============================================================================
-- [Thuc hanh] Them du lieu vao trong co so du lieu quan ly sinh vien
-- Repository tham khao: https://github.com/codegym-vn/jwbd-2023-sql-student-management-insert-into
-- =============================================================================

-- PHAN 1: KHOI TAO CO SO DU LIEU VA CAC BANG (DDL)
CREATE DATABASE IF NOT EXISTS QuanLySinhVien;
USE QuanLySinhVien;

-- 1. Tao bang Class (Lop hoc)
CREATE TABLE IF NOT EXISTS Class (
    ClassID INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    ClassName VARCHAR(60) NOT NULL,
    StartDate DATETIME NOT NULL,
    Status BIT
);

-- 2. Tao bang Student (Hoc vien)
CREATE TABLE IF NOT EXISTS Student (
    StudentId INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    StudentName VARCHAR(30) NOT NULL,
    Address VARCHAR(50),
    Phone VARCHAR(20),
    Status BIT,
    ClassId INT NOT NULL,
    CONSTRAINT FK_Student_Class FOREIGN KEY (ClassId) REFERENCES Class (ClassID)
);

-- 3. Tao bang Subject (Mon hoc)
CREATE TABLE IF NOT EXISTS Subject (
    SubId INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    SubName VARCHAR(30) NOT NULL,
    Credit TINYINT NOT NULL DEFAULT 1 CHECK (Credit >= 1),
    Status BIT DEFAULT 1
);

-- 4. Tao bang Mark (Diem thi)
CREATE TABLE IF NOT EXISTS Mark (
    MarkId INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    SubId INT NOT NULL,
    StudentId INT NOT NULL,
    Mark FLOAT DEFAULT 0 CHECK (Mark BETWEEN 0 AND 100),
    ExamTimes TINYINT DEFAULT 1,
    UNIQUE (SubId, StudentId),
    CONSTRAINT FK_Mark_Subject FOREIGN KEY (SubId) REFERENCES Subject (SubId),
    CONSTRAINT FK_Mark_Student FOREIGN KEY (StudentId) REFERENCES Student (StudentId)
);

-- =============================================================================
-- PHAN 2: THEM DU LIEU VAO CAC BANG THEO 5 BUOC HUONG DAN (DML)
-- =============================================================================

-- Buoc 1: Su dung co so du lieu QuanLySinhVien
USE QuanLySinhVien;

-- Buoc 2: Them lan luot cac ban ghi vao trong bang Class
INSERT INTO Class VALUES (1, 'A1', '2008-12-20', 1);
INSERT INTO Class VALUES (2, 'A2', '2008-12-22', 1);
INSERT INTO Class VALUES (3, 'B3', current_date, 0);

-- Buoc 3: Them du lieu vao trong bang Student
-- Luu y: Ban ghi 'Hoa' khong truyen Phone, truong Phone se nhan gia tri NULL mac dinh
INSERT INTO Student (StudentName, Address, Phone, Status, ClassId) 
VALUES ('Hung', 'Ha Noi', '0912113113', 1, 1);

INSERT INTO Student (StudentName, Address, Status, ClassId) 
VALUES ('Hoa', 'Hai phong', 1, 1);

INSERT INTO Student (StudentName, Address, Phone, Status, ClassId) 
VALUES ('Manh', 'HCM', '0123123123', 0, 2);

-- Buoc 4: Them du lieu nhanh vao trong bang Subject (Batch Insert)
INSERT INTO Subject VALUES 
(1, 'CF', 5, 1),
(2, 'C', 6, 1),
(3, 'HDJ', 5, 1),
(4, 'RDBMS', 10, 1);

-- Buoc 5: Them du lieu vao trong bang Mark
INSERT INTO Mark (SubId, StudentId, Mark, ExamTimes) 
VALUES 
(1, 1, 8, 1),
(1, 2, 10, 2),
(2, 1, 12, 1);

-- =============================================================================
-- PHAN 3: TRUY VAN KIEM TRA VA XAC MINH DU LIEU (VERIFICATION QUERIES)
-- =============================================================================

-- 1. Xem danh sach lop hoc
SELECT * FROM Class;

-- 2. Xem danh sach hoc vien (kiem tra truong Phone cua 'Hoa' la NULL)
SELECT StudentId, StudentName, Address, IFNULL(Phone, 'Khong co') AS Phone, Status, ClassId 
FROM Student;

-- 3. Xem danh sach mon hoc
SELECT * FROM Subject;

-- 4. Xem danh sach diem thi
SELECT * FROM Mark;

-- 5. Truy van tong hop danh sach diem thi chi tiet cua tung hoc vien
SELECT 
    s.StudentId,
    s.StudentName,
    c.ClassName,
    sub.SubName,
    m.Mark AS DiemThi,
    m.ExamTimes AS LanThi
FROM Mark m
JOIN Student s ON m.StudentId = s.StudentId
JOIN Subject sub ON m.SubId = sub.SubId
JOIN Class c ON s.ClassId = c.ClassID
ORDER BY s.StudentId, sub.SubName;
