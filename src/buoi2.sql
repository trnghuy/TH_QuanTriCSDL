
create database QLSanXuat

use QLSanXuat


-- Tạo bảng Loai
CREATE TABLE Loai (
    MaLoai CHAR(5) PRIMARY KEY,
    TenLoai NVARCHAR(50) NOT NULL
);

-- Tạo bảng SanPham
CREATE TABLE SanPham (
    MaSP CHAR(5) PRIMARY KEY,
    TenSP NVARCHAR(100) UNIQUE NOT NULL,
    MaLoai CHAR(5) NOT NULL,
    FOREIGN KEY (MaLoai) REFERENCES Loai(MaLoai)
);

-- Tạo bảng NhanVien
CREATE TABLE NhanVien (
    MaNV CHAR(5) PRIMARY KEY,
    HoTen NVARCHAR(100) NOT NULL,
    NgaySinh DATE NOT NULL,
    Phai BIT DEFAULT 0 CHECK (Phai IN (0, 1)),
    CHECK (DATEDIFF(YEAR, NgaySinh, GETDATE()) >= 18 AND DATEDIFF(YEAR, NgaySinh, GETDATE()) <= 55)
);

-- Tạo bảng PhieuXuat
CREATE TABLE PhieuXuat (
    MaPX INT PRIMARY KEY IDENTITY(1,1), -- mã phiếu tự tăng bắt đầu từ 1
    NgayLap DATE NOT NULL,
    MaNV CHAR(5) NOT NULL,
    FOREIGN KEY (MaNV) REFERENCES NhanVien(MaNV)
);

-- Tạo bảng CTPX 
CREATE TABLE CTPX (
    MaPX INT NOT NULL,
    MaSP CHAR(5) NOT NULL,
    SoLuong INT NOT NULL CHECK (SoLuong > 0),
    PRIMARY KEY (MaPX, MaSP),
    FOREIGN KEY (MaPX) REFERENCES PhieuXuat(MaPX),
    FOREIGN KEY (MaSP) REFERENCES SanPham(MaSP)
);

-- Thêm dữ liệu mẫu cho Loai
INSERT INTO Loai (MaLoai, TenLoai) VALUES 
('1', 'Vật Liệu Xây Dựng'),
('2', 'Hàng Tiêu Dùng'),
('3', 'Ngũ Cốc');

-- Thêm dữ liệu mẫu cho SanPham
INSERT INTO SanPham (MaSP, TenSP, MaLoai) VALUES 
('1', 'Xi Măng', '1'),
('2', 'Gạch', '1'),
('3', 'Gạo Nàng Hương', '3'),
('4', 'Bột Mì', '3'),
('5', 'Kệ Chén', '2'),
('6', 'Đậu Xanh', '3');

-- Thêm dữ liệu mẫu cho NhanVien
INSERT INTO NhanVien (MaNV, HoTen, NgaySinh, Phai) VALUES 
('NV01', 'Nguyễn Mai Thi', '1982-05-15', 0),
('NV02', 'Trần Dình Chiến', '1980-02-12', 1),
('NV03', 'Lê Thị Chi', '1979-1-23', 0);

-- Thêm dữ liệu mẫu cho PhieuXuat
INSERT INTO PhieuXuat (NgayLap, MaNV) VALUES 
('2010-3-12', 'NV01'),
('2010-2-3', 'NV02'),
('2010-6-1', 'NV03'),
('2010-6-16', 'NV01');

-- Thêm dữ liệu mẫu cho CTPX
INSERT INTO CTPX (MaPX, MaSP, SoLuong) VALUES 
(1, '1', 10),
(1, '2', 15),
(1, '3', 5),
(2, '2', 20),
(3, '1', 20),
(3, '3', 25),
(4, '5', 12);





--vieww
-- 1. Tổng số lượng xuất của từng sản phẩm trong năm 2010
CREATE VIEW v_TongSoLuongSanPhamNam2010 AS
(
    SELECT 
        sp.MaSP, 
        sp.TenSP, 
        SUM(ct.SoLuong) AS TongSoLuong
    FROM SanPham sp
    JOIN CTPX ct ON sp.MaSP = ct.MaSP
    JOIN PhieuXuat px ON ct.MaPX = px.MaPX
    WHERE YEAR(px.NgayLap) = 2010
    GROUP BY sp.MaSP, sp.TenSP
);

