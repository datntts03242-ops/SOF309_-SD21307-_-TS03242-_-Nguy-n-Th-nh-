<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html lang="vi">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Chi tiết tài khoản vi phạm – Admin</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/css/bootstrap.min.css" rel="stylesheet">
  <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css" rel="stylesheet">
  <link href="${pageContext.request.contextPath}/assets/css/admin.css" rel="stylesheet">
</head>
<body>
<div class="admin-wrapper">
  <jsp:include page="../layout/sidebar.jsp"/>
  <div class="main-content" id="mainContent">
    <jsp:include page="../layout/header.jsp"/>
    <div class="content">

      <div class="d-flex justify-content-between align-items-center mb-4">
        <h2 class="page-title">Chi tiết tài khoản vi phạm</h2>
        <a href="${pageContext.request.contextPath}/admin/users?action=banned" class="btn btn-outline-secondary btn-sm">
          <i class="fa-solid fa-arrow-left"></i> Quay lại
        </a>
      </div>

      <div class="table-card mb-4 p-3">
        <p><strong>ID:</strong> ${targetUser.id}</p>
        <p><strong>Tài khoản:</strong> ${targetUser.username}</p>
        <p><strong>Họ tên:</strong> ${targetUser.fullname}</p>
        <p><strong>Tổng số lần vi phạm:</strong> ${targetUser.warningCount}/5</p>
        <p><strong>Thời gian khóa:</strong> ${targetUser.bannedAt}</p>
      </div>

      <h5 class="mb-3">Lịch sử vi phạm</h5>
      <div class="table-card">
        <table class="table align-middle">
          <thead>
            <tr>
              <th style="width:180px;">Thời gian</th>
              <th style="width:220px;">Lý do</th>
              <th>Nội dung bình luận vi phạm</th>
            </tr>
          </thead>
          <tbody>
            <c:forEach items="${violations}" var="v">
              <tr>
                <td>${v.createdAt}</td>
                <td>${v.violationReason}</td>
                <td>${v.commentContent}</td>
              </tr>
            </c:forEach>
            <c:if test="${empty violations}">
              <tr><td colspan="3" class="text-center text-muted py-4">Không có lịch sử vi phạm</td></tr>
            </c:if>
          </tbody>
        </table>
      </div>

    </div>
    <jsp:include page="../layout/footer.jsp"/>
  </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>