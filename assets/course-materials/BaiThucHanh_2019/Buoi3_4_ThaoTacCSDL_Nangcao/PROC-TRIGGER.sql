-- BÀI 1
CREATE PROCEDURE Proc_BaiTap1
AS
BEGIN
	PRINT N'Xin Chào';
END;
EXEC Proc_BaiTap1;

-- BÀI 2
CREATE PROC Proc_BaiTap2
@TEN NVARCHAR(1000)
AS
	DECLARE @xinchao nvarchar(50)=N'Xin chào ';
BEGIN
	SET @xinchao=@xinchao+@TEN;
	PRINT @xinchao;
END
EXEC Proc_BaiTap2 N'Công Sơn';


--Nhập vào 2 số @s1, @s2. In ra câu ‘tổng là : @tg ‘  với @tg =@s1+@s2.

CREATE PROC Proc_TinhTong
@s1 int,
@s2 int
AS
BEGIN
	declare @tg int;
	set @tg = @s1+@s2;
	print N'Tổng là: '+cast(@tg as nvarchar(100));
END
exec Proc_TinhTong 1,4;


--Nhập vào 2 số @s1,@s2. Xuất tổng @s1+@s2 ra tham số @tong.
CREATE PROC Proc_TinhTong2
@s1 int,
@s2 int,
@tong int output
AS
BEGIN
	set @tong = @s1+@s2;
END

declare @rowCount int ;
exec Proc_TinhTong2 1,7, @rowCount output ;
select @rowCount as Tong;

--Nhập vào 2 số @s1,@s2. In ra câu ‘Số lớn nhất của @s1 và @s2 là max’ 
--với @s1,@s2,max là các giá trị tương ứng.
CREATE PROC PROC_MAX_MIN
@S1 INT,
@S2 INT
AS
BEGIN
	DECLARE @MAX INT =0;
	IF @S1<@S2
	SET @MAX = @S2
	ELSE
		SET @MAX = @S1
	PRINT N'Số lớn nhất của @s1 và @s2 là '+CAST(@MAX AS VARCHAR(100));
END
EXEC PROC_MAX_MIN 1,5;

--Nhập vào 2 số @s1,@s2. Xuất min và max của chúng ra tham số @max. Cho thực thi và in giá trị của các tham số này để kiểm tra.
CREATE PROC PROC_MAX_MIN_2
@S1 INT,
@S2 INT,
@MAX INT OUT
AS
BEGIN
	IF @S1<@S2
		SET @MAX = @S2
	ELSE
		SET @MAX = @S1
END
DECLARE @MAX INT;
EXEC PROC_MAX_MIN_2 1,5,@MAX OUTPUT;
SELECT @MAX

--Nhập vào số nguyên @n. In ra các số từ 1 đến @n.
--DROP PROC PROC_IN_SO_NGUYEN;
CREATE PROC PROC_IN_SO_NGUYEN
@N INT
AS
	DECLARE @BIEN INT = 1;
BEGIN
	WHILE @BIEN <= @N
	BEGIN
		PRINT @BIEN;
		SET @BIEN = @BIEN+1;
	END
END
EXEC PROC_IN_SO_NGUYEN 10;

--Nhập vào số nguyên @n. In ra tổng các số chẵn từ 1 đến @n
DROP PROC PROC_IN_SO_NGUYEN_CHAN;
CREATE PROC PROC_IN_SO_NGUYEN_CHAN
@N INT
AS
	DECLARE @BIEN INT = 0;
	DECLARE @TONG INT = 0;
BEGIN
	WHILE @BIEN <= @N
	BEGIN
		SET @BIEN = @BIEN+1;
		IF @BIEN%2=0
			SET @TONG = @TONG+@BIEN;
		ELSE
			CONTINUE
	END
	PRINT @TONG;
END
EXEC PROC_IN_SO_NGUYEN_CHAN 10;