-- 2. Sản phẩm được bán từ ngày 1/1/2010 đến 30/6/2010
CREATE VIEW v_SanPhamBanTrongKhoangThoiGian AS
(
    SELECT 
        sp.MaSP, 
        sp.TenSP, 
        l.TenLoai
    FROM SanPham sp
    JOIN Loai l ON sp.MaLoai = l.MaLoai
    JOIN CTPX ct ON sp.MaSP = ct.MaSP
    JOIN PhieuXuat px ON ct.MaPX = px.MaPX
    WHERE px.NgayLap BETWEEN '2010-01-01' AND '2010-06-30'
);

-- 3. Số lượng sản phẩm trong từng loại sản phẩm
CREATE VIEW v_SoLuongSanPhamTrongLoai AS
(
    SELECT 
        l.MaLoai, 
        l.TenLoai, 
        COUNT(sp.MaSP) AS SoLuongSanPham
    FROM Loai l
    LEFT JOIN SanPham sp ON l.MaLoai = sp.MaLoai
    GROUP BY l.MaLoai, l.TenLoai
);

-- 4. Tổng số lượng phiếu xuất trong tháng 6 năm 2010
CREATE VIEW v_TongPhieuXuatThang6Nam2010 AS
(
    SELECT 
        COUNT(*) AS TongSoPhieuXuat
    FROM PhieuXuat
    WHERE YEAR(NgayLap) = 2010 AND MONTH(NgayLap) = 6
);

-- 5. Thông tin phiếu xuất của nhân viên NV01
CREATE VIEW v_PhieuXuatNV01 AS
(
    SELECT 
        px.MaPX, 
        px.NgayLap, 
        px.MaNV
    FROM PhieuXuat px
    WHERE px.MaNV = 'NV01'
);

-- 6. Danh sách nhân viên nam trên 25 và dưới 30 tuổi
CREATE VIEW v_NhanVienNam25To30 AS
(
    SELECT 
        nv.MaNV, 
        nv.HoTen, 
        nv.NgaySinh
    FROM NhanVien nv
    WHERE nv.Phai = 1
      AND DATEDIFF(YEAR, nv.NgaySinh, GETDATE()) > 25
      AND DATEDIFF(YEAR, nv.NgaySinh, GETDATE()) < 30
);

-- 7. Thống kê số lượng phiếu xuất theo nhân viên
CREATE VIEW v_ThongKePhieuXuatTheoNhanVien AS
(
    SELECT 
        nv.MaNV, 
        nv.HoTen, 
        COUNT(px.MaPX) AS SoLuongPhieuXuat
    FROM NhanVien nv
    LEFT JOIN PhieuXuat px ON nv.MaNV = px.MaNV
    GROUP BY nv.MaNV, nv.HoTen
);

-- 8. Thống kê số lượng sản phẩm xuất theo từng sản phẩm
CREATE VIEW v_ThongKeSanPhamXuat AS
(
    SELECT 
        sp.MaSP, 
        sp.TenSP, 
        SUM(ct.SoLuong) AS TongSoLuongXuat
    FROM SanPham sp
    JOIN CTPX ct ON sp.MaSP = ct.MaSP
    GROUP BY sp.MaSP, sp.TenSP
);

-- 9. Nhân viên có số lượng phiếu xuất lớn nhất
CREATE VIEW v_NhanVienPhieuXuatNhieuNhat AS
(
    SELECT TOP 1 
        nv.HoTen, 
        COUNT(px.MaPX) AS SoLuongPhieuXuat
    FROM NhanVien nv
    LEFT JOIN PhieuXuat px ON nv.MaNV = px.MaNV
    GROUP BY nv.HoTen
    ORDER BY SoLuongPhieuXuat DESC
);

-- 10. Sản phẩm được xuất nhiều nhất trong năm 2010
CREATE VIEW v_SanPhamXuatNhieuNhat2010 AS
(
    SELECT TOP 1 
        sp.TenSP, 
        SUM(ct.SoLuong) AS TongSoLuongXuat
    FROM SanPham sp
    JOIN CTPX ct ON sp.MaSP = ct.MaSP
    JOIN PhieuXuat px ON ct.MaPX = px.MaPX
    WHERE YEAR(px.NgayLap) = 2010
    GROUP BY sp.TenSP
    ORDER BY TongSoLuongXuat DESC
);



---------------------------------------

