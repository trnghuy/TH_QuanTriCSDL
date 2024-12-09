

create database QuanLySanPham
go
use QuanLySanPham
go



-- Bảng LOAISP
CREATE TABLE LOAISP (
    MaLoai CHAR(3) PRIMARY KEY,
    TenLoai NVARCHAR(50) NOT NULL
);

-- Bảng SANPHAM
CREATE TABLE SANPHAM (
    MASP CHAR(4) PRIMARY KEY,
    TenSP NVARCHAR(100) NOT NULL,
    Mota NVARCHAR(255),
    Gia DECIMAL(18, 2) CHECK (Gia > 0),
    Maloai CHAR(3) NOT NULL,
    FOREIGN KEY (Maloai) REFERENCES LOAISP(MaLoai)
);

-- Bảng KHACHHANG
CREATE TABLE KHACHHANG (
    MAKH CHAR(5) PRIMARY KEY,
    TenKH NVARCHAR(100) NOT NULL,
    DC NVARCHAR(255),
    DT NVARCHAR(15) UNIQUE
);

-- Bảng DONDH
CREATE TABLE DONDH (
    SoDDH CHAR(5) PRIMARY KEY,
    NgayDat DATE DEFAULT GETDATE(),
    MAKH CHAR(5) NOT NULL,
    FOREIGN KEY (MAKH) REFERENCES KHACHHANG(MAKH)
);

-- Bảng CTDDH
CREATE TABLE CTDDH (
    SoDDH CHAR(5) NOT NULL,
    MASP CHAR(4) NOT NULL,
    SoLuong INT CHECK (SoLuong > 0),
    PRIMARY KEY (SoDDH, MASP),
    FOREIGN KEY (SoDDH) REFERENCES DONDH(SoDDH),
    FOREIGN KEY (MASP) REFERENCES SANPHAM(MASP)
);

-- Bảng NGUYENLIEU
CREATE TABLE NGUYENLIEU (
    MaNL CHAR(4) PRIMARY KEY,
    TenNL NVARCHAR(100) NOT NULL,
    DVT NVARCHAR(20),
    Gia DECIMAL(18, 2) CHECK (Gia > 0)
);

-- Bảng LAM
CREATE TABLE LAM (
    MaNL CHAR(4) NOT NULL,
    MASP CHAR(4) NOT NULL,
    SoLuong DECIMAL(10, 2) CHECK (SoLuong > 0),
    PRIMARY KEY (MaNL, MASP),
    FOREIGN KEY (MaNL) REFERENCES NGUYENLIEU(MaNL),
    FOREIGN KEY (MASP) REFERENCES SANPHAM(MASP)
);


-- Dữ liệu LOAISP
INSERT INTO LOAISP (MaLoai, TenLoai)
VALUES 
('L01', 'Tủ'),
('L02', 'Bàn'),
('L03', 'Giường');

-- Dữ liệu SANPHAM
INSERT INTO SANPHAM (MASP, TenSP, Mota, Gia, Maloai)
VALUES 
('SP01', 'Tủ trang điểm'	, 'Cao 1.4m, rộng 2.2m'			  , 1000000	, 'L01'),
('SP02', 'Giường đơn Cali'	, 'Rộng 1.4m'					  , 1500000 , 'L03'),
('SP03', 'Tủ DDA'			, 'Cao 1.6m, rộng 2.0m, cửa kiếng', 800000  , 'L01'),
('SP04', 'Bàn ăn'			, '1m x 1.5m'					  , 650000  , 'L02'),
('SP05', 'Bàn uống trà'		, 'Tròn, 1.8m'					  , 1100000 , 'L02');

