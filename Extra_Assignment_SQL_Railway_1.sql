CREATE DATABASE ThucTap;
USE ThucTap;

-- Tạo bảng Khoa
CREATE TABLE Khoa (
    makhoa CHAR(10) PRIMARY KEY,
    tenkhoa CHAR(30),
    dienthoai CHAR(10)
);

-- Tạo bảng GiangVien
CREATE TABLE GiangVien (
    magv INT PRIMARY KEY,
    hotengv CHAR(30),
    luong DECIMAL(5,2),
    makhoa CHAR(10),
    FOREIGN KEY (makhoa) REFERENCES Khoa(makhoa)
);

-- Tạo bảng SinhVien
CREATE TABLE SinhVien (
    masv INT PRIMARY KEY,
    hotensv CHAR(30),
    makhoa CHAR(10),
    namsinh INT,
    quequan CHAR(30),
    FOREIGN KEY (makhoa) REFERENCES Khoa(makhoa)
);

-- Tạo bảng DeTai
CREATE TABLE DeTai (
    madt CHAR(10) PRIMARY KEY,
    tendt CHAR(30),
    kinhphi INT,
    NoiThucTap CHAR(30)
);

-- Tạo bảng HuongDan
CREATE TABLE HuongDan (
    masv INT,
    madt CHAR(10),
    magv INT,
    ketqua DECIMAL(5,2),
    PRIMARY KEY (masv, madt, magv),
    FOREIGN KEY (masv) REFERENCES SinhVien(masv),
    FOREIGN KEY (madt) REFERENCES DeTai(madt),
    FOREIGN KEY (magv) REFERENCES GiangVien(magv)
);

-- Thêm dữ liệu vào bảng Khoa
INSERT INTO Khoa VALUES
('CNTT', 'CONG NGHE THONG TIN', '0973246812'),
('TOAN', 'TOAN', '0981234567'),
('SINH', 'CONG NGHE SINH HOC', '0918273645'),
('DL', 'DIA LY va QLTN', '0987654321'),
('VL', 'VAT LY', '0981726354');

-- Thêm dữ liệu vào bảng GiangVien
INSERT INTO GiangVien VALUES
(1, 'Tran Son', 700.00, 'CNTT'),
(2, 'Nguyen Huong', 500.00, 'TOAN'),
(3, 'Le Tung', 650.00, 'DL'),
(4, 'Hoang Ha', 800.00, 'SINH'),
(5, 'Pham Thi Lan', 900.00, 'CNTT'),
(6, 'Nguyen Manh', 750.00, 'SINH'),
(7, 'Vu Hong', 680.00, 'DL'),
(8, 'Tran Quang', 850.00, 'VL');

-- Thêm dữ liệu vào bảng SinhVien
INSERT INTO SinhVien VALUES
(1, 'Le Van Son', 'CNTT', 2000, 'Ha Noi'),
(2, 'Nguyen Thi Mai', 'TOAN', 2001, 'Hai Phong'),
(3, 'Bui Xuan Duc', 'CNTT', 2000, 'Ha Noi'),
(4, 'Nguyen Van Tung', 'DL', 2002, 'Thai Binh'),
(5, 'Le Khanh Linh', 'TOAN', 2001, 'Ha Noi'),
(6, 'Tran Khac Trong', 'SINH', 2000, 'Thanh Hoa'),
(7, 'Le Thi Chanh', 'CNTT', 2002, 'Ha Noi'),
(8, 'Pham Thu Thuy', 'TOAN', 2000, 'Hai Duong'),
(9, 'Le Hong Phong', 'DL', 2001, 'Thai Binh'),
(10, 'Nguyen Tuan Anh', 'SINH', 2000, 'Nam Dinh');

-- Thêm dữ liệu vào bảng DeTai
INSERT INTO DeTai VALUES
('DT01', 'GIS', 100, 'Ha Noi'),
('DT02', 'ARC GIS', 500, 'Nam Dinh'),
('DT03', 'Spatial DB', 100, 'Ha Noi'),
('DT04', 'MAP', 300, 'Hai Phong'),
('DT05', 'Machine Learning', 200, 'Ha Noi');

-- Thêm dữ liệu vào bảng HuongDan
INSERT INTO HuongDan VALUES
(1, 'DT01', 1, 8.0),
(2, 'DT03', 2, 7.5),
(3, 'DT03', 1, 7.0),
(4, 'DT04', 3, 8.5),
(5, 'DT01', 2, 9.0),
(6, 'DT02', 4, 0.0),
(7, 'DT04', 1, 7.8),
(8, 'DT03', 2, 6.5),
(9, 'DT02', 3, 8.0);

-- 1. Đưa ra thông tin gồm mã số, họ tên và tên khoa của tất cả các giảng viên
SELECT gv.magv, gv.hotengv, k.tenkhoa
FROM GiangVien gv
JOIN Khoa k ON gv.makhoa = k.makhoa;

-- 2. Đưa ra thông tin gồm mã số, họ tên và tên khoa của các giảng viên của khoa 'DIA LY va QLTN'
SELECT gv.magv, gv.hotengv, k.tenkhoa
FROM GiangVien gv
JOIN Khoa k ON gv.makhoa = k.makhoa
WHERE k.tenkhoa = 'DIA LY va QLTN';

