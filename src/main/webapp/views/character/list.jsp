<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<% request.setAttribute("activePage","characters"); %>
<!DOCTYPE html>
<html lang="vi">
<head>
  <title>Nhân Vật Lịch Sử – Sử Môn</title>
  <jsp:include page="/common/head-resources.jsp"/>
  <style>
    .contrib-card { border-radius: 16px; border: 1.5px dashed var(--c-border); background: var(--c-surface); padding: 1.75rem; margin-bottom: 1.75rem; }
    .contrib-card .card-header-custom { background: linear-gradient(90deg, var(--c-red), #8b0000); color: #fff; border-radius: 10px; padding: .7rem 1.1rem; margin-bottom: 1.25rem; font-weight: 700; }
    .contrib-toggle { border: 1.5px solid rgba(212,160,23,.4); background: rgba(212,160,23,.08); color: var(--c-gold); font-weight: 600; font-size: .875rem; border-radius: 8px; padding: .55rem 1.1rem; cursor: pointer; transition: var(--t-base); }
    .contrib-toggle:hover { background: rgba(212,160,23,.18); }
    /* fix p màu trong card */
    .character-card .card-body p { color: #475569; }
    .character-card .card-body h5 { color: #0F172A; }
  </style>
</head>
<body class="bg-light-page">
<jsp:include page="/common/header.jsp"/>

<!-- PAGE HERO -->
<div class="page-hero-banner">
  <span style="font-size:.72rem;font-weight:600;letter-spacing:.28em;text-transform:uppercase;color:#D4A017;display:block;margin-bottom:.75rem;">Khám phá</span>
  <h1>Nhân Vật Lịch Sử Việt Nam</h1>
  <p>Những anh hùng, danh nhân đã định hình dân tộc qua mỗi thời kỳ</p>
</div>

<div class="container py-4">

  <!-- TOOLBAR -->
  <div class="d-flex justify-content-between align-items-center mb-3 flex-wrap gap-2">
    <p class="mb-0" style="font-size:.875rem;color:var(--c-muted);">
      <c:if test="${not empty keyword or not empty dynasty}">Kết quả tìm kiếm</c:if>
      <c:if test="${empty keyword and empty dynasty}">Tất cả nhân vật</c:if>
    </p>
    <c:if test="${sessionScope.user != null}">
      <a href="${pageContext.request.contextPath}/submit-character" class="contrib-toggle">
        ➕ Đóng góp nhân vật
      </a>
    </c:if>
  </div>

  <!-- SEARCH BAR -->
  <div class="search-bar">
    <form class="row g-2 align-items-end" method="get" action="${pageContext.request.contextPath}/characters">
      <div class="col-md-5">
        <label class="form-label fw-semibold mb-1" style="font-size:.8rem;">Tìm kiếm</label>
        <input type="text" name="keyword" value="${keyword}" class="form-control" placeholder="🔍 Tên nhân vật...">
      </div>
      <div class="col-md-4">
        <label class="form-label fw-semibold mb-1" style="font-size:.8rem;">Triều đại</label>
        <select name="dynasty" class="form-select">
          <option value="">-- Tất cả triều đại --</option>
          <c:set var="dynasties" value="Văn Lang,Âu Lạc,Bắc thuộc,Vạn Xuân,Tự chủ,Ngô,Đinh,Nhà Lý,Nhà Trần,Hậu Lê,Tây Sơn,Nhà Nguyễn"/>
          <c:forTokens items="${dynasties}" delims="," var="d">
            <option value="${d}" ${dynasty == d ? 'selected' : ''}>${d}</option>
          </c:forTokens>
        </select>
      </div>
      <div class="col-md-3">
        <button class="btn-su-primary w-100" type="submit">Tìm kiếm</button>
      </div>
    </form>
  </div>

  <!-- CHARACTER GRID -->
  <div class="row g-4">
    <c:forEach items="${characters}" var="c">
      <div class="col-md-4 col-sm-6 d-flex">
        <div class="character-card w-100">

          <div class="card-img-wrapper">
            <img class="character-img"
                 src="${pageContext.request.contextPath}/assets/images/characters/${c.image}"
                 alt="${c.name}"
                 onerror="this.style.background='linear-gradient(135deg,#1e293b,#0f172a)';this.src='data:image/gif;base64,R0lGODlhAQABAIAAAAAAAP///yH5BAEAAAAALAAAAAABAAEAAAIBRAA7'">
          </div>

          <div class="card-body">
            <p class="text-muted mb-1">${c.dynasty}</p>
            <h5 class="mb-2">${c.name}</h5>
            <p class="mb-3">${c.description}</p>

            <!-- RATING -->
            <div class="mb-2" style="font-size:.88rem;">
              <c:forEach begin="1" end="5" var="i">
                <span style="color:${i <= c.avgRating ? '#FBBF24' : '#ddd'};">★</span>
              </c:forEach>
              <span style="font-size:.78rem;color:var(--c-muted);margin-left:4px;">${c.avgRating}</span>
            </div>

            <!-- FAVORITE -->
            <c:set var="isFav" value="false"/>
            <c:forEach items="${favIds}" var="fid">
              <c:if test="${fid == c.id}"><c:set var="isFav" value="true"/></c:if>
            </c:forEach>
            <div class="mb-3">
              <span class="fav-icon ${isFav ? 'active' : ''}" data-id="${c.id}" data-user="${sessionScope.user != null ? sessionScope.user.id : 0}" title="Yêu thích">♥</span>
            </div>

            <a href="${pageContext.request.contextPath}/characters?id=${c.id}" class="btn-su-primary w-100 justify-content-center" style="border-radius:8px;">Xem chi tiết →</a>
          </div>
        </div>
      </div>
    </c:forEach>

    <c:if test="${empty characters}">
      <div class="col-12 text-center py-5">
        <div style="font-size:3rem;margin-bottom:1rem;">🔍</div>
        <h5 style="color:var(--c-muted);">Không tìm thấy nhân vật nào</h5>
        <a href="${pageContext.request.contextPath}/characters" class="btn-su-outline mt-3">Xem tất cả</a>
      </div>
    </c:if>
  </div>

  <!-- PAGINATION -->
  <nav class="mt-5">
    <ul class="pagination justify-content-center">
      <li class="page-item ${currentPage == 1 ? 'disabled' : ''}">
        <a class="page-link" href="?page=${currentPage-1}&keyword=${keyword}&dynasty=${dynasty}">← Trước</a>
      </li>
      <c:forEach begin="1" end="${totalPages}" var="i">
        <li class="page-item ${currentPage == i ? 'active' : ''}">
          <a class="page-link" href="?page=${i}&keyword=${keyword}&dynasty=${dynasty}">${i}</a>
        </li>
      </c:forEach>
      <li class="page-item ${currentPage == totalPages ? 'disabled' : ''}">
        <a class="page-link" href="?page=${currentPage+1}&keyword=${keyword}&dynasty=${dynasty}">Sau →</a>
      </li>
    </ul>
  </nav>

</div><!-- /container -->
<jsp:include page="/common/footer.jsp"/>

<%-- Toast notification --%>
<c:if test="${not empty sessionScope.toast}">
<div id="toastMsg" style="
  position:fixed;bottom:90px;right:24px;z-index:9999;
  background:#0F172A;color:#fff;padding:.85rem 1.25rem;
  border-radius:12px;font-size:.875rem;font-weight:500;
  box-shadow:0 8px 32px rgba(0,0,0,.25);
  display:flex;align-items:center;gap:.6rem;
  animation:slideIn .3s ease;">
  ${sessionScope.toast}
</div>
<style>@keyframes slideIn{from{opacity:0;transform:translateY(20px)}to{opacity:1;transform:translateY(0)}}</style>
<script>
  setTimeout(() => {
    const t = document.getElementById('toastMsg');
    if(t) t.style.opacity='0', t.style.transition='opacity .4s', setTimeout(()=>t.remove(),400);
  }, 3500);
</script>
<% session.removeAttribute("toast"); %>
</c:if>

<script>
document.querySelectorAll('.fav-icon').forEach(icon => {
  icon.addEventListener('click', function() {
    const cid = this.dataset.id, uid = this.dataset.user;
    if (uid == 0) { alert('Bạn cần đăng nhập!'); return; }
    this.classList.add('loading');
    fetch('${pageContext.request.contextPath}/favorite', {
      method: 'POST',
      headers: {'Content-Type': 'application/x-www-form-urlencoded'},
      body: 'uid=' + uid + '&cid=' + cid
    }).then(r => r.json()).then(d => {
      this.classList.remove('loading');
      this.classList.toggle('active', d.favorite);
    }).catch(() => this.classList.remove('loading'));
  });
});
</script>
</body>
</html>
