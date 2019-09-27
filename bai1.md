---
layout: default
title: "Tài liệu bài thực hành 1"
---

## 1. Tài liệu:
    
1. Hướng dẫn cài môi trường và tạo CSDL: 
    [File Huongdanthuchanh_So1.pdf](/assets/course-materials/BaiThucHanh_2019/Buoi1_TaoCSDL/Huongdanthuchanh_So1.pdf)

2. Hướng dẫn bài thực hành: 
    [File Baitapthuchanh_So1.pdf](/assets/course-materials/BaiThucHanh_2019/Buoi1_TaoCSDL/Baitapthuchanh_So1.pdf)

## 2. Hướng dẫn cài đặt môi trường

- **Tải về và cài đặt môi trường**
    - Hướng dẫn cài đặt tại đây: <https://vinasupport.com/huong-dan-download-va-cai-dat-microsoft-sql-server/>
    - **MS SQL Server** <https://www.microsoft.com/en-us/sql-server/sql-server-downloads>.
    - **SQL Server Management Studio:** <https://docs.microsoft.com/en-us/sql/ssms/download-sql-server-management-studio-ssms>.

- **Sử dụng hướng dẫn ở mục 1 để tạo CSDL và bảng.**

## 3. Các vấn đề có thể gặp và cách giải quyết

### Tạo database

<https://docs.microsoft.com/en-us/sql/relational-databases/databases/create-a-database?view=sql-server-2017#SSMSProcedure>

### Tạo table

<https://datatofish.com/table-sql-server/>


**(!) HOẶC SỬ DỤNG LỆNH SQL:**

- Ấn chuột phải vào tên database -> Chọn **New Query**.
- Chèn Query tạo bảng và ấn F5 để chạy.
- Ví dụ về query tạo bảng:

~~~sql
USE QLBongDa
GO

CREATE TABLE dbo.BANGXH2(
	MACLB varchar(5) NOT NULL,
	NAM int NOT NULL,
	VONG int NOT NULL,
	SOTRAN int NOT NULL,
	THANG int NOT NULL,
	HOA int NOT NULL,
	THUA int NOT NULL,
	HIEUSO varchar(5) NOT NULL,
	DIEM int NOT NULL,
	HANG int NOT NULL,
 CONSTRAINT PK_BANGXH PRIMARY KEY 
    (
        MACLB ASC,
        NAM ASC,
        VONG ASC
    )
)
GO

~~~

### Tạo quan hệ giữa các table

<https://docs.microsoft.com/en-us/sql/relational-databases/tables/create-foreign-key-relationships?view=sql-server-2017>


**(!) HOẶC SỬ DỤNG LỆNH SQL:**

- Ấn chuột phải vào tên database -> Chọn **New Query**.
- Chèn Query và ấn F5 để chạy.
- Ví dụ về query tạo quan hệ giữa các bảng:

~~~sql
ALTER TABLE dbo.BANGXH  ADD  CONSTRAINT FK_BANGXH_CAULACBO FOREIGN KEY(MACLB)
REFERENCES dbo.CAULACBO (MACLB)
~~~

### Lỗi: Saving changes is not permitted

![](/assets/course-materials/images/error1.png)

- Open SQL Server Management Studio
- From the file menu, choose **Tools -> Options**
- From the left menu, choose **Designers**
- Uncheck the box entitled **Prevent saving changes that require table re-creation**
- Press OK to save

![](/assets/course-materials/images/error1-solved.png)


### Tạo truy vấn

- Right-click the database name, select **New Query**.
- Insert query
- Press [F5] to run

Example of query

```sql
INSERT INTO dbo.BANGXH
         (MACLB, NAM, VONG, SOTRAN, THANG, HOA, THUA, HIEUSO, DIEM, HANG)  
VALUES   ('BBD', 2019, 1,1,1,0,0,'3-0',3,1)  
```

### Backup CSDL

- Right-click the database that you wish to backup, point to **Tasks**, and then click Back Up....

<https://docs.microsoft.com/en-us/sql/relational-databases/backup-restore/create-a-full-database-backup-sql-server?view=sql-server-2017>

### Restore CSDL đã backup

- Right click **Databases** on left pane (Object Explorer)
- Click **Restore Database...**
- Choose **Device**, click **[...]**, and add your .bak file
- Click [OK], then [OK] again.

<https://support.managed.com/kb/a1788/how-to-manually-restore-an-mssql-database-in-management-studio.aspx>
