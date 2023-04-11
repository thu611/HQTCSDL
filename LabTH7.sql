--Câu 1--
CREATE PROCEDURE ThemHangSX
    @mahangsx VARCHAR(10),
    @tenhang NVARCHAR(50),
    @diachi NVARCHAR(100),
    @sodt VARCHAR(20),
    @email VARCHAR(50)
AS
BEGIN
    IF EXISTS(SELECT 1 FROM Hangsx WHERE tenhang = @tenhang)
    BEGIN
        PRINT 'Tên hãng sản xuất đã tồn tại trong CSDL'
        RETURN
    END

    INSERT INTO Hangsx(mahangsx, tenhang, diachi, sodt, email)
    VALUES (@mahangsx, @tenhang, @diachi, @sodt, @email)

    PRINT 'Thêm hãng sản xuất thành công'
END
EXEC ThemHangSX 'H03', N'Vinfone', N'Việt Nam', '084-098262626', 'vf@gmail.com.vn'
--Câu 2--
CREATE PROCEDURE SP_ThemMoiSanPham
    @masp NVARCHAR(10),
    @mahangsx NVARCHAR(10),
    @tensp NVARCHAR(50),
    @soluong INT,
    @mausac NVARCHAR(20),
    @giaban FLOAT,
    @donvitinh NVARCHAR(10),
    @mota NVARCHAR(200)
AS
BEGIN
    IF EXISTS (SELECT * FROM Sanpham WHERE masp = @masp)
    BEGIN
        UPDATE Sanpham 
        SET 
            mahangsx = @mahangsx,
            tensp = @tensp,
            soluong = @soluong,
            mausac = @mausac,
            giaban = @giaban,
            donvitinh = @donvitinh,
            mota = @mota
        WHERE masp = @masp
    END
    ELSE
    BEGIN
        INSERT INTO Sanpham(masp, mahangsx, tensp, soluong, mausac, giaban, donvitinh, mota)
        VALUES(@masp, @mahangsx, @tensp, @soluong, @mausac, @giaban, @donvitinh, @mota)
    END
END
EXEC SP_ThemMoiSanPham 'SP01', 'H02', 'F1 Plus', 100, 'Xám',7000000, 'Chiếc', 'Hàng cận cao cấp'
--Câu 3--
CREATE PROCEDURE SP_XoaHangSX
    @tenhang varchar(50)
AS
BEGIN
    -- Kiểm tra xem hãng sản xuất có tồn tại trong bảng Hangsx không
    IF NOT EXISTS (SELECT * FROM Hangsx WHERE tenhang = @tenhang)
    BEGIN
        PRINT 'Hãng sản xuất không tồn tại trong bảng Hangsx.'
        RETURN
    END
    
    -- Lấy mã hãng sản xuất
    DECLARE @mahangsx int
    SELECT @mahangsx = mahangsx FROM Hangsx WHERE tenhang = @tenhang
    
    -- Xóa các sản phẩm liên quan
    DELETE FROM Sanpham WHERE mahangsx = @mahangsx
    
    -- Xóa hãng sản xuất
    DELETE FROM Hangsx WHERE tenhang = @tenhang
    
    PRINT 'Đã xóa hãng sản xuất ' + @tenhang + ' và các sản phẩm liên quan.'
END
EXEC SP_XoaHangSX 'Vivo'
--Câu 4--
CREATE PROCEDURE SP_ThemMoiNV
    @manv VARCHAR,
    @tennv NVARCHAR(50),
    @gioitinh NVARCHAR(10),
    @diachi NVARCHAR(100),
    @sodt VARCHAR(20),
    @email VARCHAR(50),
    @phong NVARCHAR(50),
    @Flag BIT
AS
BEGIN
    IF @Flag = 0 -- cập nhật nhân viên theo mã nhân viên
    BEGIN
        UPDATE Nhanvien
        SET tennv = @tennv,
            gioitinh = @gioitinh,
            diachi = @diachi,
            sodt = @sodt,
            email = @email,
            phong = @phong
        WHERE manv = @manv
    END
    ELSE -- thêm mới nhân viên
    BEGIN
        INSERT INTO Nhanvien (manv, tennv, gioitinh, diachi, sodt, email, phong)
        VALUES (@manv, @tennv, @gioitinh, @diachi, @sodt, @email, @phong)
    END
END
EXECUTE SP_ThemMoiNV
    @manv = NV04, 
    @tennv = N'Tương Thanh Phúc', 
    @gioitinh = N'Nam', 
    @diachi = N'Đồng Nai', 
    @sodt = '0123456789', 
    @email = 'phuctr273@gmail.com', 
    @phong = N'Vật Tư', 
    @Flag = 1
--Câu 5--
CREATE PROCEDURE SP_Nhap	
    @sohdn VARCHAR,
    @masp VARCHAR,
    @manv VARCHAR,
    @ngaynhap DATE,
    @soluongN INT,
    @dongiaN FLOAT
