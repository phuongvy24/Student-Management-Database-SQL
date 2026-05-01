USE SinhVien

-- a.Thống kê số lượng sinh viên của từng ngành. Thông tin hiển thị gồm: Mã ngành, tên ngành, số lượng sinh viên
select n.MaN,n.TenN,COUNT(s.MaSV) as SoLuongSV
from NganhHoc n 
join ChuyenNganh c on n.MaN = c.MaN
join SinhVien s on s.MaCN = c.MaCN
group by n.MaN, n.TenN

-- b.Lấy số lượng của sinh viên theo từng lớp sinh hoạt. Thông tin hiển thị gồm: Mã lớp, số lượng sinh viên
select s.MaL, COUNT (s.MaSV) as SoLuongSV  
from LopSinhHoat l join SinhVien s
on l.MaL = s.MaL
group by s.MaL

-- c. Lấy danh sách sinh viên không đăng ký môn học trong Học kỳ 2/2023-2024. Thông tin hiển thị gồm: Mã sinh viên, tên sinh viên
select MaSV, Ho, Ten
from SinhVien sv
where sv.MaSV not in (select dk.MaSV from DKHP dk, LopHocPhan lhp where lhp.MaHP = dk.MaHP and NamHoc = '2023-2024' and TenHocKy = 'HK2')

-- d. Thống kê số lượng môn học giảng dạy của các giảng viên. Thông tin hiển thị gồm: Mã giảng viên, tên giảng viên, số lượng môn học giảng dạy.
select gv.MaGV, Ho, Ten, count(*) SLmonhoc
from GiangDay gd, GiangVien gv
where gv.MaGV = gd.MaGV
group by gv.MaGV, Ho, Ten

-- e. Lấy thông tin số lượng môn học đã đăng ký của mỗi sinh viên trong Học kỳ 2/2023-2024. Thông tin gồm: Mã SV, Họ, Tên, Mã lớp, Tên học kỳ, năm học, số lượng môn học.
SELECT SV.MaSV, Ho, Ten, MaL 'Mã Lớp' , LHP.TenHocKy 'Tên học kỳ', LHP.NamHoc 'Năm học', COUNT(LHP.MaMH) 'Số lượng môn học' FROM SinhVien SV
JOIN DKHP DK ON DK.MaSV = SV.MaSV
JOIN LopHocPhan LHP ON DK.MaHP = LHP.MaHP
WHERE TenHocKy = 'HK2' AND NamHoc = '2023-2024'
GROUP BY SV.MaSV, Ho, Ten, MaL, LHP.TenHocKy, LHP.NamHoc

-- f. Thống kê số lớp giảng dạy của mỗi giảng viên trong từng học kỳ. Thông tin hiển thị gồm: Tên học kỳ, năm học, mã giảng viên, tên giảng viên, số lớp giảng dạy.
 SELECT TenHocKy, NamHoc, GV.MaGV, CONCAT(Ho,' ',Ten) AS 'Tên giảng viên', COUNT(GD.MaHP) AS 'Số lớp giảng dạy'
FROM GiangVien GV
JOIN GiangDay GD ON GV.MaGV = GD.MaGV
JOIN LopHocPhan LHP ON GD.MaHP = LHP.MaHP
GROUP BY TenHocKy, NamHoc, GV.MaGV, CONCAT(Ho,' ',Ten)

-- g. Lấy thông tin những sinh viên đăng ký một môn học từ hai lần trở lên (đăng ký trong hai học kỳ khác nhau). Thông tin gồm: Mã SV, Họ, Tên, Mã Lớp, Mã MH, tên MH.
SELECT SV.MaSV, Ho, Ten, MaL, MH.MaMH, CONCAT(TiengViet,' / ',TiengAnh) AS 'Tên Môn Học'
FROM SinhVien SV
JOIN DKHP DK ON SV.MaSV = DK.MaSV
JOIN LopHocPhan LHP ON DK.MaHP = LHP.MaHP
JOIN MonHoc MH ON LHP.MaMH = MH.MaMH
GROUP BY SV.MaSV, Ho, Ten, MaL, MH.MaMH, CONCAT(TiengViet,' / ',TiengAnh)
HAVING COUNT(DISTINCT(CONCAT(LHP.MaMH,LHP.TenHocKy,LHP.NamHoc)))>=2

-- h. Lấy thông tin số tín chỉ tích lũy, điểm trung bình tích lũy của mỗi sinh viên. Thông tin gồm: Mã SV, Họ, Tên, Mã Lớp, Tổng tín chỉ tích lũy, điểm trung bình tích lũy
select sv.MaSV, sv.Ho, sv.Ten, sv.MaL, 
sum(mh.SoTinChi) TổngTínChỉTíchLũy, round (sum(dk.TongKet*mh.SoTinChi)/sum(mh.SoTinChi),2) ĐiểmTrungBìnhTíchLũy
from 
(select dk.MaSV, dk.MaHP, max(TongKet) TongKet
from DKHP dk
where dk.TongKet >= 4 and dk.TongKet <=10
group by dk.MaSV, dk.MaHP) dk, SinhVien sv, LopHocPhan hp, MonHoc mh
where dk.TongKet >= 4 and dk.TongKet <=10
and sv.MaSV=dk.MaSV 
and hp.MaHP = dk.MaHP 
and mh.MaMH = hp.MaMH
group by sv.MaSV, sv.Ho, sv.Ten, sv.MaL

-- i. Lấy thông tin những môn học trong học kỳ 2/2023-2024 chưa có điểm. Thông tin gồm: Mã MH, Tên MH
 select distinct mh.MaMH, TiengViet TênMônHọc
from MonHoc mh join LopHocPhan hp on hp.MaMH=mh.MaMH join DKHP dk on dk.MaHP=hp.MaHP
where  hp.TenHocKy='HK2' and hp.NamHoc= '2023-2024' and dk.TongKet is null
