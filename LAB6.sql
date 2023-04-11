--C�u 1--
CREATE FUNCTION DanhSachSanPhamTheoHangSX (@tenHangSX varchar(50))
RETURNS TABLE
AS
RETURN
    SELECT SanPham.MaSP, SanPham.TenSP, SanPham.SoLuong, SanPham.MauSac, SanPham.GiaBan, SanPham.DonViTinh, SanPham.MoTa, HangSX.TenHang
    FROM SanPham
    INNER JOIN HangSX ON SanPham.MaHangSX = HangSX.MaHangSX
    WHERE HangSX.TenHang = @tenHangSX
SELECT * FROM DanhSachSanPhamTheoHangSX('SamSung')
--C�u 2--
CREATE FUNCTION DanhSachSanPhamNhap(@ngayX date, @ngayY date)
RETURNS TABLE
AS
RETURN
    SELECT sp.tensp, hs.tenhang, n.ngaynhap
    FROM Sanpham sp
    JOIN Hangsx hs ON sp.mahangsx = hs.mahangsx
    JOIN Nhap n ON sp.masp = n.masp
    WHERE n.ngaynhap >= @ngayX AND n.ngaynhap <= @ngayY
GO
SELECT * FROM DanhSachSanPhamNhap('2019-05-02', '2020-07-04')
--c�u 3--
CREATE FUNCTION LuaChon(@luachon int)
RETURNS @bang TABLE (tensp nvarchar(20), masp nvarchar(10),tenhang nvarchar(20), Soluong int)
AS
BEGIN
	IF @luachon = 0
	BEGIN
		INSERT INTO @bang 
			SELECT tensp, Sanpham.masp, tenhang, Soluong FROM Sanpham INNER JOIN Hangsx ON Sanpham.mahangsx = Hangsx.mahangsx
			WHERE soluong < 0
	END
	IF @luachon = 1
	BEGIN
		INSERT INTO @bang
			SELECT tensp, Sanpham.masp, tenhang, Soluong FROM Sanpham INNER JOIN Hangsx ON Sanpham.mahangsx = Hangsx.mahangsx
			WHERE soluong > 0
	END
	RETURN
END
--c�u 4--
CREATE FUNCTION ThongTinNV (@Phong nvarchar(30))
RETURNS TABLE RETURN
SELECT Tennv FROM Nhanvien
WHERE Nhanvien.Phong = @Phong
GO
SELECT *FROM ThongTinNV ('Vat tu')
--C�u 5--
CREATE FUNCTION dbo.fn_DanhSachHangSXTheoDiaChi
    (@dia_chi NVARCHAR(30))
RETURNS TABLE
AS
RETURN
    SELECT mahangsx,Tenhang,Diachi
    FROM Hangsx
    WHERE Diachi LIKE '%' + @dia_chi + '%';
--kt
SELECT*FROM fn_DanhSachHangSXTheoDiaChi (N'KOREA')
--c�u 6--
CREATE FUNCTION DSXuat (@x int, @y int)
RETURNS TABLE RETURN
SELECT Tenhang, tensp, soluongX
FROM Xuat INNER JOIN Sanpham ON Xuat.Masp = Sanpham.masp INNER JOIN Hangsx ON Sanpham.mahangsx = Hangsx.Mahangsx
WHERE YEAR(Ngayxuat) BETWEEN @x AND @y
GO
SELECT * FROM DSXuat(2019, 2020)
--C�u 7--
CREATE FUNCTION DANHSACHSANPHAM1 (@MAHANGSX NCHAR(10), @LUACHON INT)
RETURNS TABLE
AS
RETURN 
(
    SELECT SP.MASP, SP.TENSP, SP.MAUSAC, SP.GIABAN, SP.DONVITINH,
        CASE 
            WHEN @LUACHON = 0 THEN BN.NGAYNHAP
            WHEN @LUACHON = 1 THEN BX.NGAYXUAT
        END AS 'NGAYNHAPXUAT'
    FROM SANPHAM SP
    LEFT JOIN NHAP BN ON SP.MASP = BN.MASP
    LEFT JOIN XUAT BX ON SP.MASP = BX.MASP
    WHERE SP.MAHANGSX = @MAHANGSX AND (@LUACHON = 0 OR @LUACHON = 1)
)
select * from DANHSACHSANPHAM1(N'H01',1)
--c�u 8--
CREATE FUNCTION NVNhap (@x int)
RETURNS TABLE RETURN
SELECT Nhanvien.Manv, Tennv, Phong
FROM Nhanvien INNER JOIN Nhap ON Nhanvien.Manv = Nhap.Manv
WHERE DAY(Ngaynhap) = @x
GO
SELECT * FROM NVNhap (22)
--C�u9--
CREATE FUNCTION DanhSachSanPham(
    @x FLOAT,
    @y FLOAT,
    @z NVARCHAR(50)
)
RETURNS TABLE
AS
RETURN
SELECT sp.masp, sp.tensp, sp.giaban, hs.tenhang
FROM Sanpham sp
INNER JOIN Hangsx hs ON sp.mahangsx = hs.mahangsx
WHERE sp.giaban >= @x AND sp.giaban <= @y AND hs.tenhang LIKE '%' + @z + '%'
SELECT * FROM DanhSachSanPham(1500000, 8000000, 'SamSung')
--C�u 10--
CREATE FUNCTION danhsachcacsanphamvahangsanxuat()
RETURNS TABLE
AS
RETURN (
  SELECT SANPHAM.TENSP, HANGSX.TENHANG
  FROM SANPHAM
  JOIN HANGSX ON SANPHAM.MAHANGSX = HANGSX.MAHANGSX
)
SELECT * FROM danhsachcacsanphamvahangsanxuat()