---
layout: default
title: "Tài liệu bài thực hành 2"
---

## I. Chuẩn bị trước:

Trước buổi 2 cần tải file backup dữ liệu từ buổi 1 tại [đây](/assets/course-materials/BaiThucHanh_2019/Buoi2_ThaoTacCSDL/QLBongDa.bak) và thực hiện Restore vào CSDL QLBongDa. Xem lại [bài 1](/bai1) nếu quên cách Restore CSDL.

## II. Tài liệu:
    
1. Hướng dẫn lý thuyết về SQL, cách viết truy vấn:
    [File Huongdanthuchanh_So2.pdf](/assets/course-materials/BaiThucHanh_2019/Buoi2_ThaoTacCSDL/Huongdanthuchanh_So2.pdf)

2. Bài tập thực hành số 2:
    [File Baitapthuchanh_So2.pdf](/assets/course-materials/BaiThucHanh_2019/Buoi2_ThaoTacCSDL/Baitapthuchanh_So2.pdf)


## III. Tóm tắt lý thuyết:

#### 1. Ngôn ngữ định nghĩa dữ liệu ( Data Definition Language – DDL)

Các câu lệnh DDL thường có dạng:

- **Create** object
- **Alter** object
- **Drop** object

Trong đó object có thể là: table, view, storedprocedure, function, trigger…

**Để chạy câu lệnh SQL trên, mở một Query Editor, copy câu lệnh vào Query Editor, bấm F5.**


- Tạo bảng **CAULACBO**:

```sql
create table CAULACBO
(
    MACLB varchar(5) primary key,
    TENCLB nvarchar(100) not null,
    MASAN varchar(5) not null
)
```

- Dùng lệnh `alter` để thay đổi cấu trúc bảng `CAULACBO`. Cụ thể là một thêm một cột mới
có tên `MATINH` vào bảng `CAULACBO`.

```sql
alter table CAULACBO
add MATINH varchar(5) not null
```

- Dùng lệnh `drop` để xóa hoàn toàn bảng `CAULACBO` ra khỏi `CSDL`, nghĩa là toàn bộ
định nghĩa bảng và các dữ liệu bên trong đều bị xóa.


```sql
drop table CAULACBO
```

**Lưu ý: Lệnh drop khác với lệnh delete. Lệnh delete chỉ xóa các dòng dữ liệu có trong bảng**


