---
layout: default
title: "Lời giải mẫu bài thực hành 2"
---


## a. Truy vấn cơ bản:

### 1. Cho biết thông tin (mã cầu thủ, họ tên, số áo, vị trí, ngày sinh, địa chỉ) của tất cả các cầu thủ

```sql
SELECT MACT, HOTEN, SO, NGAYSINH, DIACHI
FROM CAUTHU;
```

### 2. Hiển thị thông tin tất cả các cầu thủ có số áo là 7 chơi ở vị trí Tiền vệ.

```sql
SELECT * 
FROM CAUTHU
WHERE SO=7 AND VITRI=N'Tiền vệ';
```

**Lưu ý:** Thêm N trước unicode string để xác định kiểu là NCHAR, NVARCHAR, NTEXT hay vì CHAR, VARCHAR, TEXT.

**From Microsoft:**

    Prefix Unicode character string constants with the letter N. Without the N prefix, the string is converted to the default code page of the database. This default code page may not recognize certain characters.

### 3. Cho biết tên, ngày sinh, địa chỉ, điện thoại của tất cả các huấn luyện viên.

```sql
SELECT TENHLV, NGAYSINH, DIACHI, DIENTHOAI
from HUANLUYENVIEN;
```

### 4. Hiển thi thông tin tất cả các cầu thủ có quốc tịch Việt Nam thuộc câu lạc bộ Becamex Bình Dương

```sql
SELECT *
FROM CAUTHU
WHERE MAQG='VN' AND MACLB='BBD';
```

### 5. Cho biết mã số, họ tên, ngày sinh, địa chỉ và vị trí của các cầu thủ thuộc đội bóng ‘SHB Đà Nẵng’ có quốc tịch “Bra-xin”

```sql
SELECT *
FROM CAUTHU ct, CAULACBO clb, QUOCGIA qg
WHERE ct.MACLB = clb.MACLB
	AND ct.MAQG = qg.MAQG
	AND clb.TENCLB = N'SHB Đà Nẵng'
	AND qg.TENQG = N'Bra-xin';
```

```sql
SELECT *
FROM CAUTHU ct
INNER JOIN CAULACBO clb ON ct.MACLB = clb.MACLB
INNER JOIN QUOCGIA qg ON ct.MAQG = qg.MAQG
WHERE  clb.TENCLB = N'SHB Đà Nẵng'
	AND qg.TENQG = N'Bra-xin';
```

6. Hiển thị thông tin tất cả các cầu thủ đang thi đấu trong câu lạc bộ có sân nhà là “Long An”

```sql
SELECT *
FROM CAUTHU ct, CAULACBO clb, SANVD svd
WHERE ct.MACLB = clb.MACLB
	AND clb.MASAN = svd.MASAN
	AND svd.TENSAN = N'Long An';
```

```sql
SELECT ct.*
FROM CAULACBO clb
INNER JOIN CAUTHU ct ON ct.MACLB = clb.MACLB
INNER JOIN SANVD svd ON clb.MASAN = svd.MASAN
WHERE svd.TENSAN = N'Long An';
```

7. Cho biết kết quả (MATRAN, NGAYTD, TENSAN, TENCLB1, TENCLB2, KETQUA) các trận đấu vòng 2 của mùa bóng năm 2009

```sql
SELECT MATRAN, NGAYTD, TENSAN, clb1.TENCLB AS TENCLB1, clb2.TENCLB AS TENCLB2, KETQUA
FROM TRANDAU td
INNER JOIN SANVD svd ON td.MASAN = svd.MASAN
INNER JOIN CAULACBO clb1 ON td.MACLB1 = clb1.MACLB
INNER JOIN CAULACBO clb2 ON td.MACLB2 = clb2.MACLB
WHERE VONG=2 AND NAM=2009;
```

8. Cho biết mã huấn luyện viên, họ tên, ngày sinh, địa chỉ, vai trò và tên CLB đang làm việc của các huấn luyện viên có quốc tịch “ViệtNam”

