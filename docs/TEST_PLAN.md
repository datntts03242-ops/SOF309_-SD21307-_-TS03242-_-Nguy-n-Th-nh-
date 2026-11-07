# Kế hoạch kiểm thử
Nguyễn Thành Đạt · TS03242 · SD21307

Mục tiêu tuần 1 là web khởi động, tạo tài khoản, đăng nhập và CRUD triều đại. Dùng Eclipse, JDK 21, Tomcat 11, SQL Server với database SuMonDB hiện có hoặc bản backup đầy đủ của tác giả. Script sql/chat_moderation_migration.sql chỉ bổ sung cột chat, cần các bảng chat có sẵn.

Chuẩn bị một tài khoản admin đang hoạt động có mật khẩu BCrypt hợp lệ; một tài khoản thường và một tài khoản khóa. Không có tài khoản admin mẫu được xác minh trong ZIP. Dùng username mới cho từng lần đăng ký, một triều đại QA-TS03242 chưa liên kết để thử CRUD.

Thiết kế ca cho Controller và UI theo phân vùng hợp lệ/rỗng/trùng/sai quyền và biên mật khẩu 5/6/7, năm bằng nhau hoặc đảo thứ tự, kích thước ảnh quanh 10 MiB. Ca server dùng POST multipart hoặc công cụ HTTP có session phù hợp. Kiểm tra lại bằng tải trang và truy vấn DB, vì DAO có thể bỏ qua lỗi.

Y1 chỉ xác nhận khi chạy thật thành công đăng ký, đăng nhập và CRUD. Ghi kết quả thực tế, dữ liệu đã dùng và log/ảnh cho lỗi. Các ca trong bản này đều Chưa chạy. Chưa có môi trường Java 21/Tomcat/SQL Server để thực thi. Chat AI, quiz, bình luận và các chức năng khác ngoài phạm vi tuần 1.