-- Dữ liệu KHACHHANG
INSERT INTO KHACHHANG (MAKH, TenKH, DC, DT)
VALUES 
('KH001', 'Trần Hải Cường' 	 , '731 Trần Hưng Đạo, Q.1, TP.HCM'         , '08-9776655'),
('KH002', 'Nguyễn Thị Bé'	 , '638 Nguyễn Văn Cừ, Q.5, TP.HCM'         , '0913-666123'),
('KH003', 'Trần Thị Minh Hòa', '543 Mai Thị Lựu, Ba Đình, Hà Nội'       , '04-9238777'),
('KH004', 'Phạm Đình Tuân'   , '975 Lê Lai, P.3, TP. Vũng Tàu'          , '064-543678'),
('KH005', 'Lê Xuân Nguyện'   , '450 Trưng Vương, TP. Mỹ Tho, Tiền Giang', '073-987123'),
('KH006', 'Văn Hùng Dũng'    , '291 Hồ Văn Huê, Q. PN, TP.HCM'          , '08-8222111'),
('KH012', 'Lê Thị Hương Hoa' , '980 Lê Hồng Phong, TP. Vũng Tàu'        , '064-452100'),
('KH016', 'Hà Minh Trí'      , '332 Nguyễn Thái Học, TP. Quy Nhơn'      , '056-565656');

-- Dữ liệu DONDH
INSERT INTO DONDH (SoDDH, NgayDat, MAKH)
VALUES 
('DH001', '2010-03-15', 'KH001'),
('DH002', '2010-03-15', 'KH016'),
('DH003', '2010-03-16', 'KH003'),
('DH004', '2010-03-16', 'KH012'),
('DH005', '2010-03-17', 'KH001'),
('DH006', '2010-04-01', 'KH002');

-- Dữ liệu CTDDH
INSERT INTO CTDDH (SoDDH, MASP, SoLuong)
VALUES 
('DH001', 'SP01', 5),
('DH001', 'SP03', 1),
('DH002', 'SP02', 2),
('DH003', 'SP01', 2),
('DH003', 'SP04', 10),
('DH003', 'SP05', 5),
('DH004', 'SP02', 2),
('DH004', 'SP05', 2),
('DH005', 'SP03', 3),
('DH006', 'SP02', 4),
('DH006', 'SP04', 3),
('DH006', 'SP05', 6);

-- Dữ liệu NGUYENLIEU
INSERT INTO NGUYENLIEU (MaNL, TenNL, DVT, Gia)
VALUES 
('NL01', 'Gỗ Lim XP'  , 'm³', 1200000),
('NL02', 'Gỗ Sao NT'  , 'm³', 1000000),
('NL03', 'Gỗ tạp nham', 'm³', 500000),
('NL04', 'Đinh lớn'   , 'kg', 40000),
('NL05', 'Đinh nhỏ'   , 'kg', 30000),
('NL06', 'Kiếng'      , 'm²', 350000);

-- Dữ liệu LAM
INSERT INTO LAM (MaNL, MASP, SoLuong)
VALUES 
('NL01', 'SP01', 1.2),
('NL03', 'SP01', 0.3),
('NL06', 'SP01', 2.5),
('NL02', 'SP02', 1.1),
('NL04', 'SP02', 2.2),
('NL02', 'SP03', 0.9),
('NL05', 'SP03', 2.1),
('NL02', 'SP04', 1.3),
('NL04', 'SP04', 1.7),
('NL03', 'SP05', 0.8),
('NL05', 'SP05', 0.5),
('NL06', 'SP05', 2.4);



-- 1. Danh sách các loại sản phẩm có nhiều sản phẩm nhất (Tên loại SP, số sản phẩm)
CREATE VIEW View_SanPham_NhieuNhat 
AS
SELECT LOAISP.TenLoai, COUNT(SANPHAM.MASP) AS SoSanPham
FROM LOAISP
JOIN SANPHAM ON LOAISP.MaLoai = SANPHAM.Maloai
GROUP BY LOAISP.TenLoai
ORDER BY SoSanPham DESC;

-- Chạy câu lệnh SELECT để xem kết quả
SELECT * FROM View_SanPham_NhieuNhat;

-- 2. Danh sách khách hàng không đặt hàng trong tháng 3/2010 (Tên KH, địa chỉ)
CREATE VIEW View_KhachHang_KhongDatThang3 AS
SELECT KHACHHANG.TenKH, KHACHHANG.DC
FROM KHACHHANG
WHERE KHACHHANG.MAKH NOT IN (
    SELECT DISTINCT MAKH
    FROM DONDH
    WHERE MONTH(NgayDat) = 3 AND YEAR(NgayDat) = 2010
);

-- Chạy câu lệnh SELECT để xem kết quả
SELECT * FROM View_KhachHang_KhongDatThang3;