--Nhập vào số nguyên @n. In ra tổng và số lượng các số chẵn từ 1 đến @n
--Cho thực thi và in giá trị của các tham số này để kiểm tra.
DROP PROC PROC_IN_TONG_SO_NGUYEN_CHAN;
CREATE PROC PROC_IN_TONG_SO_NGUYEN_CHAN
@N INT,
@TONG INT OUTPUT,
@COUNT INT OUTPUT
AS
	DECLARE @BIEN INT = 0;
	DECLARE @T INT = 0;
	DECLARE @C INT = 0;
BEGIN
	WHILE @BIEN <= @N
	BEGIN
		SET @BIEN = @BIEN+1;
		IF @BIEN%2=0
			BEGIN 
				SET @T = @T+@BIEN;
				SET @C = @C+1;
			END
		ELSE
			CONTINUE
	END
	SET @TONG = @T;
	SET @COUNT = @C;
END
DECLARE @TONG INT,@COUNT INT;
EXEC PROC_IN_TONG_SO_NGUYEN_CHAN 10,@TONG OUTPUT, @COUNT OUTPUT;
SELECT @TONG AS TONG, @COUNT AS COUNTS;


----Viết store procedure tương ứng với các câu ở phần View. Sau đó cho thực hiện để kiểm tra kết quả.

USE QLBongDa;
DROP PROC VIEW1;
CREATE PROC PROC_VIEW1
@TENQG NVARCHAR(100),
@TENCLB NVARCHAR (100)
AS
BEGIN
	SELECT ct.MACT, ct.HOTEN, ct.NGAYSINH, ct.DIACHI, ct.VITRI
	FROM CAULACBO as clb, CAUTHU as ct, QUOCGIA as qg
	WHERE ct.MAQG= qg.MAQG
	AND qg.TENQG=@TENQG
	AND ct.MACLB= clb.MACLB
	AND clb.TENCLB=@TENCLB;
END;
EXEC PROC_VIEW1 N'Bra-xin',N'SHB Đà Nẵng';

CREATE PROC PROC_VIEW2
@VONG INT,
@NAM INT
AS
BEGIN
	SELECT td.MATRAN, td.NGAYTD, svd.TENSAN, clb1.TENCLB as TENCLB1, clb2.TENCLB as TENCLB2, td.KETQUA
	FROM TRANDAU as td , SANVD as svd , CAULACBO as clb1 , CAULACBO as clb2
	WHERE td.MASAN = svd.MASAN
	  AND td.MACLB1 = clb1.MACLB
	  AND td.MACLB2 = clb2.MACLB
	  AND td.VONG = @VONG
	  AND td.NAM = @NAM  ;
END;
EXEC PROC_VIEW2 2,2009;

CREATE PROC PROC_VIEW3
@TEN_QUOC_GIA NVARCHAR(100)
AS
BEGIN
	SELECT hlv.MAHLV, hlv.TENHLV, hlv.NGAYSINH, hlv.DIACHI, HLV_CLB.VAITRO, clb.TENCLB, qg.TENQG
	FROM HUANLUYENVIEN as hlv , HLV_CLB , CAULACBO as clb , QUOCGIA as qg
	WHERE hlv.MAHLV = HLV_CLB.MAHLV
	  AND hlv.MAQG = qg.MAQG
	  AND HLV_CLB.MACLB = clb.MACLB
	  AND qg.TENQG = @TEN_QUOC_GIA ;
END;
EXEC PROC_VIEW3 N'Việt Nam';


CREATE PROC PROC_VIEW4
@MA_QUOC_GIA NVARCHAR(100),
@COUNT INT
AS
BEGIN
	SELECT clb.MACLB, clb.TENCLB, svd.TENSAN, svd.DIACHI, count(ct.MACT) as SL_CAU_THU_NUOC_NGOAI
	FROM CAULACBO as clb , SANVD as svd , CAUTHU as ct
	WHERE clb.MASAN = svd.MASAN
	  AND clb.MACLB = ct.MACLB
	  AND ct.MAQG not like @MA_QUOC_GIA
	GROUP BY clb.MACLB, clb.TENCLB, svd.TENSAN, svd.DIACHI
	HAVING count(ct.MACT) > @COUNT  ;
