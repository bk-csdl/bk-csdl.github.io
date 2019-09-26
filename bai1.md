---
layout: default
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

### Lỗi: Saving changes is not permitted

![](/assets/course-materials/images/error1.png)

- Open SQL Server Management Studio
- From the file menu, choose **Tools -> Options**
- From the left menu, choose **Designers**
- Uncheck the box entitled **Prevent saving changes that require table re-creation**
- Press OK to save

![](/assets/course-materials/images/error1-solved.png)
