<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<% request.setAttribute("activePage","timeline"); %>
<!DOCTYPE html>
<html lang="vi">
<head>
<title>Dòng Thời Gian – Sử Môn</title>
<jsp:include page="/common/head-resources.jsp"/>
<style>
body { background: var(--c-bg); }</style>
</head>
<body class="bg-light-page">
<jsp:include page="/common/header.jsp"/>

<!-- HERO -->
<section class="timeline-hero">
  <div class="container">
    <span style="font-size:.72rem;font-weight:600;letter-spacing:.28em;text-transform:uppercase;color:var(--c-gold);display:block;margin-bottom:.75rem;">Lịch sử dân tộc</span>
    <h1>4000 Năm Lịch Sử Việt Nam</h1>
    <p>Hành trình hình thành và phát triển của dân tộc Việt Nam qua các thời kỳ</p>
  </div>
</section>

<!-- TIMELINE -->
<section class="container my-5">
  <div class="timeline">

    <div class="timeline-item">
      <div class="timeline-dot"></div>
      <div class="timeline-content">
        <h4>2879 TCN – 179 TCN</h4>
        <h5>Thời kỳ dựng nước</h5>
        <p>Hùng Vương lập nước Văn Lang · Văn minh lúa nước hình thành · An Dương Vương lập Âu Lạc, xây thành Cổ Loa</p>
      </div>
    </div>

    <div class="timeline-item">
      <div class="timeline-dot"></div>
      <div class="timeline-content">
        <h4>179 TCN – 938</h4>
        <h5>Thời kỳ Bắc thuộc</h5>
        <p>Hơn 1000 năm Bắc thuộc · Hai Bà Trưng (40) · Bà Triệu (248) · Lý Bí lập Vạn Xuân (542) · Khúc Thừa Dụ giành tự chủ (905)</p>
      </div>
    </div>

    <div class="timeline-item">
      <div class="timeline-dot"></div>
      <div class="timeline-content">
        <h4>938 – 1858</h4>
        <h5>Thời kỳ phong kiến độc lập</h5>
        <p>938: Ngô Quyền — Bạch Đằng · 1010: Dời đô Thăng Long · 1075-1077: Lý Thường Kiệt · 1258-1288: Ba lần chống Nguyên Mông · 1428: Lê Lợi lập Hậu Lê · 1789: Quang Trung đại phá quân Thanh · 1802: Nhà Nguyễn thống nhất</p>
      </div>
    </div>

    <div class="timeline-item">
      <div class="timeline-dot"></div>
      <div class="timeline-content">
        <h4>1858 – 1945</h4>
        <h5>Thời kỳ Pháp thuộc</h5>
        <p>1858: Pháp xâm lược · 1884: Thuộc địa hóa · Phong trào Cần Vương, Đông Du · 1930: Thành lập Đảng Cộng sản Việt Nam · 1945: Cách mạng Tháng Tám thắng lợi</p>
      </div>
    </div>

    <div class="timeline-item">
      <div class="timeline-dot"></div>
      <div class="timeline-content">
        <h4>1945 – 1975</h4>
        <h5>Kháng chiến chống ngoại xâm</h5>
        <p>02/09/1945: Tuyên ngôn Độc lập · 1946-1954: Kháng chiến chống Pháp · 07/05/1954: Điện Biên Phủ · 1955-1975: Kháng chiến chống Mỹ · 30/04/1975: Thống nhất đất nước</p>
      </div>
    </div>

    <div class="timeline-item">
      <div class="timeline-dot"></div>
      <div class="timeline-content">
        <h4>1975 – Nay</h4>
        <h5>Thời kỳ Đổi mới &amp; Hội nhập</h5>
        <p>1976: Thành lập nước CHXHCN Việt Nam · 1986: Đổi mới kinh tế · 2007: Gia nhập WTO · Hiện đại hóa và hội nhập quốc tế sâu rộng</p>
      </div>
    </div>

  </div>
</section>

<!-- MILESTONES -->
<section class="container mb-5">
  <h2 class="text-center fw-bold mb-4" style="font-family:var(--f-display);color:var(--c-primary);">Các Mốc Quan Trọng Nhất</h2>
  <div class="row g-3">
    <div class="col-6 col-md-4 col-lg-3"><div class="stat-card">Văn Lang ra đời</div></div>
    <div class="col-6 col-md-4 col-lg-3"><div class="stat-card">Cổ Loa – Âu Lạc</div></div>
    <div class="col-6 col-md-4 col-lg-3"><div class="stat-card">Hai Bà Trưng 40</div></div>
    <div class="col-6 col-md-4 col-lg-3"><div class="stat-card">Bạch Đằng 938</div></div>
    <div class="col-6 col-md-4 col-lg-3"><div class="stat-card">Thăng Long 1010</div></div>
    <div class="col-6 col-md-4 col-lg-3"><div class="stat-card">3 lần chống Nguyên Mông</div></div>
    <div class="col-6 col-md-4 col-lg-3"><div class="stat-card">Lam Sơn khởi nghĩa</div></div>
    <div class="col-6 col-md-4 col-lg-3"><div class="stat-card">Quang Trung 1789</div></div>
    <div class="col-6 col-md-4 col-lg-3"><div class="stat-card">Cách mạng 1945</div></div>
    <div class="col-6 col-md-4 col-lg-3"><div class="stat-card">Điện Biên Phủ 1954</div></div>
    <div class="col-6 col-md-4 col-lg-3"><div class="stat-card">Thống nhất 1975</div></div>
    <div class="col-6 col-md-4 col-lg-3"><div class="stat-card">Đổi mới 1986</div></div>
  </div>
</section>

<jsp:include page="/common/footer.jsp"/>
</body>
</html>