END;
EXEC PROC_VIEW4 'VN',2;

CREATE PROC PROC_VIEW5
@VI_TRI NVARCHAR(100)
AS
BEGIN
	SELECT TINH.TENTINH , count(ct.MACT) SO_LUONG_CAU_THU
	FROM TINH , CAULACBO as clb , CAUTHU as ct
	WHERE TINH.MATINH = clb.MATINH
	  AND clb.MACLB = ct.MACLB
	  AND ct.VITRI = @VI_TRI
	GROUP BY TINH.TENTINH  ;
END;
EXEC PROC_VIEW5 N'Tiền đạo';

CREATE PROC PROC_VIEW6
@VONG INT,
@NAM INT
AS
BEGIN
	SELECT clb.TENCLB , TINH.TENTINH
	FROM CAULACBO as clb , TINH , BANGXH as bxh
	WHERE clb.MATINH = TINH.MATINH
	  AND clb.MACLB = bxh.MACLB
	  AND bxh.VONG = @VONG AND bxh.NAM = @NAM
	ORDER BY bxh.DIEM DESC  ;
END;
EXEC PROC_VIEW6 3,2009;

CREATE PROC PROC_VIEW7
AS
BEGIN
	SELECT TENHLV
	FROM HUANLUYENVIEN
	WHERE DIENTHOAI IS NULL  ;
END;
EXEC PROC_VIEW7;

CREATE PROC PROC_VIEW8
@TEN_QUOC_GIA NVARCHAR(100)
AS
BEGIN
	SELECT hlv.TENHLV
	FROM HUANLUYENVIEN as hlv , QUOCGIA as qg , HLV_CLB
	WHERE hlv.MAQG = qg.MAQG
	  AND qg.TENQG = @TEN_QUOC_GIA
	  AND hlv.MAHLV = HLV_CLB.MAHLV
	  AND HLV_CLB.VAITRO IS NULL  ;
END;
EXEC PROC_VIEW8 N'Việt Nam';

CREATE PROC PROC_VIEW9
AS
BEGIN
	SELECT MACLB1, MACLB2, NAM, VONG, KETQUA
	FROM TRANDAU as td
END;
EXEC PROC_VIEW9;

CREATE PROC PROC_VIEW10
AS
BEGIN
	SELECT td.MACLB1 as MACLB, NAM, VONG, KETQUA
	FROM TRANDAU as td
END;
EXEC PROC_VIEW10;

CREATE PROC PROC_VIEW11
AS
BEGIN
	SELECT td.MACLB2 as MACLB, NAM, VONG, KETQUA
	FROM TRANDAU as td
END;
EXEC PROC_VIEW11;

CREATE PROC PROC_VIEW12
@HANG INT,
@VONG INT,
@NAM INT
AS
BEGIN
	SELECT td.NGAYTD, svd.TENSAN, clb1.TENCLB as TENCLB1, clb2.TENCLB as TENCLB2, td.KETQUA
	FROM TRANDAU as td , SANVD as svd , BANGXH as bxh , CAULACBO as clb1 , CAULACBO as clb2
	WHERE (clb1.MACLB = bxh.MACLB OR clb2.MACLB = bxh.MACLB)
	  AND bxh.HANG = @HANG
	  AND td.MASAN = svd.MASAN
	  AND td.MACLB1 = clb1.MACLB
	  AND td.MACLB2 = clb2.MACLB
	  AND (bxh.VONG = @VONG AND bxh.NAM = @NAM)  ;
END;
EXEC PROC_VIEW12 1,3,2009;

