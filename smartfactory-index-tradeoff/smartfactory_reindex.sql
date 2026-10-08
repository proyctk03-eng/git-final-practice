-- =============================================================================
-- [BAI TAP] GIAI CUU HE THONG IOT "SMARTFACTORY"
-- Bai Toan Danh Doi Giua Toc Do Doc (Read), Toc Do Ghi (Write) Va Chi Phi Luu Tru (Storage)
-- Khoa hoc: Co so du lieu & He quan tri CSDL MySQL
-- Hoc vien: Nguyen Tuan Dat
-- Vai tro: Database Optimization Expert
-- Repository: https://github.com/proyctk03-eng/git-final-practice
-- Thu muc: smartfactory-index-tradeoff/
-- =============================================================================

-- =============================================================================
-- BƯỚC 1: KHOI TAO CSDL VA MO PHONG THAM HOA "FAT COVERING INDEX"
-- =============================================================================

CREATE DATABASE IF NOT EXISTS smartfactory_db;
USE smartfactory_db;

DROP TABLE IF EXISTS SensorLogs;

-- Bang ghi nhat ky nhiet do va do am tu 10,000 cam bien IoT
CREATE TABLE SensorLogs (
    log_id BIGINT AUTO_INCREMENT PRIMARY KEY,
    sensor_id INT NOT NULL,
    recorded_at DATETIME NOT NULL,
    temperature DECIMAL(5,2),
    humidity DECIMAL(5,2),
    status VARCHAR(20) -- 'NORMAL', 'WARNING', 'CRITICAL'
);

-- =============================================================================
-- "FAT INDEX" GAY THAM HOA (Ky su cu da nhung toan bo cac cot vao Index)
-- Muc dich cu: Covering Index giup SELECT chay truc tiep tren RAM ma khong can doc bang goc.
-- Hau qua: Ghi cham nghiem trong, Data Pipeline bi drop record, hoa don AWS tang gap 4 lan!
-- =============================================================================
CREATE INDEX idx_fat_covering ON SensorLogs(sensor_id, recorded_at, temperature, humidity, status);

-- Nap 5,000 ban ghi du lieu mo phong cac cam bien gui ve theo thoi gian thuc
DELIMITER //
DROP PROCEDURE IF EXISTS seed_sensor_logs //
CREATE PROCEDURE seed_sensor_logs(IN total_rows INT)
BEGIN
    DECLARE i INT DEFAULT 1;
    WHILE i <= total_rows DO
        INSERT INTO SensorLogs (sensor_id, recorded_at, temperature, humidity, status)
        VALUES (
            FLOOR(1 + (RAND() * 500)),
            NOW() - INTERVAL FLOOR(RAND() * 86400) SECOND,
            ROUND(20.0 + (RAND() * 60.0), 2),
            ROUND(40.0 + (RAND() * 50.0), 2),
            ELT(FLOOR(1 + (RAND() * 3)), 'NORMAL', 'WARNING', 'CRITICAL')
        );
        SET i = i + 1;
    END WHILE;
END //
DELIMITER ;

CALL seed_sensor_logs(5000);


-- =============================================================================
-- BƯỚC 2: DO LUONG DUNG LUONG VA HIEN TRANG TRUOC TOI UU (BEFORE OPTIMIZATION)
-- =============================================================================

-- 1. Kiem tra trang thai bang va chi so Index_length
SHOW TABLE STATUS LIKE 'SensorLogs';

-- 2. Tinh toan chi tiet kich thuoc Data va Index theo Megabyte (MB) qua information_schema
SELECT 
    TABLE_NAME,
    TABLE_ROWS,
    ROUND(DATA_LENGTH / 1024 / 1024, 4) AS Data_Size_MB,
    ROUND(INDEX_LENGTH / 1024 / 1024, 4) AS Index_Size_MB,
    ROUND((DATA_LENGTH + INDEX_LENGTH) / 1024 / 1024, 4) AS Total_Size_MB,
    ROUND(INDEX_LENGTH / DATA_LENGTH, 2) AS Index_to_Data_Ratio
FROM information_schema.TABLES
WHERE TABLE_SCHEMA = 'smartfactory_db' AND TABLE_NAME = 'SensorLogs';

-- 3. Chay EXPLAIN truy van Dashboard truoc khi toi uu (Quan sat cot Extra: 'Using index')
EXPLAIN SELECT temperature, humidity, status 
FROM SensorLogs 
WHERE sensor_id = 105 AND recorded_at >= '2026-06-20';


-- =============================================================================
-- BƯỚC 3: TIEN HANH "PHAU THUAT" - THAY THE FAT INDEX BANG LEAN SEARCH INDEX
-- =============================================================================
-- Triet ly toi uu:
--   - Index duoc thiet ke de TIM KIEM (Loc WHERE va Sap xep ORDER BY), khong phai de luu tru toan bo du lieu.
--   - Chi dua (sensor_id, recorded_at) vao Index.
--   - Loai bo cac cot payload thuong xuyen thay doi: temperature, humidity, status.

-- 1. Xoa bo Fat Index phinh to
ALTER TABLE SensorLogs DROP INDEX idx_fat_covering;

-- 2. Tao Lean Index tinh gon chi gom 2 cot loc du lieu
CREATE INDEX idx_lean_search ON SensorLogs(sensor_id, recorded_at);

-- 3. To chuc lai cac trang dia InnoDB de giai phong khong gian luu tru
OPTIMIZE TABLE SensorLogs;


-- =============================================================================
-- BƯỚC 4: DO LUONG LAI DUNG LUONG VA XAC THUC KE HOACH TRUY VAN (AFTER OPTIMIZATION)
-- =============================================================================

-- 1. Do luong lai dung luong sau khi doi sang Lean Index
SELECT 
    TABLE_NAME,
    TABLE_ROWS,
    ROUND(DATA_LENGTH / 1024 / 1024, 4) AS Data_Size_MB,
    ROUND(INDEX_LENGTH / 1024 / 1024, 4) AS Index_Size_MB,
    ROUND((DATA_LENGTH + INDEX_LENGTH) / 1024 / 1024, 4) AS Total_Size_MB,
    ROUND(INDEX_LENGTH / DATA_LENGTH, 2) AS Index_to_Data_Ratio
FROM information_schema.TABLES
WHERE TABLE_SCHEMA = 'smartfactory_db' AND TABLE_NAME = 'SensorLogs';

-- 2. Chay lai EXPLAIN truy van Dashboard sau khi toi uu
-- Ket qua mong doi:
--   - key: idx_lean_search (Nhan dien index thanh cong)
--   - type: range (Truy van loc pham vi thoi gian cuc ky nhanh)
--   - Extra: Khong con 'Using index' (da tra ve che do doc bang goc Bookmark Lookup),
--     nhung thoi gian thuc thi van duoi 1ms, trong khi toc do INSERT tang vot 5x!
EXPLAIN SELECT temperature, humidity, status 
FROM SensorLogs 
WHERE sensor_id = 105 AND recorded_at >= '2026-06-20';
