<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Dashboard – Admin Sử Môn</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/css/bootstrap.min.css" rel="stylesheet">
  <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css" rel="stylesheet">
  <link href="${pageContext.request.contextPath}/assets/css/admin.css" rel="stylesheet">
  
  <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
</head>
<body>
<div class="admin-wrapper">

  <jsp:include page="layout/sidebar.jsp"/>

  <div class="main-content" id="mainContent">
    <jsp:include page="layout/header.jsp"/>

    <div class="content">

      <!-- STAT CARDS -->
      <div class="row g-3 mb-4">
        <div class="col-lg-3 col-md-6">
          <div class="dashboard-card">
            <div><h6>Nhân vật</h6><h2>${characterCount}</h2></div>
            <i class="fa-solid fa-users"></i>
          </div>
        </div>
        <div class="col-lg-3 col-md-6">
          <div class="dashboard-card">
            <div><h6>Triều đại</h6><h2>${dynastyCount}</h2></div>
            <i class="fa-solid fa-landmark"></i>
          </div>
        </div>
        <div class="col-lg-3 col-md-6">
          <div class="dashboard-card">
            <div><h6>Người dùng</h6><h2>${userCount}</h2></div>
            <i class="fa-solid fa-user"></i>
          </div>
        </div>
        <div class="col-lg-3 col-md-6">
          <div class="dashboard-card">
            <div><h6>Bình luận</h6><h2>${commentCount}</h2></div>
            <i class="fa-solid fa-comment"></i>
          </div>
        </div>
        <c:if test="${pendingSubmissions > 0}">
        <div class="col-12">
          <a href="${pageContext.request.contextPath}/admin/submissions"
             style="text-decoration:none;">
            <div class="dashboard-card" style="background:#fffbeb;border:1.5px solid #fcd34d;">
              <div>
                <h6 style="color:#92400e;">Đóng góp chờ duyệt</h6>
                <h2 style="color:#d97706;">${pendingSubmissions}</h2>
              </div>
              <i class="fa-solid fa-paper-plane" style="color:#d97706;"></i>
            </div>
          </a>
        </div>
        </c:if>
      </div>

      <!-- CHART + LATEST -->
      <div class="row g-3 mb-4">
        <div class="col-lg-7">
          <div class="top-card">
            <h5 class="fw-bold mb-3"><i class="fa-solid fa-chart-pie me-2" style="color:var(--adm-blue);"></i>Nhân vật theo triều đại</h5>
            <div style="height:320px;"><canvas id="dynastyChart"></canvas></div>
          </div>
        </div>
        <div class="col-lg-5">
          <div class="top-card h-100">
            <h5 class="fw-bold mb-3"><i class="fa-solid fa-star me-2" style="color:var(--adm-gold);"></i>Nhân vật mới nhất</h5>
            <div class="d-flex flex-column gap-2">
              <c:forEach items="${latestCharacters}" var="c">
                <div class="d-flex align-items-center gap-3 p-2 rounded" style="background:#F9FAFB;border:1px solid #E5E7EB;">
                  <img src="${pageContext.request.contextPath}/assets/images/characters/${c.image}"
                       style="width:44px;height:44px;object-fit:cover;border-radius:8px;border:1px solid #E5E7EB;"
                       onerror="this.src='${pageContext.request.contextPath}/assets/images/no-image.png'">
                  <div>
                    <div style="font-weight:600;font-size:.875rem;">${c.name}</div>
                    <div style="font-size:.75rem;color:#6B7280;">${c.dynasty}</div>
                  </div>
                </div>
              </c:forEach>
            </div>
          </div>
        </div>
      </div>

      <!-- ACTIVITY LOG -->
      <div class="table-card">
        <h5 class="fw-bold mb-3"><i class="fa-solid fa-clock-rotate-left me-2" style="color:var(--adm-blue);"></i>Hoạt động gần đây</h5>
        <table class="table table-hover align-middle">
          <thead>
            <tr>
              <th>Người dùng</th>
              <th>Hành động</th>
              <th>Đối tượng</th>
              <th>Thời gian</th>
            </tr>
          </thead>
          <tbody>
            <c:forEach items="${activities}" var="a">
              <tr>
                <td><span class="fw-semibold">${a.username}</span></td>
                <td><span class="badge" style="background:rgba(30,58,138,.1);color:var(--adm-blue);font-weight:600;">${a.action}</span></td>
                <td style="color:#6B7280;">${a.target}</td>
                <td style="font-size:.8rem;color:#9CA3AF;">${a.createdAt}</td>
              </tr>
            </c:forEach>
          </tbody>
        </table>
      </div>

    </div><!-- /content -->
    <jsp:include page="layout/footer.jsp"/>
  </div><!-- /main-content -->
</div><!-- /admin-wrapper -->

<script>
const labels = [], values = [];
<c:forEach items="${dynastyChart}" var="d">
  labels.push('<c:out value="${d.dynasty}" escapeXml="false"/>'.replace(/'/g,"\'"));
  values.push(${d.total});
</c:forEach>

new Chart(document.getElementById("dynastyChart"), {
  type: "doughnut",
  data: {
    labels,
    datasets: [{
      data: values,
      backgroundColor: ["#1e3a8a","#16a34a","#dc2626","#d4a017","#9333ea","#06b6d4","#ec4899","#84cc16","#6366f1","#f97316"],
      borderWidth: 2, hoverOffset: 12
    }]
  },
  options: {
    responsive: true, maintainAspectRatio: false, cutout: "58%",
    plugins: {
      legend: { position: "right", labels: { boxWidth: 14, padding: 14, font: { size: 12 } } }
    }
  }
});
</script>
</body>
</html>



