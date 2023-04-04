--Hãy tạo view từ các câu lệnh T-SQL ở bài thực hành số 2 và 3. Sau đó gọi thực thi các view và kiểm tra kết quả chạy.--
--LAB2-
-- 1. --
create view lab4_c1
as
SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_TYPE='BASE TABLE'
select * from lab4_c1
-- 2. --
create view lab4_c2
as
SELECT top 100 PERCENT Sanpham.masp, Sanpham.tensp, Hangsx.tenhang, Sanpham.soluong, Sanpham.mausac, Sanpham.giaban, Sanpham.donvitinh, Sanpham.mota
FROM Sanpham
INNER JOIN Hangsx ON Sanpham.mahangsx = Hangsx.mahangsx
ORDER BY Sanpham.giaban DESC;
select * from lab4_c2
-- 3. --
create view lab4_c3
as
SELECT Sanpham.tensp AS N'Tên sản phẩm của hãng samsung '
	FROM Sanpham,Hangsx
	WHERE Hangsx.Tenhang  = 'samsung' 
select * from lab4_c3
-- 4. --
create view lab4_c4
as
SELECT * FROM Nhanvien
WHERE Gioitinh = 'Nữ' AND Phong = 'Kế Toán'
select * from lab4_c4
-- 5. --
create view lab4_c5
as
SELECT top 100 percent Nhap.sohdn, Sanpham.masp, Sanpham.tensp, Hangsx.tenhang, Nhap.soluongN, Nhap.dongiaN, Nhap.soluongN*Nhap.dongiaN AS tiennhap, Sanpham.mausac, Sanpham.donvitinh, Nhap.ngaynhap, Nhanvien.tennv, Nhanvien.phong
FROM Nhap
JOIN Sanpham ON Nhap.masp = Sanpham.masp
JOIN Hangsx ON Sanpham.mahangsx = Hangsx.mahangsx
JOIN Nhanvien ON Nhap.manv = Nhanvien.manv
ORDER BY Nhap.sohdn ASC;
select * from lab4_c5
-- 6. --
create view lab4_c6
as
SELECT top 100 percent Xuat.sohdx, Sanpham.masp, Sanpham.tensp, Hangsx.tenhang, Xuat.soluongX, Sanpham.giaban, 
       Xuat.soluongX*Sanpham.giaban AS tienxuat, Sanpham.mausac, Sanpham.donvitinh, Xuat.ngayxuat, 
       Nhanvien.tennv, Nhanvien.phong