-- Function F1: Số lượng xuất kho của sản phẩm trong năm
CREATE FUNCTION F1(@TenSP NVARCHAR(50), @Nam INT)
RETURNS INT
AS
BEGIN
    DECLARE @SoLuong INT = 0;
    SELECT @SoLuong = SUM(ct.SoLuong)
    FROM SanPham sp
    JOIN CTPX ct ON sp.MaSP = ct.MaSP
    JOIN PhieuXuat px ON ct.MaPX = px.MaPX
    WHERE sp.TenSP = @TenSP AND YEAR(px.NgayLap) = @Nam;
    RETURN ISNULL(@SoLuong, 0);
END;

SELECT dbo.F1('Gạch', 2010) AS SoLuongXuatKho;

-- Function F2: Số lượng phiếu xuất của một nhân viên
CREATE FUNCTION F2(@MaNV CHAR(5))
RETURNS INT
AS
BEGIN
    DECLARE @SoLuong INT = 0;
    SELECT @SoLuong = COUNT(*)
    FROM PhieuXuat
    WHERE MaNV = @MaNV;
    RETURN @SoLuong;
END;

SELECT dbo.F2('NV01') AS SoLuongPhieuXuat;



-- Function F3: Danh sách sản phẩm được xuất trong năm
CREATE FUNCTION F3(@Nam INT)
RETURNS TABLE
AS
RETURN
(
    SELECT DISTINCT sp.MaSP, sp.TenSP
    FROM SanPham sp
    JOIN CTPX ct ON sp.MaSP = ct.MaSP
    JOIN PhieuXuat px ON ct.MaPX = px.MaPX
    WHERE YEAR(px.NgayLap) = @Nam
);

SELECT * 
FROM dbo.F3(2010);

-- Function F4: Danh sách phiếu xuất của nhân viên
CREATE FUNCTION F4(@MaNV CHAR(5) = NULL)
RETURNS TABLE
AS
RETURN
(
    SELECT px.MaPX, px.NgayLap, px.MaNV
    FROM PhieuXuat px
    WHERE @MaNV IS NULL OR px.MaNV = @MaNV
);

SELECT * 
FROM dbo.F4('NV01');


-- Function F5: Tên nhân viên của một phiếu xuất
CREATE FUNCTION F5(@MaPX INT)
RETURNS NVARCHAR(255)
AS
BEGIN
    DECLARE @HoTen NVARCHAR(255);
    SELECT @HoTen = nv.HoTen
    FROM NhanVien nv
    JOIN PhieuXuat px ON nv.MaNV = px.MaNV
    WHERE px.MaPX = @MaPX;
    RETURN @HoTen;
END;

-- Lấy tên nhân viên của phiếu xuất có mã 1
SELECT dbo.F5(1) AS TenNhanVien;

-- Function F6: Danh sách phiếu xuất từ ngày T1 đến T2
CREATE FUNCTION F6(@T1 DATE, @T2 DATE)
RETURNS TABLE
AS
RETURN
(
    SELECT px.MaPX, px.NgayLap, px.MaNV
    FROM PhieuXuat px
    WHERE px.NgayLap BETWEEN @T1 AND @T2
);
SELECT * 
FROM dbo.F6('2010-2-01', '2010-12-02');

-- Function F7: Ngày xuất của một phiếu xuất
CREATE FUNCTION F7(@MaPX INT)
RETURNS DATE
AS
BEGIN
    DECLARE @NgayLap DATE;
    SELECT @NgayLap = NgayLap
    FROM PhieuXuat
    WHERE MaPX = @MaPX;
    RETURN @NgayLap;
END;

SELECT dbo.F7(1) AS NgayXuat;





-- Procedure P1: Tổng số lượng xuất kho của sản phẩm trong năm 2010
CREATE PROCEDURE P1
    @TenSP NVARCHAR(255),
    @TongSoLuong INT OUTPUT
AS
BEGIN
    SET @TongSoLuong = dbo.F1(@TenSP, 2010);
END;

DECLARE @TongSoLuong INT;
EXEC P1 'Xi Măng', @TongSoLuong OUTPUT;
PRINT 'Tổng số lượng xuất kho: ' + CAST(@TongSoLuong AS NVARCHAR(50));


-- Procedure P2: Tổng số lượng xuất kho của sản phẩm từ 04/2010 đến 06/2010
CREATE PROCEDURE P2
    @TenSP NVARCHAR(255),
    @TongSoLuong INT OUTPUT
