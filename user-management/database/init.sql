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
