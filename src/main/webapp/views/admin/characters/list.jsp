<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Quản lý nhân vật – Admin</title>
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

      <!-- TOP BAR -->
      <div class="d-flex justify-content-between align-items-center mb-4 flex-wrap gap-2">
        <h2 class="page-title">Quản lý Nhân vật</h2>
        <div class="d-flex gap-2">
          <button class="btn btn-primary btn-sm" onclick="openAddForm()">
            <i class="fa-solid fa-plus me-1"></i> Thêm nhân vật
          </button>
          <a href="${pageContext.request.contextPath}/admin/characters?action=trash" class="btn btn-outline-secondary btn-sm">
            <i class="fa-solid fa-trash-can me-1"></i> Thùng rác
          </a>
        </div>
      </div>

      <!-- ADD / EDIT FORM -->
      <div id="addForm" class="top-card mb-4"
           style="<c:choose><c:when test='${not empty editCharacter}'>display:block;</c:when><c:otherwise>display:none;</c:otherwise></c:choose>">
        <h5 class="fw-bold mb-3">
          <c:choose>
            <c:when test="${not empty editCharacter}">✏️ Sửa nhân vật: ${editCharacter.name}</c:when>
            <c:otherwise>➕ Thêm nhân vật mới</c:otherwise>
          </c:choose>
        </h5>
        <form method="post" action="${pageContext.request.contextPath}/admin/characters" enctype="multipart/form-data">
          <c:choose>
            <c:when test="${not empty editCharacter}">
              <input type="hidden" name="action" value="update">
              <input type="hidden" name="id" value="${editCharacter.id}">
            </c:when>
            <c:otherwise>
              <input type="hidden" name="action" value="insert">
            </c:otherwise>
          </c:choose>

          <div class="row g-3">
            <div class="col-md-6">
              <label class="form-label">Tên nhân vật</label>
              <input class="form-control" name="name" value="${editCharacter.name}" <c:if test="${empty editCharacter}">required</c:if>>
            </div>
            <div class="col-md-6">
              <label class="form-label">Triều đại</label>
              <select class="form-select" name="dynasty_id">
                <c:forEach items="${dynasties}" var="d">
                  <option value="${d.name}" ${editCharacter.dynasty == d.name ? 'selected' : ''}>${d.name}</option>
                </c:forEach>
              </select>
            </div>
            <div class="col-md-6">
              <label class="form-label">Mô tả ngắn</label>
              <textarea class="form-control" rows="2" name="description">${editCharacter.description}</textarea>
            </div>
            <div class="col-md-6">
              <label class="form-label">Tiểu sử</label>
              <textarea class="form-control" rows="2" name="biography">${editCharacter.biography}</textarea>
            </div>
            <div class="col-md-6">
              <label class="form-label">Thành tựu</label>
              <textarea class="form-control" rows="2" name="achievement">${editCharacter.achievement}</textarea>
            </div>
            <div class="col-md-3">
              <label class="form-label">Nơi sinh</label>
              <input class="form-control" name="birth_place" value="${editCharacter.birthPlace}">
            </div>
            <div class="col-md-3">
              <label class="form-label">Di tích</label>
              <input class="form-control" name="historical_site" value="${editCharacter.historical_site}">
            </div>
            <div class="col-md-4">
              <label class="form-label">Ảnh</label>
              <c:if test="${not empty editCharacter.image}">
                <img src="${pageContext.request.contextPath}/assets/images/characters/${editCharacter.image}"
                     style="width:60px;height:75px;object-fit:cover;border-radius:6px;display:block;margin-bottom:.5rem;border:1px solid #E5E7EB;">
              </c:if>
              <input type="file" class="form-control" name="image" accept="image/*">
            </div>
            <div class="col-md-4">
              <label class="form-label">Timeline Order</label>
              <input class="form-control" type="number" name="timelineOrder" value="${editCharacter.timelineOrder}">
            </div>
            <div class="col-md-4">
              <label class="form-label">YouTube Link (video ID)</label>
              <input class="form-control" name="youtube_link" value="${editCharacter.youtubeLink}">
            </div>
          </div>

          <div class="mt-3 d-flex gap-2">
            <c:choose>
              <c:when test="${not empty editCharacter}">
                <button class="btn btn-warning btn-sm"><i class="fa-solid fa-floppy-disk me-1"></i> Cập nhật</button>
              </c:when>
              <c:otherwise>
                <button class="btn btn-success btn-sm"><i class="fa-solid fa-plus me-1"></i> Thêm mới</button>
              </c:otherwise>
            </c:choose>
            <button type="button" class="btn btn-secondary btn-sm" onclick="closeAddForm()">Hủy</button>
            <a class="btn btn-outline-danger btn-sm" href="${pageContext.request.contextPath}/admin/characters">Làm mới</a>
          </div>
        </form>
      </div>

      <!-- SEARCH -->
      <div class="top-card mb-3">
        <form class="row g-2 align-items-end" method="get" action="${pageContext.request.contextPath}/admin/characters">
          <div class="col-md-5">
            <label class="form-label">Tìm kiếm</label>
            <input class="form-control" name="keyword" placeholder="🔍 Tên nhân vật..." value="${param.keyword}">
          </div>
          <div class="col-md-4">
            <label class="form-label">Triều đại</label>
            <select class="form-select" name="dynasty">
              <option value="">-- Tất cả --</option>
              <c:forEach items="${dynasties}" var="d">
                <option value="${d.name}" ${param.dynasty == d.name ? 'selected' : ''}>${d.name}</option>
              </c:forEach>
            </select>
          </div>
          <div class="col-md-3">
            <button class="btn btn-primary w-100">Tìm kiếm</button>
          </div>
        </form>
      </div>

      <!-- TABLE -->
      <div class="table-card">
        <table class="table align-middle">
          <thead>
            <tr>
              <th style="width:50px;">ID</th>
              <th style="width:80px;">Ảnh</th>
              <th>Tên nhân vật</th>
              <th>Triều đại</th>
              <th style="width:150px;">Thao tác</th>
            </tr>
          </thead>
          <tbody>
            <c:forEach items="${characters}" var="c">
              <tr>
                <td style="color:#9CA3AF;">${c.id}</td>
                <td>
                  <c:if test="${not empty c.image}">
                    <img src="${pageContext.request.contextPath}/assets/images/characters/${c.image}"
                         style="width:52px;height:65px;object-fit:cover;border-radius:8px;border:1px solid #E5E7EB;"
                         onerror="this.style.display='none'">
                  </c:if>
                </td>
                <td class="fw-semibold">${c.name}</td>
                <td><span class="badge" style="background:rgba(30,58,138,.1);color:#1e3a8a;font-weight:600;">${c.dynasty}</span></td>
                <td>
                  <a class="btn btn-warning btn-sm btn-action" href="${pageContext.request.contextPath}/admin/characters?action=edit&id=${c.id}" title="Sửa">
                    <i class="fa-solid fa-pen"></i>
                  </a>
                  <a class="btn btn-danger btn-sm btn-action ms-1"
                     href="${pageContext.request.contextPath}/admin/characters?action=delete&id=${c.id}"
                     onclick="return confirm('Chuyển [${c.name}] vào thùng rác?');" title="Xóa">
                    <i class="fa-solid fa-trash"></i>
                  </a>
                </td>
              </tr>
            </c:forEach>
            <c:if test="${empty characters}">
              <tr><td colspan="5" class="text-center text-muted py-4">Không có dữ liệu</td></tr>
            </c:if>
          </tbody>
        </table>

        <!-- PAGINATION -->
        <nav><ul class="pagination justify-content-center mb-0">
          <c:if test="${page > 1}">
            <li class="page-item"><a class="page-link" href="?page=${page-1}&keyword=${param.keyword}&dynasty=${param.dynasty}">←</a></li>
          </c:if>
          <c:forEach begin="1" end="${totalPage}" var="i">
            <li class="page-item ${i == page ? 'active' : ''}">
              <a class="page-link" href="?page=${i}&keyword=${param.keyword}&dynasty=${param.dynasty}">${i}</a>
            </li>
          </c:forEach>
          <c:if test="${page < totalPage}">
            <li class="page-item"><a class="page-link" href="?page=${page+1}&keyword=${param.keyword}&dynasty=${param.dynasty}">→</a></li>
          </c:if>
        </ul></nav>
      </div>

    </div><!-- /content -->
    <jsp:include page="../layout/footer.jsp"/>
  </div>
</div>

<script>
function openAddForm() { document.getElementById('addForm').style.display = 'block'; window.scrollTo({top:0,behavior:'smooth'}); }
function closeAddForm() { document.getElementById('addForm').style.display = 'none'; }
</script>
</body>
</html>