AS
BEGIN
    SELECT @TongSoLuong = SUM(ct.SoLuong)
    FROM SanPham sp
    JOIN CTPX ct ON sp.MaSP = ct.MaSP
    JOIN PhieuXuat px ON ct.MaPX = px.MaPX
    WHERE sp.TenSP = @TenSP 
      AND px.NgayLap BETWEEN '2010-04-01' AND '2010-06-30';
    IF @TongSoLuong IS NULL
        SET @TongSoLuong = 0;
END;

DECLARE @TongSoLuong INT;
EXEC P2 'Bột Mì', @TongSoLuong OUTPUT;
PRINT 'Tong so luong xuat kho (04/2010 - 06/2010): ' + CAST(@TongSoLuong AS NVARCHAR(50));



-- Procedure P3: Gọi P2 để lấy số lượng xuất kho
CREATE PROCEDURE P3
    @TenSP NVARCHAR(255)
AS
BEGIN
    DECLARE @SoLuong INT;
    EXEC P2 @TenSP, @SoLuong OUTPUT;
    PRINT 'so luong xuat kho: ' + CAST(@SoLuong AS NVARCHAR(50));
END;
EXEC P3 'Xi Măng';


-- Procedure P4: Thêm một loại sản phẩm
CREATE PROCEDURE P4
    @MaLoai CHAR(5),
    @TenLoai NVARCHAR(255)
AS
BEGIN
    INSERT INTO Loai (MaLoai, TenLoai)
    VALUES (@MaLoai, @TenLoai);
END;


EXEC P4 'L005', 'Loại sản phẩm mới';-- Thêm loại sản phẩm mới với mã L005 và tên "Loại sản phẩm mới"
-- Kiểm tra kết quả
SELECT * 
FROM Loai;


-- Procedure P5: Xóa nhân viên theo mã
CREATE PROCEDURE P5
    @MaNV CHAR(5)
AS
BEGIN
    DELETE FROM NhanVien
    WHERE MaNV = @MaNV;
END;


EXEC P5 'NV02';-- Xóa nhân viên với mã NV01
-- Kiểm tra 
SELECT * 
FROM NhanVien;



------------------------------------------------
-- Trigger 1: Giới hạn tối đa 5 chi tiết phiếu xuất cho một phiếu xuất
CREATE TRIGGER trg_LimitChiTietPhieuXuat
ON CTPX
AFTER INSERT, UPDATE
AS
BEGIN
    -- Kiểm tra số lượng chi tiết trong từng phiếu xuất
    IF EXISTS (
        SELECT MaPX
        FROM CTPX
        GROUP BY MaPX
        HAVING COUNT(MaSP) > 5
    )
    BEGIN
        ROLLBACK TRANSACTION;
        RAISERROR ('Một phiếu xuất chỉ được phép có tối đa 5 chi tiết.', 16, 1);
    END;
END;

-- Trigger 2: Giới hạn tối đa 10 phiếu xuất/ngày cho một nhân viên
CREATE TRIGGER trg_LimitPhieuXuatByNhanVien
ON PhieuXuat
AFTER INSERT, UPDATE
AS
BEGIN
    -- Kiểm tra số lượng phiếu xuất của từng nhân viên trong cùng một ngày
    IF EXISTS (
        SELECT MaNV, NgayLap
        FROM PhieuXuat
        GROUP BY MaNV, CAST(NgayLap AS DATE)
        HAVING COUNT(MaPX) > 10
    )
    BEGIN
        ROLLBACK TRANSACTION;
        RAISERROR ('Mỗi nhân viên chỉ được phép lập tối đa 10 phiếu xuất trong một ngày.', 16, 1);
    END;
END;

-- Trigger 3: Kiểm tra mã phiếu xuất khi thêm chi tiết phiếu xuất
CREATE TRIGGER trg_ValidateChiTietPhieuXuat
ON CTPX
AFTER INSERT, UPDATE
AS
BEGIN
    -- Kiểm tra mã phiếu xuất trong bảng chi tiết phiếu xuất có tồn tại trong bảng phiếu xuất hay không
    IF EXISTS (
        SELECT ct.MaPX
        FROM INSERTED ct
        LEFT JOIN PhieuXuat px ON ct.MaPX = px.MaPX
        WHERE px.MaPX IS NULL
    )
    BEGIN
        ROLLBACK TRANSACTION;
        RAISERROR ('Phiếu xuất này không tồn tại.', 16, 1);
    END;
END;
