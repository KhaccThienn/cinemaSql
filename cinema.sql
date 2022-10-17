--1: Khoi Tao database
CREATE DATABASE lich_chieu_phim
-- Khoi Tao bang Rap
CREATE TABLE rap( MaRap varchar(2) PRIMARY KEY, TenRap varchar(60), DiaChi varchar(100) )

-- Khoi Tao Bang The_Loai
CREATE TABLE the_loai ( MaTheLoai int PRIMARY KEY, TenTheLoai varchar(40) )

-- Khoi Tao Bang Phim
CREATE TABLE phim ( MaPhim varchar(5) PRIMARY KEY, TenPhim varchar(100), MaTheLoai int, NgayPhatHanh Datetime, HangSanXuat varchar(100), FOREIGN KEY (MaTheLoai) REFERENCES the_loai(MaTheLoai) )

- Khoi Tao bang Lich_Chieu:
CREATE TABLE lich_chieu( MaLich int PRIMARY KEY, MaRap varchar(2), MaPhim varchar(5), ThoiGian datetime, SoLuongVe SMALLINT, FOREIGN KEY (MaRap) REFERENCES rap(MaRap), FOREIGN KEY (MaPhim) REFERENCES phim(MaPhim) )

--2, Đổi NGAY_PHAT_HANH ở bảng PHIM thành kiểu Date 
ALTER TABLE phim MODIFY COLUMN phim.NgayPhatHanh date

--3, Thêm vào bảng PHIM cột thuộc tính GIOI_THIEU(nvarchar(500)), DIEN_VIEN  (nvarchar(100)), GIA_VE(money), MO_TA(nvarchar(50))  

ALTER TABLE phim 
ADD COLUMN GioiThieu varchar(500),
ADD COLUMN DienVien varchar(100),
ADD COLUMN GiaVe float,
ADD COLUMN MoTa varchar(50)

-- 4, Xóa cột MO_TA ở bảng PHIM  

ALTER TABLE phim DROP COLUMN MoTa

-- 5, Viết lệnh để thêm dữ liệu vào cac bảng (môi bảng it nhât 5 dòng)
  
-- thêm dữ liệu vào bảng Rạp
INSERT INTO rap VALUES 
("MS", "MegaStar", "Salai Road Tiruchirappalli No 150/74 D1"),
("HD", "CGV Aeon Ha Dong", "Ha Dong, Ha Noi"),
("IP", "CGV IndoChina Plaza Ha Noi", "Q.Cau Giay, Ha Noi"),
("TT", "CGV Trang Tien Plaza", "Hai Ba Trung, Hoan Kiem, Ha Noi"),
("LB", "CGV Long Bien", "Phuc Loi, Long Bien, Ha Noi");

-- Thêm Dữ Liệu Vào bảng thể loại
INSERT INTO the_loai VALUES
(1, "Rom-Com"),
(2, "Drama"),
(3, "Isekai"),
(4, "Action"),
(5, "Horror");

-- thêm dữ liệu cho bảng phim

INSERT INTO phim VALUES 
("1", "My Teen Romantic Comedy SNAFU!", 1, CURRENT_DATE, "feel", null, "Hachiman", 1200000),
("2", "Isekai wa Smartphone to Tomo ni", 3, CURRENT_DATE, "J.C.Staff", null, "Touya Mochizuki", 2000000),
("3", "Chainsaw Man", 5, CURRENT_DATE, "MAPPA", null, "Denji", 5000000),
("4", "Kimetsu no Yaiba: Infinity Train", 4, CURRENT_DATE, "ufotable", null, "Tanjiro", 350000),
("5", "Domestic na Kanojo", 3, CURRENT_DATE, "Diomedea", null, "Natsuo", 1500000),
("6", "Sex Is Zero", 2, CURRENT_DATE, "Diomedea", null, "Natsuo", 1500000),
("7", "Xác ướp Ai Cập", 2, CURRENT_DATE, "Diomedea", null, "Natsuo", 3000000);

-- thêm dữ liệu cho bảng lịch chiếu
INSERT INTO lich_chieu VALUES
(1, "TT", "2", CURRENT_DATE, 200),
(2, "LB", "5", CURRENT_DATE, 500),
(3, "HD", "1", CURRENT_DATE, 300),
(4, "IP", "4", CURRENT_DATE, 225),
(5, "MS", "6", CURRENT_DATE, 446),
(6, "MS", "7", CURRENT_DATE, 15000),
(7, "TT", "3", CURRENT_DATE, 322)

-- 6, Tìm thông tin về rạp có tên là “MegaStar”
SELECT r.MaRap, r.TenRap, r.DiaChi FROM rap r WHERE r.TenRap = "MegaStar"

--7,  Tìm thông tin về những phim có số lương vé > 100 
SELECT p.*, lc.SoLuongVe FROM phim p INNER JOIN lich_chieu lc ON lc.MaPhim = p.MaPhim WHERE lc.SoLuongVe > 100

-- 8, Xóa thông tin về phim có tên là “Sex Is Zero”  
DELETE FROM phim WHERE TenPhim = "Sex Is Zero"

--9, Sửa thông tin của phim có tên “Xác ướp Ai Cập” thành “Cướp biển Carribe”  
UPDATE phim SET TenPhim = "Cuop Bien Caribe" WHERE TenPhim = "Xác ướp Ai Cập"  

-- 10, Tìm những bộ phim nào mà có số lượng vé từ 200-400 vé  
SELECT p.*, lc.SoLuongVe FROM phim p INNER JOIN lich_chieu lc ON lc.MaPhim = p.MaPhim WHERE lc.SoLuongVe >= 200 AND lc.SoLuongVe <= 400

-- 11, Tìm kiếm những bộ phim nào có tên bắt đầu bằng chữ ‘N’  
SELECT p.* FROM phim p WHERE p.TenPhim LIKE "N%"

-- 12, .Cập nhật dữ liệu trong bảng lịch chiếu, tăng số lượng vé của các phim có mã từ  10-20 lên 50 vé mỗi phim. 

-- 13, Tìm thông tin của các lịch chiếu có số lượng vé nằm trong khoảng từ 100-300,  sắp xếp theo số lượng vé (theo thứ tự giảm dần). 
SELECT lc.* FROM lich_chieu lc WHERE lc.SoLuongVe >= 100 AND lc.SoLuongVe <= 300 ORDER BY lc.SoLuongVe DESC
