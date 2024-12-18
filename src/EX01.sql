CREATE DATABASE QUANLY_BANHANG

USE QUANLY_BANHANG

on primary
(
	Name='QUANLY_BANHANG_DATA', 
	filename='C:\QTCSDL\QLBANHANG.mdf'
)
log on
(
	Name='QUANLY_BANHANG_LOG', 
	filename='C:\QTCSDL\QLBANHANG.ldf'
)
/*
--Tao lai CSDL bang DETACH
--B1: Ngat ket noi CSDL (Neu dang ket noi)
SP_DETACH_DB QLBANHANG
--B2: Ket noi lai CSDL tu mdf file
Create database QLBANHANG
on primary
(
	filename='C:\QTCSDL\QLBANHANG.mdf'
)
FOR ATTACH
*/

--Mo CSDL de dung

--II. Tao bang
--Tao bang VATTU
Create Table VATTU
(
	MaVT varchar(5),
	TenVT nvarchar(40) not null,
	DVT nvarchar(10) not null,
	DonGiaMua money constraint chkDonGiaMua check (DonGiaMua>0),
	SLTON int constraint chkSLTON check (SLTON>=0),
	primary key(MaVT) 
)
--Tao bang KhachHang (MaKH, TenKH, Diachi, DT, Email)
create table KhachHang
(
	MaKH varchar(5),
	TenKH nvarchar(30) not null,
	DiaChi nvarchar(50) not null,
	DT varchar(11),
	Email varchar(30),
	primary key(MaKH)
)

Create Table HOADON
(
	SoHD Varchar(12),
	NgayLap Date not null, --constraint chkNgayLap check (NgayLap>=getdate()),
	TongTG float,
	MaKH varchar(5) not null,
	Primary key (SoHD)
	--,Foreign key (MaKH) references KHACHHANG(MaKH) on update cascade
)

Create Table CHITIETHOADON
(
	SoHD Varchar(12),
	MaVT Varchar(5),
	SoLuong int not null, 
	DonGiaBan float not null,
	KhuyenMai float,	
	Primary key (SoHD, MaVT),
	--Foreign key (SoHD) references HOADON(SoHD) on update cascade,
	--Foreign key (MaVT) references VATTU(MaVT) on update cascade, 
	Constraint chkSoLuong check (SoLuong>0), 
	Constraint chkDonGiaBan check (DonGiaBan>0)
)
--III. Them mau tin (bộ, dong du lieu)
--Them mau tin vao bang MATHANG
Insert Into VATTU(MAVT,TENVT,DVT,DonGiaMua,SLTON)
Values('VT01',N'Xi măng',N'Bao',50000,5000)
Insert Into VATTU(MAVT,TENVT,DVT,DonGiaMua,SLTON)
Values('VT02',N'Cát',N'Khối',45000,50000)
Insert Into VATTU(MAVT,TENVT,DVT,DonGiaMua,SLTON)
Values('VT03',N'Gạch ống',N'Viên',120,800000)
Insert Into VATTU(MAVT,TENVT,DVT,DonGiaMua,SLTON)
Values('VT04',N'Gạch thẻ',N'Viên',110,800000)
Insert Into VATTU(MAVT,TENVT,DVT,DonGiaMua,SLTON)
Values('VT05',N'Đá lớn',N'Khối',25000,100000)
Insert Into VATTU(MAVT,TENVT,DVT,DonGiaMua,SLTON)
Values('VT06',N'Đá nhỏ',N'Khối',33000,100000)
Insert Into VATTU(MAVT,TENVT,DVT,DonGiaMua,SLTON)
Values('VT07',N'Lam gió',N'Cái',15000,50000)

--Them mau tin vao bang KHACHHANG
Insert Into KHACHHANG(MAKH,TENKH,DIACHI,DT,EMAIL)
Values('KH01',N'Nguyễn Thị Bé',N'Tân Bình','38457895','bnt@yahoo.com')
Insert Into KHACHHANG(MAKH,TENKH,DIACHI,DT,EMAIL)
Values('KH02',N'Lê Hoàng Nam',N'Bình Chánh','39878987','namlehoang@gmail.com')
Insert Into KHACHHANG(MAKH,TENKH,DIACHI,DT,EMAIL)
Values('KH03',N'Trần Thị Chiêu',N'Tân Bình','38457895',NULL)
Insert Into KHACHHANG(MAKH,TENKH,DIACHI,DT,EMAIL)
Values('KH04',N'Mai Thị Quế Anh',N'Bình Chánh',NULL,NULL)
Insert Into KHACHHANG(MAKH,TENKH,DIACHI,DT,EMAIL)
Values('KH05',N'Lê Văn Sáng',N'Quận 10',NULL,'sanglv@hcm.vnn.vn')
Insert Into KHACHHANG(MAKH,TENKH,DIACHI,DT,EMAIL)
Values('KH06',N'Trần Hoàng',N'Tân Bình','38457897',NULL)

