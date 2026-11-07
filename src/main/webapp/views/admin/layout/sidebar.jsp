<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%
    String cp = request.getContextPath();
    String uri = request.getRequestURI();
    int chatUnreadCount = new dao.ChatConversationDAO().countTotalUnreadForAdmin();
%>
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css" rel="stylesheet">

<div id="sidebar" class="sidebar">

  <div class="logo">
    <img src="${pageContext.request.contextPath}/assets/images/logo-su-mon.png" alt="logo" onerror="this.style.display='none'">
    <div>
      <h4>Sử Môn</h4>
      <small>Hệ thống quản trị</small>
    </div>
  </div>

  <ul>
    <li>
      <a href="${pageContext.request.contextPath}/admin/dashboard"
         class="<%= uri.contains("/admin/dashboard") ? "active" : "" %>">
        <i class="fa-solid fa-gauge-high"></i> Dashboard
      </a>
    </li>
    <li>
      <a href="${pageContext.request.contextPath}/admin/characters"
         class="<%= uri.contains("/admin/characters") ? "active" : "" %>">
        <i class="fa-solid fa-users"></i> Nhân vật
      </a>
    </li>
    <li>
      <a href="${pageContext.request.contextPath}/admin/dynasties"
         class="<%= uri.contains("/admin/dynasties") ? "active" : "" %>">
        <i class="fa-solid fa-landmark"></i> Triều đại
      </a>
    </li>
    <li>
      <a href="${pageContext.request.contextPath}/admin/users"
         class="<%= uri.contains("/admin/users") ? "active" : "" %>">
        <i class="fa-solid fa-user-group"></i> Người dùng
      </a>
    </li>
    <li>
      <a href="${pageContext.request.contextPath}/admin/comments"
         class="<%= uri.contains("/admin/comments") ? "active" : "" %>">
        <i class="fa-solid fa-comments"></i> Bình luận
      </a>
    </li>
    <li>
      <a href="${pageContext.request.contextPath}/admin/chat"
         class="<%= uri.contains("/admin/chat") ? "active" : "" %>"
         style="display:flex;align-items:center;justify-content:space-between;">
        <span><i class="fa-solid fa-message"></i> Tin nhắn</span>
        <% if (chatUnreadCount > 0) { %>
        <span style="background:#A50000;color:#fff;font-size:.68rem;font-weight:700;min-width:19px;height:19px;border-radius:999px;display:flex;align-items:center;justify-content:center;padding:0 5px;">
          <%= chatUnreadCount > 9 ? "9+" : chatUnreadCount %>
        </span>
        <% } %>
      </a>
    </li>
    <li>
      <a href="${pageContext.request.contextPath}/admin/submissions"
         class="<%= uri.contains("/admin/submissions") ? "active" : "" %>">
        <i class="fa-solid fa-paper-plane"></i> Đóng góp
      </a>
    </li>
    <li style="margin-top:auto;padding-top:1rem;">
      <a href="${pageContext.request.contextPath}/">
        <i class="fa-solid fa-arrow-left"></i> Về trang chủ
      </a>
    </li>
  </ul>

</div>