-- 3. 5 khách hàng đặt nhiều đơn đặt hàng nhất trong tháng 3/2010 (Tên KH, địa chỉ)
CREATE VIEW View_KhachHang_DatNhieuDDH AS
SELECT KHACHHANG.TenKH, KHACHHANG.DC, COUNT(DONDH.SoDDH) AS SoDonDat
FROM KHACHHANG
JOIN DONDH ON KHACHHANG.MAKH = DONDH.MAKH
WHERE MONTH(DONDH.NgayDat) = 3 AND YEAR(DONDH.NgayDat) = 2010
GROUP BY KHACHHANG.TenKH, KHACHHANG.DC
ORDER BY SoDonDat DESC
LIMIT 5;

-- Chạy câu lệnh SELECT để xem kết quả
SELECT * FROM View_KhachHang_DatNhieuDDH;

-- 4. Danh sách các sản phẩm không được đặt trong tháng 3/2010 (Tên SP, mô tả)
CREATE VIEW View_SanPham_KhongDatThang3 AS
SELECT SANPHAM.TenSP, SANPHAM.Mota
FROM SANPHAM
WHERE SANPHAM.MASP NOT IN (
    SELECT DISTINCT MASP
    FROM CTDDH
    JOIN DONDH ON CTDDH.SoDDH = DONDH.SoDDH
    WHERE MONTH(DONDH.NgayDat) = 3 AND YEAR(DONDH.NgayDat) = 2010
);

-- Chạy câu lệnh SELECT để xem kết quả
SELECT * FROM View_SanPham_KhongDatThang3;

-- 5. Danh sách khách hàng có đặt trên 10 cái tủ DDA (Tên KH, địa chỉ, tổng số lượng)
CREATE VIEW View_KhachHang_DatTenDDA AS
SELECT KHACHHANG.TenKH, KHACHHANG.DC, SUM(CTDDH.SOLUONG) AS TongSoLuong
FROM KHACHHANG
JOIN DONDH ON KHACHHANG.MAKH = DONDH.MAKH
JOIN CTDDH ON DONDH.SoDDH = CTDDH.SoDDH
JOIN SANPHAM ON CTDDH.MASP = SANPHAM.MASP
WHERE SANPHAM.TenSP = 'Tủ DDA'
GROUP BY KHACHHANG.TenKH, KHACHHANG.DC
HAVING SUM(CTDDH.SOLUONG) > 10;

-- Chạy câu lệnh SELECT để xem kết quả
SELECT * FROM View_KhachHang_DatTenDDA;

-- 6. DS các sản phẩm được làm từ nhiều loại nguyên liệu nhất (Tên SP, Giá, Số loại)
CREATE VIEW View_SanPham_LamTuNhieuNL AS
SELECT SANPHAM.TenSP, SANPHAM.Gia, COUNT(DISTINCT LAM.MaNL) AS SoLoaiNguyenLieu
FROM SANPHAM
JOIN LAM ON SANPHAM.MASP = LAM.MASP
GROUP BY SANPHAM.TenSP, SANPHAM.Gia
ORDER BY SoLoaiNguyenLieu DESC;

-- Chạy câu lệnh SELECT để xem kết quả
SELECT * FROM View_SanPham_LamTuNhieuNL;

-- 7. Danh sách các sản phẩm có giá thành SX hơn 1 triệu (Tên SP, Giá thành SX)
CREATE VIEW View_SanPham_GiaSX_Hon1Trieu AS
SELECT SANPHAM.TenSP, SANPHAM.Gia AS GiaSX
FROM SANPHAM
WHERE SANPHAM.Gia > 1000000;

-- Chạy câu lệnh SELECT để xem kết quả
SELECT * FROM View_SanPham_GiaSX_Hon1Trieu;

-- 8. DS các sản phẩm có lãi trên 20% (Tên SP, Giá thành SX, Giá bản, phần trăm lãi)
CREATE VIEW View_SanPham_LaiTren20 AS
SELECT SANPHAM.TenSP, SANPHAM.Gia AS GiaSX, SANPHAM.Gia * 1.2 AS GiaBan, (SANPHAM.Gia * 1.2 - SANPHAM.Gia) / SANPHAM.Gia * 100 AS PhanTramLai
FROM SANPHAM
WHERE (SANPHAM.Gia * 1.2 - SANPHAM.Gia) / SANPHAM.Gia * 100 > 20;

