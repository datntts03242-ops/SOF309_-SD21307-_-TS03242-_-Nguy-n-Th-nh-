# Đặc tả SuMon
Nguyễn Thành Đạt · TS03242 · SD21307

## Môi trường
Java 21, Jakarta Servlet 6.1/JSP 4, Tomcat 11, SQL Server và JDBC. pom.xml có Hibernate nhưng các DAO được kiểm tra sử dụng JDBC.
URL dự kiến http://localhost:8080/SuMon; xác nhận context trong Eclipse.
DBContext dùng localhost:1433, SuMonDB, tài khoản sa. Mật khẩu lấy từ biến môi trường SUMON_DB_PASSWORD, mặc định rỗng.

## Chức năng tuần 1
| Luồng | URL | Trường và hành vi |
|---|---|---|
| Đăng ký | /register | fullname, username, password. Form bắt buộc cả ba và minlength mật khẩu 6. Server kiểm tra username trùng; hash BCrypt trước khi INSERT Users; thành công chuyển /login. Form không có xác nhận mật khẩu. |
| Đăng nhập | /login | username, password. Kiểm tra tài khoản tồn tại, active=true và BCrypt. Sai hiện thông báo, tài khoản khóa hiện lỗi khóa. Thành công lưu session, ghi ActivityLog và chuyển trang chủ /. |
| Danh sách triều đại | /admin/dynasties | Chỉ admin theo AdminFilter và SessionUtil. Danh sách sắp theo StartYear tăng dần. |
| Thêm | POST /admin/dynasties | Multipart, action=insert, name, founder, startYear, endYear, capital, description, image. Form bắt buộc tên/người sáng lập/năm bắt đầu/năm kết thúc/kinh đô. Hai năm parseInt. Ảnh tùy chọn. |
| Sửa | GET action=edit&id=...; POST action=update | Cập nhật theo id. Ô name/founder/capital/description rỗng được thay bằng giá trị cũ; không chọn ảnh mới thì giữ ảnh cũ. |
| Xóa | GET /admin/dynasties?action=delete&id=... | Xóa vật lý theo ID. Nên thử trên bản ghi mới chưa có liên kết. Khóa ngoại thực tế phụ thuộc database đang dùng. |

## Giới hạn và điểm cần kiểm tra
Controller đăng ký chưa kiểm tra độ dài mật khẩu ở server. Độ dài 5/6/7 là biên quy tắc HTML. Chưa xác minh độ dài các cột SQL vì ZIP thiếu script tạo database đầy đủ.
Controller triều đại chưa chặn startYear > endYear. Kiểm tra bằng phân vùng năm trước/bằng/sau, ghi là khảo sát yêu cầu nghiệp vụ.
Giới hạn upload trong annotation: một file 10 MiB, tổng request 20 MiB.
DAO có nhánh bắt lỗi rồi in stack trace; phải xác minh dữ liệu sau chuyển trang.
Các bảng tối thiểu cho luồng này gồm Users, ActivityLog, Dynasties. UserDAO đọc cả warning_count và banned_at. Chạy trang chủ có thể cần các bảng khác.
