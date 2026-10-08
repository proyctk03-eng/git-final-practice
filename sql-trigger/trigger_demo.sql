-- =============================================================================
-- [THUC HANH] TRIGGER TRONG MYSQL
-- Co so du lieu: company
-- Bang: employees
-- Khoa hoc: Co so du lieu & He quan tri CSDL MySQL
-- Hoc vien: Nguyen Tuan Dat
-- Repository: https://github.com/proyctk03-eng/git-final-practice
-- Thu muc: sql-trigger/
-- Nhanh tham khao: https://github.com/codegym-vn/jwbd-2023-trigger (dev)
-- =============================================================================

-- =============================================================================
-- PHAN 1: KHOI TAO CSDL COMPANY VA BANG EMPLOYEES
-- =============================================================================

CREATE DATABASE IF NOT EXISTS company;
USE company;

-- Xoa bang neu da ton tai de dam bao tinh toan ven khi chay lai script
DROP TABLE IF EXISTS employees;

CREATE TABLE employees (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    department VARCHAR(50) NOT NULL,
    salary DECIMAL(10,2) NOT NULL
);


-- =============================================================================
-- PHAN 2: TAO TRIGGER update_department
-- =============================================================================
-- Muc tieu: Tu dong kiem tra muc luong (NEW.salary) va gan lai phong ban (NEW.department)
--           truoc khi dong du lieu duoc chen vao bang (BEFORE INSERT).
-- Quy tac nghiep vu:
--   - salary >= 5000 : phong ban 'Management'
--   - salary >= 3000 : phong ban 'Sales'
--   - con lai        : phong ban 'Support'
--
-- Luu y ky thuat:
--   - Su dung BEFORE INSERT boi vi bien gia lap NEW chi co the duoc sua doi (SET NEW.col = ...)
--     trong trigger BEFORE. Trong trigger AFTER, ban ghi da duoc ghi xuong bang va NEW chi doc (read-only).

DELIMITER //

DROP TRIGGER IF EXISTS update_department //

CREATE TRIGGER update_department
BEFORE INSERT ON employees
FOR EACH ROW
BEGIN
    IF NEW.salary >= 5000 THEN
        SET NEW.department = 'Management';
    ELSEIF NEW.salary >= 3000 THEN
        SET NEW.department = 'Sales';
    ELSE
        SET NEW.department = 'Support';
    END IF;
END //

DELIMITER ;


-- =============================================================================
-- PHAN 3: DEMO CHEN DU LIEU VA KIEM TRA HOAT DONG CUA TRIGGER
-- =============================================================================
-- Mac du gia tri department duoc truyen vao la 'A', trigger se ghi de theo quy tac luong:

INSERT INTO employees (name, department, salary) VALUES
('John Doe', 'A', 3500),
('Jane Smith', 'A', 2000),
('David Johnson', 'A', 6000);

-- Truy van kiem tra ket qua thuc te
SELECT 
    id, 
    name, 
    department, 
    salary 
FROM employees 
ORDER BY id ASC;


-- =============================================================================
-- PHAN 4: MO RONG - TRIGGER GHI NHAT KY KIEM TOAN (AUDIT LOG TRIGGER)
-- =============================================================================
-- Tao bang luu vet lich su thay doi luong nhan vien
CREATE TABLE IF NOT EXISTS salary_audit (
    audit_id INT AUTO_INCREMENT PRIMARY KEY,
    employee_id INT NOT NULL,
    employee_name VARCHAR(50) NOT NULL,
    old_salary DECIMAL(10,2) NOT NULL,
    new_salary DECIMAL(10,2) NOT NULL,
    action_type VARCHAR(20) NOT NULL,
    changed_at DATETIME NOT NULL
);

-- Tao Trigger AFTER UPDATE de ghi log tu dong khi co thao tac cap nhat luong
DELIMITER //

DROP TRIGGER IF EXISTS trg_audit_salary_update //

CREATE TRIGGER trg_audit_salary_update
AFTER UPDATE ON employees
FOR EACH ROW
BEGIN
    -- Chi ghi log khi luong thuc su bi thay doi
    IF OLD.salary <> NEW.salary THEN
        INSERT INTO salary_audit (
            employee_id, 
            employee_name, 
            old_salary, 
            new_salary, 
            action_type, 
            changed_at
        ) VALUES (
            OLD.id, 
            OLD.name, 
            OLD.salary, 
            NEW.salary, 
            'SALARY_UPDATE', 
            NOW()
        );
    END IF;
END //

DELIMITER ;

-- Thu nghiem tang luong cho nhan vien Jane Smith tu 2000 len 3200
UPDATE employees 
SET salary = 3200 
WHERE name = 'Jane Smith';

-- Kiem tra bang audit log de xac nhan trigger hoat dong tu dong
SELECT * FROM salary_audit;