CREATE PROC PROC_VIEW13
@VONG INT,
@NAM INT
AS
BEGIN
	SELECT td.NGAYTD, svd.TENSAN, clb1.TENCLB as TENCLB1, clb2.TENCLB as TENCLB2, td.KETQUA
	FROM TRANDAU as td , SANVD as svd , BANGXH as bxh , CAULACBO as clb1 , CAULACBO as clb2
	WHERE (clb1.MACLB = bxh.MACLB OR clb2.MACLB = bxh.MACLB)
	  AND bxh.HANG =  ( SELECT max(HANG) 
					   FROM BANGXH
					   WHERE VONG = @VONG AND NAM = @NAM )
	  AND td.MASAN = svd.MASAN
	  AND td.MACLB1 = clb1.MACLB
	  AND td.MACLB2 = clb2.MACLB
	  AND (bxh.VONG = @VONG AND bxh.NAM = @NAM)  ;
END;
EXEC PROC_VIEW13 3,2009;

--Ứng với mỗi bảng trong CSDL Quản lý bóng đá, 
--bạn hãy viết 4 Stored Procedure ứng với 4 công việc Insert/Update/Delete/Select. 
--Trong đó Stored Procedure Update và Delete lấy khóa chính làm tham số.
CREATE PROC INSERT_TINH
@MATINH VARCHAR(5),
@TENTINH NVARCHAR(100),
@RESULT NVARCHAR(100) output
AS
BEGIN
	DECLARE @COUNTS INT = 0;
	DECLARE @error INT;
	DECLARE @id INT;
	SELECT @COUNTS = COUNT(*) FROM TINH A WHERE A.MATINH=@MATINH;
	IF @COUNTS >= 1
		SET @RESULT = N'Tồn tại mã tỉnh '+@MATINH;
	ELSE
		BEGIN
			INSERT INTO TINH VALUES (@MATINH,@TENTINH);
			SELECT @error = @@ERROR, @id = SCOPE_IDENTITY(); 
			IF @error = 0
				SET @RESULT = N'Đã tạo dữ liệu cho mã tỉnh là: '+@MATINH;
			ELSE
				SET @RESULT = N'Đã xảy ra lỗi tạo dữ liệu với mã lỗi: '+@id;
			END;
		END;
END;
DECLARE @RESULT NVARCHAR(100);
EXEC INSERT_TINH 'HPH',N'HẢI PHÒNG',@RESULT OUTPUT;
SELECT @RESULT AS MESSAGES_RESULT;

CREATE PROC UPDATE_TINH
@KEY VARCHAR(5),
@TENTINH NVARCHAR(100),
@RESULT NVARCHAR(100) output
AS
BEGIN
	DECLARE @COUNTS INT = 0;
	DECLARE @error INT;
	SELECT @COUNTS = COUNT(*) FROM TINH A WHERE A.MATINH = @KEY;
	IF @COUNTS = 0
		SET @RESULT = N'Không tìm thấy mã tỉnh: '+@KEY;
	ELSE
		BEGIN
			UPDATE TINH SET TENTINH=@TENTINH WHERE MATINH = @KEY;
			SELECT @error = @@ERROR, @id = SCOPE_IDENTITY(); 
			IF @error = 0
				SET @RESULT = N'Đã cập nhật thông tin với mã tỉnh: '+@KEY;
			ELSE
				SET @RESULT = N'Đã xảy ra lỗi cập nhật';
			END;
		END;
END;
DECLARE @RESULT NVARCHAR(100);
EXEC UPDATE_TINH 'HPH',N'Hải Phòng',@RESULT OUTPUT;
SELECT @RESULT AS MESSAGES_RESULT;

