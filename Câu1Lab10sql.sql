go
USE QLBanHang
go

go
----Cau 1---------
--a--
INSERT INTO NhanVien (manv, tennv,  gioitinh, diachi, sodt, email, phong)
VALUES ('NV006', 'Nguyen Van A', 'Nam', 'Ha Noi', '0987654321', 'nva@example.com', N'Kế toán')
----Thực hiện full back up
BACKUP DATABASE [QLBanHang] TO DISK = 'D:\QLBH.bak';
go

go
--b--
INSERT INTO NhanVien (manv, tennv,  gioitinh, diachi, sodt, email, phong)
VALUES ('NV007', 'Nguyen Van B', 'Nam', 'Ha Noi', '0987654321', 'nva@example.com', N'Kế toán')
----Thực hiện different backup
BACKUP DATABASE [QLBanHang] TO DISK = 'D:\QLBHdifferentbackup.bak';
go

go
--c--
INSERT INTO NhanVien (manv, tennv,  gioitinh, diachi, sodt, email, phong)
VALUES ('NV15', 'Nguyen Van C', 'Nam', 'Ha Noi', '0987654321', 'nva@example.com', N'Kế toán');
----Thực hiện BACKUP LOG
Backup database QLBanHang To Disk = 'D:\QLBH.bak';
BACKUP LOG [QLBanHang] TO DISK = 'D:\QLBH.trn';
go

go
--d--
INSERT INTO NhanVien (manv, tennv,  gioitinh, diachi, sodt, email, phong)
VALUES ('NV16', 'Nguyen Van C', 'Nam', 'Ha Noi', '0987654321', 'nva@example.com', N'Kế toán')
----Thực hiện BACKUP LOG
BACKUP LOG [QLBanHang] TO DISK = 'D:\QLBH.trn' WITH  NOINIT;
go
