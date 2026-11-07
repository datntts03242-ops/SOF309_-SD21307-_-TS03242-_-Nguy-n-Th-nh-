<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Sử Môn - Lịch sử xóa nhân vật</title>
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
            <h2 class="page-title">🗑️ Thùng rác nhân vật</h2>
            <a href="${pageContext.request.contextPath}/admin/characters" class="btn btn-outline-primary fw-semibold">
                <i class="fa-solid fa-arrow-left me-1"></i> Quay lại trang Quản lý
            </a>
        </div>

        <div class="card card-body shadow-sm">
            <table class="table table-striped align-middle text-center mb-0">
                <thead class="table-dark">
                    <tr>
                        <th style="width: 60px;">ID</th>
                        <th class="text-start">Tên nhân vật</th>
                        <th>Triều đại</th>
                        <th style="width: 80px;">Ảnh</th>
                        <th style="width: 220px;">Thao tác</th>
                    </tr>
                </thead>
                <tbody>
                    <c:choose>
                        <c:when test="${not empty trashList}">
                            <c:forEach var="c" items="${trashList}">
                                <tr>
                                    <td>${c.id}</td>
                                    <td class="text-start fw-bold">${c.name}</td>
                                    <td><span class="badge bg-secondary">${c.dynasty}</span></td>
                                    <td>
                                        <c:if test="${not empty c.image}">
                                            <img src="${pageContext.request.contextPath}/assets/images/characters/${c.image}" width="50" height="50" style="object-fit:cover;" class="rounded">
                                        </c:if>
                                    </td>
                                    <td>
											<a href="${pageContext.request.contextPath}/admin/characters?action=restore&id=${c.id}" 
											   onclick="return confirm('Khôi phục nhân vật [${c.name}]?');" 
											   class="btn btn-success btn-sm">
											    ↺ Khôi phục
											</a>
											<a href="${pageContext.request.contextPath}/admin/characters?action=hard-delete&id=${c.id}" 
											   onclick="return confirm('⚠️ Nhân vật [${c.name}] sẽ bị XÓA VĨNH VIỄN!');" 
											   class="btn btn-danger btn-sm">
											    ❌ Xóa hẳn
											</a>
                                    </td>
                                </tr>
                            </c:forEach>
                        </c:when>
                        <c:otherwise>
                            <tr>
                                <td colspan="5" class="py-4 text-muted fw-semibold">Thùng rác hiện đang trống!</td>
                            </tr>
                        </c:otherwise>
                    </c:choose>
                </tbody>
            </table>
        </div>

        </div><!-- /content -->
        <jsp:include page="../layout/footer.jsp"/>
    </div>
</div>
</body>
</html>