CREATE PROC DELETE_TINH
@KEY VARCHAR(5),
@RESULT NVARCHAR(100) output
AS
BEGIN
	DECLARE @COUNTS INT = 0;
	DECLARE @error INT;
	SELECT @COUNTS = COUNT(*) FROM TINH A WHERE A.MATINH = @KEY;
	IF @COUNTS = 0
		SET @RESULT = N'Không tìm thấy mã tỉnh: '+@KEY;
	ELSE
		BEGIN
			DELETE FROM TINH WHERE MATINH = @KEY;
			SELECT @error = @@ERROR; 
			IF @error = 0
				SET @RESULT = N'Đã xóa mã tỉnh: '+@KEY;
			ELSE
				PRINT 'Đã xảy ra lỗi khi xóa mã tỉnh: '+@KEY;
		END
END;
DECLARE @RESULT NVARCHAR(100);
EXEC DELETE_TINH 'BD',@RESULT OUTPUT;
SELECT @RESULT AS MESSAGES_RESULT;

CREATE PROC SELECT_TINH
@KEY VARCHAR(5),
@RESULT NVARCHAR(100) output
AS
BEGIN
	DECLARE @COUNTS INT = 0;
	DECLARE @error INT;
	SELECT @COUNTS = COUNT(*) FROM TINH A WHERE A.MATINH = @KEY;
	IF @COUNTS = 0
		SET @RESULT = N'Không tìm thấy mã tỉnh: '+@KEY;
	ELSE
		BEGIN
			SELECT * FROM TINH A WHERE A.MATINH=@KEY;
			SET @RESULT =N'Tìm thấy '+CAST(@COUNTS AS NVARCHAR(100))+' bản ghi';
		END
END;
DECLARE @RESULT NVARCHAR(100);
EXEC SELECT_TINH 'BD',@RESULT OUTPUT;
SELECT @RESULT AS MESSAGES_RESULT;

--CÁC BẢNG KHÁC TƯƠNG TỰ, SINH VIÊN TỰ THỰC HIỆN


--Bài tập về Trigger
--Khi thêm cầu thủ mới, kiểm tra vị trí trên sân của cần thủ chỉ thuộc một trong các vị trí sau: Thủ môn, Tiền đạo, Tiền vệ, Trung vệ, Hậu vệ.
--Khi thêm cầu thủ mới, kiểm tra số áo của cầu thủ thuộc cùng một câu lạc bộ phải khác nhau.
--Khi thêm thông tin cầu thủ thì in ra câu thông báo bằng Tiếng Việt ‘ Đã thêm cầu thủ mới’.
--Khi thêm cầu thủ mới, kiểm tra số lượng cầu thủ nước ngoài ở mỗi câu lạc bộ chỉ được phép đăng ký tối đa 8 cầu thủ.
DROP TRIGGER TRIG_CAUTHU;
CREATE TRIGGER TRIG_CAUTHU ON CAUTHU
FOR INSERT
AS
	DECLARE @HOTEN NVARCHAR(100);
	DECLARE @VITRI NVARCHAR(50);
	DECLARE @NGAYSINH DATE;
	DECLARE @DIACHI NVARCHAR(200);
	DECLARE @MACLB VARCHAR(5);
	DECLARE @MAQG VARCHAR (5);
	DECLARE @SO INT;
