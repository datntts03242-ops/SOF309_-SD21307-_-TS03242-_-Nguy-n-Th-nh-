# Bộ ca kiểm thử SuMon
Nguyễn Thành Đạt · TS03242 · SD21307

Dữ liệu đăng ký hợp lệ dùng username mới, họ tên QA Đạt và mật khẩu Abc123!. Ca admin có session admin. Chuỗi CRUD dùng cùng bản ghi thử.

| ID | Chức năng | Tầng | Kỹ thuật | Bước | Dữ liệu | Mong đợi | Trạng thái |
|---|---|---|---|---|---|---|---|
| TC001 | Đăng ký | UI | Hợp lệ | Mở /register, điền và gửi | QA Đạt; qa03242_01; Abc123! | Chuyển /login, Users có bản ghi và password dạng BCrypt | Chưa chạy |
| TC002 | Đăng ký | Controller/UI | Trùng | Gửi username đã có | qa03242_01 | Báo Tài khoản đã tồn tại; không thêm | Chưa chạy |
| TC003 | Đăng ký | UI | Bắt buộc | Để trống fullname rồi gửi | fullname rỗng | Trình duyệt chặn gửi | Chưa chạy |
| TC004 | Đăng ký | UI | Bắt buộc | Để trống username rồi gửi | username rỗng | Trình duyệt chặn gửi | Chưa chạy |
| TC005 | Đăng ký | UI | Bắt buộc | Để trống password rồi gửi | password rỗng | Trình duyệt chặn gửi | Chưa chạy |
| TC006 | Đăng ký | UI | Biên | Gửi username mới với mật khẩu dài n | 5 ký tự | 5 bị HTML chặn; 6/7 đăng ký được khi DB hợp lệ | Chưa chạy |
| TC007 | Đăng ký | UI | Biên | Gửi username mới với mật khẩu dài n | 6 ký tự | 5 bị HTML chặn; 6/7 đăng ký được khi DB hợp lệ | Chưa chạy |
| TC008 | Đăng ký | UI | Biên | Gửi username mới với mật khẩu dài n | 7 ký tự | 5 bị HTML chặn; 6/7 đăng ký được khi DB hợp lệ | Chưa chạy |
| TC009 | Đăng ký | Controller | Bỏ qua HTML | POST mật khẩu 5 ký tự trực tiếp | username mới; password=Abc12 | Yêu cầu cần xác nhận: server nên áp min 6; mã hiện tại có thể chấp nhận. Ghi lỗi thực tế | Chưa chạy |
| TC010 | Đăng ký | Controller | Thiếu tham số | Bỏ password khỏi POST | Không có password | Cần phản hồi lỗi đầu vào; mã hiện tại có nguy cơ ngoại lệ BCrypt | Chưa chạy |
| TC011 | Đăng nhập | UI | Hợp lệ | Nhập tài khoản vừa tạo | username/password đúng, active=true | Chuyển /, session có user, ghi LOGIN | Chưa chạy |
| TC012 | Đăng nhập | UI | Sai | Nhập mật khẩu sai | User tồn tại | Báo Sai tài khoản hoặc mật khẩu | Chưa chạy |
| TC013 | Đăng nhập | UI | Không tồn tại | Nhập username mới | Username chưa có | Báo sai thông tin | Chưa chạy |
| TC014 | Đăng nhập | UI | Khóa | Đăng nhập tài khoản active=false | Mật khẩu đúng | Báo tài khoản đã bị khóa | Chưa chạy |
| TC015 | Phân quyền | UI | Tài khoản thường | Mở /admin/dynasties | Đã đăng nhập user thường | Chuyển trang chủ, không cho CRUD | Chưa chạy |
| TC016 | Thêm triều đại | UI | Hợp lệ | Admin gửi form thêm | QA-TS03242; QA; 1000; 1100; QA City; mô tả thử | Bản ghi mới xuất hiện và dữ liệu đúng | Chưa chạy |
| TC017 | Danh sách | UI | Đọc | Tải lại danh sách | Triều đại vừa thêm | Dữ liệu tồn tại, sắp theo StartYear | Chưa chạy |
| TC018 | Sửa | UI | Hợp lệ | Chọn sửa và lưu | Đổi tên thành QA-TS03242-B; năm kết thúc 1110 | Cùng ID cập nhật đúng | Chưa chạy |
| TC019 | Sửa | UI | Ảnh | Sửa bản ghi đã có ảnh, bỏ chọn ảnh mới | Không gửi file mới | Giữ ảnh cũ | Chưa chạy |
| TC020 | Thêm | Controller | Quan hệ biên | Gửi POST multipart hợp lệ | startYear=1099, endYear=1100 | Ghi hiện trạng; server chưa chặn đảo năm, cần xác nhận yêu cầu với giảng viên | Chưa chạy |
| TC021 | Thêm | Controller | Quan hệ biên | Gửi POST multipart hợp lệ | startYear=1100, endYear=1100 | Ghi hiện trạng; server chưa chặn đảo năm, cần xác nhận yêu cầu với giảng viên | Chưa chạy |
| TC022 | Thêm | Controller | Quan hệ biên | Gửi POST multipart hợp lệ | startYear=1101, endYear=1100 | Ghi hiện trạng; server chưa chặn đảo năm, cần xác nhận yêu cầu với giảng viên | Chưa chạy |
| TC023 | Thêm | Controller | Sai kiểu | POST startYear=abc | abc | Cần báo lỗi đầu vào; mã hiện tại có nguy cơ NumberFormatException | Chưa chạy |
| TC024 | Upload | Controller | Biên | Gửi multipart file thử; tổng request <20 MiB | 10485759 byte | Hai giá trị <=10 MiB qua giới hạn file; >10 MiB bị container từ chối; quan sát phản hồi lỗi | Chưa chạy |
| TC025 | Upload | Controller | Biên | Gửi multipart file thử; tổng request <20 MiB | 10485760 byte | Hai giá trị <=10 MiB qua giới hạn file; >10 MiB bị container từ chối; quan sát phản hồi lỗi | Chưa chạy |
| TC026 | Upload | Controller | Biên | Gửi multipart file thử; tổng request <20 MiB | 10485761 byte | Hai giá trị <=10 MiB qua giới hạn file; >10 MiB bị container từ chối; quan sát phản hồi lỗi | Chưa chạy |
| TC027 | Xóa | UI | Hợp lệ | Xóa đúng triều đại QA rồi tải lại | Bản ghi chưa có liên kết | Bản ghi mất khỏi danh sách và DB | Chưa chạy |
| TC028 | Xóa | Controller | ID sai | GET delete với id=abc | abc | Cần lỗi đầu vào thân thiện; có nguy cơ NumberFormatException | Chưa chạy |