-- 3. Cho biết số sinh viên của khoa 'CONG NGHE SINH HOC'
SELECT COUNT(*) AS SoSinhVien
FROM SinhVien sv
JOIN Khoa k ON sv.makhoa = k.makhoa
WHERE k.tenkhoa = 'CONG NGHE SINH HOC';

-- 4. Đưa ra danh sách gồm mã số, họ tên và tuổi của các sinh viên khoa 'TOAN'
SELECT sv.masv, sv.hotensv, (2025 - sv.namsinh) AS tuoi
FROM SinhVien sv
JOIN Khoa k ON sv.makhoa = k.makhoa
WHERE k.tenkhoa = 'TOAN';

-- 5. Cho biết số giảng viên của khoa 'CONG NGHE SINH HOC'
SELECT COUNT(*) AS SoGiangVien
FROM GiangVien gv
JOIN Khoa k ON gv.makhoa = k.makhoa
WHERE k.tenkhoa = 'CONG NGHE SINH HOC';

-- 6. Cho biết thông tin về sinh viên không tham gia thực tập
SELECT sv.*
FROM SinhVien sv
LEFT JOIN HuongDan hd ON sv.masv = hd.masv
WHERE hd.masv IS NULL;

-- 7. Đưa ra mã khoa, tên khoa và số giảng viên của mỗi khoa
SELECT k.makhoa, k.tenkhoa, COUNT(gv.magv) AS SoGiangVien
FROM Khoa k
LEFT JOIN GiangVien gv ON k.makhoa = gv.makhoa
GROUP BY k.makhoa, k.tenkhoa;

-- 8. Cho biết số điện thoại của khoa mà sinh viên có tên 'Le van son' đang theo học
SELECT k.dienthoai
FROM SinhVien sv
JOIN Khoa k ON sv.makhoa = k.makhoa
WHERE sv.hotensv = 'Le Van Son';

-- 9. Cho biết mã số và tên của các đề tài do giảng viên 'Tran son' hướng dẫn
SELECT DISTINCT dt.madt, dt.tendt
FROM DeTai dt
JOIN HuongDan hd ON dt.madt = hd.madt
JOIN GiangVien gv ON hd.magv = gv.magv
WHERE gv.hotengv = 'Tran Son';

-- 10. Cho biết tên đề tài không có sinh viên nào thực tập
SELECT dt.tendt
FROM DeTai dt
LEFT JOIN HuongDan hd ON dt.madt = hd.madt
WHERE hd.madt IS NULL;

-- 11. Cho biết mã số, họ tên, tên khoa của các giảng viên hướng dẫn từ 3 sinh viên trở lên
SELECT gv.magv, gv.hotengv, k.tenkhoa
FROM GiangVien gv
JOIN Khoa k ON gv.makhoa = k.makhoa
JOIN HuongDan hd ON gv.magv = hd.magv
GROUP BY gv.magv, gv.hotengv, k.tenkhoa
HAVING COUNT(DISTINCT hd.masv) >= 3;

-- 12. Cho biết mã số, tên đề tài của đề tài có kinh phí cao nhất
SELECT madt, tendt
FROM DeTai
WHERE kinhphi = (SELECT MAX(kinhphi) FROM DeTai);

-- 13. Cho biết mã số và tên các đề tài có nhiều hơn 2 sinh viên tham gia thực tập
SELECT dt.madt, dt.tendt
FROM DeTai dt
JOIN HuongDan hd ON dt.madt = hd.madt
GROUP BY dt.madt, dt.tendt
HAVING COUNT(DISTINCT hd.masv) > 2;

-- 14. Đưa ra mã số, họ tên và điểm của các sinh viên khoa 'DIALY và QLTN'
SELECT sv.masv, sv.hotensv, hd.ketqua
FROM SinhVien sv
JOIN Khoa k ON sv.makhoa = k.makhoa
LEFT JOIN HuongDan hd ON sv.masv = hd.masv
WHERE k.tenkhoa = 'DIA LY va QLTN';

-- 15. Đưa ra tên khoa, số lượng sinh viên của mỗi khoa
SELECT k.tenkhoa, COUNT(sv.masv) AS SoLuongSV
FROM Khoa k
LEFT JOIN SinhVien sv ON k.makhoa = sv.makhoa
GROUP BY k.tenkhoa;

-- 16. Cho biết thông tin về các sinh viên thực tập tại quê nhà
SELECT sv.*
FROM SinhVien sv
JOIN HuongDan hd ON sv.masv = hd.masv
JOIN DeTai dt ON hd.madt = dt.madt
WHERE sv.quequan = dt.NoiThucTap;

-- 17. Hãy cho biết thông tin về những sinh viên chưa có điểm thực tập
SELECT sv.*
FROM SinhVien sv
LEFT JOIN HuongDan hd ON sv.masv = hd.masv
WHERE hd.ketqua IS NULL OR hd.ketqua = 0;

-- 18. Đưa ra danh sách gồm mã số, họ tên các sinh viên có điểm thực tập bằng 0
SELECT sv.masv, sv.hotensv
FROM SinhVien sv
JOIN HuongDan hd ON sv.masv = hd.masv
WHERE hd.ketqua = 0;