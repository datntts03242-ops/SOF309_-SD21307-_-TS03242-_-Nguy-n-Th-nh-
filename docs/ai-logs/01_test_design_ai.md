# Nhật ký thiết kế với AI
Nguyễn Thành Đạt · TS03242 · SD21307

Yêu cầu thực tế: dùng SuMon (1).zip để chuẩn bị bài tuần 1 và file CMD đăng lên repo cá nhân đã cung cấp.
Ngữ cảnh đã đọc: pom.xml, RegisterServlet, LoginServlet, UserDAO, DBContext, AdminDynastyController, DynastyDAO, LoginFilter, AdminFilter, SessionUtil, form đăng ký và form triều đại.

Prompt có thể tái sử dụng: Bạn là QA Lead. Dùng SPECIFICATIONS.md của SuMon làm ngữ cảnh để thiết kế Test Plan và ca Controller/UI theo phân vùng tương đương và giá trị biên. Tách quy tắc đang có với yêu cầu cần xác nhận. Chưa chạy ca thì ghi Chưa chạy.

Kết quả: bộ đặc tả, kế hoạch, test cases; gộp JUnit/Selenium vào Maven. Đối chiếu đăng nhập username, BCrypt, min 6 trên HTML và giới hạn upload 10 MiB. Phát hiện thiếu script tạo database đầy đủ, ghi rõ cần SuMonDB sẵn có.
Chuyển mật khẩu SQL hardcode sang biến môi trường SUMON_DB_PASSWORD để bản đưa lên repo dùng cấu hình riêng trên máy.
Sinh viên cần chạy lại, ghi kết quả thật và bổ sung minh chứng theo quá trình của mình.
