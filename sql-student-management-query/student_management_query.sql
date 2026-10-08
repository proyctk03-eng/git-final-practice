-- =============================================================================
-- [Thuc hanh] Truy van du lieu voi CSDL Quan ly sinh vien
-- Repository tham khao: https://github.com/codegym-vn/jwbd-2023-sql-student-management-select-query
-- =============================================================================

-- PHAN 1: KHOI TAO CSDL VA DU LIEU MAU (DAM BAO SCRIPT CHAY DOC LAP)
CREATE DATABASE IF NOT EXISTS QuanLySinhVien;
USE QuanLySinhVien;

-- 1. Tao cac bang neu chua co
CREATE TABLE IF NOT EXISTS Class (
    ClassID INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    ClassName VARCHAR(60) NOT NULL,
    StartDate DATETIME NOT NULL,
    Status BIT
);

CREATE TABLE IF NOT EXISTS Student (
    StudentId INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    StudentName VARCHAR(30) NOT NULL,
    Address VARCHAR(50),
    Phone VARCHAR(20),
    Status BIT,
    ClassId INT NOT NULL,
    CONSTRAINT FK_Student_Class FOREIGN KEY (ClassId) REFERENCES Class (ClassID)
);

CREATE TABLE IF NOT EXISTS Subject (
    SubId INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    SubName VARCHAR(30) NOT NULL,
    Credit TINYINT NOT NULL DEFAULT 1 CHECK (Credit >= 1),
    Status BIT DEFAULT 1
);

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

-- 2. Nap du lieu mau (neu bang rong)
INSERT IGNORE INTO Class (ClassID, ClassName, StartDate, Status) VALUES
(1, 'A1', '2008-12-20', 1),
(2, 'A2', '2008-12-22', 1),
(3, 'B3', CURRENT_DATE, 0);

INSERT IGNORE INTO Student (StudentId, StudentName, Address, Phone, Status, ClassId) VALUES
(1, 'Hung', 'Ha Noi', '0912113113', 1, 1),
(2, 'Hoa', 'Hai phong', NULL, 1, 1),
(3, 'Manh', 'HCM', '0123123123', 0, 2);

INSERT IGNORE INTO Subject (SubId, SubName, Credit, Status) VALUES
(1, 'CF', 5, 1),
(2, 'C', 6, 1),
(3, 'HDJ', 5, 1),
(4, 'RDBMS', 10, 1);

INSERT IGNORE INTO Mark (MarkId, SubId, StudentId, Mark, ExamTimes) VALUES
(1, 1, 1, 8, 1),
(2, 1, 2, 10, 2),
(3, 2, 1, 12, 1);


-- =============================================================================
-- PHAN 2: CAC CAU TRUY VAN DU LIEU THEO 6 BUOC HUONG DAN
-- =============================================================================

-- Buoc 1: Chon su dung co so du lieu QuanLySinhVien
USE QuanLySinhVien;

-- Buoc 2: Hien thi danh sach tat ca cac hoc vien
-- Muc tieu: Lay toan bo cot va dong trong bang Student
SELECT * FROM Student;

-- Buoc 3: Hien thi danh sach cac hoc vien dang theo hoc (Status = true hoac 1)
-- Muc tieu: Su dung menh de WHERE de loc theo dieu kien Status = true
SELECT * FROM Student 
WHERE Status = true;

-- Buoc 4: Hien thi danh sach cac mon hoc co thoi gian hoc / tin chi nho hon 10 (Credit < 10)
-- Muc tieu: Loc du lieu so sanh so hoc tren bang Subject
SELECT * FROM Subject 
WHERE Credit < 10;

-- Buoc 5: Hien thi danh sach hoc vien lop A1
-- Muc tieu: Ket noi (JOIN) 2 bang Student va Class theo khoa ClassId = ClassID,
-- ket hop menh de WHERE ClassName = 'A1'
SELECT 
    S.StudentId, 
    S.StudentName, 
    C.ClassName 
FROM Student S 
JOIN Class C ON S.ClassId = C.ClassID 
WHERE C.ClassName = 'A1';

-- Buoc 6: Hien thi diem mon CF cua cac hoc vien
-- 6.1. Hien thi tat ca diem hien co cua hoc vien (JOIN 3 bang: Student, Mark, Subject)
SELECT 
    S.StudentId, 
    S.StudentName, 
    Sub.SubName, 
    M.Mark 
FROM Student S 
JOIN Mark M ON S.StudentId = M.StudentId 
JOIN Subject Sub ON M.SubId = Sub.SubId;

-- 6.2. Loc lay rieng diem mon 'CF' cua cac hoc vien
SELECT 
    S.StudentId, 
    S.StudentName, 
    Sub.SubName, 
    M.Mark 
FROM Student S 
JOIN Mark M ON S.StudentId = M.StudentId 
JOIN Subject Sub ON M.SubId = Sub.SubId 
WHERE Sub.SubName = 'CF';
