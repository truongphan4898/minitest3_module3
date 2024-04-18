drop database if exists QuanLyCuaHang;
create database if not exists QuanLyCuaHang;

use QuanLyCuaHang;

create table VatTu(
MaVatTu int primary key not null,
TenVatTu nvarchar(50) not null,
DonViTinh nvarchar(20) not null,
Price float not null);
insert into VatTu(MaVatTu, TenVatTu, DonViTinh, Price) value (101, 'chuot khong day', 'cai', 100), (102, 'chuot co day', 'cai', 120),
(103, 'phim co', 'cai', 1000), (104, 'phim gia co', 'cai', 300), (105, 'tai nghe gaming', 'cai',900),(106,'tai nghe in ear', 'cai',500),
(107, 'loa mini', 'cai', 600), (108, 'loa cai', 'cai', 1500), (109, 'sac khong day', 'cai', 2000), (110, 'lot chuot', 'cai', 50);

create table TonKho(
ID int auto_increment primary key not null,
MaVatTu int not null,
SoLuongDau int not null,
TongSoLuongNhap int not null,
TongSoLuongXuat int not null);
insert into TonKho(MaVatTu, SoLuongDau, TongSoLuongNhap, TongSoLuongXuat) value ( 101, 1000, 300, 200), (102, 2000, 600, 400), (104, 1000, 500,400),
(105, 500, 350,300), (109, 1500, 400, 250);
insert into TonKho(MaVatTu, SoLuongDau, TongSoLuongNhap, TongSoLuongXuat) value (103, 200,400,200), ( 106, 300, 500,300), (107, 400,200,100),
(108, 400, 300,100),(110,200,300,100);

create table NhaCungCap(
MaNCC int primary key not null,
TenNCC nvarchar(50) not null,
DiaChi nvarchar(50) not null,
SDT varchar(20) not null);
insert into NhaCungCap( MaNCC, TenNCC, DiaChi, SDT) value ( 905, 'Nha cung cap 1', 'Quang Nam', '0905123'), (906, 'Nha Cung Cap 2', 'Da Nang', '0905124'),
(907, 'Nha Cung Cap 3', 'Hue', '0905125');

create table DonDatHang (
MaDon int primary key not null,
NgayDatHang date not null,
MaNCC int not null);
insert into DonDatHang (MaDon, NgayDatHang, MaNCC) value (666, '2024-03-04', 905), (777, '2024-02-05', 906), (888, '2024-01-08', 907);

create table PhieuNhap(
SoPNhap int primary key not null,
NgayNhap date not null,
MaDon int not null);
insert into PhieuNhap (SoPNhap, NgayNhap, MaDon) value (111, '2024-03-10', 666), (112, '2024-02-15', 777), (113, '2024-01-20',888);


create table PhieuXuat(
ID int auto_increment primary key not null,
NgayXuat date not null,
TenKh nvarchar(50) not null);
insert into PhieuXuat(NgayXuat, TenKh) value ('2024-03-10','Phat'), ('2024-02-15','Loc'), ('2024-01-20','Tho');

create table CTDonHang(
ID int auto_increment primary key not null,
MaDH int not null,
MaVatTu int not null,
SoLuongDat int not null);
insert into CTDonHang( MaDH, MaVatTu, SoLuongDat) value (666, 102, 200), (666, 103,300), (777, 104, 300), (666, 105, 400), (777, 107, 600),
(888, 109, 700);

create table CTPhieuNhap(
ID int auto_increment primary key not null,
SoPNhap int not null,
MaVatTu int not null,
SoLuongNhap int not null,
DonGiaNhap float not null,
GhiChu text);
insert into CTPhieuNhap(SoPNhap, MaVatTu, SoLuongNhap, DonGiaNhap) value (112, 102, 100, 80), (113,103,200,800), (113, 104, 300, 200),
(111,105,400,700), (112, 106, 300,400), (113, 109, 300,500);
insert into CTPhieuNhap(SoPNhap, MaVatTu, SoLuongNhap, DonGiaNhap) value(111, 108,200,1000);


create table CTPhieuXuat(
ID int auto_increment primary key not null,
PhieuXuat_ID int not null,
MaVatTu int not null,
SoLuongXuat int not null,
DonGiaXuat float not null,
GhiChu text);
insert into CTPhieuXuat(PhieuXuat_ID, MaVatTu, SoLuongXuat, DonGiaXuat) value (1, 102, 100, 100), (1,103,200,1000), (2, 104, 300, 300),
(1,105,400,900), (3, 106, 300,600), (2, 109, 300,700);

alter table TonKho add constraint FK1 foreign key (MaVatTu) references VatTu (MaVatTu);
alter table CTPhieuXuat add constraint FK2 foreign key (MaVatTu) references VatTu (MaVatTu);
alter table CTDonHang add constraint FK3 foreign key (MaVatTu) references VatTu (MaVatTu);
alter table CTPhieuNhap add constraint FK4 foreign key (MaVatTu) references VatTu (MaVatTu);

alter table CTPhieuNhap add constraint FK5 foreign key (SoPNhap) references PhieuNhap (SoPNhap);

alter table PhieuNhap add constraint FK6 foreign key (MaDon) references DonDatHang (MaDon);

