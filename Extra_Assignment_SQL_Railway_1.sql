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