BEGIN
	-- Lấy thông tin dữ liệu đầu vào và set giá trị vào biến.
	SELECT @HOTEN = a.HOTEN, @VITRI = a.VITRI, @NGAYSINH =a.NGAYSINH, 
	@DIACHI =a.DIACHI, @MACLB =a.MACLB,@MAQG =a.MAQG,@SO=a.SO FROM INSERTED a;

	IF (@VITRI = N'Thủ môn' OR  
	@VITRI = N'Tiền Đạo' OR   
	@VITRI = N'Tiền vệ' OR 
	@VITRI = N'Trung vệ' OR 
	@VITRI = N'Hậu vệ' )
		BEGIN
			DECLARE @SO_LUONG INT;
			-- kiểm tra số áo
			SELECT @SO_LUONG = COUNT(*) FROM CAUTHU A WHERE A.SO=@SO AND A.MACLB=@MACLB;
			IF @SO_LUONG = 0
				BEGIN
					DECLARE @CAU_THU_NUOC_NGOAI INT;
					-- kiểm tra số lượng cầu thủ nước ngoài ở mỗi câu lạc bộ chỉ được phép đăng ký tối đa 8 cầu thủ.
					SELECT @CAU_THU_NUOC_NGOAI = COUNT(*) FROM CAUTHU C JOIN CAULACBO B ON C.MACLB = B.MACLB
					WHERE C.MACLB=@MACLB AND C.MAQG <> 'VN';

					IF  @CAU_THU_NUOC_NGOAI <= 8
						BEGIN
							DECLARE @error INT;
							INSERT INTO CAUTHU VALUES (@HOTEN,@VITRI,@NGAYSINH,@DIACHI,@MACLB,@MAQG,@SO);
							SELECT @error = @@ERROR; 
							IF @error = 0
								BEGIN
									COMMIT TRANSACTION;
									PRINT N'Đã thêm cầu thủ mới';
								END
							ELSE
								BEGIN
									PRINT N'Xảy ra lỗi khi thêm cầu thủ mới';
									ROLLBACK TRANSACTION;
								END
						END
					ELSE
						BEGIN
							PRINT N'SỐ LƯỢNG CẦU THỦ NGOẠI QUỐC VƯỢT QUÁ 8';
							ROLLBACK TRANSACTION;
						END
				END
			ELSE
				BEGIN
					PRINT N'ĐÃ TỒN TẠI SỐ ÁO: '+CAST(@SO AS NVARCHAR(100));
					ROLLBACK TRANSACTION;
				END
		END
	ELSE
		BEGIN
			PRINT N'KHÔNG THUỘC VỊ TRÍ NÀO';
			ROLLBACK TRANSACTION;
		END
END;
INSERT INTO CAUTHU VALUES (N'Nguyễn Công Sơn',N'Tiền đạo','1990-02-20',NULL,'BBD','VN',10);

--Khi thêm tên quốc gia, kiểm tra tên quốc gia không được trùng với tên quốc gia đã có.
CREATE TRIGGER TRIG_QUOCGIA ON QUOCGIA
FOR INSERT
AS
	DECLARE @MAQG VARCHAR(5);
	DECLARE @TENQG NVARCHAR(60);
BEGIN
	SELECT @MAQG = A.MAQG, @TENQG = A.TENQG FROM INSERTED A;
	IF((SELECT COUNT(*) FROM QUOCGIA QG WHERE QG.TENQG =@TENQG) = 0)
		BEGIN
			DECLARE @error INT;
			INSERT INTO QUOCGIA VALUES (@MAQG, @TENQG);
			SELECT @error = @@ERROR; 
			IF @error = 0
				BEGIN
					COMMIT TRANSACTION;
					PRINT N'Đã thêm quốc gia';
				END
			ELSE
				BEGIN
					PRINT N'Xảy ra lỗi khi thêm quốc gia';
					ROLLBACK TRANSACTION;
				END
		END
	ELSE
		BEGIN 
			PRINT N'TÊN QUỐC GIA ĐÃ TỒN TẠI';
			ROLLBACK TRANSACTION;
		END
END;

--Khi thêm tên tỉnh thành, kiểm tra tên tỉnh thành không được trùng với tên tỉnh thành đã có.
CREATE TRIGGER TRIG_TINH ON TINH
FOR INSERT
AS
	DECLARE @MATINH VARCHAR(5);
	DECLARE @TENTINH NVARCHAR(100);