```sql
SELECT hlv.MAHLV, TENHLV as HOTEN, NGAYSINH, DIACHI, VAITRO, TENCLB
FROM HUANLUYENVIEN hlv, QUOCGIA qg, CAULACBO clb, HLV_CLB
WHERE hlv.MAQG = qg.MAQG
	AND hlv.MAHLV = HLV_CLB.MAHLV
	AND clb.MACLB = HLV_CLB.MACLB
	AND qg.TENQG = N'Việt Nam';
```

9. Lấy tên 3 câu lạc bộ có điểm cao nhất sau vòng 3 năm 2009

```sql
SELECT TOP 3 TENCLB
FROM BANGXH bxh
INNER JOIN CAULACBO clb ON bxh.MACLB = clb.MACLB
WHERE VONG=3 AND NAM=2009
ORDER BY DIEM DESC;
```

10. Cho biết mã huấn luyện viên, họ tên, ngày sinh, địa chỉ, vai trò và tên CLB đang làm việc mà câu lạc bộ đó đóng ở tỉnh Binh Dương.

```sql
SELECT hlv.MAHLV, TENHLV as HOTEN, NGAYSINH, DIACHI, VAITRO, TENCLB
FROM HUANLUYENVIEN hlv, TINH t, CAULACBO clb, HLV_CLB
WHERE clb.MATINH = t.MATINH
	AND hlv.MAHLV = HLV_CLB.MAHLV
	AND clb.MACLB = HLV_CLB.MACLB
	AND t.TENTINH = N'Bình Dương';
```

## b. Các phép toán trên nhóm

### 1. Thống kê số lượng cầu thủ của mỗi câu lạc bộ

```sql
SELECT clb.TENCLB, COUNT(ct.MACT) AS SOCAUTHU
FROM CAULACBO clb
INNER JOIN CAUTHU ct ON clb.MACLB = ct.MACLB
GROUP BY clb.TENCLB;
```

### 2. Thống kê số lượng cầu thủ nước ngoài (có quốc tịch khác Việt Nam) của mỗi câu lạc bộ

```sql
SELECT clb.TENCLB, COUNT(ct.MACT) AS SOCAUTHU
FROM CAULACBO clb
INNER JOIN CAUTHU ct ON clb.MACLB = ct.MACLB
WHERE ct.MAQG <> 'VN'
GROUP BY clb.TENCLB;
```

### 3. Cho biết mã câu lạc bộ, tên câu lạc bộ, tên sân vận động, địa chỉ và số lượng cầu thủ nước ngoài (có quốc tịch khác Việt Nam) tương ứng của các câu lạc bộ có nhiều hơn 2 cầu thủ nước ngoài.

```sql
SELECT clb.MACLB, clb.TENCLB, svd.TENSAN, svd.DIACHI, SOCAUTHUNUOCNGOAI
FROM CAULACBO clb, 
	SANVD svd,
	(SELECT clb.MACLB, COUNT(ct.MACT) AS SOCAUTHUNUOCNGOAI
		FROM CAULACBO clb
		INNER JOIN CAUTHU ct ON clb.MACLB = ct.MACLB
		WHERE ct.MAQG <> 'VN'
		GROUP BY clb.MACLB) AS tk
WHERE clb.MASAN = svd.MASAN
	AND clb.MACLB = tk.MACLB
	AND SOCAUTHUNUOCNGOAI > 2;
```

### 4. Cho biết tên tỉnh, số lượng cầu thủ đang thi đấu ở vị trí tiền đạo trong các câu lạc bộ thuộc địa bàn tỉnh đó quản l

```sql
SELECT TENTINH, COUNT(ct.MACT) as SOTIENDAO
FROM TINH t, CAULACBO clb, CAUTHU ct
WHERE clb.MATINH = t.MATINH
	AND ct.MACLB = clb.MACLB
	AND ct.VITRI = N'Tiền đạo'
GROUP BY TENTINH;
```

### 5. Cho biết tên câu lạc bộ, tên tỉnh mà CLB đang đóng nằm ở vị trí cao nhất của bảng xếp hạng vòng 3, năm 2009

