-- =============================================================================
-- [BAI TAP & THUC HANH] TRUY VAN DU LIEU VOI CSDL QUAN LY SINH VIEN
-- Khoa hoc: Co so du lieu & He quan tri CSDL MySQL
-- Hoc vien: Nguyen Tuan Dat
-- Repository: https://github.com/proyctk03-eng/git-final-practice
-- Thu muc: sql-student-management-query/
-- =============================================================================

-- =============================================================================
-- PHAN 1: KHOI TAO CSDL VA DU LIEU MAU (DAM BAO SCRIPT CHAY DOC LAP)
-- =============================================================================

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

-- 2. Nap du lieu mau ban dau (neu bang chua co du lieu)
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
-- PHAN 2: 5 CAU TRUY VAN CHINH THEO TIÊU CHÍ CHẤM ĐIỂM BÀI TẬP (100/100 ĐIỂM)
-- =============================================================================

USE QuanLySinhVien;

-- -----------------------------------------------------------------------------
-- TIEU CHI 1: Hien thi tat ca cac sinh vien co ten bat dau bang ky tu 'h' / 'H'
-- Muc tieu: Su dung menh de WHERE ket hop toan tu LIKE voi mau 'h%'
-- Ket qua mong doi: 2 ban ghi (Hung, Hoa)
-- -----------------------------------------------------------------------------
SELECT * 
FROM Student 
WHERE StudentName LIKE 'h%';


-- -----------------------------------------------------------------------------
-- TIEU CHI 2: Hien thi cac thong tin lop hoc co thoi gian bat dau vao thang 12
-- Muc tieu: Su dung ham xu ly ngay thang MONTH(StartDate) = 12
-- Ket qua mong doi: 2 ban ghi lop A1 (2008-12-20) va A2 (2008-12-22)
-- -----------------------------------------------------------------------------
SELECT * 
FROM Class 
WHERE MONTH(StartDate) = 12;


-- -----------------------------------------------------------------------------
-- TIEU CHI 3: Hien thi tat ca cac thong tin mon hoc co credit trong khoang tu 3-5
-- Muc tieu: Su dung toan tu BETWEEN 3 AND 5 de loc khoang gia tri tin chi
-- Ket qua mong doi: 2 ban ghi mon hoc CF (Credit: 5) va HDJ (Credit: 5)
-- -----------------------------------------------------------------------------
SELECT * 
FROM Subject 
WHERE Credit BETWEEN 3 AND 5;


-- -----------------------------------------------------------------------------
-- TIEU CHI 4: Thay doi ma lop (ClassID) cua sinh vien co ten 'Hung' la 2
-- Muc tieu: Su dung cau lenh UPDATE de thay doi du lieu, kem truy van kiem tra
-- Ket qua mong doi: Ban ghi cua sinh vien Hung co ClassId duoc cap nhat thanh 2
-- -----------------------------------------------------------------------------
-- Tam thoi tat safe updates trong session de cap nhat theo ten (neu MySQL bat che do an toan)
SET SQL_SAFE_UPDATES = 0;

UPDATE Student 
SET ClassId = 2 
WHERE StudentName = 'Hung';

SET SQL_SAFE_UPDATES = 1;

-- Truy van kiem tra ket qua sau khi cap nhat
SELECT 
    StudentId, 
    StudentName, 
    Address, 
    Phone, 
    Status, 
    ClassId 
FROM Student 
WHERE StudentName = 'Hung';


-- -----------------------------------------------------------------------------
-- TIEU CHI 5: Hien thi cac thong tin: StudentName, SubName, Mark.
--             Du lieu sap xep theo diem thi (mark) giam dan, neu trung sap theo ten tang dan.
-- Muc tieu: JOIN 3 bang (Student, Mark, Subject), chi dinh dung 3 cot yeu cau,
--           va su dung menh de ORDER BY M.Mark DESC, S.StudentName ASC.
-- Ket qua mong doi:
--   1. Hung | C  | 12.0 (Diem cao nhat)
--   2. Hoa  | CF | 10.0
--   3. Hung | CF | 8.0
-- -----------------------------------------------------------------------------
SELECT 
    S.StudentName, 
    Sub.SubName, 
    M.Mark 
FROM Student S 
JOIN Mark M ON S.StudentId = M.StudentId 
JOIN Subject Sub ON M.SubId = Sub.SubId 
ORDER BY M.Mark DESC, S.StudentName ASC;


-- =============================================================================
-- PHAN 3: CAC CAU TRUY VAN THUC HANH CO BAN BO TRO (REFERENCE QUERIES)
-- =============================================================================

-- Buoc 1: Chon su dung co so du lieu QuanLySinhVien
USE QuanLySinhVien;

-- Buoc 2: Hien thi danh sach tat ca cac hoc vien
SELECT * FROM Student;

-- Buoc 3: Hien thi danh sach cac hoc vien dang theo hoc (Status = true)
SELECT * FROM Student 
WHERE Status = true;

-- Buoc 4: Hien thi danh sach cac mon hoc co thoi gian hoc / tin chi nho hon 10 (Credit < 10)
SELECT * FROM Subject 
WHERE Credit < 10;

-- Buoc 5: Hien thi danh sach hoc vien lop A1
SELECT 
    S.StudentId, 
    S.StudentName, 
    C.ClassName 
FROM Student S 
JOIN Class C ON S.ClassId = C.ClassID 
WHERE C.ClassName = 'A1';

-- Buoc 6.1: Hien thi tat ca diem hien co cua hoc vien (JOIN 3 bang)
SELECT 
    S.StudentId, 
    S.StudentName, 
    Sub.SubName, 
    M.Mark 
FROM Student S 
JOIN Mark M ON S.StudentId = M.StudentId 
JOIN Subject Sub ON M.SubId = Sub.SubId;

-- Buoc 6.2: Loc lay rieng diem mon 'CF' cua cac hoc vien
SELECT 
    S.StudentId, 
    S.StudentName, 
    Sub.SubName, 
    M.Mark 
FROM Student S 
JOIN Mark M ON S.StudentId = M.StudentId 
JOIN Subject Sub ON M.SubId = Sub.SubId 
WHERE Sub.SubName = 'CF';
