<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html lang="vi">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Quản lý người dùng – Admin</title>
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

      <div class="d-flex justify-content-between align-items-center mb-4 flex-wrap gap-2">
        <h2 class="page-title">Quản lý Người dùng</h2>
      </div>

      <!-- Tabs -->
      <ul class="nav nav-tabs mb-3">
        <li class="nav-item">
          <button class="nav-link active" data-bs-toggle="tab" data-bs-target="#tab-users" type="button">
            Người dùng
          </button>
        </li>
        <li class="nav-item">
          <button class="nav-link" data-bs-toggle="tab" data-bs-target="#tab-admins" type="button">
            Quản trị viên
          </button>
        </li>
        <li class="nav-item">
          <button class="nav-link" data-bs-toggle="tab" data-bs-target="#tab-banned" type="button">
            Tài khoản vi phạm
          </button>
        </li>
      </ul>

      <div class="tab-content">

        <!-- Tab: Users -->
        <div class="tab-pane fade show active" id="tab-users">
          <div class="table-card">
            <table class="table align-middle">
              <thead>
                <tr>
                  <th style="width:50px;">ID</th>
                  <th>Họ tên</th>
                  <th>Tài khoản</th>
                  <th>Vai trò</th>
                  <th>Trạng thái</th>
                  <th style="width:180px;">Thao tác</th>
                </tr>
              </thead>
              <tbody>
                <c:set var="hasUser" value="false"/>
                <c:forEach items="${users}" var="u">
                  <c:if test="${u.role != 'admin'}">
                    <c:set var="hasUser" value="true"/>
                    <tr>
                      <td style="color:#9CA3AF;">${u.id}</td>
                      <td class="fw-semibold">${u.fullname}</td>
                      <td style="color:#6B7280;font-size:.875rem;">${u.username}</td>
                      <td>
                        <span class="badge" style="background:rgba(30,58,138,.1);color:#1e3a8a;font-weight:600;">
                          ${u.role != null ? u.role : 'user'}
                        </span>
                      </td>
                      <td>
                        <c:choose>
                          <c:when test="${u.active}">
                            <span class="badge" style="background:rgba(22,163,74,.12);color:#16a34a;font-weight:600;">● Hoạt động</span>
                          </c:when>
                          <c:otherwise>
                            <span class="badge" style="background:rgba(220,53,69,.12);color:#dc3545;font-weight:600;">● Đã khóa</span>
                          </c:otherwise>
                        </c:choose>
                      </td>
                      <td>
                        <!-- Toggle active -->
                        <form style="display:inline;" method="post" action="${pageContext.request.contextPath}/admin/users">
                          <input type="hidden" name="action" value="active">
                          <input type="hidden" name="id" value="${u.id}">
                          <c:choose>
                            <c:when test="${u.active}">
                              <input type="hidden" name="active" value="false">
                              <button class="btn btn-warning btn-sm btn-action" title="Khóa tài khoản">
                                <i class="fa-solid fa-lock"></i>
                              </button>
                            </c:when>
                            <c:otherwise>
                              <input type="hidden" name="active" value="true">
                              <button class="btn btn-success btn-sm btn-action" title="Mở tài khoản">
                                <i class="fa-solid fa-lock-open"></i>
                              </button>
                            </c:otherwise>
                          </c:choose>
                        </form>
                        <!-- Xóa -->
                        <a class="btn btn-danger btn-sm btn-action ms-1"
                           onclick="return confirm('Xóa tài khoản ${u.username}?')"
                           href="${pageContext.request.contextPath}/admin/users?action=delete&id=${u.id}" title="Xóa">
                          <i class="fa-solid fa-trash"></i>
                        </a>
                      </td>
                    </tr>
                  </c:if>
                </c:forEach>
                <c:if test="${!hasUser}">
                  <tr><td colspan="6" class="text-center text-muted py-4">Không có người dùng</td></tr>
                </c:if>
              </tbody>
            </table>
          </div>
        </div>

        <!-- Tab: Admins -->
        <div class="tab-pane fade" id="tab-admins">
          <div class="table-card">
            <table class="table align-middle">
              <thead>
                <tr>
                  <th style="width:50px;">ID</th>
                  <th>Họ tên</th>
                  <th>Tài khoản</th>
                  <th>Vai trò</th>
                  <th>Trạng thái</th>
                  <th style="width:180px;">Thao tác</th>
                </tr>
              </thead>
              <tbody>
                <c:set var="hasAdmin" value="false"/>
                <c:forEach items="${users}" var="u">
                  <c:if test="${u.role == 'admin'}">
                    <c:set var="hasAdmin" value="true"/>
                    <tr>
                      <td style="color:#9CA3AF;">${u.id}</td>
                      <td class="fw-semibold">${u.fullname}</td>
                      <td style="color:#6B7280;font-size:.875rem;">${u.username}</td>
                      <td>
                        <span class="badge" style="background:rgba(220,53,69,.12);color:#dc3545;font-weight:600;">
                          admin
                        </span>
                      </td>
                      <td>
                        <c:choose>
                          <c:when test="${u.active}">
                            <span class="badge" style="background:rgba(22,163,74,.12);color:#16a34a;font-weight:600;">● Hoạt động</span>
                          </c:when>
                          <c:otherwise>
                            <span class="badge" style="background:rgba(220,53,69,.12);color:#dc3545;font-weight:600;">● Đã khóa</span>
                          </c:otherwise>
                        </c:choose>
                      </td>
                      <td>
                        <!-- Toggle active -->
                        <form style="display:inline;" method="post" action="${pageContext.request.contextPath}/admin/users">
                          <input type="hidden" name="action" value="active">
                          <input type="hidden" name="id" value="${u.id}">
                          <c:choose>
                            <c:when test="${u.active}">
                              <input type="hidden" name="active" value="false">
                              <button class="btn btn-warning btn-sm btn-action" title="Khóa tài khoản">
                                <i class="fa-solid fa-lock"></i>
                              </button>
                            </c:when>
                            <c:otherwise>
                              <input type="hidden" name="active" value="true">
                              <button class="btn btn-success btn-sm btn-action" title="Mở tài khoản">
                                <i class="fa-solid fa-lock-open"></i>
                              </button>
                            </c:otherwise>
                          </c:choose>
                        </form>
                        <!-- Xóa -->
                        <a class="btn btn-danger btn-sm btn-action ms-1"
                           onclick="return confirm('Xóa tài khoản ${u.username}?')"
                           href="${pageContext.request.contextPath}/admin/users?action=delete&id=${u.id}" title="Xóa">
                          <i class="fa-solid fa-trash"></i>
                        </a>
                      </td>
                    </tr>
                  </c:if>
                </c:forEach>
                <c:if test="${!hasAdmin}">
                  <tr><td colspan="6" class="text-center text-muted py-4">Không có quản trị viên</td></tr>
                </c:if>
              </tbody>
            </table>
          </div>
        </div>

        <!-- Tab: Banned -->
        <div class="tab-pane fade" id="tab-banned">
          <div class="table-card">
            <table class="table align-middle">
              <thead>
                <tr>
                  <th style="width:50px;">ID</th>
                  <th>Tài khoản</th>
                  <th>Họ tên</th>
                  <th>Tổng vi phạm</th>
                  <th>Thời gian khóa</th>
                  <th style="width:180px;">Thao tác</th>
                </tr>
              </thead>
              <tbody>
                <c:forEach items="${bannedUsers}" var="u">
                  <tr>
                    <td style="color:#9CA3AF;">${u.id}</td>
                    <td style="color:#6B7280;font-size:.875rem;">${u.username}</td>
                    <td class="fw-semibold">${u.fullname}</td>
                    <td><span class="badge" style="background:rgba(220,53,69,.12);color:#dc3545;font-weight:600;">${u.warningCount}/5</span></td>
                    <td>${u.bannedAt}</td>
                    <td>
                      <a class="btn btn-primary btn-sm btn-action"
                         href="${pageContext.request.contextPath}/admin/users?action=violationDetail&id=${u.id}" title="Chi tiết">
                        <i class="fa-solid fa-eye"></i>
                      </a>
                      <form style="display:inline;" method="post" action="${pageContext.request.contextPath}/admin/users">
                        <input type="hidden" name="action" value="restore">
                        <input type="hidden" name="id" value="${u.id}">
                        <button class="btn btn-success btn-sm btn-action ms-1"
                                onclick="return confirm('Khôi phục tài khoản ${u.username}?')" title="Khôi phục">
                          <i class="fa-solid fa-rotate-left"></i>
                        </button>
                      </form>
                    </td>
                  </tr>
                </c:forEach>
                <c:if test="${empty bannedUsers}">
                  <tr><td colspan="6" class="text-center text-muted py-4">Không có tài khoản vi phạm</td></tr>
                </c:if>
              </tbody>
            </table>
          </div>
        </div>

      </div><!-- /tab-content -->

    </div><!-- /content -->
    <jsp:include page="../layout/footer.jsp"/>
  </div>
</div>
<!-- Nếu footer.jsp CHƯA có bootstrap bundle JS thì giữ dòng dưới, nếu đã có rồi thì xóa để tránh load 2 lần -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>