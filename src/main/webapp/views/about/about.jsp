<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>

<%
request.setAttribute("activePage", "");
%>

<!DOCTYPE html>
<html lang="vi">

<head>
<meta charset="UTF-8">
<title>Giới thiệu | Sử Môn</title>

<!-- Load Bootstrap + CSS chung -->
<jsp:include page="/common/head-resources.jsp"/>

</head>

<body style="background:#f5f6fa; padding-top:90px;">

<!-- Header -->
<jsp:include page="/common/header.jsp"/>

<div class="container py-5">

    <!-- Logo -->
    <div class="text-center mb-5">

        <img src="${pageContext.request.contextPath}/assets/images/logo-su-mon.png"
             width="120"
             class="mb-3">

        <h1 class="fw-bold">
            Sử Môn
        </h1>

        <p class="text-muted fs-5">
            Khai Mở Lịch Sử Việt Nam
        </p>

    </div>

    <!-- Card -->
    <div class="card shadow-lg rounded-4 border-0">

        <div class="card-body p-5">

            <h2 class="text-center fw-bold mb-3">
                Chào mừng đến với Sử Môn
            </h2>

            <p class="text-center text-muted fs-5 mb-5">
                Nền tảng lưu trữ và chia sẻ tri thức lịch sử Việt Nam dành cho mọi người.
            </p>

            <hr>

            <h3 class="text-danger mb-3">
                📖 Giới thiệu
            </h3>

            <p class="fs-5" style="text-align:justify;line-height:1.9;">

                <strong>Sử Môn</strong> được xây dựng với mong muốn trở thành một nền tảng
                giúp mọi người tiếp cận lịch sử Việt Nam theo cách trực quan,
                sinh động và hiện đại hơn.

                <br><br>

                Thay vì chỉ học lịch sử thông qua sách giáo khoa hay những tài liệu
                dài và khô khan, người dùng có thể khám phá thông tin thông qua hệ
                thống nhân vật lịch sử, các triều đại, dòng thời gian và những sự kiện
                tiêu biểu được trình bày trực quan ngay trên website.

                <br><br>

                Không chỉ dừng lại ở việc cung cấp kiến thức, Sử Môn còn tạo nên
                một môi trường để cộng đồng cùng đóng góp tư liệu lịch sử.
                Mọi thông tin do người dùng gửi lên đều được quản trị viên kiểm duyệt
                trước khi công bố nhằm đảm bảo tính chính xác và độ tin cậy.

                <br><br>

                Chúng tôi hy vọng website sẽ góp phần lan tỏa niềm yêu thích lịch sử,
                giúp việc học tập trở nên thú vị hơn, đồng thời góp phần gìn giữ và
                phát huy những giá trị truyền thống của dân tộc Việt Nam trong thời đại số.

            </p>

            <hr>

            <h3 class="text-danger mb-3">
                🎯 Sứ mệnh
            </h3>

            <p class="fs-5" style="text-align:justify;line-height:1.8;">

                Xây dựng một kho tư liệu lịch sử Việt Nam đầy đủ, dễ tra cứu và
                luôn được cập nhật. Sử Môn không chỉ là nơi học tập mà còn là cầu
                nối giúp cộng đồng cùng nhau lưu giữ và lan tỏa những giá trị lịch sử
                đến với các thế hệ mai sau.

            </p>

            <hr>

            <h3 class="text-danger mb-3">
                🎯 Mục đích
            </h3>

            <ul class="fs-5">

                <li>Tra cứu thông tin nhân vật lịch sử Việt Nam.</li>

                <li>Tìm hiểu các triều đại qua từng thời kỳ.</li>

                <li>Khám phá dòng thời gian lịch sử.</li>

                <li>Học tập thông qua hệ thống Quiz lịch sử.</li>

                <li>Lưu danh sách nhân vật yêu thích.</li>

                <li>Cho phép người dùng đóng góp tư liệu và chờ quản trị viên kiểm duyệt trước khi công bố.</li>

            </ul>

            <hr>

            <h3 class="text-danger mb-3">
                💻 Công nghệ sử dụng
            </h3>

            <div class="d-flex flex-wrap gap-2 mb-4">

                <span class="badge bg-primary p-2">Java Servlet</span>

                <span class="badge bg-success p-2">JSP</span>

                <span class="badge bg-danger p-2">SQL Server</span>

                <span class="badge bg-warning text-dark p-2">Hibernate</span>

                <span class="badge bg-secondary p-2">Bootstrap</span>

                <span class="badge bg-dark p-2">Maven</span>

            </div>

            <hr>

            <div class="text-center">

                <a href="${pageContext.request.contextPath}/home"
                   class="btn btn-warning btn-lg px-5">

                    🏠 Quay về Trang chủ

                </a>

            </div>

        </div>

    </div>

    <div class="text-center text-muted mt-4 mb-3">

        © 2026 Sử Môn - Website Quản Lý Kho Tư Liệu Lịch Sử Việt Nam

    </div>

</div>

<jsp:include page="/common/footer.jsp"/>

</body>
</html>