CREATE DATABASE IF NOT EXISTS DB_RestaurantManagement;
use DB_RestaurantManagement;
CREATE TABLE NguoiDung(
    ID_ND INT(8),
    Email VARCHAR(50),
    Matkhau VARCHAR(20),
    VerifyCode VARCHAR(10) DEFAULT NULL,
    Trangthai VARCHAR(10) DEFAULT '',
    Vaitro VARCHAR(20),
    CONSTRAINT ND_Email_NNULL CHECK (Email IS NOT NULL),
    CONSTRAINT ND_Matkhau_NNULL CHECK (Matkhau IS NOT NULL),
    CONSTRAINT ND_Vaitro_Ten CHECK (Vaitro IN ('Khach Hang','Nhan Vien','Nhan Vien Kho','Quan Ly')),
    PRIMARY KEY (ID_ND)
);
select * from NguoiDung;
INSERT INTO NguoiDung (ID_ND,Email, Matkhau, Vaitro) VALUES (1,'123@gmail.com', '123', 'Khach Hang');
INSERT INTO NguoiDung (ID_ND,Email, Matkhau, Vaitro) VALUES (2,'nhanvien@gmail.com', '123', 'Nhan Vien');
INSERT INTO NguoiDung (ID_ND,Email, Matkhau, Vaitro) VALUES (3,'nhanvienkho@gmail.com', '123', 'Nhan Vien Kho');
INSERT INTO NguoiDung (ID_ND,Email, Matkhau, Vaitro) VALUES (4,'quanly@gmail.com', '123', 'Quan Ly');
INSERT INTO NguoiDung (ID_ND,Email, Matkhau, Vaitro) VALUES (5,'quanly1@gmail.com', '123', 'Quan Ly');
-- Create table NhanVien
CREATE TABLE NhanVien(
    ID_NV INT(8),
    TenNV VARCHAR(50),
    NgayVL DATE,
    SDT VARCHAR(50),
    Chucvu VARCHAR(50),
    ID_ND INT(8) DEFAULT NULL,
    ID_NQL INT(8),
    Tinhtrang VARCHAR(20),
    CONSTRAINT NV_TenNV_NNULL CHECK (TenNV IS NOT NULL),
    CONSTRAINT NV_SDT_NNULL CHECK (SDT IS NOT NULL),
    CONSTRAINT NV_NgayVL_NNULL CHECK (NgayVL IS NOT NULL),
    CONSTRAINT NV_Chucvu_Thuoc CHECK (Chucvu IN ('Phuc vu','Tiep tan','Thu ngan','Bep','Kho','Quan ly')),
    CONSTRAINT NV_Tinhtrang_Thuoc CHECK (Tinhtrang IN ('Dang lam viec','Da nghi viec')),
    PRIMARY KEY (ID_NV),
    CONSTRAINT NV_fk_idND FOREIGN KEY (ID_ND) REFERENCES NguoiDung(ID_ND),
    CONSTRAINT NV_fk_idNQL FOREIGN KEY (ID_NQL) REFERENCES NhanVien(ID_NV)
);
select * from NhanVien;
INSERT INTO NhanVien (ID_NV, TenNV, NgayVL, SDT, Chucvu, ID_ND, Tinhtrang)
VALUES (1, 'Ho Tan Anh', '2023-04-28', '0123456789', 'Tiep tan', 2, 'Dang lam viec');


-- Create table KhachHang
select * from hoadon;
select * from CTHD;
select * from ban;
INSERT INTO KhachHang (ID_KH, TenKH, Ngaythamgia, ID_ND)
VALUES (1, 'Tên khách hàng', '2024-04-28', 1);

CREATE TABLE KhachHang(
    ID_KH INT(8),
    TenKH VARCHAR(50),
    Ngaythamgia DATE,
    Doanhso INT(10) DEFAULT 0,
    Diemtichluy INT(5) DEFAULT 0,
    ID_ND INT(8),
    CONSTRAINT KH_TenKH_NNULL CHECK (TenKH IS NOT NULL),
    CONSTRAINT KH_Ngaythamgia_NNULL CHECK (Ngaythamgia IS NOT NULL),
    CONSTRAINT KH_Doanhso_NNULL CHECK (Doanhso IS NOT NULL),
    CONSTRAINT KH_Diemtichluy_NNULL CHECK (Diemtichluy IS NOT NULL),
    CONSTRAINT KH_IDND_NNULL CHECK (ID_ND IS NOT NULL),
    PRIMARY KEY (ID_KH),
    CONSTRAINT KH_fk_idND FOREIGN KEY (ID_ND) REFERENCES NguoiDung(ID_ND)
);


-- Create table MonAn
CREATE TABLE MonAn(
    ID_MonAn INT(8),
    TenMon VARCHAR(50),
    DonGia INT(8),
    Loai VARCHAR(50),
    TrangThai VARCHAR(30),
    CONSTRAINT MA_TenMon_NNULL CHECK (TenMon IS NOT NULL),
    CONSTRAINT MA_DonGia_NNULL CHECK (DonGia IS NOT NULL),
    CONSTRAINT MA_Loai_Ten CHECK (Loai IN ('Sashimi','Salad','Món hấp và súp','Sushi','Món khai vị','Cơm cuộn')),
    CONSTRAINT MA_TrangThai_Thuoc CHECK (TrangThai IN ('Dang kinh doanh','Ngung kinh doanh')),
    PRIMARY KEY (ID_MonAn)
);

ALTER TABLE MonAn 
ADD CONSTRAINT MA_Loai_Ten
CHECK (Loai IN ('Sashimi','Salad','MonHapSup','Sushi','KhaiVi','ComCuon'));

ALTER TABLE MonAn 
DROP CONSTRAINT MA_Loai_Ten;
select * from nguoidung;

SET SQL_SAFE_UPDATES = 0;
UPDATE MonAn SET Loai = 'MonHapSup' WHERE Loai = 'Món hấp và súp';
UPDATE MonAn SET Loai = 'KhaiVi' WHERE Loai = 'Món khai vị';
UPDATE MonAn SET Loai = 'ComCuon' WHERE Loai = 'Cơm cuộn';
-- Create table Ban
CREATE TABLE Ban(
    ID_Ban INT(8),
    TenBan VARCHAR(50),
    Vitri VARCHAR(50),
    Trangthai VARCHAR(50),
    CONSTRAINT Ban_TenBan_NNULL CHECK (TenBan IS NOT NULL),
    CONSTRAINT Ban_Vitri_NNULL CHECK (Vitri IS NOT NULL),
    CONSTRAINT Ban_Trangthai_Ten CHECK (Trangthai IN ('Con trong','Dang dung bua','Da dat truoc')),
    PRIMARY KEY (ID_Ban)
);
select * from monan;
select * from hoadon WHERE ID_Ban=3 AND Trangthai='Chua thanh toan';
-- Thêm bàn cho tầng 1
INSERT INTO Ban (ID_Ban, TenBan, Vitri, Trangthai) VALUES (1, 'Ban 1A', 'Tầng 1', 'Con trong');
INSERT INTO Ban (ID_Ban, TenBan, Vitri, Trangthai) VALUES (2, 'Ban 2A', 'Tầng 1', 'Con trong');
INSERT INTO Ban (ID_Ban, TenBan, Vitri, Trangthai) VALUES (3, 'Ban 3A', 'Tầng 1', 'Con trong');

-- Thêm bàn cho tầng 2
INSERT INTO Ban (ID_Ban, TenBan, Vitri, Trangthai) VALUES (4, 'Ban 1B', 'Tầng 2', 'Con trong');
INSERT INTO Ban (ID_Ban, TenBan, Vitri, Trangthai) VALUES (5, 'Ban 2B', 'Tầng 2', 'Con trong');
INSERT INTO Ban (ID_Ban, TenBan, Vitri, Trangthai) VALUES (6, 'Ban 3B', 'Tầng 2', 'Con trong');

-- Thêm bàn cho tầng 3
INSERT INTO Ban (ID_Ban, TenBan, Vitri, Trangthai) VALUES (7, 'Ban 1C', 'Tầng 3', 'Con trong');
INSERT INTO Ban (ID_Ban, TenBan, Vitri, Trangthai) VALUES (8, 'Ban 2C', 'Tầng 3', 'Con trong');
INSERT INTO Ban (ID_Ban, TenBan, Vitri, Trangthai) VALUES (9, 'Ban 3C', 'Tầng 3', 'Con trong');


-- Create table Voucher
CREATE TABLE Voucher(
    Code_Voucher VARCHAR(10),
    Mota VARCHAR(50),
    Phantram INT(3),
    LoaiMA VARCHAR(50),
    SoLuong INT(3),
    Diem INT(8),
    CONSTRAINT V_Code_NNULL CHECK (Code_Voucher IS NOT NULL),
    CONSTRAINT V_Mota_NNULL CHECK (Mota IS NOT NULL),
    CONSTRAINT V_Phantram_NNULL CHECK (Phantram > 0 AND Phantram <= 100),
    CONSTRAINT V_LoaiMA_Thuoc CHECK (LoaiMA IN ('All','Aries','Taurus','Gemini','Cancer','Leo','Virgo','Libra','Scorpio','Sagittarius','Capricorn','Aquarius','Pisces')),
    PRIMARY KEY (Code_Voucher)
);

-- Create table HoaDon
CREATE TABLE HoaDon(
    ID_HoaDon INT(8),
    ID_KH INT(8),
    ID_Ban INT(8),
    NgayHD DATE,
    TienMonAn INT(8),
    Code_Voucher VARCHAR(10),
    TienGiam INT(8),
    Tongtien INT(10),
    Trangthai VARCHAR(50),
    CONSTRAINT HD_NgayHD_NNULL CHECK (NgayHD IS NOT NULL),
    CONSTRAINT HD_TrangThai CHECK (Trangthai IN ('Chua thanh toan','Da thanh toan')),
    PRIMARY KEY (ID_HoaDon),
    CONSTRAINT HD_fk_idKH FOREIGN KEY (ID_KH) REFERENCES KhachHang(ID_KH),
    CONSTRAINT HD_fk_idBan FOREIGN KEY (ID_Ban) REFERENCES Ban(ID_Ban)
);

-- Create table CTHD
CREATE TABLE CTHD(
    ID_HoaDon INT(8),
    ID_MonAn INT(8),
    SoLuong INT(3),
    Thanhtien INT(10),
    CONSTRAINT CTHD_SoLuong_NNULL CHECK (SoLuong IS NOT NULL),
    PRIMARY KEY (ID_HoaDon, ID_MonAn),
    CONSTRAINT CTHD_fk_idHD FOREIGN KEY (ID_HoaDon) REFERENCES HoaDon(ID_HoaDon),
    CONSTRAINT CTHD_fk_idMonAn FOREIGN KEY (ID_MonAn) REFERENCES MonAn(ID_MonAn)
);

-- Create table NguyenLieu
CREATE TABLE NguyenLieu(
    ID_NL INT(8),
    TenNL VARCHAR(50),
    Dongia INT(8),
    Donvitinh VARCHAR(50),
    CONSTRAINT NL_TenNL_NNULL CHECK (TenNL IS NOT NULL),
    CONSTRAINT NL_Dongia_NNULL CHECK (Dongia IS NOT NULL),
    CONSTRAINT NL_DVT_Thuoc CHECK (Donvitinh IN ('g','kg','ml','l')),
    PRIMARY KEY (ID_NL)
);

-- Create table Kho
CREATE TABLE Kho(
    ID_NL INT(8),
    SLTon INT(3) DEFAULT 0,
    PRIMARY KEY (ID_NL),
    CONSTRAINT Kho_fk_idNL FOREIGN KEY (ID_NL) REFERENCES NguyenLieu(ID_NL)
);