```sql
SELECT TENCLB, TENTINH
FROM TINH t, CAULACBO clb, 
	(SELECT TOP 1 MACLB
		FROM BANGXH bxh
		WHERE VONG=3 AND NAM=2009
		ORDER BY HANG ASC) AS clb_top
WHERE clb.MATINH = t.MATINH
	AND clb.MACLB = clb_top.MACLB;
```

## c. Các toán tử nâng cao


### 1. Cho biết tên huấn luyện viên đang nắm giữ một vị trí trong một câu lạc bộ mà chưa có số điện thoại

```sql
SELECT TENHLV as HOTEN
FROM HUANLUYENVIEN hlv, CAULACBO clb, HLV_CLB
WHERE hlv.MAQG = qg.MAQG
	AND hlv.MAHLV = HLV_CLB.MAHLV
	AND clb.MACLB = HLV_CLB.MACLB
	AND hlv.DIENTHOAI 
```

### 2. Liệt kê các huấn luyện viên thuộc quốc gia Việt Nam chưa làm công tác huấn luyện tại bất kỳ một câu lạc bộ nào

```sql
SELECT *
FROM HUANLUYENVIEN
WHERE MAHLV NOT IN (
SELECT DISTINCT hlv.MAHLV
    FROM HUANLUYENVIEN hlv, QUOCGIA qg, CAULACBO clb, HLV_CLB
    WHERE (hlv.MAHLV = HLV_CLB.MAHLV AND clb.MACLB = HLV_CLB.MACLB)
        OR (hlv.MAQG = qg.MAQG AND qg.TENQG <> N'Việt Nam')
)
```

```sql
SELECT *
FROM HUANLUYENVIEN hlv
WHERE NOT EXISTS (
	SELECT DISTINCT hlv2.MAHLV
    FROM HUANLUYENVIEN hlv2, QUOCGIA qg, CAULACBO clb, HLV_CLB
    WHERE hlv.MAHLV = hlv2.MAHLV
		AND (
			(hlv2.MAHLV = HLV_CLB.MAHLV AND clb.MACLB = HLV_CLB.MACLB)
			OR (hlv2.MAQG = qg.MAQG AND qg.TENQG <> N'Việt Nam')
		)
)
```

### 3. Liệt kê các cầu thủ đang thi đấu trong các câu lạc bộ có thứ hạng ở vòng 3 năm 2009 lớn hơn 6 hoặc nhỏ hơn 3


```sql
SELECT DISTINCT ct.*
FROM CAUTHU ct
INNER JOIN BANGXH xh ON ct.MACLB = xh.MACLB
WHERE xh.HANG > 6 OR xh.HANG < 3;
```

Hoặc 1 cách sử dụng điểm

```sql
SELECT ct.*
FROM 
	CAUTHU ct,
	(SELECT ROW_NUMBER() OVER(ORDER BY DIEM DESC) AS xep_hang, 
		MACLB
	FROM BANGXH
	WHERE VONG=3 AND NAM=2009
	) as xh_clb
WHERE xep_hang > 6 OR xep_hang < 3
	AND ct.MACLB = xh_clb.MACLB;
```

### 4. Cho biết danh sách các trận đấu (NGAYTD, TENSAN, TENCLB1, TENCLB2, KETQUA) của câu lạc bộ (CLB) đang xếp hạng cao nhất tính đến hết vòng 3 năm 2009.

```sql
SELECT NGAYTD, TENSAN, clb1.TENCLB AS TENCLB1, clb2.TENCLB AS TENCLB2, KETQUA
FROM TRANDAU td,
	SANVD svd,
	CAULACBO clb1,
	CAULACBO clb2,
    (SELECT TOP 1 MACLB
        FROM BANGXH bxh
        WHERE VONG=3 AND NAM=2009
        ORDER BY HANG ASC) AS clb_top
WHERE td.MASAN = svd.MASAN
	AND td.MACLB1 = clb1.MACLB 
	AND td.MACLB2 = clb2.MACLB 
	AND (clb_top.MACLB = clb1.MACLB OR clb_top.MACLB = clb2.MACLB);
```
