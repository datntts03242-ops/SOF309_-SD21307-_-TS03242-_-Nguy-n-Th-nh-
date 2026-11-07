<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Quản lý bình luận – Admin</title>
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
        <h2 class="page-title">Quản lý Bình luận</h2>
      </div>

      <!-- SEARCH -->
      <div class="top-card mb-3">
        <form method="get" action="${pageContext.request.contextPath}/admin/comments" class="d-flex gap-2 align-items-center">
          <input type="text" name="keyword" class="form-control" style="max-width:320px;"
                 placeholder="🔍 Tìm theo user, nhân vật, nội dung..." value="${keyword}">
          <button type="submit" class="btn btn-primary btn-sm px-3">Tìm kiếm</button>
          <c:if test="${not empty keyword}">
            <a href="${pageContext.request.contextPath}/admin/comments" class="btn btn-outline-secondary btn-sm">Xóa lọc</a>
          </c:if>
        </form>
      </div>

      <!-- TABLE -->
      <div class="table-card">
        <table class="table align-middle">
          <thead>
            <tr>
              <th style="width:50px;">ID</th>
              <th>Người dùng</th>
              <th>Nhân vật</th>
              <th>Nội dung</th>
              <th style="width:90px;">Điểm</th>
              <th style="width:140px;">Ngày tạo</th>
              <th style="width:60px;">Xóa</th>
            </tr>
          </thead>
          <tbody>
            <c:forEach var="cmt" items="${comments}">
              <tr>
                <td style="color:#9CA3AF;">${cmt.id}</td>
                <td class="fw-semibold">${cmt.username}</td>
                <td style="color:#6B7280;font-size:.875rem;">${cmt.characterName}</td>
                <td style="font-size:.875rem;max-width:260px;overflow:hidden;text-overflow:ellipsis;white-space:nowrap;">
                  <c:out value="${cmt.content}"/>
                </td>
                <td>
                  <span style="color:#FBBF24;font-weight:700;">${cmt.score}</span>
                  <span style="color:#FBBF24;">★</span>
                </td>
                <td style="font-size:.78rem;color:#9CA3AF;">
                  <fmt:formatDate value="${cmt.createdAt}" pattern="dd/MM/yyyy HH:mm"/>
                </td>
                <td>
                  <a class="btn btn-danger btn-sm btn-action"
                     href="${pageContext.request.contextPath}/admin/comments?action=delete&id=${cmt.id}&keyword=${keyword}&page=${page}"
                     onclick="return confirm('Xóa bình luận này?');" title="Xóa">
                    <i class="fa-solid fa-trash"></i>
                  </a>
                </td>
              </tr>
            </c:forEach>
            <c:if test="${empty comments}">
              <tr><td colspan="7" class="text-center text-muted py-4">Không có bình luận nào</td></tr>
            </c:if>
          </tbody>
        </table>

        <nav><ul class="pagination justify-content-center mb-0">
          <c:forEach begin="1" end="${totalPage}" var="i">
            <li class="page-item ${i == page ? 'active' : ''}">
              <a class="page-link" href="${pageContext.request.contextPath}/admin/comments?keyword=${keyword}&page=${i}">${i}</a>
            </li>
          </c:forEach>
        </ul></nav>
      </div>

    </div><!-- /content -->
    <jsp:include page="../layout/footer.jsp"/>
  </div><!-- /main-content -->
</div><!-- /admin-wrapper -->
</body>
</html>