-- Chạy câu lệnh SELECT để xem kết quả
SELECT * FROM View_SanPham_LaiTren20;

-- 9. Danh sách đơn đặt hàng có tổng số tiền lớn hơn 100 triệu (Số DDH, Ngày đặt, Tổng tiền)
CREATE VIEW View_DonDatHang_TongTienLonHon100Trieu AS
SELECT DONDH.SoDDH, DONDH.NgayDat, SUM(CTDDH.SOLUONG * SANPHAM.Gia) AS TongTien
FROM DONDH
JOIN CTDDH ON DONDH.SoDDH = CTDDH.SoDDH
JOIN SANPHAM ON CTDDH.MASP = SANPHAM.MASP
GROUP BY DONDH.SoDDH, DONDH.NgayDat
HAVING SUM(CTDDH.SOLUONG * SANPHAM.Gia) > 100000000;

-- Chạy câu lệnh SELECT để xem kết quả
SELECT * FROM View_DonDatHang_TongTienLonHon100Trieu;

-- 10. Danh sách các loại nguyên liệu dùng để làm tất cả các sản phẩm (Tên NL, Giá)
CREATE VIEW View_NguyenLieu_LamTatCaSP AS
SELECT NGUYENLIEU.TenNL, NGUYENLIEU.Gia
FROM NGUYENLIEU
WHERE NOT EXISTS (
    SELECT 1
    FROM SANPHAM
    WHERE NOT EXISTS (
        SELECT 1
        FROM LAM
        WHERE SANPHAM.MASP = LAM.MASP AND NGUYENLIEU.MaNL = LAM.MaNL
    )
);

-- Chạy câu lệnh SELECT để xem kết quả
SELECT * FROM View_NguyenLieu_LamTatCaSP;

-- 11. Danh sách khách hàng có đặt tất cả các sản phẩm (Tên KH, DC)
CREATE VIEW View_KhachHang_DatTatCaSP AS
SELECT KHACHHANG.TenKH, KHACHHANG.DC
FROM KHACHHANG
WHERE NOT EXISTS (
    SELECT 1
    FROM SANPHAM
    WHERE NOT EXISTS (
        SELECT 1
        FROM DONDH
        JOIN CTDDH ON DONDH.SoDDH = CTDDH.SoDDH
        WHERE DONDH.MAKH = KHACHHANG.MAKH AND CTDDH.MASP = SANPHAM.MASP
    )
);

-- Chạy câu lệnh SELECT để xem kết quả
SELECT * FROM View_KhachHang_DatTatCaSP;

-- 12. Danh sách các sản phẩm tất cả khách hàng đều đặt (Tên SP, Mô tả)
CREATE VIEW View_SanPham_TatCaKH_Dat AS
SELECT SANPHAM.TenSP, SANPHAM.Mota
FROM SANPHAM
WHERE NOT EXISTS (
    SELECT 1
    FROM KHACHHANG
    WHERE NOT EXISTS (
        SELECT 1
        FROM DONDH
        JOIN CTDDH ON DONDH.SoDDH = CTDDH.SoDDH
        WHERE DONDH.MAKH = KHACHHANG.MAKH AND CTDDH.MASP = SANPHAM.MASP
    )
);

-- Chạy câu lệnh SELECT để xem kết quả
SELECT * FROM View_SanPham_TatCaKH_Dat;

-- 13. Danh sách khách hàng lâu nhất chưa đặt hàng (Tên KH, địa chỉ)
CREATE VIEW View_KhachHang_LauNhat_ChuaDat AS
SELECT KHACHHANG.TenKH, KHACHHANG.DC
FROM KHACHHANG
WHERE KHACHHANG.MAKH NOT IN (
    SELECT DISTINCT MAKH
    FROM DONDH
)
ORDER BY KHACHHANG.DC ASC
LIMIT 1;

-- Chạy câu lệnh SELECT để xem kết quả
SELECT * FROM View_KhachHang_LauNhat_ChuaDat;
