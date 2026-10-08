-- =============================================================================
-- [THUC HANH] THAM HOA QUA TAI O CUNG TAI MANG XA HOI "QUICKFEED"
-- Giai Phap Toi Uu Hoa Index: Can Bang Read vs Write & Tiet Kiem Tai Nguyen
-- Khoa hoc: Co so du lieu & He quan tri CSDL MySQL
-- Hoc vien: Nguyen Tuan Dat
-- Repository: https://github.com/proyctk03-eng/git-final-practice
-- Thu muc: quickfeed-index-optimization/
-- =============================================================================

-- =============================================================================
-- BƯỚC 1: KHOI TAO CSDL VA MO PHONG THAM HOA OVER-INDEXING (LEGACY SCRIPT)
-- =============================================================================

CREATE DATABASE IF NOT EXISTS quickfeed_db;
USE quickfeed_db;

DROP TABLE IF EXISTS Posts;

-- Bang Posts cua mang xa hoi QuickFeed
CREATE TABLE Posts (
    post_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    content TEXT,
    post_type VARCHAR(10),        -- Chi chua 3 gia tri: 'TEXT', 'IMAGE', 'VIDEO'
    is_visible BOOLEAN DEFAULT 1, -- Chi chua 1 (Hien) hoac 0 (An)
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- =============================================================================
-- THAM HOA OVER-INDEXING: Lap trinh vien cu tao Index tren tat ca cac cot
-- =============================================================================
CREATE INDEX idx_user_id ON Posts(user_id);
-- LOI 1: Index cot TEXT voi prefix 255 ky tu gay phinh to dung luong dia khong thiet
CREATE INDEX idx_content ON Posts(content(255));
-- LOI 2: Cardinality cuc thap (chi 3 gia tri), Query Optimizer thuong bo qua
CREATE INDEX idx_post_type ON Posts(post_type);
-- LOI 3: Cardinality chi co 2 gia tri (0 va 1), vo dung va ton chi phi B-Tree split
CREATE INDEX idx_is_visible ON Posts(is_visible);
CREATE INDEX idx_created_at ON Posts(created_at);

-- Nap du lieu mau da dang de do luong dung luong Index thuc te
DELIMITER //
DROP PROCEDURE IF EXISTS seed_quickfeed_data //
CREATE PROCEDURE seed_quickfeed_data(IN total_rows INT)
BEGIN
    DECLARE i INT DEFAULT 1;
    DECLARE sample_text TEXT;
    SET sample_text = 'Hom nay thoi tiet Ha Noi rat dep, toi dang hoc toi uu hoa co so du lieu MySQL tai CodeGym. Thu nghiem mang xa hoi QuickFeed dang tai status vi blog voi noi dung dai de kiem tra dung luong luu tru cua cac trang B-Tree Index.';
    
    WHILE i <= total_rows DO
        INSERT INTO Posts (user_id, content, post_type, is_visible, created_at)
        VALUES (
            FLOOR(1 + (RAND() * 500)),
            CONCAT(sample_text, ' - Ma bai viet #', i),
            ELT(FLOOR(1 + (RAND() * 3)), 'TEXT', 'IMAGE', 'VIDEO'),
            IF(RAND() > 0.05, 1, 0), -- 95% bai viet la visible (1)
            NOW() - INTERVAL FLOOR(RAND() * 30) DAY
        );
        SET i = i + 1;
    END WHILE;
END //
DELIMITER ;

-- Nap 1,000 ban ghi mau de phan tich thong so tai nguyen
CALL seed_quickfeed_data(1000);


-- =============================================================================
-- BƯỚC 2: DO LUONG TAI NGUYEN VA DUNG LUONG TRUOC KHI TOI UU (BEFORE PROFILING)
-- =============================================================================

-- 1. Xem trang thai bang va chi so Index_length
SHOW TABLE STATUS LIKE 'Posts';

-- 2. Truy van thong so chi tiet tu information_schema.TABLES (Don vi Megabyte)
SELECT 
    TABLE_NAME,
    TABLE_ROWS,
    ROUND(DATA_LENGTH / 1024 / 1024, 4) AS Data_Size_MB,
    ROUND(INDEX_LENGTH / 1024 / 1024, 4) AS Index_Size_MB,
    ROUND((DATA_LENGTH + INDEX_LENGTH) / 1024 / 1024, 4) AS Total_Size_MB,
    ROUND(INDEX_LENGTH / DATA_LENGTH, 2) AS Index_to_Data_Ratio
FROM information_schema.TABLES
WHERE TABLE_SCHEMA = 'quickfeed_db' AND TABLE_NAME = 'Posts';

-- 3. Kiem tra do phan giai (Cardinality) cua cac Index hien tai
SHOW INDEX FROM Posts;

-- 4. Minh chung su vo dung cua idx_is_visible: Optimizer chon Full Table Scan (type: ALL)
EXPLAIN SELECT * FROM Posts WHERE is_visible = 1;


-- =============================================================================
-- BƯỚC 3: TIEN HANH "PHAU THUAT" DROP CAC INDEX VO DUNG & GAY HAI
-- =============================================================================
-- Quyet dinh can cu theo Decision Matrix:
--   - idx_content: DROP (Ton bo nho, nen dung FULLTEXT Index khi can tim kiem van ban)
--   - idx_post_type: DROP (Cardinality chi co 3, ty le chon loc Selectivity qua thap)
--   - idx_is_visible: DROP (Cardinality chi co 2, 95% la 1, gay ton cong bao tri B-Tree)
--   - idx_user_id: GIU LAI (Tra cuu trang ca nhan cua tung nguoi dung)
--   - idx_created_at: GIU LAI (Sap xep Newsfeed theo thoi gian moi nhat)

ALTER TABLE Posts DROP INDEX idx_content;
ALTER TABLE Posts DROP INDEX idx_post_type;
ALTER TABLE Posts DROP INDEX idx_is_visible;

-- To chuc lai cac trang du lieu va giai phong vung nho Index bi huy
OPTIMIZE TABLE Posts;


-- =============================================================================
-- BƯỚC 4: DO LUONG LAI TAI NGUYEN SAU KHI TOI UU (AFTER PROFILING)
-- =============================================================================

-- 1. Kiem tra lai cac Index con ton tai tren bang Posts
SHOW INDEX FROM Posts;

-- 2. Truy van lai dung luong tu information_schema.TABLES
SELECT 
    TABLE_NAME,
    TABLE_ROWS,
    ROUND(DATA_LENGTH / 1024 / 1024, 4) AS Data_Size_MB,
    ROUND(INDEX_LENGTH / 1024 / 1024, 4) AS Index_Size_MB,
    ROUND((DATA_LENGTH + INDEX_LENGTH) / 1024 / 1024, 4) AS Total_Size_MB,
    ROUND(INDEX_LENGTH / DATA_LENGTH, 2) AS Index_to_Data_Ratio
FROM information_schema.TABLES
WHERE TABLE_SCHEMA = 'quickfeed_db' AND TABLE_NAME = 'Posts';

-- 3. Kiem tra truy van hieu qua voi cac Index da giu lai
EXPLAIN SELECT * FROM Posts WHERE user_id = 101 ORDER BY created_at DESC;
