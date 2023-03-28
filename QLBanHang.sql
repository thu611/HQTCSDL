USE master;  
GO  
CREATE DATABASE QLBanHang
USE QLBanHang
CREATE TABLE Hangsx(
Mahangsx Nchar(10) PRIMARY KEY,
Tenhang Nvarchar(20),
Diachi Nvarchar(30),
Sodt Nvarchar(20),
email Nvarchar(30)
);
CREATE TABLE Sanpham(
Masp Nchar(10) primary key,
Mahangsx nchar(10) REFERENCES Hangsx(Mahangsx),
Tensp Nvarchar(20),
Soluong Int,
Mausac Nvarchar(20),
Giaban Money,
Donvitinh Nchar(10),
Mota Nvarchar(Max)
);
CREATE TABLE Nhanvien
(
Manv Nchar(10) PRIMARY KEY,
Tennv Nvarchar(20),
Gioitinh Nchar(10),
Diachi Nvarchar(30),
Sodt Nvarchar(20),
email nvarchar(30),
Phong nvarchar(30)
);
CREATE TABLE Nhap(
Sohdn Nchar(10) PRIMARY KEY,
Masp Nchar(10) REFERENCES Sanpham(Masp),
Manv Nchar(10) REFERENCES Nhanvien(Manv),
Ngaynhap date,
SoluongN INT,
DongiaN money
);
CREATE TABLE Xuat(
Sohdx Nchar(10) PRIMARY KEY,
Masp Nchar(10) REFERENCES Sanpham(Masp),
Manv Nchar(10) REFERENCES Nhanvien(Manv),
Ngayxuat date,
SoluongX int
);
INSERT INTO Hangsx VALUES
('H01', 'Samsung', 'Korea', '011-08271717', 'ss@gmail.com.kr'),
('H02', 'OPPO', 'China', '081-08626262', 'oppo@gmail.com.cn'),
('H03', 'Vinfone', N'Việt Nam', '084-098262626', 'vf@gmail.com.vn');
INSERT INTO Nhanvien VALUES
('NV01', N'Nguyễn Thị Thu', N'Nữ', N'Hà Nội', '0982626521', 'thu@gmail.com', N'Kế toán'),
('NV02', N'Lê Văn Nam', N'Nam', N'Bắc Ninh', '0972525252', 'nam@gmail.com', N'Vật tư'),
('NV03', N'Trần Hòa Bình', N'Nữ', N'Hà Nội', '0328388388', 'hb@gmail.com', N'Kế toán');
INSERT INTO Sanpham VALUES
('SP01', 'H02', 'F1 Plus', '100', N'Xám', '7000000', N'Chiếc', N'Hàng cận cao cấp'),
('SP02', 'H01', 'Galaxy Note11', '50', N'Đỏ', '19000000', N'Chiếc', N'Hàng cao cấp'),
('SP03', 'H02', 'F3 Lite', '200', N'Nâu', '3000000', N'Chiếc', N'Hàng phổ thông'),
('SP04', 'H03', 'Vjoy3', '200', N'Xám', '1500000', N'Chiếc', N'Hàng phổ thông'),
('SP05', 'H01', 'Galaxy', '50', N'Nâu', '8000000', N'Chiếc', N'Hàng cận cao cấp');
INSERT INTO Nhap VALUES
('N01', 'SP02', 'NV01', '02-05-2019', 10, 17000000),
('N02', 'SP01','NV02','04-07-2020',30,6000000),
('N03', 'SP04','NV02','05-17-2020',20,1200000),
('N04', 'SP01','NV03','03-22-2020',10,6200000),
('N05', 'SP05','NV01','07-07-2020',20,7000000);
INSERT INTO Xuat VALUES
('X01', 'SP03', 'NV02', '06-14-2020', 5),
('X02', 'SP01', 'NV03', '03-05-2019', 3),
('X03', 'SP02', 'NV01', '12-12-2020', 1),
('X04', 'SP03', 'NV02', '06-02-2020', 2),
('X05', 'SP05', 'NV01', '05-18-2020', 1);
BACKUP DATABASE [QLBanHang] TO DISK = 'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER01\MSSQL\DATA\QLBanHang.bak'
RESTORE DATABASE [QLBanHang] FROM DISK = 'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER01\MSSQL\DATA\QLBanHang.bak'
-- 1. --
SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_TYPE='BASE TABLE'
-- 2. --
SELECT Sanpham.Masp, Sanpham.Tensp, Hangsx.Tenhang, Sanpham.Soluong, Sanpham.Masp, Sanpham.Mausac, Sanpham.Giaban, Sanpham.Donvitinh, Sanpham.Mota
FROM Sanpham
INNER JOIN Hangsx ON Sanpham.Mahangsx = Hangsx.Mahangsx
ORDER BY Sanpham.Giaban DESC
-- 3. --
SELECT Sanpham.tensp AS N'Tên sản phẩm của hãng samsung '
	FROM Sanpham,Hangsx
	WHERE Hangsx.Tenhang  = 'samsung' 