--Them mau tin vao bang HOADON
set dateformat dmy		--Thiet lap dinh dang dd/mm/yyyy

insert into HOADON (SoHD,NGAYLAP,MAKH,TONGTG)
values ('HD001','12/05/2010','KH01',NULL)
insert into HOADON (SoHD,NGAYLAP,MAKH,TONGTG)
values ('HD002','25/05/2010','KH02',NULL)
insert into HOADON (SoHD,NGAYLAP,MAKH,TONGTG)
values ('HD003','25/05/2010','KH01',NULL)
insert into HOADON (SoHD,NGAYLAP,MAKH,TONGTG)
values ('HD004','25/05/2010','KH04',NULL)
insert into HOADON (SoHD,NGAYLAP,MAKH,TONGTG)
values ('HD005','26/05/2010','KH04',NULL)
insert into HOADON (SoHD,NGAYLAP,MAKH,TONGTG)
values ('HD006','02/06/2010','KH03',NULL)
insert into HOADON (SoHD,NGAYLAP,MAKH,TONGTG)
values ('HD007','22/06/2010','KH04',NULL)
insert into HOADON (SoHD,NGAYLAP,MAKH,TONGTG)
values ('HD008','25/06/2010','KH03',NULL)
insert into HOADON (SoHD,NGAYLAP,MAKH,TONGTG)
values ('HD009','15/08/2010','KH04',NULL)
insert into HOADON (SoHD,NGAYLAP,MAKH,TONGTG)
values ('HD010','30/09/2010','KH01',NULL)


--Them mau tin vao bang CHITIETHOADON
Insert Into CHITIETHOADON(SoHD,MAVT,SoLuong,KHUYENMAI,DonGiaBan)
Values ('HD001','VT01',5,NULL,52000)
Insert Into CHITIETHOADON(SoHD,MAVT,SoLuong,KHUYENMAI,DonGiaBan)
Values ('HD001','VT05',10,NULL,30000)
Insert Into CHITIETHOADON(SoHD,MAVT,SoLuong,KHUYENMAI,DonGiaBan)
Values ('HD002','VT03',10000,NULL,150)
Insert Into CHITIETHOADON(SoHD,MAVT,SoLuong,KHUYENMAI,DonGiaBan)
Values ('HD003','VT02',20,NULL,55000)
Insert Into CHITIETHOADON(SoHD,MAVT,SoLuong,KHUYENMAI,DonGiaBan)
Values ('HD004','VT03',50000,NULL,150)
Insert Into CHITIETHOADON(SoHD,MAVT,SoLuong,KHUYENMAI,DonGiaBan)
Values ('HD004','VT04',20000,NULL,120)
Insert Into CHITIETHOADON(SoHD,MAVT,SoLuong,KHUYENMAI,DonGiaBan)
Values ('HD005','VT05',10,NULL,30000)
Insert Into CHITIETHOADON(SoHD,MAVT,SoLuong,KHUYENMAI,DonGiaBan)
Values ('HD005','VT06',15,NULL,35000)
Insert Into CHITIETHOADON(SoHD,MAVT,SoLuong,KHUYENMAI,DonGiaBan)
Values ('HD005','VT07',20,NULL,17000)
Insert Into CHITIETHOADON(SoHD,MAVT,SoLuong,KHUYENMAI,DonGiaBan)
Values ('HD006','VT04',10000,NULL,120)
Insert Into CHITIETHOADON(SoHD,MAVT,SoLuong,KHUYENMAI,DonGiaBan)
Values ('HD007','VT04',20000,NULL,125)
Insert Into CHITIETHOADON(SoHD,MAVT,SoLuong,KHUYENMAI,DonGiaBan)
Values ('HD008','VT01',100,NULL,55000)
Insert Into CHITIETHOADON(SoHD,MAVT,SoLuong,KHUYENMAI,DonGiaBan)
Values ('HD008','VT02',20,NULL,47000)
Insert Into CHITIETHOADON(SoHD,MAVT,SoLuong,KHUYENMAI,DonGiaBan)
Values ('HD009','VT02',25,NULL,48000)
Insert Into CHITIETHOADON(SoHD,MAVT,SoLuong,KHUYENMAI,DonGiaBan)
Values ('HD010','VT01',25,NULL,57000)




--TẠO VIEW

-- CÂU 3

CREATE VIEW CAU3 
AS 
(
	SELECT *
	FROM KhachHang
	WHERE (DT IS NULL) AND (Email IS NULL)
)

-- CAU6
CREATE VIEW CAU6 
AS
(
	SELECT *
	FROM VATTU
	WHERE DonGiaMua >=25000
)

-- CAU8
CREATE VIEW CAU8 
AS
(
	SELECT *
	FROM VATTU VT
	WHERE VT.DonGiaMua >20000 AND VT.DonGiaMua <40000
)

