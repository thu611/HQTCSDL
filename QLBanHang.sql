USE master;  
GO  
CREATE DATABASE QLBanHang
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
('H03', 'Vinfone', 'Việt Nam', '084-098262626', 'vf@gmail.com.vn');
INSERT INTO Nhanvien VALUES
('NV01', 'Nguyễn Thị Thu', 'Nữ', 'Hà Nội', '0982626521', 'thu@gmail.com', 'Kế toán'),
('NV02', 'Lê Văn Nam', 'Nam', 'Bắc Ninh', '0972525252', 'nam@gmail.com', 'Vật tư'),
('NV03', 'Trần Hòa Bình', 'Nữ', 'Hà Nội', '0328388388', 'hb@gmail.com', 'Kế toán');
INSERT INTO Sanpham VALUES
('SP01', 'H02', 'F1 Plus', '100', 'Xám', '7000000', 'Chiếc', 'Hàng cận cao cấp'),
('SP02', 'H01', 'Galaxy Note11', '50', 'Đỏ', '19000000', 'Chiếc', 'Hàng cao cấp'),
('SP03', 'H02', 'F3 Lite', '200', 'Nâu', '3000000', 'Chiếc', 'Hàng phổ thông'),
('SP04', 'H03', 'Vjoy3', '200', 'Xám', '1500000', 'Chiếc', 'Hàng phổ thông'),
('SP05', 'H01', 'Galaxy', '50', 'Nâu', '8000000', 'Chiếc', 'Hàng cận cao cấp');
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