-- Create table PhieuNK
CREATE TABLE PhieuNK(
    ID_NK INT(8),
    ID_NV INT(8),
    NgayNK DATE,
    Tongtien INT(10) DEFAULT 0,
    CONSTRAINT PNK_NgayNK_NNULL CHECK (NgayNK IS NOT NULL),
    PRIMARY KEY (ID_NK),
    CONSTRAINT PNK_fk_idNV FOREIGN KEY (ID_NV) REFERENCES NhanVien(ID_NV)
);

-- Create table CTNK
CREATE TABLE CTNK(
    ID_NK INT(8),
    ID_NL INT(8),
    SoLuong INT(3),
    Thanhtien INT(10),
    CONSTRAINT CTNK_SL_NNULL CHECK (SoLuong IS NOT NULL),
    PRIMARY KEY (ID_NK, ID_NL),
    CONSTRAINT CTNK_fk_idNK FOREIGN KEY (ID_NK) REFERENCES PhieuNK(ID_NK),
    CONSTRAINT CTNK_fk_idNL FOREIGN KEY (ID_NL) REFERENCES NguyenLieu(ID_NL)
);

-- Create table PhieuXK

CREATE TABLE PhieuXK(
    ID_XK INT(8),
    ID_NV INT(8),
    NgayXK DATE,
    PRIMARY KEY (ID_XK),
    CONSTRAINT PXK_NgayXK_NNULL CHECK (NgayXK IS NOT NULL),
    CONSTRAINT PXK_fk_idNV FOREIGN KEY (ID_NV) REFERENCES NhanVien(ID_NV)
);

-- Create table CTXK
CREATE TABLE CTXK(
    ID_XK INT(8),
    ID_NL INT(8),
    SoLuong INT(3),
    PRIMARY KEY (ID_XK, ID_NL),
    CONSTRAINT CTXK_SL_NNULL CHECK (SoLuong IS NOT NULL),
    CONSTRAINT CTNK_fk_idXK FOREIGN KEY (ID_XK) REFERENCES PhieuXK(ID_XK),
    CONSTRAINT CTXK_fk_idNL FOREIGN KEY (ID_NL) REFERENCES NguyenLieu(ID_NL)
);

;

--- Tao Trigger

-- trigger update doanh số và điêm tích lũy
DELIMITER //

CREATE TRIGGER Tg_KH_DoanhsovaDTL AFTER UPDATE ON HoaDon 
FOR EACH ROW 
BEGIN 
    IF NEW.Trangthai = 'Da thanh toan' THEN 
        UPDATE KhachHang 
        SET Doanhso = Doanhso + NEW.Tongtien, 
            Diemtichluy = Diemtichluy + ROUND(NEW.Tongtien * 0.00005) 
        WHERE ID_KH = NEW.ID_KH; 
    END IF; 
END;
//

DELIMITER ;

-- trigger update tiền trong hóa đơn khi áp dụng voucher
DELIMITER //

CREATE TRIGGER Tg_HD_DoiVoucher BEFORE UPDATE ON HoaDon
FOR EACH ROW
BEGIN
    DECLARE TongtienLoaiMonAnduocgiam DECIMAL(8,0);
    DECLARE v_Diemdoi INT;
    DECLARE v_Phantram DECIMAL(5,2);
    DECLARE v_LoaiMA VARCHAR(50);
    
    IF NEW.Code_Voucher IS NOT NULL THEN
        SELECT Diem, Phantram, LoaiMA INTO v_Diemdoi, v_Phantram, v_LoaiMA
        FROM Voucher
        WHERE Code_Voucher = NEW.Code_Voucher;
        
        CALL KH_TruDTL(NEW.ID_KH, v_Diemdoi);
        CALL Voucher_GiamSL(NEW.Code_Voucher);
        
        IF v_LoaiMA = 'All' THEN
            SET TongtienLoaiMonAnduocgiam = NEW.TienMonAn;
        ELSE
            SELECT SUM(Thanhtien) INTO TongtienLoaiMonAnduocgiam
            FROM CTHD
            JOIN MonAn ON MonAn.ID_MonAn = CTHD.ID_MonAn
            WHERE ID_HoaDon = NEW.ID_HoaDon AND LOAI = v_LoaiMA;
        END IF;
        
        SET NEW.Tiengiam = ROUND(TongtienLoaiMonAnduocgiam * v_Phantram / 100);
        SET NEW.Tongtien = NEW.Tienmonan - NEW.Tiengiam;
    ELSE
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Voucher khong ton tai';
    END IF;
END;
//

DELIMITER ;

-- PROCEDURE trừ đi số điểm tích lũy của khi khách hàng sử dụng voucher
DELIMITER //

CREATE PROCEDURE KH_TruDTL(IN p_ID INT, IN p_diemdoi INT)
BEGIN
    DECLARE v_count INT;
    
    SELECT COUNT(*) INTO v_count
    FROM KHACHHANG
    WHERE ID_KH = p_ID;
    
    IF v_count > 0 THEN
        UPDATE KHACHHANG SET Diemtichluy = Diemtichluy - p_diemdoi WHERE ID_KH = p_ID;
    ELSE
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Khach hang khong ton tai';
    END IF;
END //

DELIMITER ;

-- PROCEDURE trừ đi số lượng của voucher khi khách hàng sử dụng
DELIMITER //

CREATE PROCEDURE Voucher_GiamSL(IN p_code VARCHAR(255))
BEGIN
    DECLARE v_count INT;
    
    SELECT COUNT(*) INTO v_count
    FROM Voucher
    WHERE Code_Voucher = p_code;
    
    IF v_count > 0 THEN
        UPDATE Voucher SET SoLuong = SoLuong - 1 WHERE Code_Voucher = p_code;
    ELSE
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Voucher khong ton tai';
    END IF;
END //

DELIMITER ;

--Khach hang chi duoc co toi da mot hoa don co trang thai Chua thanh toan
CREATE OR REPLACE TRIGGER Tg_SLHD_CTT
BEFORE INSERT OR UPDATE OF ID_KH,TrangThai ON HoaDon
FOR EACH ROW
DECLARE 
    v_count NUMBER;
