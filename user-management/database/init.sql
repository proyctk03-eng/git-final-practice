-- Khoi tao co so du lieu demo va bang users
CREATE DATABASE IF NOT EXISTS demo CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE demo;

DROP TABLE IF EXISTS users;

CREATE TABLE users (
    id INT(3) NOT NULL AUTO_INCREMENT,
    name VARCHAR(120) NOT NULL,
    email VARCHAR(220) NOT NULL,
    country VARCHAR(120),
    PRIMARY KEY (id)
);

-- Them du lieu mau ban dau
INSERT INTO users(name, email, country) VALUES('Minh', 'minh@codegym.vn', 'Viet Nam');
INSERT INTO users(name, email, country) VALUES('Kante', 'kante@che.uk', 'Kenia');
INSERT INTO users(name, email, country) VALUES('Nguyen Tuan Dat', 'proyctk03@gmail.com', 'Viet Nam');

-- 1. Tao Stored Procedure de lay thong tin User theo ID
DELIMITER $$
DROP PROCEDURE IF EXISTS get_user_by_id$$
CREATE PROCEDURE get_user_by_id(IN user_id INT)
BEGIN
    SELECT users.name, users.email, users.country
    FROM users
    WHERE users.id = user_id;
END$$
DELIMITER ;

-- 2. Tao Stored Procedure de them moi mot User
DELIMITER $$
DROP PROCEDURE IF EXISTS insert_user$$
CREATE PROCEDURE insert_user(
    IN user_name VARCHAR(50),
    IN user_email VARCHAR(50),
    IN user_country VARCHAR(50)
)
BEGIN
    INSERT INTO users(name, email, country) VALUES(user_name, user_email, user_country);
END$$
DELIMITER ;
