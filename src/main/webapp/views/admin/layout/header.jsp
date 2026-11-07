<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div class="header">
  <button class="menu-btn" onclick="toggleSidebar()" aria-label="Toggle sidebar">☰</button>
  <h1 class="page-title" style="font-size:1.15rem;">Sử Môn — Admin</h1>
  <div style="display:flex;align-items:center;gap:.75rem;font-size:.875rem;">
    <span style="color:#6B7280;">Xin chào,</span>
    <strong style="color:#111827;">${sessionScope.user.fullname}</strong>
    <a href="${pageContext.request.contextPath}/"
       style="font-size:.78rem;color:#6B7280;text-decoration:none;border:1px solid #E5E7EB;padding:.3rem .7rem;border-radius:6px;transition:.2s;"
       title="Về trang chủ">🌐 Website</a>
  </div>
</div>

<script>
function toggleSidebar() {
  const sidebar = document.getElementById('sidebar');
  const main    = document.getElementById('mainContent');
  const isMobile = window.innerWidth <= 991;

  if (isMobile) {
    // Mobile: slide in/out từ trái
    if (sidebar) sidebar.classList.toggle('active');
    if (main)    main.classList.toggle('active');
  } else {
    // Desktop: ẩn/hiện sidebar, mở rộng content
    if (sidebar) sidebar.classList.toggle('hidden');
    if (main)    main.classList.toggle('full');
  }
}
</script>
