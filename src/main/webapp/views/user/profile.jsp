<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%
    entity.User u = (entity.User) session.getAttribute("user");
    if (u == null) { response.sendRedirect(request.getContextPath() + "/login"); return; }
    request.setAttribute("activePage","profile");
    String cp = request.getContextPath();
    String avatarSrc = (u.getAvatar() != null && !u.getAvatar().isEmpty())
        ? cp + "/uploads/" + u.getAvatar()
        : cp + "/assets/images/default-avatar.png";
    String roleName = (u.getRole() == null || u.getRole().isEmpty()) ? "USER" : u.getRole().toUpperCase();
%>
<!DOCTYPE html>
<html lang="vi">
<head>
  <title>Hồ sơ – Sử Môn</title>
  <jsp:include page="/common/head-resources.jsp"/>
  <style>
    /* === HERO === */
    .profile-hero {
      background: linear-gradient(135deg, #0F172A 0%, #1a0a0a 100%);
      padding: 3.5rem 1rem 2.5rem;
      text-align: center;
      position: relative;
      overflow: hidden;
    }
    .profile-hero::before {
      content: ''; position: absolute;
      top: -80px; right: -80px; width: 280px; height: 280px;
      background: radial-gradient(circle, rgba(212,160,23,.12), transparent 70%);
      pointer-events: none;
    }

    /* === AVATAR === */
    .profile-avatar-wrap {
      position: relative; display: inline-block; cursor: pointer;
      margin-bottom: 1.25rem;
    }
    .profile-avatar {
      width: 120px; height: 120px; border-radius: 50%;
      object-fit: cover; object-position: top;
      border: 4px solid #D4A017;
      box-shadow: 0 8px 32px rgba(0,0,0,.4);
      transition: .3s; display: block;
    }
    .profile-avatar-wrap:hover .profile-avatar { transform: scale(1.06); }
    .avatar-overlay {
      position: absolute; inset: 4px; border-radius: 50%;
      background: rgba(0,0,0,.55);
      opacity: 0; transition: opacity .3s;
      display: flex; align-items: center; justify-content: center;
      color: #fff; font-size: .78rem; font-weight: 600;
    }
    .profile-avatar-wrap:hover .avatar-overlay { opacity: 1; }

    /* === TEXT TRÊN HERO (dark bg) === */
    .profile-name {
      font-family: 'Cormorant Garamond', Georgia, serif;
      font-size: 2rem; font-weight: 700;
      color: #ffffff; margin: 0 0 .25rem;
    }
    .profile-uname {
      color: rgba(255,255,255,.55); font-size: .88rem; margin-bottom: .5rem;
    }
    .profile-role-badge {
      display: inline-block; padding: .3rem .9rem; border-radius: 999px;
      background: rgba(212,160,23,.18); color: #D4A017;
      font-size: .72rem; font-weight: 700;
      letter-spacing: .1em; text-transform: uppercase;
    }

    /* === INFO CARD === */
    .info-card {
      background: #fff; border-radius: 16px;
      border: 1px solid #E2E8F0; padding: 1.75rem;
      box-shadow: 0 4px 20px rgba(15,23,42,.07);
    }
    .info-card h5 { color: #0F172A; font-weight: 700; margin-bottom: 1rem; }
    .info-row {
      display: flex; justify-content: space-between; align-items: center;
      padding: .8rem 0; border-bottom: 1px solid #E2E8F0;
    }
    .info-row:last-child { border-bottom: none; }
    .info-label { font-weight: 600; color: #64748B; font-size: .875rem; }
    .info-value { color: #0F172A; font-weight: 500; font-size: .9rem; }

    /* === ACTION BUTTONS === */
    .action-btn {
      display: flex; align-items: center; justify-content: center; gap: .5rem;
      padding: .75rem 1.25rem; border-radius: 10px; font-weight: 600;
      font-size: .875rem; text-decoration: none; transition: .3s;
      border: 1.5px solid #E2E8F0; color: #0F172A; background: #fff;
    }
    .action-btn:hover { border-color: #D4A017; color: #D4A017; background: rgba(212,160,23,.05); }
    .action-btn.danger { background: #dc3545; color: #fff; border-color: #dc3545; }
    .action-btn.danger:hover { background: #b91c1c; border-color: #b91c1c; color: #fff; }
  </style>
</head>
<body class="bg-light-page">
<jsp:include page="/common/header.jsp"/>

<!-- HERO -->
<div class="profile-hero">
  <form id="avatarForm"
        action="${pageContext.request.contextPath}/profile"
        method="post" enctype="multipart/form-data">
    <input type="file" id="avatarInput" name="avatar" accept="image/*" hidden>
    <div class="profile-avatar-wrap"
         onclick="document.getElementById('avatarInput').click();"
         title="Nhấn để đổi ảnh đại diện">
      <img id="avatarPreview" class="profile-avatar"
           src="<%= avatarSrc %>" alt="Avatar">
      <div class="avatar-overlay">📷 Đổi ảnh</div>
    </div>
  </form>

  <h1 class="profile-name"><%= u.getFullname() != null ? u.getFullname() : u.getUsername() %></h1>
  <p class="profile-uname">@<%= u.getUsername() %></p>
  <span class="profile-role-badge"><%= roleName %></span>
</div>

<!-- INFO -->
<div class="container py-4" style="max-width:580px;">

  <div class="info-card mb-3">
    <h5>📋 Thông tin tài khoản</h5>
    <div class="info-row">
      <span class="info-label">ID</span>
      <span class="info-value">#<%= u.getId() %></span>
    </div>
    <div class="info-row">
      <span class="info-label">Họ tên</span>
      <span class="info-value"><%= u.getFullname() != null ? u.getFullname() : "—" %></span>
    </div>
    <div class="info-row">
      <span class="info-label">Tài khoản</span>
      <span class="info-value"><%= u.getUsername() %></span>
    </div>
    <div class="info-row">
      <span class="info-label">Vai trò</span>
      <span class="info-value"><%= roleName %></span>
    </div>
    <div class="info-row">
      <span class="info-label">Trạng thái</span>
      <span class="info-value" style="color:<%= u.getActive() ? "#16a34a" : "#dc3545" %>;">
        <%= u.getActive() ? "✅ Hoạt động" : "🔒 Đã khóa" %>
      </span>
    </div>
  </div>

  <div class="d-grid gap-2">
    <a href="${pageContext.request.contextPath}/favorites" class="action-btn">❤️ Nhân vật yêu thích</a>
    <a href="${pageContext.request.contextPath}/library"   class="action-btn">📚 Lịch sử xem</a>
    <a href="${pageContext.request.contextPath}/"          class="action-btn">← Quay lại trang chủ</a>
    <a href="${pageContext.request.contextPath}/logout"    class="action-btn danger">🚪 Đăng xuất</a>
  </div>

</div>

<jsp:include page="/common/footer.jsp"/>
<script>
document.getElementById('avatarInput').addEventListener('change', function() {
  if (!this.files.length) return;
  const reader = new FileReader();
  reader.onload = e => document.getElementById('avatarPreview').src = e.target.result;
  reader.readAsDataURL(this.files[0]);
  // Đợi preview xong rồi submit
  setTimeout(() => document.getElementById('avatarForm').submit(), 400);
});
</script>
</body>
</html>