-- CAU10
CREATE VIEW CAU10 
AS
(
	SELECT SoHD, TenKH,DiaChi,DT
	FROM KhachHang KH, HOADON HD
	WHERE KH.MaKH=HD.MaKH AND (NgayLap = '25/5/2010')
)

--CAU 11
CREATE VIEW CAU11 
AS
(
	SELECT HD.SoHD,HD.NgayLap, KH.TenKH,KH.DiaChi,KH.DT
	FROM KhachHang KH, HOADON HD
	WHERE KH.MaKH=HD.MaKH AND MONTH(HD.NgayLap)=6 AND YEAR(HD.NgayLap)='2010'
)

--CAU16
CREATE VIEW CAU16 
AS 
(
	SELECT 
		CT.SoHD ,CT.MaVT ,VT.TenVT,VT.DVT,CT.DonGiaBan,VT.DonGiaMua,CT.SoLuong,
		VT.DonGiaMua * CT.SoLuong AS GiaMua, 
		CT.DonGiaBan * CT.SoLuong AS GiaBan,
		(CT.DonGiaBan * CT.SoLuong)* 0.1 AS KhuyenMai
	FROM CHITIETHOADON CT
	JOIN VATTU VT ON CT.MaVT = VT.MaVT
	WHERE CT.DonGiaBan * CT.SoLuong > 100
)


-- cau20
CREATE VIEW cau20 AS
(

)
 
 --cau21
 CREATE VIEW cau21
 AS
(
	SELECT 
		HD.SoHD ,HD.NgayLap ,KH.TenKH,KH.DiaChi,
		SUM(CT.DonGiaBan * CT.SoLuong) AS TongTriGia
	FROM HOADON HD
	JOIN KHACHHANG KH ON HD.MaKH = KH.MaKH
	JOIN CHITIETHOADON CT ON HD.SoHD = CT.SoHD
	GROUP BY HD.SoHD, HD.NgayLap, KH.TenKH, KH.DiaChi
)
 
 --cau 22
 create view cau22 
 as
 (
	 SELECT top 1
		HD.SoHD,HD.NgayLap, KH.TenKH , KH.DiaChi ,
		SUM(CT.DonGiaBan * CT.SoLuong) AS TongTriGia
	FROM HOADON HD
	JOIN KHACHHANG KH ON HD.MaKH = KH.MaKH
	JOIN CHITIETHOADON CT ON HD.SoHD = CT.SoHD
	GROUP BY HD.SoHD, HD.NgayLap, KH.TenKH, KH.DiaChi
	ORDER BY TongTriGia DESC
)


-- cau 23
create view cau23 
as
(
	SELECT top 1
		HD.SoHD,HD.NgayLap, KH.TenKH , KH.DiaChi ,
		SUM(CT.DonGiaBan * CT.SoLuong) AS TongTriGia
	FROM HOADON HD
	JOIN KHACHHANG KH ON HD.MaKH = KH.MaKH
	JOIN CHITIETHOADON CT ON HD.SoHD = CT.SoHD
	WHERE HD.NgayLap BETWEEN '2010-05-01' AND '2010-05-31'
	GROUP BY HD.SoHD, HD.NgayLap, KH.TenKH, KH.DiaChi
	ORDER BY TongTriGia DESC 
)



-- TẠO PROC---

---CAU2 LẤY DANH SÁCH KHÁCH HÀNG CÓ TỔNG GIÁ TRỊ CÁC ĐƠN HÀNG LỚN HƠN X ( X LÀ THAM SỐ)

CREATE PROC cau2  @x int
AS
BEGIN
    SELECT KH.MaKH, TenKH, DiaChi, DT, 
           SUM(CT.DonGiaBan * CT.SoLuong) AS TongTriGia
    FROM KHACHHANG KH
    JOIN HOADON HD ON KH.MaKH = HD.MaKH
    JOIN CHITIETHOADON CT ON HD.SoHD = CT.SoHD
    GROUP BY KH.MaKH ,KH.TenKH, KH.DiaChi, KH.DT
    HAVING SUM(CT.DonGiaBan * CT.SoLuong) > @x
END 

--cau 3
CREATE PROC cau3  @x int
AS
BEGIN
    SELECT TOP 1 KH.MaKH, TenKH, DiaChi, DT, 
           SUM(CT.DonGiaBan * CT.SoLuong) AS TongTriGia
    FROM KHACHHANG KH
    JOIN HOADON HD ON KH.MaKH = HD.MaKH
    JOIN CHITIETHOADON CT ON HD.SoHD = CT.SoHD
    GROUP BY KH.MaKH ,KH.TenKH, KH.DiaChi, KH.DT
    HAVING SUM(CT.DonGiaBan * CT.SoLuong) > @x
    ORDER BY TongTriGia DESC
END 

EXE