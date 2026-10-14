-- =====================================================================
-- Kich ban tao Co so du lieu va Bang cho Ung dung iNotes
-- Tac gia: Nguyen Tuan Dat (proyctk03@gmail.com)
-- =====================================================================

CREATE DATABASE IF NOT EXISTS inotes_db
    CHARACTER SET utf8mb4
    COLLATE utf8mb4_unicode_ci;

USE inotes_db;

-- 1. Tao bang loai ghi chu (note_type)
CREATE TABLE IF NOT EXISTS note_type (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    description VARCHAR(255)
);

-- 2. Tao bang danh sach ghi chu (notes)
CREATE TABLE IF NOT EXISTS notes (
    id INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(255) NOT NULL,
    content TEXT,
    type_id INT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT fk_notes_note_type FOREIGN KEY (type_id) REFERENCES note_type(id) ON DELETE SET NULL
);

-- 3. Chen du lieu khoi tao cho bang note_type
INSERT INTO note_type (id, name, description) VALUES
(1, 'Cá nhân', 'Ghi chú sinh hoạt, sở thích và kế hoạch cá nhân'),
(2, 'Công việc', 'Nhiệm vụ, dự án, cuộc họp và deadline công việc'),
(3, 'Học tập', 'Kiến thức lập trình, bài tập và tài liệu nghiên cứu')
ON DUPLICATE KEY UPDATE name=VALUES(name), description=VALUES(description);

-- 4. Chen du lieu khoi tao cho bang notes
INSERT INTO notes (id, title, content, type_id) VALUES
(1, 'Họp giao ban đầu tuần', 'Báo cáo tiến độ module Strategy Pattern và tổng kết sprint trước', 2),
(2, 'Ôn tập Design Pattern Servlet', 'Nghiên cứu áp dụng Strategy Pattern, Singleton và Factory trong Java Web MVC', 3),
(3, 'Lên lịch tập thể dục buổi sáng', 'Chạy bộ 30 phút và tập cardio nhẹ nhàng lúc 6h00', 1)
ON DUPLICATE KEY UPDATE title=VALUES(title), content=VALUES(content), type_id=VALUES(type_id);