alter table DonDatHang add constraint FK7 foreign key (MaNCC) references NhaCungCap (MaNCC);

alter table CTDonHang add constraint FK8 foreign key (MaDH) references DonDatHang (MaDon);

alter table CTPhieuXuat add constraint FK9 foreign key (PhieuXuat_ID) references PhieuXuat (ID);


create view vw_CTPhieuNhap as 
select 
    SoPNhap as SoPhieuNhap,
    MaVatTu,
    SoLuongNhap,
    DonGiaNhap,
    SoLuongNhap * DonGiaNhap as ThanhTien
from CTPhieuNhap;
select * from vw_CTPhieuNhap;


create view vw_CTPhieuNhap_VT as 
select
PN.SoPNhap as SoPhieuNhap,
    PN.MaVatTu,
    VT.TenVatTu,
    PN.SoLuongNhap,
    PN.DonGiaNhap,
    PN.SoLuongNhap * PN.DonGiaNhap as ThanhTien
from CTPhieuNhap PN join VatTu VT on PN.MaVatTu = VT.MaVatTu;

create view vw_CTPN_VT_NN as select
ctPN.SoPNhap as SoPhieuNhap,
	PN.NgayNhap,
    ctPN.MaVatTu,
    VT.TenVatTu,
    ctPN.SoLuongNhap,
    ctPN.DonGiaNhap,
    ctPN.SoLuongNhap * ctPN.DonGiaNhap as ThanhTien
from CTPhieuNhap ctPN join VatTu VT on ctPN.MaVatTu = VT.MaVatTu
					join PhieuNhap PN on ctPN.SoPNhap = PN.SoPNhap;  
                    
create view vw_CTPNHAP_VT_PN_DH as select
ctPN.SoPNhap as SoPhieuNhap,
	PN.NgayNhap,
    PN.MaDon,
    DD.MaNCC as MaNhaCungCap,
    ctPN.MaVatTu,
    VT.TenVatTu,
    ctPN.SoLuongNhap,
    ctPN.DonGiaNhap,
    ctPN.SoLuongNhap * ctPN.DonGiaNhap as ThanhTien
from CTPhieuNhap ctPN join VatTu VT on ctPN.MaVatTu = VT.MaVatTu
					join PhieuNhap PN on ctPN.SoPNhap = PN.SoPNhap
					join DonDatHang DD on PN.MaDon = DD.MaDon;
                    
                    
create view vw_CTPNHAP_loc as select
  SoPNhap as SoPhieuNhap,
  MaVatTu,
  SoLuongNhap,
  DonGiaNhap,
  SoLuongNhap * DonGiaNhap as ThanhTien
from CTPhieuNhap where SoLuongNhap >300;


create view vw_CTPNHAP_VT_loc as 
select
PN.SoPNhap as SoPhieuNhap,
    PN.MaVatTu,
    VT.TenVatTu,
    PN.SoLuongNhap,
    PN.DonGiaNhap,
    PN.SoLuongNhap * PN.DonGiaNhap as ThanhTien
from CTPhieuNhap PN join VatTu VT on PN.MaVatTu = VT.MaVatTu
where VT.DonViTinh = 'Bo';

create view vw_CTPNHAP_VT_loc1 as 
select
PN.SoPNhap as SoPhieuNhap,
    PN.MaVatTu,
    VT.TenVatTu,
    PN.SoLuongNhap,
    PN.DonGiaNhap,
    PN.SoLuongNhap * PN.DonGiaNhap as ThanhTien
from CTPhieuNhap PN join VatTu VT on PN.MaVatTu = VT.MaVatTu
where VT.DonViTinh = 'cai';
  
  
create view vw_CTPXUAT as select 
PhieuXuat_ID as SoPhhieuXuat,
MaVatTu,
SoLuongXuat,
DonGiaXuat,
SoLuongXuat * DonGiaXuat as ThanhTien
from CTPhieuXuat;

create view vw_CTPXUAT_VT as select
ctPX.PhieuXuat_ID as SoPhhieuXuat,
ctPX.MaVatTu,
VT.TenVatTu,
ctPX.SoLuongXuat,
ctPX.DonGiaXuat,
ctPX.SoLuongXuat * ctPX.DonGiaXuat as ThanhTien
from CTPhieuXuat ctPX join VatTu VT on ctPX.MaVatTu = VT.MaVatTu;


create view vw_CTPXUAT_VT_PX as select
ctPX.PhieuXuat_ID as SoPhhieuXuat,
PX.TenKh as TenKhachHang,
ctPX.MaVatTu,
VT.TenVatTu,
ctPX.SoLuongXuat,
ctPX.DonGiaXuat
from CTPhieuXuat ctPX join VatTu VT on ctPX.MaVatTu = VT.MaVatTu
					  join PhieuXuat PX on ctPX.PhieuXuat_ID = PX.ID;
                      
                      

DELIMITER //

CREATE PROCEDURE GetFinalQuantity (IN MaVatTu INT)
BEGIN
    DECLARE finalQuantity INT;

    SELECT (SoLuongDau + TongSoLuongNhap) - TongSoLuongXuat INTO finalQuantity
    FROM TonKho TK
    WHERE TK.MaVatTu = MaVatTu
    limit 1;

END //

DELIMITER ;
call GetFinalQuantity(102); 