AS
BEGIN
    -- Kiểm tra masp có tồn tại trong bảng Sanpham không
    IF NOT EXISTS(SELECT * FROM Sanpham WHERE masp = @masp)
    BEGIN
        PRINT 'Mã sản phẩm không tồn tại trong bảng Sanpham'
        RETURN
    END

    -- Kiểm tra manv có tồn tại trong bảng Nhanvien không
    IF NOT EXISTS(SELECT * FROM Nhanvien WHERE manv = @manv)
    BEGIN
        PRINT 'Mã nhân viên không tồn tại trong bảng Nhanvien'
        RETURN
    END

    -- Kiểm tra sohdn đã tồn tại trong bảng Nhap hay chưa
    IF EXISTS(SELECT * FROM Nhap WHERE sohdn = @sohdn)
    BEGIN
        -- Nếu đã tồn tại thì cập nhật lại thông tin
        UPDATE Nhap 
        SET masp = @masp, manv = @manv, ngaynhap = @ngaynhap, soluongN = @soluongN, dongiaN = @dongiaN 
        WHERE sohdn = @sohdn
    END
    ELSE
    BEGIN
        -- Nếu chưa tồn tại thì thêm mới thông tin
        INSERT INTO Nhap(sohdn, masp, manv, ngaynhap, soluongN, dongiaN)
        VALUES(@sohdn, @masp, @manv, @ngaynhap, @soluongN, @dongiaN)
    END
END
EXEC SP_Nhap N06, SP06, NV06, '2020-06-15', 40, 7000000
--Câu  6--
CREATE PROCEDURE InsertOrUpdateXuat @sohdx VARCHAR, @masp VARCHAR, @manv VARCHAR, @ngayxuat DATE, @soluongX INT
AS
BEGIN
    -- Kiểm tra xem masp có tồn tại trong bảng Sanpham không
    IF NOT EXISTS(SELECT 1 FROM Sanpham WHERE masp = @masp)
    BEGIN
        RAISERROR('Mã sản phẩm không tồn tại trong bảng Sanpham.', 16, 1)
        RETURN
    END
    
    -- Kiểm tra xem manv có tồn tại trong bảng Nhanvien không
    IF NOT EXISTS(SELECT 1 FROM Nhanvien WHERE manv = @manv)
    BEGIN
        RAISERROR('Mã nhân viên không tồn tại trong bảng Nhanvien.', 16, 1)
        RETURN
    END
    
    -- Kiểm tra xem soluongX có tồn tại trong bảng Soluong hay không
    IF NOT EXISTS(SELECT 1 FROM Soluong WHERE masp = @masp AND soluong >= @soluongX)
    BEGIN
        RAISERROR('Số lượng xuất không hợp lệ.', 16, 1)
        RETURN
    END
    
    -- Kiểm tra xem sohdx đã tồn tại trong bảng Xuat hay chưa
    IF EXISTS(SELECT 1 FROM Xuat WHERE sohdx = @sohdx)
    BEGIN
        -- Nếu đã tồn tại, cập nhật bảng Xuat
        UPDATE Xuat
        SET masp = @masp, manv = @manv, ngayxuat = @ngayxuat, soluongX = @soluongX
        WHERE sohdx = @sohdx
    END
    ELSE
    BEGIN
        -- Nếu chưa tồn tại, thêm mới vào bảng Xuat
        INSERT INTO Xuat (sohdx, masp, manv, ngayxuat, soluongX)
        VALUES (@sohdx, @masp, @manv, @ngayxuat, @soluongX)
    END
END
INSERT INTO Xuat (sohdx, masp, manv, ngayxuat, soluongX) VALUES ('X06', 'SP06', 'NV06', '2020/07/03', '4');
--Câu 7--
CREATE PROCEDURE DeleteNhanVien
    @MANV NCHAR(10)
AS
BEGIN
    SET NOCOUNT ON;
    
    IF NOT EXISTS (SELECT * FROM NHANVIEN WHERE MANV = @MANV)
    BEGIN
        PRINT 'Không tồn tại nhân viên có MANV là ' + @MANV + '.'
        RETURN;
    END
    

    DELETE FROM NHAP WHERE MANV = @MANV;
    DELETE FROM XUAT WHERE MANV = @MANV;
    

    DELETE FROM NHANVIEN WHERE MANV = @MANV;
    
    PRINT 'Đã xoá thành công nhân viên có MANV là ' + @MANV + '.';
END
EXEC DeleteNhanVien N'NV05';
--cau8
CREATE PROCEDURE DeleteSanPham
    @MASP NCHAR(10)
AS
BEGIN

    IF NOT EXISTS(SELECT * FROM SANPHAM WHERE MASP = @MASP)
    BEGIN
        RAISERROR('MASP does not exist in SANPHAM table', 16, 1)
        RETURN
    END

    DELETE FROM NHAP WHERE MASP = @MASP
    

    DELETE FROM XUAT WHERE MASP = @MASP
    

    DELETE FROM SANPHAM WHERE MASP = @MASP
    
END
--kt
EXEC DeleteSanPham 'SP01';