BEGIN
	SELECT @MATINH = A.MATINH, @TENTINH = A.TENTINH FROM INSERTED A;
	IF((SELECT COUNT(*) FROM TINH T WHERE T.TENTINH =@TENTINH) = 0)
		BEGIN
			DECLARE @error INT;
			INSERT INTO TINH VALUES (@MATINH, @TENTINH);
			SELECT @error = @@ERROR; 
			IF @error = 0
				BEGIN
					COMMIT TRANSACTION;
					PRINT N'Đã thêm TỈNH';
				END
			ELSE
				BEGIN
					PRINT N'Xảy ra lỗi khi thêm TỈNH';
					ROLLBACK TRANSACTION;
				END
		END
	ELSE
		BEGIN 
			PRINT N'TÊN TỈNH ĐÃ TỒN TẠI';
			ROLLBACK TRANSACTION;
		END
END;
--Không cho sửa kết quả của các trận đã diễn ra.
DROP TRIGGER TRIG_TRANDAU;
CREATE TRIGGER TRIG_TRANDAU ON TRANDAU
FOR UPDATE
AS
BEGIN
	DECLARE	@KETQUA1 VARCHAR(5)
	DECLARE	@KETQUA2 VARCHAR(5)
	Select @KETQUA1 = I.KETQUA, @KETQUA2 = d.KETQUA from inserted i join deleted d on (i.MATRAN = d.MATRAN);
	IF (@KETQUA1 <> @KETQUA2)
		BEGIN
			PRINT N'KHÔNG ĐƯỢC CHỈNH SỬA KẾT QUẢ CỦA TRẬN ĐẤU';
			ROLLBACK TRANSACTION;
		END
END;
UPDATE TRANDAU SET KETQUA='3-1' WHERE MATRAN=1;

--Khi phân công huấn luyện viên cho câu lạc bộ:
--Kiểm tra vai trò của huấn luyện viên chỉ thuộc một trong các vai trò sau: HLV chính, HLV phụ, HLV thể lực, HLV thủ môn .
--Kiểm tra mỗi câu lạc bộ chỉ có tối đa 2 HLV chính.
CREATE TRIGGER TRIG_HLV_CLB ON HLV_CLB
FOR INSERT
AS
	DECLARE @MACLB VARCHAR(5);
	DECLARE @MAHLV VARCHAR(5);
	DECLARE @VAITRO NVARCHAR(10);
BEGIN
	SELECT @MACLB = A.MACLB, @MAHLV = A.MAHLV,@VAITRO = A.VAITRO FROM INSERTED A;
	IF (@VAITRO = 'HLV chính' OR
		@VAITRO = 'HLV phụ' OR
		@VAITRO = 'HLV thể lực' OR
		@VAITRO = 'HLV thủ môn')
		IF((SELECT COUNT(*) FROM CAULACBO A JOIN HLV_CLB B ON A.MACLB = B.MACLB 
		WHERE A.MACLB=@MACLB AND B.VAITRO=N'HLV chính') = 0)
			BEGIN 
				DECLARE @error INT;
				INSERT INTO HLV_CLB VALUES (@MAHLV, @MACLB, @VAITRO);
				SELECT @error = @@ERROR; 
				IF @error = 0
					BEGIN
						COMMIT TRANSACTION;
						PRINT N'Đã phân công';
					END
				ELSE
					BEGIN
						PRINT N'Xảy ra lỗi khi phân công';
						ROLLBACK TRANSACTION;
					END
			END
		ELSE
			BEGIN
				PRINT 'mỗi câu lạc bộ chỉ có tối đa 2 HLV chính.';
				ROLLBACK TRANSACTION;
			END
	ELSE
		BEGIN
			PRINT N'Vai trò của huấn luyện viên không thuộc trong các vai trò sau: HLV chính, HLV phụ, HLV thể lực, HLV thủ môn';
			ROLLBACK TRANSACTION;
		END
END

