-- =============================================================================
-- [THUC HANH] STORED PROCEDURE TRONG MYSQL
-- Co so du lieu: classicmodels
-- Bang: customers
-- Khoa hoc: Co so du lieu & He quan tri CSDL MySQL
-- Hoc vien: Nguyen Tuan Dat
-- Repository: https://github.com/proyctk03-eng/git-final-practice
-- Thu muc: sql-stored-procedure/
-- Nhanh tham khao: https://github.com/codegym-vn/jwbd-2023-using-stored-procedure (dev)
-- =============================================================================

-- =============================================================================
-- PHAN 1: KHOI TAO CSDL CLASSICMODELS VA BANG CUSTOMERS (CHAY DOC LAP)
-- =============================================================================

CREATE DATABASE IF NOT EXISTS classicmodels;
USE classicmodels;

-- Tao bang customers neu chua ton tai
CREATE TABLE IF NOT EXISTS customers (
    customerNumber INT NOT NULL PRIMARY KEY,
    customerName VARCHAR(50) NOT NULL,
    contactLastName VARCHAR(50) NOT NULL,
    contactFirstName VARCHAR(50) NOT NULL,
    phone VARCHAR(50) NOT NULL,
    addressLine1 VARCHAR(50) NOT NULL,
    addressLine2 VARCHAR(50) DEFAULT NULL,
    city VARCHAR(50) NOT NULL,
    state VARCHAR(50) DEFAULT NULL,
    postalCode VARCHAR(15) DEFAULT NULL,
    country VARCHAR(50) NOT NULL,
    salesRepEmployeeNumber INT DEFAULT NULL,
    creditLimit DECIMAL(10,2) DEFAULT NULL
);

-- Nap du lieu mau gom ban ghi 175 ('Gift Depot Inc.') va cac khach hang khac
INSERT IGNORE INTO customers (customerNumber, customerName, contactLastName, contactFirstName, phone, addressLine1, addressLine2, city, state, postalCode, country, salesRepEmployeeNumber, creditLimit) VALUES
(103, 'Atelier graphique', 'Schmitt', 'Carine', '40.32.2555', '54, rue Royale', NULL, 'Nantes', NULL, '44000', 'France', 1370, 21000.00),
(112, 'Signal Gift Stores', 'King', 'Jean', '7025551838', '8489 Strong St.', NULL, 'Las Vegas', 'NV', '83030', 'USA', 1166, 71800.00),
(114, 'Australian Collectors, Co.', 'Ferguson', 'Peter', '03 9520 4555', '636 St Kilda Road', 'Level 3', 'Melbourne', 'Victoria', '3004', 'Australia', 1611, 117300.00),
(119, 'La Rochelle Gifts', 'Labrune', 'Janine', '40.67.8555', '67, rue des Cinquante Otages', NULL, 'Nantes', NULL, '44340', 'France', 1370, 118200.00),
(121, 'Baane Mini Imports', 'Bergulfsen', 'Jonas', '07-98 9555', 'Erling Skakkes gate 78', NULL, 'Stavern', NULL, '4110', 'Norway', 1504, 81700.00),
(141, 'Euro+ Shopping Channel', 'Freyre', 'Diego', '(91) 555 94 44', 'C/ Moralzarzal, 86', NULL, 'Madrid', NULL, '28034', 'Spain', 1370, 227600.00),
(145, 'Danish Wholesale Imports', 'Petersen', 'Jytte', '31 12 3555', 'Vinbaeltet 34', NULL, 'Kobenhavn', NULL, '1734', 'Denmark', 1401, 82100.00),
(175, 'Gift Depot Inc.', 'King', 'Julie', '2035552570', '255 Vista Charra', NULL, 'Bridgewater', 'CT', '06805', 'USA', 1323, 84300.00);


-- =============================================================================
-- PHAN 2: TAO STORED PROCEDURE DAU TIEN - findAllCustomers()
-- =============================================================================
-- Giai thich:
-- 1. DELIMITER //: Thay doi ky tu phan tach ket thuc cau lenh tu dau cham phay (;)
--    sang //, ngan chan trinh thong dich ket thuc cau lenh CREATE PROCEDURE truoc thoi diem.
-- 2. CREATE PROCEDURE findAllCustomers(): Khai bao ten thu tuc can luu tru.
-- 3. BEGIN ... END: Khoi khai bao cac cau lenh SQL ben trong thu tuc.
-- 4. DELIMITER ;: Thiet lap lai ky tu phan tach mac dinh ve dau cham phay (;).

DELIMITER //

CREATE PROCEDURE findAllCustomers()
BEGIN
    SELECT * FROM customers;
END //

DELIMITER ;


-- =============================================================================
-- PHAN 3: TRIEU GOI (CALL) STORED PROCEDURE
-- =============================================================================
-- Su dung lenh CALL theo sau boi ten thu tuc va cap ngoac don ()
CALL findAllCustomers();


-- =============================================================================
-- PHAN 4: SUA STORED PROCEDURE (DROP & RE-CREATE)
-- =============================================================================
-- Luu y: MySQL khong cho phep sua truc tiep than thu tuc (khong ho tro ALTER PROCEDURE
-- de sua khoi BEGIN...END). Vi vay, quy trinh chuan la:
-- 1. DROP PROCEDURE IF EXISTS: Xoa thu tuc cu neu da ton tai.
-- 2. CREATE PROCEDURE: Tao lai thu tuc moi voi noi dung da thay doi.
-- O day, thay doi truy van de chi lay ban ghi co customerNumber = 175.

DELIMITER //

DROP PROCEDURE IF EXISTS `findAllCustomers` //

CREATE PROCEDURE findAllCustomers()
BEGIN
    SELECT * FROM customers WHERE customerNumber = 175;
END //

DELIMITER ;


-- =============================================================================
-- PHAN 5: GOI LAI STORED PROCEDURE SAU KHI CAP NHAT
-- =============================================================================
-- Ket qua luc nay chi tra ve duy nhat 1 ban ghi co customerNumber = 175 (Gift Depot Inc.)
CALL findAllCustomers();


-- =============================================================================
-- PHAN 6: MO RONG - STORED PROCEDURE CO THAM SO (IN PARAMETER)
-- =============================================================================
-- Giup thu tuc linh hoat: cho phep truyen bat ky ma khach hang nao vao de tra cuu
DELIMITER //

DROP PROCEDURE IF EXISTS `getCustomerById` //

CREATE PROCEDURE getCustomerById(IN p_customerNumber INT)
BEGIN
    SELECT * 
    FROM customers 
    WHERE customerNumber = p_customerNumber;
END //

DELIMITER ;

-- Trieu goi voi tham so 175
CALL getCustomerById(175);

-- Trieu goi voi tham so 103
CALL getCustomerById(103);
