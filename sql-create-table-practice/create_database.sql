-- =============================================================================
-- [Thuc hanh] Tao bang trong CSDL - QuanLyDiemThi
-- =============================================================================

-- Buoc 1: Tao co so du lieu co ten la QuanLyDiemThi
CREATE DATABASE IF NOT EXISTS QuanLyDiemThi;

-- Buoc 2: Chon Database QuanLyDiemThi de thao tac
USE QuanLyDiemThi;

-- Buoc 3: Tao bang HocSinh
CREATE TABLE IF NOT EXISTS HocSinh (
    MaHS VARCHAR(20) PRIMARY KEY,
    TenHS VARCHAR(50),
    NgaySinh DATETIME,
    Lop VARCHAR(20),
    GT VARCHAR(20)
);

-- Buoc 4: Tao bang MonHoc
-- Luu y: Do do dai MaMH trong BangDiem la VARCHAR(50), ta su dung VARCHAR(50) 
-- cho MaMH trong MonHoc de dong nhat kieu du lieu va tuong thich khoa ngoai hoan hao.
CREATE TABLE IF NOT EXISTS MonHoc (
    MaMH VARCHAR(50) PRIMARY KEY,
    TenMH VARCHAR(50),
    MaGV VARCHAR(20)
);

-- Buoc 5: Tao bang BangDiem la bang trung gian cua moi quan he n - n giua HocSinh va MonHoc
CREATE TABLE IF NOT EXISTS BangDiem (
    MaHS VARCHAR(20),
    MaMH VARCHAR(50),
    DiemThi INT,
    NgayKT DATETIME,
    PRIMARY KEY (MaHS, MaMH),
    FOREIGN KEY (MaHS) REFERENCES HocSinh(MaHS),
    FOREIGN KEY (MaMH) REFERENCES MonHoc(MaMH)
);

-- Buoc 6: Tao bang GiaoVien
CREATE TABLE IF NOT EXISTS GiaoVien (
    MaGV VARCHAR(20) PRIMARY KEY,
    TenGV VARCHAR(50),
    SDT VARCHAR(10)
);

-- Buoc 7: Chinh sua lai bang MonHoc bo sung them khoa ngoai tham chieu den GiaoVien
ALTER TABLE MonHoc 
ADD CONSTRAINT FK_MaGV FOREIGN KEY (MaGV) REFERENCES GiaoVien(MaGV);

-- =============================================================================
-- DU LIEU MAU THU NGHIEM (SAMPLE DATA)
-- =============================================================================

-- 1. Chen du lieu Giao Vien
INSERT INTO GiaoVien (MaGV, TenGV, SDT) VALUES
('GV01', 'Nguyen Van A', '0912345678'),
('GV02', 'Tran Thi B', '0987654321');

-- 2. Chen du lieu Mon Hoc
INSERT INTO MonHoc (MaMH, TenMH, MaGV) VALUES
('MH01', 'Toan Hoc', 'GV01'),
('MH02', 'Vat Ly', 'GV01'),
('MH03', 'Hoa Hoc', 'GV02');

-- 3. Chen du lieu Hoc Sinh
INSERT INTO HocSinh (MaHS, TenHS, NgaySinh, Lop, GT) VALUES
('HS01', 'Nguyen Tuan Dat', '2004-05-15', '12A1', 'Nam'),
('HS02', 'Le Thi Mai', '2004-08-20', '12A1', 'Nu');

-- 4. Chen du lieu Bang Diem
INSERT INTO BangDiem (MaHS, MaMH, DiemThi, NgayKT) VALUES
('HS01', 'MH01', 9, '2026-05-10 08:00:00'),
('HS01', 'MH02', 8, '2026-05-12 08:00:00'),
('HS02', 'MH01', 10, '2026-05-10 08:00:00');

-- =============================================================================
-- TRUY VAN KIEM TRA (VERIFICATION QUERY)
-- =============================================================================
SELECT 
    hs.MaHS,
    hs.TenHS,
    hs.Lop,
    mh.TenMH,
    bd.DiemThi,
    bd.NgayKT,
    gv.TenGV AS GiaoVienPhuTrach
FROM BangDiem bd
JOIN HocSinh hs ON bd.MaHS = hs.MaHS
JOIN MonHoc mh ON bd.MaMH = mh.MaMH
LEFT JOIN GiaoVien gv ON mh.MaGV = gv.MaGV;