BEGIN
    SELECT COUNT(*)
    FROM HoaDon
    WHERE ID_KH=:new.ID_KH AND TrangThai='Chua thanh toan';
    
    IF v_count>1 THEN
     RAISE_APPLICATION_ERROR(-20000,'Moi khach hang chi duoc co toi da mot hoa don co trang thai
     chua thanh toan');
    END IF;
END;
/

    
--Trigger Tien giam o Hoa Don = tong thanh tien cua mon An duoc giam  x Phantram
CREATE OR REPLACE TRIGGER Tg_HD_TienGiam
AFTER INSERT OR UPDATE OR DELETE ON CTHD
FOR EACH ROW
DECLARE 
    v_code HoaDon.Code_Voucher%TYPE;
    v_loaiMA Voucher.LoaiMA%TYPE;
    MA_Loai MonAn.Loai%TYPE;
BEGIN
    v_code:=NULL;
--Tim Code Voucher, Loai mon an duoc Ap dung Voucher tu bang Voucher
    IF (INSERTING OR UPDATING) THEN
        SELECT HoaDon.Code_Voucher,Voucher.LoaiMA 
        INTO v_code,v_LoaiMA
        FROM HoaDon
        LEFT JOIN Voucher ON Voucher.Code_Voucher = HoaDon.Code_Voucher
        WHERE ID_HoaDon=:new.ID_HoaDon;
    --Tim loai mon an cua Mon an vua duoc them vao CTHD   
        SELECT Loai
        INTO MA_Loai
        FROM MonAn 
        WHERE ID_MonAn = :new.ID_MonAn;
    END IF;
    
    IF (DELETING) THEN
        SELECT HoaDon.Code_Voucher,Voucher.LoaiMA 
        INTO v_code,v_LoaiMA
        FROM HoaDon
        LEFT JOIN Voucher ON Voucher.Code_Voucher = HoaDon.Code_Voucher
        WHERE ID_HoaDon=:old.ID_HoaDon;
    --Tim loai mon an cua Mon an vua duoc xoa khoi CTHD   
        SELECT Loai
        INTO MA_Loai
        FROM MonAn 
        WHERE ID_MonAn = :old.ID_MonAn;
    END IF;
    
    IF(v_code IS NOT NULL) THEN
        IF(v_LoaiMA='All' OR v_LoaiMA=MA_Loai) THEN 
            IF INSERTING THEN    
                UPDATE HoaDon SET TienGiam = TienGiam + Tinhtiengiam(:new.ThanhTien,v_code) WHERE HoaDon.ID_HoaDon=:new.ID_HoaDon;
            END IF;
            
            IF UPDATING THEN    
                UPDATE HoaDon SET TienGiam = TienGiam + Tinhtiengiam(:new.ThanhTien,v_code) - Tinhtiengiam(:old.ThanhTien,v_code) WHERE HoaDon.ID_HoaDon=:new.ID_HoaDon;
            END IF;
            
            IF DELETING THEN    
                UPDATE HoaDon SET TienGiam = TienGiam - Tinhtiengiam(:old.ThanhTien,v_code) WHERE HoaDon.ID_HoaDon=:old.ID_HoaDon;
            END IF;
        END IF;
    END IF;
END;
/
        
        
        
--  Trigger Thanh tien o CTNK bang SoLuong x Dongia cua nguyen lieu do

CREATE OR REPLACE TRIGGER Tg_CTNK_Thanhtien
BEFORE INSERT OR UPDATE OF SoLuong ON CTNK
FOR EACH ROW
DECLARE 
    gia NguyenLieu.DonGia%TYPE;
BEGIN
    SELECT DonGia
    INTO gia
    FROM NguyenLieu
    WHERE NguyenLieu.ID_NL = :new.ID_NL;

    :new.ThanhTien := :new.SoLuong * gia;
    
END;
/
--  Trigger Thanh tien o CTNK bang SoLuong x Dongia cua nguyen lieu do

CREATE OR REPLACE TRIGGER Tg_CTNK_Thanhtien
BEFORE INSERT OR UPDATE OF SoLuong ON CTNK
FOR EACH ROW
DECLARE 
    gia NguyenLieu.DonGia%TYPE;
BEGIN
    SELECT DonGia
    INTO gia
    FROM NguyenLieu
    WHERE NguyenLieu.ID_NL = :new.ID_NL;
    
    :new.ThanhTien := :new.SoLuong * gia;
    
END;
/
--Trigger Tong tien o PhieuNK bang tong thanh tien cua CTNK
CREATE OR REPLACE TRIGGER Tg_PNK_Tongtien
AFTER INSERT OR UPDATE OR DELETE ON CTNK
FOR EACH ROW
BEGIN
    IF INSERTING THEN    
        UPDATE PhieuNK SET Tongtien = Tongtien + :new.ThanhTien WHERE PhieuNK.ID_NK = :new.ID_NK;
    END IF;
    
    IF UPDATING THEN    
        UPDATE PhieuNK SET Tongtien = Tongtien + :new.ThanhTien - :old.ThanhTien WHERE PhieuNK.ID_NK = :new.ID_NK;
    END IF;
    
    IF DELETING THEN    
        UPDATE PhieuNK SET Tongtien = Tongtien - :old.ThanhTien WHERE PhieuNK.ID_NK = :old.ID_NK;
    END IF;
END;
/
--Trigger khi them CTNK tang So luong ton cua nguyen lieu trong kho
CREATE OR REPLACE TRIGGER Tg_Kho_ThemSLTon
AFTER INSERT OR DELETE OR UPDATE OF SoLuong ON CTNK
FOR EACH ROW
BEGIN
    IF INSERTING THEN    
        UPDATE Kho SET SLTon = SLTon + :new.SoLuong WHERE Kho.ID_NL = :new.ID_NL;
    END IF;
    
    IF UPDATING THEN    
        UPDATE Kho SET SLTon = SLTon + :new.SoLuong - :old.SoLuong WHERE Kho.ID_NL = :new.ID_NL;
    END IF;
    
    IF DELETING THEN    
        UPDATE Kho SET SLTon = SLTon - :old.SoLuong WHERE Kho.ID_NL = :old.ID_NL;
    END IF;
END;
/
--Trigger khi them CTXK giam So luong ton cua nguyen lieu trong kho
CREATE OR REPLACE TRIGGER Tg_Kho_GiamSLTon
AFTER INSERT OR DELETE OR UPDATE OF SoLuong ON CTXK
FOR EACH ROW
BEGIN
    IF INSERTING THEN    
        UPDATE Kho SET SLTon = SLTon - :new.SoLuong WHERE Kho.ID_NL = :new.ID_NL;
    END IF;
    
    IF UPDATING THEN    
        UPDATE Kho SET SLTon = SLTon - :new.SoLuong + :old.SoLuong WHERE Kho.ID_NL = :new.ID_NL;
    END IF;
    
    IF DELETING THEN    
        UPDATE Kho SET SLTon = SLTon + :old.SoLuong WHERE Kho.ID_NL = :old.ID_NL;
    END IF;
END;
/
--Trigger khi them mot Nguyen Lieu moi, them NL do vao Kho
CREATE OR REPLACE TRIGGER Tg_Kho_ThemNL
AFTER INSERT ON NguyenLieu
FOR EACH ROW
BEGIN
    INSERT INTO Kho(ID_NL) VALUES(:new.ID_NL);
END;
/

--Procedure
--Procudure them mot khach hang moi voi cac thong tin tenKH , NgayTG va ID_ND
CREATE OR REPLACE PROCEDURE KH_ThemKH(tenKH KHACHHANG.TenKH%TYPE, NgayTG KHACHHANG.Ngaythamgia%TYPE,
ID_ND KHACHHANG.ID_ND%TYPE)
IS
    v_ID_KH KHACHHANG.ID_KH%TYPE;
IS 
BEGIN
    --Them ma KH tiep theo
    SELECT MIN(ID_KH)+1
    INTO v_ID_KH
    FROM KHACHHANG
    WHERE ID_KH + 1 NOT IN(SELECT ID_KH FROM KHACHHANG);
    
    INSERT INTO KhachHang(ID_KH,TenKH,Ngaythamgia,ID_ND) VALUES (v_ID_KH,tenKH,TO_DATE(NgayTG,'dd-MM-YYYY'),ID_ND);
    EXCEPTION WHEN NO_DATA_FOUND THEN
        RAISE_APPLICATION_ERROR('Thong tin khong hop le');
END;
/
--Procudure them mot nhan vien moi voi cac thong tin tenNV, NgayVL, SDT, Chucvu, ID_NQL, Tinhtrang
CREATE OR REPLACE PROCEDURE NV_ThemNV(tenNV NHANVIEN.TenNV%TYPE, NgayVL NHANVIEN.NgayVL%TYPE, SDT NHANVIEN.SDT%TYPE,
Chucvu NHANVIEN.Chucvu%TYPE,ID_NQL NHANVIEN.ID_NQL%TYPE, Tinhtrang NHANVIEN.Tinhtrang%TYPE)
IS
    v_ID_NV NHANVIEN.ID_NV%TYPE;
IS 
BEGIN
    --Them ma KH tiep theo
    SELECT MIN(ID_NV)+1
    INTO v_ID_NV
    FROM NHANVIEN
    WHERE ID_NV + 1 NOT IN(SELECT ID_NV FROM NHANVIEN);
    
    INSERT INTO NhanVien(ID_NV,TenNV,NgayVL,SDT,Chucvu,ID_NQL,Tinhtrang) 
    VALUES (v_ID_NV,tenNV,TO_DATE(NgayVL,'dd-MM-YYYY'),SDT,Chucvu,ID_NQL,Tinhtrang);
    EXCEPTION WHEN NO_DATA_FOUND THEN
        RAISE_APPLICATION_ERROR('Thong tin khong hop le');
END;
/
-- Procudure xoa mot NHANVIEN voi idNV
CREATE OR REPLACE PROCEDURE NV_XoaNV(idNV NHANVIEN.ID_NV%TYPE)
IS
    v_count NUMBER;
    idNQL NHANVIEN.ID_NQL%TYPE;
BEGIN 
    SELECT COUNT(ID_NV),ID_NQL
    INTO v_count,ID_NQL
    FROM NHANVIEN
    WHERE ID_NV=idNV;
    
    IF(v_count>0) THEN
        IF (id_NV = idNQL) THEN
            RAISE_APPLICATION_ERROR(-20000,'Khong the xoa QUAN LY');
        ELSE
            FOR cur IN (SELECT ID_NK FROM PHIEUNK
            WHERE ID_NV=idNV
            )
            LOOP
                DELETE FROM CTNK WHERE ID_NK=cur.ID_NK;
            END LOOP;
            
            FOR cur IN (SELECT ID_XK FROM PHIEUXK
            WHERE ID_NV=idNV
            )
            LOOP
                DELETE FROM CTXK WHERE ID_XK=cur.ID_XK;
            END LOOP;
            
            DELETE FROM PHIEUNK WHERE ID_NV=idNV;
            DELETE FROM PHIEUNK WHERE ID_NV=idNV;
            DELETE FROM NHANVIEN WHERE ID_NV=idNV;
        END IF;
    ELSE 
        RAISE_APPLICATION_ERROR(-20000,'Nhan vien khong ton tai');
    END IF;
END;
/
-- Procudure xoa mot KHACHHANG voi idKH
CREATE OR REPLACE PROCEDURE KH_XoaKH(idKH KHACHHANG.ID_KH%TYPE)
IS
    v_count NUMBER;
BEGIN 
    SELECT COUNT(*)
    INTO v_count
    FROM KHACHHANG
    WHERE ID_KH=idKH;
    
    IF(v_count>0) THEN
        FOR cur IN (SELECT ID_HoaDon FROM HOADON 
        WHERE ID_KH=idKH
        )
        LOOP
            DELETE FROM CTHD WHERE ID_HoaDon=cur.ID_HoaDon;
        END LOOP;
        DELETE FROM HOADON WHERE ID_KH=idKH;
        DELETE FROM KHACHHANG WHERE ID_KH=idKH;
    ELSE 
        RAISE_APPLICATION_ERROR(-20000,'Khach hang khong ton tai');
    END IF;
END;
/

-- Procedure xem thong tin KHACHHANG voi thong tin idKH
CREATE OR REPLACE PROCEDURE KH_XemTT(idKH KHACHHANG.ID_KH%TYPE)
IS
BEGIN 
    FOR cur IN (SELECT TenKH,Ngaythamgia,Doanhso,Diemtichluy,ID_ND
    FROM KHACHHANG WHERE ID_KH=idKH;
    )
    LOOP
        DBMS_OUTPUT.PUT_LINE('Ma khach hang: '||idKH);
        DBMS_OUTPUT.PUT_LINE('Ten khach hang: '||cur.TenKH);
        DBMS_OUTPUT.PUT_LINE('Ngay tham gia: '||TO_CHAR(cur.Ngaythamgia,'dd-MM-YYYY');
        DBMS_OUTPUT.PUT_LINE('Doanh so: '||cur.Doanhso);
        DBMS_OUTPUT.PUT_LINE('Diemtichluy: '||cur.Diemtichluy);
        DBMS_OUTPUT.PUT_LINE('Ma nguoi dung: '||cur.ID_ND);
        
        EXCEPTION WHEN NO_DATA_FOUND THEN
             RAISE_APPLICATION_ERROR(-20000,'Khach hang khong ton tai');
    END LOOP;
END;
/
-- Procedure xem thong tin NHANVIEN voi thong tin idNV
CREATE OR REPLACE PROCEDURE NV_XemTT(idNV NHANVIEN.ID_NV%TYPE)
IS
BEGIN 
    FOR cur IN (SELECT TenKH,NgayVL,SDT,Chucvu,ID_NQL   
    FROM NHANVIEN WHERE ID_NV=idNV;
    )
    LOOP
        DBMS_OUTPUT.PUT_LINE('Ma nhan vien: '||idNV);
        DBMS_OUTPUT.PUT_LINE('Ten nhan vien: '||cur.TenNV);
        DBMS_OUTPUT.PUT_LINE('Ngay vao lam: '||TO_CHAR(cur.NgayVL,'dd-MM-YYYY');
        DBMS_OUTPUT.PUT_LINE('Chuc vu: '||cur.Chucvu);
        DBMS_OUTPUT.PUT_LINE('Ma nguoi quan ly: '||cur.ID_NQL);
        
        EXCEPTION WHEN NO_DATA_FOUND THEN
             RAISE_APPLICATION_ERROR(-20000,'Nhan vien khong ton tai');
    END LOOP;
END;
/

-- Procedure liet ke danh sach hoa don tu ngay A den ngay B
CREATE OR REPLACE PROCEDURE DS_HoaDon_tuAdenB(fromA DATE, toB DATE)
IS
BEGIN 
    FOR cur IN (SELECT ID_HOADON,ID_KH,ID_BAN,NGAYHD,TIENMONAN,TIENGIAM,TONGTIEN,TRANGTHAI   
    FROM HOADON WHERE NGAYHD BETWEEN fromA AND (toB +1);
    )
    LOOP
        DBMS_OUTPUT.PUT_LINE('Ma hoa don: '||cur.ID_HOADON);
        DBMS_OUTPUT.PUT_LINE('Ma khach hang: '||cur.ID_KH);
        DBMS_OUTPUT.PUT_LINE('Ma ban: '||cur.ID_BAN);
        DBMS_OUTPUT.PUT_LINE('Ngay hoa don: '||TO_CHAR(cur.NgayHD,'dd-MM-YYYY');
        DBMS_OUTPUT.PUT_LINE('Tien mon an: '||cur.TIENMONAN);
        DBMS_OUTPUT.PUT_LINE('Tien giam: '||cur.TIENGIAM);
        DBMS_OUTPUT.PUT_LINE('Tong tien: '||cur.TONGTIEN);
        DBMS_OUTPUT.PUT_LINE('Trang thai: '||cur.TRANGTHAI);
        
        EXCEPTION WHEN NO_DATA_FOUND THEN
             RAISE_APPLICATION_ERROR(-20000,'Khong co hoa don nao');
    END LOOP;
END;
/
-- Procedure liet ke danh sach phieu nhap kho tu ngay A den ngay B
CREATE OR REPLACE PROCEDURE DS_PhieuNK_tuAdenB(fromA DATE, toB DATE)
IS
BEGIN 
    FOR cur IN (SELECT ID_NK,ID_NV,NGAYNK,TONGTIEN  
    FROM PHIEUNK WHERE NGAYNK BETWEEN fromA AND (toB +1);
    )
    LOOP
        DBMS_OUTPUT.PUT_LINE('Ma nhap kho: '||cur.ID_NK);
        DBMS_OUTPUT.PUT_LINE('Ma nhan vien: '||cur.ID_NV);
        DBMS_OUTPUT.PUT_LINE('Ngay nhap kho: '||TO_CHAR(cur.NGAYNK,'dd-MM-YYYY');
        DBMS_OUTPUT.PUT_LINE('Tong tien: '||cur.TONGTIEN);
        
        EXCEPTION WHEN NO_DATA_FOUND THEN
             RAISE_APPLICATION_ERROR(-20000,'Khong co hoa don nao');
    END LOOP;
END;
/

-- Procedure liet ke danh sach phieu xuat kho tu ngay A den ngay B
CREATE OR REPLACE PROCEDURE DS_PhieuXK_tuAdenB(fromA DATE, toB DATE)
IS
BEGIN 
    FOR cur IN (SELECT ID_XK,ID_NV,NGAYXK
    FROM PHIEUXK WHERE NGAYXK BETWEEN fromA AND (toB +1);
    )
    LOOP
        DBMS_OUTPUT.PUT_LINE('Ma xuat kho: '||cur.ID_XK);
        DBMS_OUTPUT.PUT_LINE('Ma nhan vien: '||cur.ID_NV);
        DBMS_OUTPUT.PUT_LINE('Ngay xuat kho: '||TO_CHAR(cur.NGAYXK,'dd-MM-YYYY');
        
        EXCEPTION WHEN NO_DATA_FOUND THEN
             RAISE_APPLICATION_ERROR(-20000,'Khong co hoa don nao');
    END LOOP;
END;
/
-- Procedure xem chi tiet hoa don cua 1 hoa don
CREATE OR REPLACE PROCEDURE HD_XemCTHD(idHD HOADON.ID_HOADON%TYPE)
IS
BEGIN 
    FOR cur IN (SELECT ID_MONAN,SOLUONG,THANHTIEN
    FROM CTHD WHERE ID_HOADON=idHD;
    )
    LOOP
        DBMS_OUTPUT.PUT_LINE('Ma mon an: '||cur.ID_MONAN);
        DBMS_OUTPUT.PUT_LINE('So luong: '||cur.SOLUONG);
        DBMS_OUTPUT.PUT_LINE('Thanh tien: '||cur.THANHTIEN);
        
        EXCEPTION WHEN NO_DATA_FOUND THEN
             RAISE_APPLICATION_ERROR(-20000,'Khong co chi tiet hoa don nao');
    END LOOP;
END;
/
-- Procedure giam So Luong cua Voucher di 1 khi KH doi Voucher
CREATE OR REPLACE PROCEDURE Voucher_GiamSL(code Voucher.Code_Voucher%TYPE)
IS
    v_count NUMBER;
BEGIN
    SELECT COUNT(*)
    INTO v_count
    FROM Voucher
    WHERE Code_Voucher=code;
    IF(v_count>0) THEN
        UPDATE Voucher SET SoLuong = SoLuong - 1 WHERE Code_Voucher=code;
    ELSE 
        RAISE_APPLICATION_ERROR(-20000,'Voucher khong ton tai');
    END IF;
END;
/

-- Procedure giam Diem tich luy cua KH khi doi Voucher
CREATE OR REPLACE PROCEDURE KH_TruDTL(ID KHACHHANG.ID_KH%TYPE,diemdoi NUMBER)
IS
    v_count NUMBER;
BEGIN 
    SELECT COUNT(*)
    INTO v_count
    FROM KHACHHANG
    WHERE ID_KH=ID;
    IF(v_count>0) THEN
        UPDATE KHACHHANG SET Diemtichluy = Diemtichluy - diemdoi WHERE ID_KH=ID;
    ELSE 
        RAISE_APPLICATION_ERROR(-20000,'Khach hang khong ton tai');
    END IF;
END;
/

--Fuction 
--Fuction Tinh doanh thu hoa don theo ngay
CREATE OR REPLACE FUNCTION DoanhThuHD_theoNgay (ngHD DATE)
RETURN NUMBER
IS 
    v_Doanhthu NUMBER;
BEGIN
    SELECT SUM(Tongtien)
    INTO v_Doanhthu
    FROM HOADON 
    WHERE NGAYHD=ngHD;
    
    v_Doanhthu := NVL(v_Doanhthu,0);
    RETURN v_Doanhthu;
END;
/
--Fuction Tinh chi phi nhap kho theo ngay
CREATE OR REPLACE FUNCTION ChiPhiNK_theoNgay (ngNK DATE)
RETURN NUMBER
IS 
    v_Chiphi NUMBER;
BEGIN
    SELECT SUM(Tongtien)
    INTO v_Chiphi
    FROM PHIEUNK 
    WHERE NGAYNK=ngNK;
    
    v_Chiphi := NVL(v_Chiphi,0);
    RETURN v_Chiphi;
END;
/
--Fuction Tinh doanh so trung binh cua x KHACHHANG co doanh so cao nhat
CREATE OR REPLACE FUNCTION DoanhsoTB_TOPxKH(x INT)
RETURN DECIMAL
IS 
   v_avg DECIMAL;
BEGIN
    SELECT AVG(Doanhso)
    INTO v_avg
    FROM (
        SELECT Doanhso 
        FROM KHACHHANG
        ORDER BY Doanhso DESC
        FETCH FIRST x ROWS ONLY
        );
    RETURN v_avg;
END;
/

--Fuction Tinh so luong KHACHANG moi trong thang chi dinh cua nam co it nhat mot hoa don co tri gia tren x vnd
CREATE OR REPLACE FUNCTION SL_KH_Moi(thang NUMBER, nam NUMBER, trigiaHD NUMBER)
RETURN NUMBER
IS 
   v_count NUMBER;
BEGIN
    SELECT COUNT(ID_KH)
    INTO v_count;
    FROM KHACHHANG
    WHERE EXTRACT(MONTH FROM Ngaythamgia)=thang AND EXTRACT(YEAR FROM Ngaythamgia) = nam
    AND EXISTS(SELECT *
               FROM HOADON 
               WHERE HOADON.ID_KH=KHACHHANG.ID_KH AND TONGTIEN>trigiaHD
               );
    RETURN v_count;          
END;
/
    
-- Fuction Tinh tien mon an duoc giam khi them mot CTHD moi
CREATE OR REPLACE FUNCTION CTHD_Tinhtiengiam(Tongtien Number,Code Voucher.Code_Voucher%TYPE)
RETURN NUMBER
IS 
    Tiengiam NUMBER;
    v_phantram NUMBER;
BEGIN
    SELECT Phantram
    INTO v_Phantram
    FROM Voucher
    WHERE Code_Voucher=Code;
    Tiengiam := ROUND(Tongtien*v_Phantram/100);
    RETURN Tiengiam;
END;
/
-- Them data
ALTER SESSION SET NLS_DATE_FORMAT = 'dd-MM-YYYY';
use DB_RestaurantManagement;
-- Them data cho Bang NguoiDung
-- Nhan vien
INSERT INTO NguoiDung(ID_ND,Email,MatKhau,Trangthai,Vaitro) VALUES (100,'NVHoangViet@gmail.com','123','Verified','Quan Ly');
INSERT INTO NguoiDung(ID_ND,Email,MatKhau,Trangthai,Vaitro) VALUES (101,'NVHoangPhuc@gmail.com','123','Verified','Nhan Vien');
INSERT INTO NguoiDung(ID_ND,Email,MatKhau,Trangthai,Vaitro) VALUES (102,'NVAnhHong@gmail.com','123','Verified','Nhan Vien Kho');
INSERT INTO NguoiDung(ID_ND,Email,MatKhau,Trangthai,Vaitro) VALUES (103,'NVQuangDinh@gmail.com','123','Verified','Nhan Vien');
-- Khach Hang
INSERT INTO NguoiDung(ID_ND,Email,MatKhau,Trangthai,Vaitro) VALUES (104,'KHThaoDuong@gmail.com','123','Verified','Khach Hang');
INSERT INTO NguoiDung(ID_ND,Email,MatKhau,Trangthai,Vaitro) VALUES (105,'KHTanHieu@gmail.com','123','Verified','Khach Hang');
INSERT INTO NguoiDung(ID_ND,Email,MatKhau,Trangthai,Vaitro) VALUES (106,'KHQuocThinh@gmail.com','123','Verified','Khach Hang');
INSERT INTO NguoiDung(ID_ND,Email,MatKhau,Trangthai,Vaitro) VALUES (107,'KHNhuMai@gmail.com','123','Verified','Khach Hang');
INSERT INTO NguoiDung(ID_ND,Email,MatKhau,Trangthai,Vaitro) VALUES (108,'KHBichHao@gmail.com','123','Verified','Khach Hang');
INSERT INTO NguoiDung(ID_ND,Email,MatKhau,Trangthai,Vaitro) VALUES (109,'KHMaiQuynh@gmail.com','123','Verified','Khach Hang');
INSERT INTO NguoiDung(ID_ND,Email,MatKhau,Trangthai,Vaitro) VALUES (110,'KHMinhQuang@gmail.com','123','Verified','Khach Hang');
INSERT INTO NguoiDung(ID_ND,Email,MatKhau,Trangthai,Vaitro) VALUES (111,'KHThanhHang@gmail.com','123','Verified','Khach Hang');
INSERT INTO NguoiDung(ID_ND,Email,MatKhau,Trangthai,Vaitro) VALUES (112,'KHThanhNhan@gmail.com','123','Verified','Khach Hang');
INSERT INTO NguoiDung(ID_ND,Email,MatKhau,Trangthai,Vaitro) VALUES (113,'KHPhucNguyen@gmail.com','123','Verified','Khach Hang');

-- Them data cho bang Nhan Vien
ALTER SESSION SET NLS_DATE_FORMAT = 'dd-MM-YYYY';
-- Co tai khoan
INSERT INTO NhanVien(ID_NV,TenNV,NgayVL,SDT,Chucvu,ID_ND,ID_NQL,Tinhtrang) VALUES (100,'Nguyen Hoang Viet','2023-05-10','0848044725','Quan ly',100,100,'Dang lam viec');
INSERT INTO NhanVien(ID_NV,TenNV,NgayVL,SDT,Chucvu,ID_ND,ID_NQL,Tinhtrang) VALUES (101,'Nguyen Hoang Phuc','2023-05-20','0838033334','Tiep tan',101,100,'Dang lam viec');
INSERT INTO NhanVien(ID_NV,TenNV,NgayVL,SDT,Chucvu,ID_ND,ID_NQL,Tinhtrang) VALUES (102,'Le Thi Anh Hong','2023-05-19','0838033234','Kho',102,100,'Dang lam viec');
INSERT INTO NhanVien(ID_NV,TenNV,NgayVL,SDT,Chucvu,ID_ND,ID_NQL,Tinhtrang) VALUES (103,'Ho Quang Dinh','2023-05-19','0838033234','Tiep tan',103,100,'Dang lam viec');
-- Khong co tai khoan
INSERT INTO NhanVien(ID_NV,TenNV,NgayVL,SDT,Chucvu,ID_NQL,Tinhtrang) VALUES (104,'Ha Thao Duong','2023-05-10','0838033232','Phuc vu',100,'Dang lam viec');
INSERT INTO NhanVien(ID_NV,TenNV,NgayVL,SDT,Chucvu,ID_NQL,Tinhtrang) VALUES (105,'Nguyen Quoc Thinh','2023-05-11','0838033734','Phuc vu',100,'Dang lam viec');
INSERT INTO NhanVien(ID_NV,TenNV,NgayVL,SDT,Chucvu,ID_NQL,Tinhtrang) VALUES (106,'Truong Tan Hieu','2023-05-12','0838033834','Phuc vu',100,'Dang lam viec');
INSERT INTO NhanVien(ID_NV,TenNV,NgayVL,SDT,Chucvu,ID_NQL,Tinhtrang) VALUES (107,'Nguyen Thai Bao','2023-05-10','0838093234','Phuc vu',100,'Dang lam viec');
INSERT INTO NhanVien(ID_NV,TenNV,NgayVL,SDT,Chucvu,ID_NQL,Tinhtrang) VALUES (108,'Tran Nhat Khang','2023-05-11','0838133234','Thu ngan',100,'Dang lam viec');
INSERT INTO NhanVien(ID_NV,TenNV,NgayVL,SDT,Chucvu,ID_NQL,Tinhtrang) VALUES (109,'Nguyen Ngoc Luong','2023-05-12','0834033234','Bep',100,'Dang lam viec');

select*from KhachHang;
-- Them data cho bang KhachHang
INSERT INTO KhachHang(ID_KH,TenKH,Ngaythamgia,ID_ND) VALUES (100,'Ha Thao Duong','2023-05-10',104);
INSERT INTO KhachHang(ID_KH,TenKH,Ngaythamgia,ID_ND) VALUES (101,'Truong Tan Hieu','2023-05-10',105);
INSERT INTO KhachHang(ID_KH,TenKH,Ngaythamgia,ID_ND) VALUES (102,'Nguyen Quoc Thinh','2023-05-10',106);
INSERT INTO KhachHang(ID_KH,TenKH,Ngaythamgia,ID_ND) VALUES (103,'Tran Nhu Mai','2023-05-10',107);
INSERT INTO KhachHang(ID_KH,TenKH,Ngaythamgia,ID_ND) VALUES (104,'Nguyen Thi Bich Hao','2023-05-10',108);
INSERT INTO KhachHang(ID_KH,TenKH,Ngaythamgia,ID_ND) VALUES (105,'Nguyen Mai Quynh','2023-05-11',109);
INSERT INTO KhachHang(ID_KH,TenKH,Ngaythamgia,ID_ND) VALUES (106,'Hoang Minh Quang','2023-05-11',110);
INSERT INTO KhachHang(ID_KH,TenKH,Ngaythamgia,ID_ND) VALUES (107,'Nguyen Thanh Hang','2023-05-12',111);
INSERT INTO KhachHang(ID_KH,TenKH,Ngaythamgia,ID_ND) VALUES (108,'Nguyen Ngoc Thanh Nhan','2023-05-11',112);
INSERT INTO KhachHang(ID_KH,TenKH,Ngaythamgia,ID_ND) VALUES (109,'Hoang Thi Phuc Nguyen','2023-05-12',113);

-- Them data cho bang MonAn
-- Sashimi
insert into MonAn(ID_MonAn,TenMon,Dongia,Loai,TrangThai) values(1,'CUA HOANG DE', 2300000,'Sashimi','Dang kinh doanh');
insert into MonAn(ID_MonAn,TenMon,Dongia,Loai,TrangThai) values(2,'SASHIMI BUNG CA HOI', 500000,'Sashimi','Dang kinh doanh');
insert into MonAn(ID_MonAn,TenMon,Dongia,Loai,TrangThai) values(3,'SASHIMI CA NGU VAY XANH PHAN LUNG', 590000,'Sashimi','Dang kinh doanh');
insert into MonAn(ID_MonAn,TenMon,Dongia,Loai,TrangThai) values(4,'SASHIMI CA HOI', 400000,'Sashimi','Dang kinh doanh');
insert into MonAn(ID_MonAn,TenMon,Dongia,Loai,TrangThai) values(5,'SASHIMI OC VOI VOI', 890000,'Sashimi','Dang kinh doanh');
insert into MonAn(ID_MonAn,TenMon,Dongia,Loai,TrangThai) values(6,'SASHIMI CA BON', 149000,'Sashimi','Dang kinh doanh');
insert into MonAn(ID_MonAn,TenMon,Dongia,Loai,TrangThai) values(7,'SASHIMI BACH TUOT', 950000,'Sashimi','Dang kinh doanh');
insert into MonAn(ID_MonAn,TenMon,Dongia,Loai,TrangThai) values(8,'SASHIMI GOSOKU 5 MON', 479000,'Sashimi','Dang kinh doanh');
insert into MonAn(ID_MonAn,TenMon,Dongia,Loai,TrangThai) values(9,'SASHIMI TRUNG CA CHUON', 750000,'Sashimi','Dang kinh doanh');
insert into MonAn(ID_MonAn,TenMon,Dongia,Loai,TrangThai) values(10,'SASHIMI CA NGU VAY XANH PHAN BUNG', 450000,'Sashimi','Dang kinh doanh');
insert into MonAn(ID_MonAn,TenMon,Dongia,Loai,TrangThai) values(11,'SASHIMI TOM HUM', 800000,'Sashimi','Dang kinh doanh');
insert into MonAn(ID_MonAn,TenMon,Dongia,Loai,TrangThai) values(12,'HAU SUA MIYAGI NHAT', 350000,'Sashimi','Dang kinh doanh');
insert into MonAn(ID_MonAn,TenMon,Dongia,Loai,TrangThai) values(13,'SASHIMI SO DO', 145000,'Sashimi','Dang kinh doanh');
insert into MonAn(ID_MonAn,TenMon,Dongia,Loai,TrangThai) values(14,'SASHIMI SO DIEP NHAT', 150000,'Sashimi','Dang kinh doanh');
insert into MonAn(ID_MonAn,TenMon,Dongia,Loai,TrangThai) values(15,'SASHIMI TINH HOAN CA TUYET', 1690000,'Sashimi','Dang kinh doanh');
insert into MonAn(ID_MonAn,TenMon,Dongia,Loai,TrangThai) values(16,'SASHIMI CA MU NGUYEN CON', 329000,'Sashimi','Dang kinh doanh');
insert into MonAn(ID_MonAn,TenMon,Dongia,Loai,TrangThai) values(17,'SASHIMI TRUNG CA HOI', 720000,'Sashimi','Dang kinh doanh');
insert into MonAn(ID_MonAn,TenMon,Dongia,Loai,TrangThai) values(18,'TOM HUM ALASKA', 1350000,'Sashimi','Dang kinh doanh');
insert into MonAn(ID_MonAn,TenMon,Dongia,Loai,TrangThai) values(19,'SASHIMI CA CAM', 189000,'Sashimi','Dang kinh doanh');
insert into MonAn(ID_MonAn,TenMon,Dongia,Loai,TrangThai) values(20,'SASHIMI THUONG HANG TOHOKU', 369000,'Sashimi','Dang kinh doanh');
insert into MonAn(ID_MonAn,TenMon,Dongia,Loai,TrangThai) values(21,'SASHIMI HANA', 300000,'Sashimi','Dang kinh doanh');
insert into MonAn(ID_MonAn,TenMon,Dongia,Loai,TrangThai) values(22,'SASHIMI CA NGU VAY XANH PHAN BUNG IT BEO', 590000,'Sashimi','Dang kinh doanh');
insert into MonAn(ID_MonAn,TenMon,Dongia,Loai,TrangThai) values(23,'SASHIMI CA TRICH EP TRUNG', 450000,'Sashimi','Dang kinh doanh');
insert into MonAn(ID_MonAn,TenMon,Dongia,Loai,TrangThai) values(24,'SASHIMI BAO NGU', 450000,'Sashimi','Dang kinh doanh');

-- Salad
insert into MonAn(ID_MonAn,TenMon,Dongia,Loai,TrangThai) values(25,'SALAD 7 MON', 60000,'Salad','Dang kinh doanh');
insert into MonAn(ID_MonAn,TenMon,Dongia,Loai,TrangThai) values(26,'SALAD HAI SAN RONG NHO',1320000,'Salad','Dang kinh doanh');
insert into MonAn(ID_MonAn,TenMon,Dongia,Loai,TrangThai) values(27,'SALAD RONG BIEN VA BO', 179000,'Salad','Dang kinh doanh');
insert into MonAn(ID_MonAn,TenMon,Dongia,Loai,TrangThai) values(28,'SALAD RONG NHO VA SOT CA CHUA', 169000,'Salad','Dang kinh doanh');
insert into MonAn(ID_MonAn,TenMon,Dongia,Loai,TrangThai) values(29,'SALAD RONG BIEN TUOI VA TRUNG CUA', 1180000,'Salad','Dang kinh doanh');
insert into MonAn(ID_MonAn,TenMon,Dongia,Loai,TrangThai) values(30,'SALAD THIT CUA BO', 1290000,'Salad','Dang kinh doanh');
insert into MonAn(ID_MonAn,TenMon,Dongia,Loai,TrangThai) values(31,'SALAD CA HOI BO VA LONG DO TRUNG GA', 550000,'Salad','Dang kinh doanh');
insert into MonAn(ID_MonAn,TenMon,Dongia,Loai,TrangThai) values(32,'SALAD CA TUOI', 239000,'Salad','Dang kinh doanh');
insert into MonAn(ID_MonAn,TenMon,Dongia,Loai,TrangThai) values(33,'SALAD HAI SAN TRAI CAY', 180000,'Salad','Dang kinh doanh');

-- Món hấp và súp
insert into MonAn(ID_MonAn,TenMon,Dongia,Loai,TrangThai) values(34,'SUP BAO NGU', 490000,'Món hấp và súp','Dang kinh doanh');
insert into MonAn(ID_MonAn,TenMon,Dongia,Loai,TrangThai) values(35,'TRUNG HAP PHU SOT CUA', 190000,'Món hấp và súp','Dang kinh doanh');
insert into MonAn(ID_MonAn,TenMon,Dongia,Loai,TrangThai) values(36,'SUP THANH YEN', 700000,'Món hấp và súp','Dang kinh doanh');
insert into MonAn(ID_MonAn,TenMon,Dongia,Loai,TrangThai) values(37,'SUP AM TRA KIEU NHAT', 480000,'Món hấp và súp','Dang kinh doanh');
insert into MonAn(ID_MonAn,TenMon,Dongia,Loai,TrangThai) values(38,'SUP MISO KIEU NHAT', 590000,'Món hấp và súp','Dang kinh doanh');
insert into MonAn(ID_MonAn,TenMon,Dongia,Loai,TrangThai) values(39,'TRUNG HAP PHU LUON', 250000,'Món hấp và súp','Dang kinh doanh');
insert into MonAn(ID_MonAn,TenMon,Dongia,Loai,TrangThai) values(40,'SUP NGAO HAI COI', 250000,'Món hấp và súp','Dang kinh doanh');
insert into MonAn(ID_MonAn,TenMon,Dongia,Loai,TrangThai) values(41,'SUP GA HAM DONG TRUNG HA THAO', 620000,'Món hấp và súp','Dang kinh doanh');
insert into MonAn(ID_MonAn,TenMon,Dongia,Loai,TrangThai) values(42,'TRUNG HAP', 600000,'Món hấp và súp','Dang kinh doanh');
insert into MonAn(ID_MonAn,TenMon,Dongia,Loai,TrangThai) values(43,'TRUNG HAP THIT CUA PHU TRUNG CA CHUON', 500000,'Món hấp và súp','Dang kinh doanh');

UPDATE MonAn
SET Loai = 'MonHapSup'
WHERE ID_MonAn in (34,35,36,37,38,39,40,41,42,43) AND Loai = 'Món hấp và súp';

-- Sushi
insert into MonAn(ID_MonAn,TenMon,Dongia,Loai,TrangThai) values(44,'SUSHI CA HOI TRON SOT MAYO ', 620000,'Sushi','Dang kinh doanh');
insert into MonAn(ID_MonAn,TenMon,Dongia,Loai,TrangThai) values(45,'SUSHI CA CAM NUONG TAI', 365000,'Sushi','Dang kinh doanh');
insert into MonAn(ID_MonAn,TenMon,Dongia,Loai,TrangThai) values(46,'SUSHI THIT BO WAGYU NHAT', 265000,'Sushi','Dang kinh doanh');
insert into MonAn(ID_MonAn,TenMon,Dongia,Loai,TrangThai) values(47,'SUSHI DAU PHU NGOT', 230000,'Sushi','Dang kinh doanh');
insert into MonAn(ID_MonAn,TenMon,Dongia,Loai,TrangThai) values(48,'SET SUSHI MATSU', 255000,'Sushi','Dang kinh doanh');
insert into MonAn(ID_MonAn,TenMon,Dongia,Loai,TrangThai) values(49,'SUSHI TOM SOT TRUNG CA TUYET', 265000,'Sushi','Dang kinh doanh');
insert into MonAn(ID_MonAn,TenMon,Dongia,Loai,TrangThai) values(50,'SUSHI THANH CUA', 185000,'Sushi','Dang kinh doanh');
insert into MonAn(ID_MonAn,TenMon,Dongia,Loai,TrangThai) values(51,'SUSHI CA MU', 185000,'Sushi','Dang kinh doanh');
insert into MonAn(ID_MonAn,TenMon,Dongia,Loai,TrangThai) values(52,'SUSHI CA HOI PHAN BUNG', 185000,'Sushi','Dang kinh doanh');
insert into MonAn(ID_MonAn,TenMon,Dongia,Loai,TrangThai) values(53,'SUSHI TRUNG CA HOI', 165000,'Sushi','Dang kinh doanh');
insert into MonAn(ID_MonAn,TenMon,Dongia,Loai,TrangThai) values(54,'SUSHI SO DO NHAT', 205000,'Sushi','Dang kinh doanh');
insert into MonAn(ID_MonAn,TenMon,Dongia,Loai,TrangThai) values(55,'SUSHI RONG BIEN', 185000,'Sushi','Dang kinh doanh');
insert into MonAn(ID_MonAn,TenMon,Dongia,Loai,TrangThai) values(56,'SUSHI TOM', 285000,'Sushi','Dang kinh doanh');
insert into MonAn(ID_MonAn,TenMon,Dongia,Loai,TrangThai) values(57,'SUSHI BO', 385000,'Sushi','Dang kinh doanh');
insert into MonAn(ID_MonAn,TenMon,Dongia,Loai,TrangThai) values(58,'SUSHI THIT BO NUONG TAI', 105000,'Sushi','Dang kinh doanh');
insert into MonAn(ID_MonAn,TenMon,Dongia,Loai,TrangThai) values(59,'SUSHI LUON NHAT', 172000,'Sushi','Dang kinh doanh');

-- Món khai vị
insert into MonAn(ID_MonAn,TenMon,Dongia,Loai,TrangThai) values(60,'BACH TUOT SOT WASABI', 650000,'KhaiVi','Dang kinh doanh');
insert into MonAn(ID_MonAn,TenMon,Dongia,Loai,TrangThai) values(61,'BACH QUA NUONG', 350000,'KhaiVi','Dang kinh doanh');
insert into MonAn(ID_MonAn,TenMon,Dongia,Loai,TrangThai) values(62,'DAU NANH NHAT BAN', 250000,'KhaiVi','Dang kinh doanh');
insert into MonAn(ID_MonAn,TenMon,Dongia,Loai,TrangThai) values(63,'KHAI VI 5 MON', 650000,'KhaiVi','Dang kinh doanh');
insert into MonAn(ID_MonAn,TenMon,Dongia,Loai,TrangThai) values(64,'DAU PHU CHIEN KIEU NHAT', 350000,'KhaiVi','Dang kinh doanh');
insert into MonAn(ID_MonAn,TenMon,Dongia,Loai,TrangThai) values(65,'VI CA BIEN NUONG', 750000,'KhaiVi','Dang kinh doanh');
insert into MonAn(ID_MonAn,TenMon,Dongia,Loai,TrangThai) values(66,'GOI RONG BIEN', 150000,'KhaiVi','Dang kinh doanh');


-- Cơm cuộn
insert into MonAn(ID_MonAn,TenMon,Dongia,Loai,TrangThai) values(67,'COM CUON BO PHU BO MY', 150000,'ComCuon','Dang kinh doanh');
insert into MonAn(ID_MonAn,TenMon,Dongia,Loai,TrangThai) values(68,'COM CUON CA HOI VA MUC CHIEN', 120000,'ComCuon','Dang kinh doanh');
insert into MonAn(ID_MonAn,TenMon,Dongia,Loai,TrangThai) values(69,'COM CUON CA HOI VA THANH LONG', 250000,'ComCuon','Dang kinh doanh');
insert into MonAn(ID_MonAn,TenMon,Dongia,Loai,TrangThai) values(70,'COM CUON TOM CHIEN PHU LUON NHAT VA BO', 15000,'ComCuon','Dang kinh doanh');
insert into MonAn(ID_MonAn,TenMon,Dongia,Loai,TrangThai) values(71,'COM CUON TOM PHO MAI DAC BIET', 450000,'ComCuon','Dang kinh doanh');
insert into MonAn(ID_MonAn,TenMon,Dongia,Loai,TrangThai) values(72,'COM CUON DA CA PHU CA HOI NUONG VA SOT CAY', 550000,'ComCuon','Dang kinh doanh');
insert into MonAn(ID_MonAn,TenMon,Dongia,Loai,TrangThai) values(73,'COM CUON HAI SAN CHIEN', 300000,'ComCuon','Dang kinh doanh');
insert into MonAn(ID_MonAn,TenMon,Dongia,Loai,TrangThai) values(74,'COM CUON HOA ANH DAO', 220000,'ComCuon','Dang kinh doanh');
insert into MonAn(ID_MonAn,TenMon,Dongia,Loai,TrangThai) values(75,'COM CUON TRUNG CHIEN', 185000,'ComCuon','Dang kinh doanh');
insert into MonAn(ID_MonAn,TenMon,Dongia,Loai,TrangThai) values(76,'COM CUON DUA CHUOT', 165000,'ComCuon','Dang kinh doanh');
insert into MonAn(ID_MonAn,TenMon,Dongia,Loai,TrangThai) values(77,'COM CUON LUON VA PHO MAI', 470000,'ComCuon','Dang kinh doanh');
insert into MonAn(ID_MonAn,TenMon,Dongia,Loai,TrangThai) values(78,'COM CUON PHU XOAI', 250000,'ComCuon','Dang kinh doanh');
insert into MonAn(ID_MonAn,TenMon,Dongia,Loai,TrangThai) values(79,'COM CUON THANH CUA', 420000,'ComCuon','Dang kinh doanh');
insert into MonAn(ID_MonAn,TenMon,Dongia,Loai,TrangThai) values(80,'COM CUON LUON EP CUA', 380000,'ComCuon','Dang kinh doanh');
insert into MonAn(ID_MonAn,TenMon,Dongia,Loai,TrangThai) values(81,'COM EP KHUON CA HOI VA BO', 250000,'ComCuon','Dang kinh doanh');



-- Them data cho bang Ban
-- Tang 1
insert into Ban(ID_Ban,TenBan,Vitri,Trangthai) values(100,'Ban T1.1','Tang 1','Con trong');
insert into Ban(ID_Ban,TenBan,Vitri,Trangthai) values(101,'Ban T1.2','Tang 1','Con trong');
insert into Ban(ID_Ban,TenBan,Vitri,Trangthai) values(102,'Ban T1.3','Tang 1','Con trong');
insert into Ban(ID_Ban,TenBan,Vitri,Trangthai) values(103,'Ban T1.4','Tang 1','Con trong');
insert into Ban(ID_Ban,TenBan,Vitri,Trangthai) values(104,'Ban T1.5','Tang 1','Con trong');
insert into Ban(ID_Ban,TenBan,Vitri,Trangthai) values(105,'Ban T1.6','Tang 1','Con trong');
insert into Ban(ID_Ban,TenBan,Vitri,Trangthai) values(106,'Ban T1.7','Tang 1','Con trong');
insert into Ban(ID_Ban,TenBan,Vitri,Trangthai) values(107,'Ban T1.8','Tang 1','Con trong');
insert into Ban(ID_Ban,TenBan,Vitri,Trangthai) values(108,'Ban T1.9','Tang 1','Con trong');
insert into Ban(ID_Ban,TenBan,Vitri,Trangthai) values(109,'Ban T1.10','Tang 1','Con trong');
insert into Ban(ID_Ban,TenBan,Vitri,Trangthai) values(110,'Ban T1.11','Tang 1','Con trong');
insert into Ban(ID_Ban,TenBan,Vitri,Trangthai) values(111,'Ban T1.12','Tang 1','Con trong');
-- Tang 2
insert into Ban(ID_Ban,TenBan,Vitri,Trangthai) values(112,'Ban T2.1','Tang 2','Con trong');
insert into Ban(ID_Ban,TenBan,Vitri,Trangthai) values(113,'Ban T2.2','Tang 2','Con trong');
insert into Ban(ID_Ban,TenBan,Vitri,Trangthai) values(114,'Ban T2.3','Tang 2','Con trong');
insert into Ban(ID_Ban,TenBan,Vitri,Trangthai) values(115,'Ban T2.4','Tang 2','Con trong');
insert into Ban(ID_Ban,TenBan,Vitri,Trangthai) values(116,'Ban T2.5','Tang 2','Con trong');
insert into Ban(ID_Ban,TenBan,Vitri,Trangthai) values(117,'Ban T2.6','Tang 2','Con trong');
insert into Ban(ID_Ban,TenBan,Vitri,Trangthai) values(118,'Ban T2.7','Tang 2','Con trong');
insert into Ban(ID_Ban,TenBan,Vitri,Trangthai) values(119,'Ban T2.8','Tang 2','Con trong');
insert into Ban(ID_Ban,TenBan,Vitri,Trangthai) values(120,'Ban T2.9','Tang 2','Con trong');
insert into Ban(ID_Ban,TenBan,Vitri,Trangthai) values(121,'Ban T2.10','Tang 2','Con trong');
insert into Ban(ID_Ban,TenBan,Vitri,Trangthai) values(122,'Ban T2.11','Tang 2','Con trong');
insert into Ban(ID_Ban,TenBan,Vitri,Trangthai) values(123,'Ban T2.12','Tang 2','Con trong');
-- Tang 3
insert into Ban(ID_Ban,TenBan,Vitri,Trangthai) values(124,'Ban T3.1','Tang 3','Con trong');
insert into Ban(ID_Ban,TenBan,Vitri,Trangthai) values(125,'Ban T3.1','Tang 3','Con trong');
insert into Ban(ID_Ban,TenBan,Vitri,Trangthai) values(126,'Ban T3.1','Tang 3','Con trong');
insert into Ban(ID_Ban,TenBan,Vitri,Trangthai) values(127,'Ban T3.1','Tang 3','Con trong');
insert into Ban(ID_Ban,TenBan,Vitri,Trangthai) values(128,'Ban T3.1','Tang 3','Con trong');
insert into Ban(ID_Ban,TenBan,Vitri,Trangthai) values(129,'Ban T3.1','Tang 3','Con trong');
insert into Ban(ID_Ban,TenBan,Vitri,Trangthai) values(130,'Ban T3.1','Tang 3','Con trong');
insert into Ban(ID_Ban,TenBan,Vitri,Trangthai) values(131,'Ban T3.1','Tang 3','Con trong');
insert into Ban(ID_Ban,TenBan,Vitri,Trangthai) values(132,'Ban T3.1','Tang 3','Con trong');
insert into Ban(ID_Ban,TenBan,Vitri,Trangthai) values(133,'Ban T3.1','Tang 3','Con trong');
insert into Ban(ID_Ban,TenBan,Vitri,Trangthai) values(134,'Ban T3.1','Tang 3','Con trong');
insert into Ban(ID_Ban,TenBan,Vitri,Trangthai) values(135,'Ban T3.1','Tang 3','Con trong');

-- Them data cho bang Voucher
insert into Voucher(Code_Voucher, Phantram,LoaiMA,SoLuong,Diem) values ('loQy','20% off for Aries Menu',20,'Aries',10,200);
insert into Voucher(Code_Voucher, Phantram,LoaiMA,SoLuong,Diem) values ('pCfI','30% off for Taurus Menu',30,'Taurus',5,300);
insert into Voucher(Code_Voucher, Phantram,LoaiMA,SoLuong,Diem) values ('pApo','20% off for Gemini Menu',20,'Gemini',10,200);
insert into Voucher(Code_Voucher, Phantram,LoaiMA,SoLuong,Diem) values ('ugQx','100% off for Virgo Menu',100,'Virgo',3,500);
insert into Voucher(Code_Voucher, Phantram,LoaiMA,SoLuong,Diem) values ('nxVX','20% off for All Menu',20,'All',5,300);
insert into Voucher(Code_Voucher, Phantram,LoaiMA,SoLuong,Diem) values ('Pwyn','20% off for Cancer Menu',20,'Cancer',10,200);
insert into Voucher(Code_Voucher, Phantram,LoaiMA,SoLuong,Diem) values ('bjff','50% off for Leo Menu',50,'Leo',5,600);
insert into Voucher(Code_Voucher, Phantram,LoaiMA,SoLuong,Diem) values ('YPzJ','20% off for Aquarius Menu',20,'Aquarius',5,200);
insert into Voucher(Code_Voucher, Phantram,LoaiMA,SoLuong,Diem) values ('Y5g0','30% off for Pisces Menu',30,'Pisces',5,300);
insert into Voucher(Code_Voucher, Phantram,LoaiMA,SoLuong,Diem) values ('7hVO','60% off for Aries Menu',60,'Aries',0,1000);
insert into Voucher(Code_Voucher, Phantram,LoaiMA,SoLuong,Diem) values ('WHLm','20% off for Capricorn Menu',20,'Capricorn',0,200);
insert into Voucher(Code_Voucher, Phantram,LoaiMA,SoLuong,Diem) values ('GTsC','20% off for Leo Menu',20,'Leo',0,200);


-- Them data cho bang HoaDon
INSERT INTO HoaDon(ID_HoaDon,ID_KH,ID_Ban,NgayHD,TienMonAn,TienGiam,Trangthai) VALUES (101,100,100,'2023-01-10',0,0,'Chua thanh toan');
INSERT INTO HoaDon(ID_HoaDon,ID_KH,ID_Ban,NgayHD,TienMonAn,TienGiam,Trangthai) VALUES (102,104,102,'2023-01-15',0,0,'Chua thanh toan');
INSERT INTO HoaDon(ID_HoaDon,ID_KH,ID_Ban,NgayHD,TienMonAn,TienGiam,Trangthai) VALUES (103,105,103,'2023-01-20',0,0,'Chua thanh toan');
INSERT INTO HoaDon(ID_HoaDon,ID_KH,ID_Ban,NgayHD,TienMonAn,TienGiam,Trangthai) VALUES (104,101,101,'2023-02-13',0,0,'Chua thanh toan');
INSERT INTO HoaDon(ID_HoaDon,ID_KH,ID_Ban,NgayHD,TienMonAn,TienGiam,Trangthai) VALUES (105,103,120,'2023-02-12',0,0,'Chua thanh toan');
INSERT INTO HoaDon(ID_HoaDon,ID_KH,ID_Ban,NgayHD,TienMonAn,TienGiam,Trangthai) VALUES (106,104,100,'2023-03-16',0,0,'Chua thanh toan');
INSERT INTO HoaDon(ID_HoaDon,ID_KH,ID_Ban,NgayHD,TienMonAn,TienGiam,Trangthai) VALUES (107,107,103,'2023-03-20',0,0,'Chua thanh toan');
INSERT INTO HoaDon(ID_HoaDon,ID_KH,ID_Ban,NgayHD,TienMonAn,TienGiam,Trangthai) VALUES (108,108,101,'2023-04-10',0,0,'Chua thanh toan');
INSERT INTO HoaDon(ID_HoaDon,ID_KH,ID_Ban,NgayHD,TienMonAn,TienGiam,Trangthai) VALUES (109,100,100,'2023-04-20',0,0,'Chua thanh toan');
INSERT INTO HoaDon(ID_HoaDon,ID_KH,ID_Ban,NgayHD,TienMonAn,TienGiam,Trangthai) VALUES (110,103,101,'2023-05-05',0,0,'Chua thanh toan');
INSERT INTO HoaDon(ID_HoaDon,ID_KH,ID_Ban,NgayHD,TienMonAn,TienGiam,Trangthai) VALUES (111,106,102,'2023-05-10',0,0,'Chua thanh toan');
INSERT INTO HoaDon(ID_HoaDon,ID_KH,ID_Ban,NgayHD,TienMonAn,TienGiam,Trangthai) VALUES (112,108,103,'2023-05-15',0,0,'Chua thanh toan');
INSERT INTO HoaDon(ID_HoaDon,ID_KH,ID_Ban,NgayHD,TienMonAn,TienGiam,Trangthai) VALUES (113,106,102,'2023-05-20',0,0,'Chua thanh toan');
INSERT INTO HoaDon(ID_HoaDon,ID_KH,ID_Ban,NgayHD,TienMonAn,TienGiam,Trangthai) VALUES (114,108,103,'2023-06-05',0,0,'Chua thanh toan');
INSERT INTO HoaDon(ID_HoaDon,ID_KH,ID_Ban,NgayHD,TienMonAn,TienGiam,Trangthai) VALUES (115,109,104,'2023-06-07',0,0,'Chua thanh toan');
INSERT INTO HoaDon(ID_HoaDon,ID_KH,ID_Ban,NgayHD,TienMonAn,TienGiam,Trangthai) VALUES (116,100,105,'2023-06-07',0,0,'Chua thanh toan');
INSERT INTO HoaDon(ID_HoaDon,ID_KH,ID_Ban,NgayHD,TienMonAn,TienGiam,Trangthai) VALUES (117,106,106,'2023-06-10',0,0,'Chua thanh toan');
INSERT INTO HoaDon(ID_HoaDon,ID_KH,ID_Ban,NgayHD,TienMonAn,TienGiam,Trangthai) VALUES (118,102,106,'2023-02-10',0,0,'Chua thanh toan');
INSERT INTO HoaDon(ID_HoaDon,ID_KH,ID_Ban,NgayHD,TienMonAn,TienGiam,Trangthai) VALUES (119,103,106,'2023-02-12',0,0,'Chua thanh toan');
INSERT INTO HoaDon(ID_HoaDon,ID_KH,ID_Ban,NgayHD,TienMonAn,TienGiam,Trangthai) VALUES (120,104,106,'2023-04-10',0,0,'Chua thanh toan');
INSERT INTO HoaDon(ID_HoaDon,ID_KH,ID_Ban,NgayHD,TienMonAn,TienGiam,Trangthai) VALUES (121,105,106,'2023-04-12',0,0,'Chua thanh toan');
INSERT INTO HoaDon(ID_HoaDon,ID_KH,ID_Ban,NgayHD,TienMonAn,TienGiam,Trangthai) VALUES (122,107,106,'2023-05-12',0,0,'Chua thanh toan');


-- Them data cho CTHD
INSERT INTO CTHD(ID_HoaDon,ID_MonAn,SoLuong) VALUES (101,1,2);
INSERT INTO CTHD(ID_HoaDon,ID_MonAn,SoLuong) VALUES (101,3,1);
INSERT INTO CTHD(ID_HoaDon,ID_MonAn,SoLuong) VALUES (101,10,3);
INSERT INTO CTHD(ID_HoaDon,ID_MonAn,SoLuong) VALUES (102,1,2);
INSERT INTO CTHD(ID_HoaDon,ID_MonAn,SoLuong) VALUES (102,2,1);
INSERT INTO CTHD(ID_HoaDon,ID_MonAn,SoLuong) VALUES (102,4,2);
INSERT INTO CTHD(ID_HoaDon,ID_MonAn,SoLuong) VALUES (103,12,2);
INSERT INTO CTHD(ID_HoaDon,ID_MonAn,SoLuong) VALUES (104,30,3);
INSERT INTO CTHD(ID_HoaDon,ID_MonAn,SoLuong) VALUES (104,59,4);
INSERT INTO CTHD(ID_HoaDon,ID_MonAn,SoLuong) VALUES (105,28,1);
INSERT INTO CTHD(ID_HoaDon,ID_MonAn,SoLuong) VALUES (105,88,2);
INSERT INTO CTHD(ID_HoaDon,ID_MonAn,SoLuong) VALUES (106,70,3);
INSERT INTO CTHD(ID_HoaDon,ID_MonAn,SoLuong) VALUES (106,75,2);
INSERT INTO CTHD(ID_HoaDon,ID_MonAn,SoLuong) VALUES (106,78,4);
INSERT INTO CTHD(ID_HoaDon,ID_MonAn,SoLuong) VALUES (107,32,2);
INSERT INTO CTHD(ID_HoaDon,ID_MonAn,SoLuong) VALUES (107,12,5);
INSERT INTO CTHD(ID_HoaDon,ID_MonAn,SoLuong) VALUES (108,12,1);
INSERT INTO CTHD(ID_HoaDon,ID_MonAn,SoLuong) VALUES (108,40,4);
INSERT INTO CTHD(ID_HoaDon,ID_MonAn,SoLuong) VALUES (109,45,4);
INSERT INTO CTHD(ID_HoaDon,ID_MonAn,SoLuong) VALUES (110,34,2);
INSERT INTO CTHD(ID_HoaDon,ID_MonAn,SoLuong) VALUES (110,43,4);
INSERT INTO CTHD(ID_HoaDon,ID_MonAn,SoLuong) VALUES (111,65,2);
INSERT INTO CTHD(ID_HoaDon,ID_MonAn,SoLuong) VALUES (111,47,4);
INSERT INTO CTHD(ID_HoaDon,ID_MonAn,SoLuong) VALUES (112,49,3);
INSERT INTO CTHD(ID_HoaDon,ID_MonAn,SoLuong) VALUES (112,80,2);
INSERT INTO CTHD(ID_HoaDon,ID_MonAn,SoLuong) VALUES (112,31,5);
INSERT INTO CTHD(ID_HoaDon,ID_MonAn,SoLuong) VALUES (113,80,2);
INSERT INTO CTHD(ID_HoaDon,ID_MonAn,SoLuong) VALUES (113,80,2);
INSERT INTO CTHD(ID_HoaDon,ID_MonAn,SoLuong) VALUES (114,30,2);
INSERT INTO CTHD(ID_HoaDon,ID_MonAn,SoLuong) VALUES (114,32,3);
INSERT INTO CTHD(ID_HoaDon,ID_MonAn,SoLuong) VALUES (115,80,2);
INSERT INTO CTHD(ID_HoaDon,ID_MonAn,SoLuong) VALUES (116,57,2);
INSERT INTO CTHD(ID_HoaDon,ID_MonAn,SoLuong) VALUES (116,34,1);
INSERT INTO CTHD(ID_HoaDon,ID_MonAn,SoLuong) VALUES (117,67,2);
INSERT INTO CTHD(ID_HoaDon,ID_MonAn,SoLuong) VALUES (117,66,3);
INSERT INTO CTHD(ID_HoaDon,ID_MonAn,SoLuong) VALUES (118,34,10);
INSERT INTO CTHD(ID_HoaDon,ID_MonAn,SoLuong) VALUES (118,35,5);
INSERT INTO CTHD(ID_HoaDon,ID_MonAn,SoLuong) VALUES (119,83,2);
INSERT INTO CTHD(ID_HoaDon,ID_MonAn,SoLuong) VALUES (119,78,2);
INSERT INTO CTHD(ID_HoaDon,ID_MonAn,SoLuong) VALUES (120,38,5);
INSERT INTO CTHD(ID_HoaDon,ID_MonAn,SoLuong) VALUES (120,39,4);
INSERT INTO CTHD(ID_HoaDon,ID_MonAn,SoLuong) VALUES (121,53,5);
INSERT INTO CTHD(ID_HoaDon,ID_MonAn,SoLuong) VALUES (121,31,4);
INSERT INTO CTHD(ID_HoaDon,ID_MonAn,SoLuong) VALUES (122,33,5);
INSERT INTO CTHD(ID_HoaDon,ID_MonAn,SoLuong) VALUES (122,34,6);
UPDATE HOADON SET TrangThai='Da thanh toan';

--Them data cho bang NguyenLieu
INSERT INTO NguyenLieu(ID_NL,TenNL,Dongia,Donvitinh) VALUES(100,'Thit ga',40000,'kg');
INSERT INTO NguyenLieu(ID_NL,TenNL,Dongia,Donvitinh) VALUES(101,'Thit heo',50000,'kg');
INSERT INTO NguyenLieu(ID_NL,TenNL,Dongia,Donvitinh) VALUES(102,'Thit bo',80000,'kg');
INSERT INTO NguyenLieu(ID_NL,TenNL,Dongia,Donvitinh) VALUES(103,'Tom',100000,'kg');
INSERT INTO NguyenLieu(ID_NL,TenNL,Dongia,Donvitinh) VALUES(104,'Ca hoi',500000,'kg');
INSERT INTO NguyenLieu(ID_NL,TenNL,Dongia,Donvitinh) VALUES(105,'Gao',40000,'kg');
INSERT INTO NguyenLieu(ID_NL,TenNL,Dongia,Donvitinh) VALUES(106,'Sua tuoi',40000,'l');
INSERT INTO NguyenLieu(ID_NL,TenNL,Dongia,Donvitinh) VALUES(107,'Bot mi',20000,'kg');
INSERT INTO NguyenLieu(ID_NL,TenNL,Dongia,Donvitinh) VALUES(108,'Dau ca hoi',1000000,'l');
INSERT INTO NguyenLieu(ID_NL,TenNL,Dongia,Donvitinh) VALUES(109,'Dau dau nanh',150000,'l');
INSERT INTO NguyenLieu(ID_NL,TenNL,Dongia,Donvitinh) VALUES(110,'Muoi',20000,'kg');
INSERT INTO NguyenLieu(ID_NL,TenNL,Dongia,Donvitinh) VALUES(111,'Duong',20000,'kg');
INSERT INTO NguyenLieu(ID_NL,TenNL,Dongia,Donvitinh) VALUES(112,'Hanh tay',50000,'kg');
INSERT INTO NguyenLieu(ID_NL,TenNL,Dongia,Donvitinh) VALUES(113,'Toi',30000,'kg');
INSERT INTO NguyenLieu(ID_NL,TenNL,Dongia,Donvitinh) VALUES(114,'Dam',50000,'l');
INSERT INTO NguyenLieu(ID_NL,TenNL,Dongia,Donvitinh) VALUES(115,'Thit de',130000,'kg');

--Them data cho PhieuNK
INSERT INTO PhieuNK(ID_NK,ID_NV,NgayNK) VALUES (100,102,'2023-01-10');
INSERT INTO PhieuNK(ID_NK,ID_NV,NgayNK) VALUES (101,102,'2023-02-11');
INSERT INTO PhieuNK(ID_NK,ID_NV,NgayNK) VALUES (102,102,'2023-02-12');
INSERT INTO PhieuNK(ID_NK,ID_NV,NgayNK) VALUES (103,102,'2023-03-12');
INSERT INTO PhieuNK(ID_NK,ID_NV,NgayNK) VALUES (104,102,'2023-03-15');
INSERT INTO PhieuNK(ID_NK,ID_NV,NgayNK) VALUES (105,102,'2023-04-12');
INSERT INTO PhieuNK(ID_NK,ID_NV,NgayNK) VALUES (106,102,'2023-04-15');
INSERT INTO PhieuNK(ID_NK,ID_NV,NgayNK) VALUES (107,102,'2023-05-12');
INSERT INTO PhieuNK(ID_NK,ID_NV,NgayNK) VALUES (108,102,'2023-05-15');
INSERT INTO PhieuNK(ID_NK,ID_NV,NgayNK) VALUES (109,102,'2023-06-05');
INSERT INTO PhieuNK(ID_NK,ID_NV,NgayNK) VALUES (110,102,'2023-06-07');

--Them data cho CTNK
INSERT INTO CTNK(ID_NK,ID_NL,SoLuong) VALUES (100,100,10);
INSERT INTO CTNK(ID_NK,ID_NL,SoLuong) VALUES (100,101,20);
INSERT INTO CTNK(ID_NK,ID_NL,SoLuong) VALUES (100,102,15);
INSERT INTO CTNK(ID_NK,ID_NL,SoLuong) VALUES (101,101,10);
INSERT INTO CTNK(ID_NK,ID_NL,SoLuong) VALUES (101,103,20);
INSERT INTO CTNK(ID_NK,ID_NL,SoLuong) VALUES (101,104,10);
INSERT INTO CTNK(ID_NK,ID_NL,SoLuong) VALUES (101,105,10);
INSERT INTO CTNK(ID_NK,ID_NL,SoLuong) VALUES (101,106,20);
INSERT INTO CTNK(ID_NK,ID_NL,SoLuong) VALUES (101,107,5);
INSERT INTO CTNK(ID_NK,ID_NL,SoLuong) VALUES (101,108,5);
INSERT INTO CTNK(ID_NK,ID_NL,SoLuong) VALUES (102,109,10);
INSERT INTO CTNK(ID_NK,ID_NL,SoLuong) VALUES (102,110,20);
INSERT INTO CTNK(ID_NK,ID_NL,SoLuong) VALUES (102,112,15);
INSERT INTO CTNK(ID_NK,ID_NL,SoLuong) VALUES (102,113,15);
INSERT INTO CTNK(ID_NK,ID_NL,SoLuong) VALUES (102,114,15);
INSERT INTO CTNK(ID_NK,ID_NL,SoLuong) VALUES (103,112,15);
INSERT INTO CTNK(ID_NK,ID_NL,SoLuong) VALUES (103,113,15);
INSERT INTO CTNK(ID_NK,ID_NL,SoLuong) VALUES (103,114,15);
INSERT INTO CTNK(ID_NK,ID_NL,SoLuong) VALUES (104,112,15);
INSERT INTO CTNK(ID_NK,ID_NL,SoLuong) VALUES (104,113,15);
INSERT INTO CTNK(ID_NK,ID_NL,SoLuong) VALUES (105,110,15);
INSERT INTO CTNK(ID_NK,ID_NL,SoLuong) VALUES (106,102,25);
INSERT INTO CTNK(ID_NK,ID_NL,SoLuong) VALUES (106,115,25);
INSERT INTO CTNK(ID_NK,ID_NL,SoLuong) VALUES (107,110,35);
INSERT INTO CTNK(ID_NK,ID_NL,SoLuong) VALUES (107,105,25);
INSERT INTO CTNK(ID_NK,ID_NL,SoLuong) VALUES (108,104,25);
INSERT INTO CTNK(ID_NK,ID_NL,SoLuong) VALUES (108,103,15);
INSERT INTO CTNK(ID_NK,ID_NL,SoLuong) VALUES (108,106,30);
INSERT INTO CTNK(ID_NK,ID_NL,SoLuong) VALUES (109,112,15);
INSERT INTO CTNK(ID_NK,ID_NL,SoLuong) VALUES (109,113,15);
INSERT INTO CTNK(ID_NK,ID_NL,SoLuong) VALUES (109,114,15);
INSERT INTO CTNK(ID_NK,ID_NL,SoLuong) VALUES (110,102,15);
INSERT INTO CTNK(ID_NK,ID_NL,SoLuong) VALUES (110,106,25);
INSERT INTO CTNK(ID_NK,ID_NL,SoLuong) VALUES (110,107,15);
INSERT INTO CTNK(ID_NK,ID_NL,SoLuong) VALUES (110,110,20);

-- Them data cho PhieuXK
INSERT INTO PhieuXK(ID_XK,ID_NV,NgayXK) VALUES (100,102,'2023-01-10');
INSERT INTO PhieuXK(ID_XK,ID_NV,NgayXK) VALUES (101,102,'2023-02-11');
INSERT INTO PhieuXK(ID_XK,ID_NV,NgayXK) VALUES (102,102,'2023-03-12');
INSERT INTO PhieuXK(ID_XK,ID_NV,NgayXK) VALUES (103,102,'2023-03-13');
INSERT INTO PhieuXK(ID_XK,ID_NV,NgayXK) VALUES (104,102,'2023-04-12');
INSERT INTO PhieuXK(ID_XK,ID_NV,NgayXK) VALUES (105,102,'2023-04-13');
INSERT INTO PhieuXK(ID_XK,ID_NV,NgayXK) VALUES (106,102,'2023-05-12');
INSERT INTO PhieuXK(ID_XK,ID_NV,NgayXK) VALUES (107,102,'2023-05-15');
INSERT INTO PhieuXK(ID_XK,ID_NV,NgayXK) VALUES (108,102,'2023-05-20');
INSERT INTO PhieuXK(ID_XK,ID_NV,NgayXK) VALUES (109,102,'2023-06-05');
INSERT INTO PhieuXK(ID_XK,ID_NV,NgayXK) VALUES (110,102,'2023-06-10');

-- Them data cho CTXK
INSERT INTO CTXK(ID_XK,ID_NL,SoLuong) VALUES (100,100,5);
INSERT INTO CTXK(ID_XK,ID_NL,SoLuong) VALUES (100,101,5);
INSERT INTO CTXK(ID_XK,ID_NL,SoLuong) VALUES (100,102,5);
INSERT INTO CTXK(ID_XK,ID_NL,SoLuong) VALUES (101,101,7);
INSERT INTO CTXK(ID_XK,ID_NL,SoLuong) VALUES (101,103,10);
INSERT INTO CTXK(ID_XK,ID_NL,SoLuong) VALUES (101,104,5);
INSERT INTO CTXK(ID_XK,ID_NL,SoLuong) VALUES (101,105,5);
INSERT INTO CTXK(ID_XK,ID_NL,SoLuong) VALUES (101,106,10);
INSERT INTO CTXK(ID_XK,ID_NL,SoLuong) VALUES (102,109,5);
INSERT INTO CTXK(ID_XK,ID_NL,SoLuong) VALUES (102,110,5);
INSERT INTO CTXK(ID_XK,ID_NL,SoLuong) VALUES (102,112,10);
INSERT INTO CTXK(ID_XK,ID_NL,SoLuong) VALUES (102,113,8);
INSERT INTO CTXK(ID_XK,ID_NL,SoLuong) VALUES (102,114,5);
INSERT INTO CTXK(ID_XK,ID_NL,SoLuong) VALUES (103,114,5);
INSERT INTO CTXK(ID_XK,ID_NL,SoLuong) VALUES (103,104,5);
INSERT INTO CTXK(ID_XK,ID_NL,SoLuong) VALUES (104,101,5);
INSERT INTO CTXK(ID_XK,ID_NL,SoLuong) VALUES (104,112,5);
INSERT INTO CTXK(ID_XK,ID_NL,SoLuong) VALUES (105,113,5);
INSERT INTO CTXK(ID_XK,ID_NL,SoLuong) VALUES (105,102,5);
INSERT INTO CTXK(ID_XK,ID_NL,SoLuong) VALUES (106,103,5);
INSERT INTO CTXK(ID_XK,ID_NL,SoLuong) VALUES (106,114,5);
INSERT INTO CTXK(ID_XK,ID_NL,SoLuong) VALUES (107,105,5);
INSERT INTO CTXK(ID_XK,ID_NL,SoLuong) VALUES (107,106,5);
INSERT INTO CTXK(ID_XK,ID_NL,SoLuong) VALUES (108,115,5);
INSERT INTO CTXK(ID_XK,ID_NL,SoLuong) VALUES (108,110,5);
INSERT INTO CTXK(ID_XK,ID_NL,SoLuong) VALUES (109,110,5);
INSERT INTO CTXK(ID_XK,ID_NL,SoLuong) VALUES (109,112,5);
INSERT INTO CTXK(ID_XK,ID_NL,SoLuong) VALUES (110,113,5);
INSERT INTO CTXK(ID_XK,ID_NL,SoLuong) VALUES (110,114,5);