-- 4. --
SELECT * FROM Nhanvien
WHERE Gioitinh = 'Nữ' AND Phong = 'Kế Toán'
-- 5. --
SELECT Nhap.Sohdn, Sanpham.Masp, Sanpham.Tensp, Hangsx.Tenhang, Nhap.SoluongN, Nhap.DongiaN, Nhap.SoluongN*Nhap.DongiaN AS tiennhap, Sanpham.Mausac, Sanpham.Donvitinh, Nhap.Ngaynhap, Nhanvien.Tennv, Nhanvien.Phong
FROM Nhap
JOIN Sanpham ON Nhap.Masp = Sanpham.Masp
JOIN Hangsx ON Sanpham.Mahangsx= Hangsx.Mahangsx
JOIN Nhanvien ON Nhap.Manv = Nhanvien.Manv
ORDER BY Nhap.Sohdn ASC;
-- 6. --
SELECT Xuat.Sohdx, Sanpham.Masp,Sanpham.Tensp,Hangsx.Tenhang,Xuat.SoluongX,Sanpham.Giaban,Xuat.SoluongX*Sanpham.Giaban AS tienxuat, Sanpham.Mausac, Sanpham.Donvitinh,Xuat.Ngayxuat,Nhanvien.Tennv,Nhanvien.Phong
FROM Xuat
INNER JOIN Sanpham ON Xuat.Masp=Sanpham.Masp
INNER JOIN Hangsx ON Sanpham.Mahangsx=Hangsx.Mahangsx
INNER JOIN Nhanvien ON Xuat.Manv=Nhanvien.Manv
WHERE MONTH(Xuat.Ngayxuat) = 10 AND YEAR(Xuat.Ngayxuat) = 2018
ORDER BY Xuat.Sohdx ASC;
-- 7. --
SELECT Sohdn,Sanpham.masp,tensp,soluongN,dongiaN, Ngaynhap,Tennv,Phong
FROM Nhap
JOIN Sanpham ON Nhap.Masp =Sanpham.masp
JOIN Hangsx ON Sanpham.mahangsx = Hangsx.Mahangsx
JOIN Nhanvien ON.Nhap.Manv = Nhanvien.Manv
WHERE Hangsx.Tenhang = 'Samsung' AND YEAR(Ngaynhap)=2017
-- 8. --
SELECT TOP 10 Xuat.Sohdx, Xuat.Masp, SanPham.Tensp, Hangsx.Tenhang, Xuat.SoluongX, Sanpham.Giaban, Xuat.SoluongX*Sanpham.Giaban AS TienXuat, Sanpham.Mausac, Sanpham.Donvitinh, Xuat.Ngayxuat, Nhanvien.Tennv, Nhanvien.Phong
FROM Xuat
INNER JOIN Sanpham ON Xuat.Masp = Sanpham.Masp
INNER JOIN Hangsx ON Sanpham.Mahangsx = Hangsx.Mahangsx
INNER JOIN Nhanvien ON Xuat.Manv = Nhanvien.Manv
WHERE YEAR(Xuat.Ngayxuat) = 2018
ORDER BY Xuat.SoluongX DESC
-- 9. --
SELECT TOP(10) tenSP, giaBan
FROM SanPham
ORDER BY giaBan DESC;
-- 10. --
SELECT *
FROM Sanpham
JOIN Hangsx ON Sanpham.mahangsx = Hangsx.mahangsx
WHERE Hangsx.tenhang = 'Samsung' AND Sanpham.giaban >= 100000 AND Sanpham.giaban <= 500000
--11 --
SELECT SUM(SoluongN * DongiaN) AS TongTien
FROM Nhap
JOIN Sanpham ON Nhap.Masp=Sanpham.Masp
JOIN Hangsx ON Sanpham.Mahangsx=Hangsx.Mahangsx
WHERE Hangsx.Tenhang= 'Samsung' AND YEAR(Ngaynhap) = 2018 
--12 --
SELECT SUM(Xuat.SoluongX * Sanpham.Giaban) AS TongTien
FROM Xuat
INNER JOIN Sanpham ON Xuat.Masp = Sanpham.Masp
WHERE Xuat.Ngayxuat = '2018-09-02'
--13 --
SELECT TOP 1 Sohdn, Ngaynhap, DongiaN
FROM Nhap
ORDER BY DongiaN DESC
--14 --
SELECT TOP 10 Sanpham.Tensp, SUM(Nhap.SoluongN) AS TongSoLuongN 
FROM Sanpham 
INNER JOIN Nhap ON Sanpham.Masp = Nhap.Masp 
WHERE YEAR(Nhap.Ngaynhap) = 2019 
GROUP BY Sanpham.Tensp 
ORDER BY TongSoLuongN DESC
--15 --
SELECT Sanpham.Masp, Sanpham.Tensp
FROM Sanpham
INNER JOIN Hangsx ON Sanpham.Mahangsx = Hangsx.Mahangsx
INNER JOIN Nhap ON Sanpham.Masp = Nhap.Masp
INNER JOIN Nhanvien ON Nhap.Manv = Nhanvien.Manv
WHERE Hangsx.Tenhang = 'Samsung' AND Nhanvien.Manv = 'NV01';
--16 --
SELECT Sohdn, Masp, SoluongN, Ngaynhap
FROM Nhap
WHERE Masp = 'SP02' AND Manv = 'NV02'
--17 --
SELECT Nhanvien.manv, Nhanvien.tennv
FROM Nhanvien
JOIN Xuat ON Nhanvien.Manv = Xuat.Manv
WHERE Xuat.Masp = 'SP02' AND Xuat.Ngayxuat = '2020-03-02'
