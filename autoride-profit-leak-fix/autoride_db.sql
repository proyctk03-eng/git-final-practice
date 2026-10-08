-- =============================================================================
-- HE THONG QUAN LY CHO THUE XE AUTORIDE (AUTORIDE DATABASE OPTIMIZED)
-- Giai quyet su co boc hoi loi nhuan do du lieu lech pha voi Activity Diagram
-- =============================================================================

CREATE DATABASE IF NOT EXISTS autoride_db;
USE autoride_db;

-- 1. BANG DANH MUC XE (CARS)
CREATE TABLE IF NOT EXISTS Cars (
    car_id INT AUTO_INCREMENT PRIMARY KEY,
    model_name VARCHAR(100) NOT NULL,
    license_plate VARCHAR(20) UNIQUE NOT NULL
);

-- 2. BANG HOP DONG THUE XE (RENTALS) - DA TOI UU & CHUAN HOA
-- Khac phuc Data Gaps:
-- + status su dung ENUM khoa chat vong doi hop dong: BOOKED, ACTIVE, COMPLETED, CANCELLED.
-- + security_deposit, late_fee, damage_fee su dung DECIMAL(12, 2) tranh sai so dau phay dong.
CREATE TABLE IF NOT EXISTS Rentals (
    rental_id INT AUTO_INCREMENT PRIMARY KEY,
    car_id INT NOT NULL,
    customer_name VARCHAR(100) NOT NULL,
    rent_date DATETIME NOT NULL,
    return_date DATETIME,
    status ENUM('BOOKED', 'ACTIVE', 'COMPLETED', 'CANCELLED') NOT NULL DEFAULT 'BOOKED',
    security_deposit DECIMAL(12, 2) NOT NULL DEFAULT 0.00,
    late_fee DECIMAL(12, 2) NOT NULL DEFAULT 0.00,
    damage_fee DECIMAL(12, 2) NOT NULL DEFAULT 0.00,
    CONSTRAINT FK_Rentals_Cars FOREIGN KEY (car_id) 
        REFERENCES Cars(car_id) ON DELETE RESTRICT ON UPDATE CASCADE
);

-- 3. BANG BIEN BAN KIEM TRA XE (INSPECTIONS) - MOI
-- Ghi nhan chi tiet tinh trang xe luc nhan/tra xe, nguoi kiem tra va vi tri hu hong
CREATE TABLE IF NOT EXISTS Inspections (
    inspection_id INT AUTO_INCREMENT PRIMARY KEY,
    rental_id INT NOT NULL,
    inspection_date DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    damage_description TEXT,
    inspector_name VARCHAR(100) NOT NULL,
    CONSTRAINT FK_Inspections_Rentals FOREIGN KEY (rental_id) 
        REFERENCES Rentals(rental_id) ON DELETE RESTRICT ON UPDATE CASCADE
);

-- 4. TRIGGER RANG BUOC NGHIEP VU (BUSINESS RULE ENFORCEMENT)
-- Chặn ghi nhận biên bản kiểm tra xe nếu hợp đồng đang ở trạng thái 'BOOKED' (khách chưa nhận xe)
DELIMITER //
CREATE TRIGGER before_insert_inspections
BEFORE INSERT ON Inspections
FOR EACH ROW
BEGIN
    DECLARE current_status ENUM('BOOKED', 'ACTIVE', 'COMPLETED', 'CANCELLED');
    
    SELECT status INTO current_status 
    FROM Rentals 
    WHERE rental_id = NEW.rental_id;
    
    IF current_status = 'BOOKED' THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Loi nghiep vu: Khong the tao bien ban kiem tra xe khi hop dong dang o trang thai BOOKED. Khach hang chua nhan xe.';
    END IF;
END //
DELIMITER ;

-- =============================================================================
-- KICH BAN MO PHONG DU LIEU THUC TE (DML SIMULATION)
-- =============================================================================

-- Buoc 1: Them xe vao doi xe AutoRide
INSERT INTO Cars (model_name, license_plate) VALUES
('VinFast VF8 Plus', '30K-888.88'),
('Hyundai SantaFe 2024', '30K-999.99');

-- Buoc 2: Khach hang 'Nguyen Van A' thue xe, dong coc 10.000.000 VND, trang thai ACTIVE
INSERT INTO Rentals (car_id, customer_name, rent_date, status, security_deposit, late_fee, damage_fee)
VALUES (1, 'Nguyen Van A', '2026-10-06 08:00:00', 'ACTIVE', 10000000.00, 0.00, 0.00);

-- Luu ma rental_id vua tao de tiep tuc xu ly
SET @current_rental_id = LAST_INSERT_ID();

-- Buoc 3: Khach tra xe. Nhan vien kiem tra phat hien vo den pha trai
INSERT INTO Inspections (rental_id, inspection_date, damage_description, inspector_name)
VALUES (@current_rental_id, '2026-10-08 17:00:00', 'Vo den pha trai phia truoc do va cham, tray xuoc can truoc', 'Nhan vien Nguyen Van Kiem');

-- Buoc 4: Cap nhat hop dong thue xe khi ket thuc:
-- Trang thai COMPLETED, ngay tra xe 2026-10-08 17:00:00, late_fee = 0, damage_fee = 2.000.000 VND
UPDATE Rentals
SET return_date = '2026-10-08 17:00:00',
    status = 'COMPLETED',
    late_fee = 0.00,
    damage_fee = 2000000.00
WHERE rental_id = @current_rental_id;

-- =============================================================================
-- TRUY VAN QUAN TRONG: TINH TOAN TIEN HOAN LAI CHO KHACH HANG (REFUND CALCULATION)
-- Cong thuc: Tien hoan lai = Tien coc - Phi phat tre - Phi sua chua hu hai
-- =============================================================================
SELECT 
    r.rental_id AS 'Ma_Hop_Dong',
    r.customer_name AS 'Khach_Hang',
    c.model_name AS 'Mau_Xe',
    c.license_plate AS 'Bien_So',
    r.rent_date AS 'Ngay_Nhan_Xe',
    r.return_date AS 'Ngay_Tra_Xe',
    r.status AS 'Trang_Thai',
    i.damage_description AS 'Bien_Ban_Hu_Hong',
    i.inspector_name AS 'Nguoi_Kiem_Tra',
    FORMAT(r.security_deposit, 0) AS 'Tien_Coc_VND',
    FORMAT(r.late_fee, 0) AS 'Phat_Tre_Gio_VND',
    FORMAT(r.damage_fee, 0) AS 'Phat_Hu_Hong_VND',
    FORMAT(r.security_deposit - r.late_fee - r.damage_fee, 0) AS 'Tien_Hoan_Tra_Khach_VND'
FROM Rentals r
JOIN Cars c ON r.car_id = c.car_id
LEFT JOIN Inspections i ON r.rental_id = i.rental_id
WHERE r.rental_id = @current_rental_id;