FROM Xuat
INNER JOIN Sanpham ON Xuat.masp = Sanpham.masp
INNER JOIN Hangsx ON Sanpham.mahangsx = Hangsx.mahangsx
INNER JOIN Nhanvien ON Xuat.manv = Nhanvien.manv
WHERE MONTH(Xuat.ngayxuat) = 10 AND YEAR(Xuat.ngayxuat) = 2018
ORDER BY Xuat.sohdx ASC;
select * from lab4_c6
-- 7. --
create view lab4_c7
as
SELECT Sohdn,Sanpham.masp,tensp,soluongN,dongiaN, Ngaynhap,Tennv,Phong
FROM Nhap
JOIN Sanpham ON Nhap.Masp =Sanpham.masp
JOIN Hangsx ON Sanpham.mahangsx = Hangsx.Mahangsx
JOIN Nhanvien ON.Nhap.Manv = Nhanvien.Manv
WHERE Hangsx.Tenhang = 'Samsung' AND YEAR(Ngaynhap)=2017
select * from lab4_c7
-- 8. --
create view lab4_c8
as
SELECT TOP 10 Xuat.Sohdx, Xuat.Masp, SanPham.Tensp, Hangsx.Tenhang, Xuat.SoluongX, Sanpham.Giaban, Xuat.SoluongX*Sanpham.Giaban AS TienXuat, Sanpham.Mausac, Sanpham.Donvitinh, Xuat.Ngayxuat, Nhanvien.Tennv, Nhanvien.Phong
FROM Xuat
INNER JOIN Sanpham ON Xuat.Masp = Sanpham.Masp
INNER JOIN Hangsx ON Sanpham.Mahangsx = Hangsx.Mahangsx
INNER JOIN Nhanvien ON Xuat.Manv = Nhanvien.Manv
WHERE YEAR(Xuat.Ngayxuat) = 2018
ORDER BY Xuat.SoluongX DESC
select * from lab4_c8
-- 9. --
create view lab4_c9
as
SELECT TOP(10) tenSP, giaBan
FROM SanPham
ORDER BY giaBan DESC;
select * from lab4_c9
-- 10. --
create view lab4_c10
as
SELECT top 100 percent Hangsx.tenhang, Sanpham.giaban,Sanpham.mahangsx
FROM Sanpham
JOIN Hangsx ON Sanpham.mahangsx = Hangsx.mahangsx
WHERE Hangsx.tenhang = 'Samsung' AND Sanpham.giaban >= 100000 AND Sanpham.giaban <= 500000
select * from lab4_c10
--11 --
create view lab4_c11
as
SELECT SUM(SoluongN * DongiaN) AS TongTien
FROM Nhap
JOIN Sanpham ON Nhap.Masp=Sanpham.Masp
JOIN Hangsx ON Sanpham.Mahangsx=Hangsx.Mahangsx
WHERE Hangsx.Tenhang= 'Samsung' AND YEAR(Ngaynhap) = 2018 
select * from lab4_c11
--12 --
create view lab4_c12
as
SELECT SUM(Xuat.SoluongX * Sanpham.Giaban) AS TongTien
FROM Xuat
INNER JOIN Sanpham ON Xuat.Masp = Sanpham.Masp
WHERE Xuat.Ngayxuat = '2018-09-02'
select * from lab4_c12
--13 --
create view lab4_c13
as
SELECT TOP 1 Sohdn, Ngaynhap, DongiaN
FROM Nhap
ORDER BY DongiaN DESC
select * from lab4_c12
--14 --
create view lab4_c14
as
SELECT TOP 10 Sanpham.tensp, SUM(Nhap.soluongN) AS TongSoLuongN 
FROM Sanpham 
INNER JOIN Nhap ON Sanpham.masp = Nhap.masp 
WHERE YEAR(Nhap.ngaynhap) = 2019 
GROUP BY Sanpham.tensp 
ORDER BY TongSoLuongN DESC
select * from lab4_c14
--15 --
create view lab4_c15
as
SELECT Sanpham.Masp, Sanpham.Tensp
FROM Sanpham
INNER JOIN Hangsx ON Sanpham.Mahangsx = Hangsx.Mahangsx
INNER JOIN Nhap ON Sanpham.Masp = Nhap.Masp
INNER JOIN Nhanvien ON Nhap.Manv = Nhanvien.Manv
WHERE Hangsx.Tenhang = 'Samsung' AND Nhanvien.Manv = 'NV01';
select * from lab4_c15
--16 --
create view lab4_c16
as
SELECT Sohdn, Masp, SoluongN, Ngaynhap
FROM Nhap
WHERE Masp = 'SP02' AND Manv = 'NV02'
select * from lab4_c16
--17 --
create view lab4_c17
as
SELECT Nhanvien.manv, Nhanvien.tennv
FROM Nhanvien
JOIN Xuat ON Nhanvien.Manv = Xuat.Manv
WHERE Xuat.Masp = 'SP02' AND Xuat.Ngayxuat = '2020-03-02'
select * from lab4_c17
--LAB3--
--1--
create view vw_ds_1
as
SELECT Hangsx.tenhang, COUNT(Sanpham.masp) AS so_luong_sp
FROM Hangsx
JOIN Sanpham ON Hangsx.mahangsx = Sanpham.mahangsx
GROUP BY Hangsx.tenhang
select * from vw_ds_1
--2--
create view vw_ds_2
as
SELECT masp, SUM(soluongN * dongiaN) AS TongTienNhap
FROM Nhap
WHERE YEAR(ngaynhap) = 2020
GROUP BY masp;
select * from vw_ds_2
--3--
create view vw_ds_3
as
SELECT Sanpham.masp, Sanpham.tensp, SUM(Xuat.soluongX) as tong_soluong_xuat
FROM Sanpham
JOIN Xuat ON Sanpham.masp = Xuat.masp
JOIN Hangsx ON Sanpham.mahangsx = Hangsx.mahangsx
WHERE YEAR(Xuat.ngayxuat) = 2018 AND Hangsx.tenhang = 'Samsung'
GROUP BY Sanpham.masp, Sanpham.tensp
HAVING SUM(Xuat.soluongX) > 10000;
select * from vw_ds_3
--4--
create view vw_ds_4
as
SELECT phong, COUNT(*) AS SoLuongNam
FROM Nhanvien
WHERE gioitinh = 'Nam'
GROUP BY phong
select * from vw_ds_4
--5--
create view vw_ds_5
as
SELECT Hangsx.tenhang, SUM(Nhap.soluongN) as TongSoLuongNhap
FROM Nhap
JOIN Sanpham ON Nhap.masp = Sanpham.masp
JOIN Hangsx ON Sanpham.mahangsx = Hangsx.mahangsx
WHERE YEAR(Nhap.ngaynhap) = 2018
GROUP BY Hangsx.tenhang
select * from vw_ds_5
--6--
create view vw_ds_6
as
SELECT Nhanvien.manv, Nhanvien.tennv, SUM(Xuat.soluongX * Sanpham.giaban) AS tongtienxuat
FROM Xuat
INNER JOIN Sanpham ON Xuat.masp = Sanpham.masp
INNER JOIN Nhanvien ON Xuat.manv = Nhanvien.manv
WHERE YEAR(Xuat.ngayxuat) = 2018
GROUP BY Nhanvien.manv, Nhanvien.tennv
select * from vw_ds_6
--7--
create view vw_ds_7
as
SELECT manv, SUM(soluongN * dongiaN) AS tong_tien_nhap
FROM Nhap
WHERE MONTH(ngaynhap) = 8 AND YEAR(ngaynhap) = 2018
GROUP BY manv
HAVING SUM(soluongN * dongiaN) > 100000;
select * from vw_ds_7
-- 8 --
create view vw_ds_8
as
SELECT *
FROM Sanpham
WHERE masp NOT IN (SELECT masp FROM Xuat)
select * from vw_ds_8
-- 9 --
create view vw_ds_9
as
SELECT Sanpham.masp, Sanpham.tensp, Hangsx.tenhang, Nhap.ngaynhap, Xuat.ngayxuat
FROM Sanpham
JOIN Hangsx ON Sanpham.mahangsx = Hangsx.mahangsx
JOIN Nhap ON Sanpham.masp = Nhap.masp
JOIN Xuat ON Sanpham.masp = Xuat.masp
WHERE YEAR(Nhap.ngaynhap) = 2018 AND YEAR(Xuat.ngayxuat) = 2018;
select * from vw_ds_9
-- 10 --
create view vw_ds_10
as
SELECT DISTINCT NV.manv, NV.tennv
FROM Nhap N 
JOIN Xuat X ON N.masp = X.masp AND N.manv = X.manv
JOIN Nhanvien NV ON N.manv = NV.manv;
select * from vw_ds_10
-- 11 --
create view vw_ds_11
as
SELECT top 100 percent Nhanvien.manv
FROM Nhanvien
LEFT JOIN Nhap ON Nhanvien.manv = Nhap.manv
LEFT JOIN Xuat ON Nhanvien.manv = Xuat.manv
WHERE Nhap.manv IS NULL AND Xuat.manv IS NULL;
select * from vw_ds_11