--Khi thêm mới một câu lạc bộ thì kiểm tra xem đã có câu lạc bộ trùng tên với câu lạc bộ vừa được thêm hay không?
--chỉ thông báo vẫn cho insert.
--thông báo và không cho insert.
CREATE TRIGGER TRIG_CAULACBO ON CAULACBO
FOR INSERT
AS
	DECLARE @MACLB VARCHAR(5);
	DECLARE @TENCLB NVARCHAR(100);
	DECLARE @MASAN VARCHAR(5);
	DECLARE @MATINH VARCHAR(5);
BEGIN
	SELECT @TENCLB = A.TENCLB FROM INSERTED A;
	BEGIN
		IF((SELECT COUNT(*) FROM CAULACBO A WHERE A.TENCLB=@TENCLB) > 0)
			PRINT N'TRÙNG TÊN CÂU LẠC BỘ VÀ TẠO BẢN GHI MỚI';
	END
		INSERT INTO CAULACBO VALUES (@MACLB, @TENCLB, @MASAN, @MATINH);
		COMMIT TRANSACTION;
END

CREATE TRIGGER TRIG_CAULACBO ON CAULACBO
FOR INSERT
AS
	DECLARE @MACLB VARCHAR(5);
	DECLARE @TENCLB NVARCHAR(100);
	DECLARE @MASAN VARCHAR(5);
	DECLARE @MATINH VARCHAR(5);
BEGIN
	SELECT @TENCLB = A.TENCLB FROM INSERTED A;
	IF((SELECT COUNT(*) FROM CAULACBO A WHERE A.TENCLB=@TENCLB) = 0)
		BEGIN
			INSERT INTO CAULACBO VALUES (@MACLB, @TENCLB, @MASAN, @MATINH);
			DECLARE @error INT;
			SELECT @error = @@ERROR; 
			IF @error = 0
				BEGIN
					COMMIT TRANSACTION;
					PRINT N'Đã tạo bản ghi';
				END
			ELSE
				BEGIN
					PRINT N'Xảy ra lỗi khi tạo mới';
					ROLLBACK TRANSACTION;
				END
		END
	ELSE
		PRINT  N'TRÙNG TÊN CÂU LẠC BỘ, ROLLBACK TRANSACTION';
END

--Khi sửa tên cầu thủ cho một (hoặc nhiều) cầu thủ thì in ra:
--danh sách mã cầu thủ của các cầu thủ vừa được sửa.
--danh sách mã cầu thủ vừa được sửa và tên cầu thủ mới.
--danh sách mã cầu thủ vừa được sửa và tên cầu thủ cũ.
--danh sách mã cầu thủ vừa được sửa và tên cầu thủ cũ và cầu thủ mới.
--câu thông báo bằng Tiếng Việt:
--Vừa sửa thông tin của cầu thủ có mã số xxx’ với xxx là mã cầu thủ vừa được sửa.
CREATE TRIGGER TRIG_CAUTHU_UPDATE ON CAUTHU
FOR UPDATE
AS
	DECLARE @MACT INT;
	DECLARE @HOTEN_NEW NVARCHAR(100);
	DECLARE @HOTEN_OLD NVARCHAR(100);
BEGIN
	Select @MACT = I.MACT,@HOTEN_NEW = I.HOTEN, @HOTEN_OLD = D.HOTEN from inserted i join deleted d on (i.MACT = d.MACT);
	UPDATE CAUTHU SET HOTEN = @HOTEN_NEW WHERE MACT=@MACT;
	PRINT @MACT;
	PRINT CAST(@MACT AS NVARCHAR(10)) +' - '+ @HOTEN_NEW;
	PRINT CAST(@MACT AS NVARCHAR(10)) +' - '+ @HOTEN_OLD;
	PRINT CAST(@MACT AS NVARCHAR(10)) +' - '+ @HOTEN_OLD +' - '+  @HOTEN_NEW;
	PRINT N'Vừa sửa thông tin của cầu thủ có mã số '+CAST(@MACT AS NVARCHAR(10));
END
UPDATE CAUTHU SET HOTEN=N'Nguyễn Công Sơn' where MACT=1;