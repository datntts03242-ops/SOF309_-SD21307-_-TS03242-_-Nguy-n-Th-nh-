<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>

<!DOCTYPE html>
<html>
<head>

<meta charset="UTF-8">
<title>Quản lý Triều đại</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/css/bootstrap.min.css" rel="stylesheet">
  <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css" rel="stylesheet">
  <link href="${pageContext.request.contextPath}/assets/css/admin.css" rel="stylesheet">
<style>

body{
    background:#f5f7fb;
}
</style>

</head>

<body>
<div class="admin-wrapper">

    <jsp:include page="../layout/sidebar.jsp"/>

    <div class="main-content" id="mainContent">

        <jsp:include page="../layout/header.jsp"/>
<div class="content">
<div class="top-card mb-3">

<div class="d-flex justify-content-between align-items-center">

<h2 class="page-title">🏯 Quản lý Triều đại</h2>

<button
class="btn btn-primary"
data-bs-toggle="modal"
data-bs-target="#dynastyModal">

<i class="fa-solid fa-plus"></i>

Thêm Triều đại

</button>

</div>

</div>



<div class="table-card">

<table class="table table-hover align-middle">

<thead>

<tr>

<th width="80">ID</th>

<th width="90">Ảnh</th>

<th>Tên triều đại</th>

<th>Người sáng lập</th>

<th>Bắt đầu</th>

<th>Kết thúc</th>

<th>Kinh đô</th>

<th width="120">Action</th>

</tr>

</thead>

<tbody>

<c:forEach items="${dynasties}" var="d">

<tr>

<td>${d.id}</td>

<td>
<img src="${pageContext.request.contextPath}/assets/images/dynasties/${d.image}"
     style="width:60px;height:45px;object-fit:cover;border-radius:6px;"
     onerror="this.style.display='none'">
</td>

<td>

<b>${d.name}</b>

</td>

<td>

${d.founder}

</td>

<td>

${d.startYear}

</td>

<td>

${d.endYear}

</td>

<td>

${d.capital}

</td>

<td>

<a
class="btn btn-outline-primary btn-sm btn-action"

href="${pageContext.request.contextPath}/admin/dynasties?action=edit&id=${d.id}">

<i class="fa-solid fa-pen"></i>

</a>

<a
class="btn btn-outline-danger btn-sm btn-action"

onclick="return confirm('Xóa triều đại này?')"

href="${pageContext.request.contextPath}/admin/dynasties?action=delete&id=${d.id}">

<i class="fa-solid fa-trash"></i>

</a>

</td>

</tr>

</c:forEach>

</tbody>

</table>

</div>



<!-- Modal -->

<div
class="modal fade"
id="dynastyModal">

<div class="modal-dialog modal-lg">

<div class="modal-content">

<form

method="post"

action="${pageContext.request.contextPath}/admin/dynasties"

enctype="multipart/form-data">

<div class="modal-header">

<c:choose>

<c:when test="${not empty editDynasty}">

<h4>Sửa Triều đại</h4>

<input
type="hidden"
name="action"
value="update">

<input
type="hidden"
name="id"
value="${editDynasty.id}">

</c:when>

<c:otherwise>

<h4>Thêm Triều đại</h4>

<input
type="hidden"
name="action"
value="insert">

</c:otherwise>

</c:choose>

<button
type="button"
class="btn-close btn-close-white"
data-bs-dismiss="modal"></button>

</div>

<div class="modal-body">

<div class="row">

<div class="col-md-6">

<label>Tên triều đại</label>

<input
class="form-control"

name="name"

value="${editDynasty.name}"

required>

<br>

<label>Người sáng lập</label>

<input
class="form-control"

name="founder"

value="${editDynasty.founder}"

required>

<br>

<label>Năm bắt đầu</label>

<input
type="number"

class="form-control"

name="startYear"

value="${editDynasty.startYear}"

required>

<br>

<label>Năm kết thúc</label>

<input
type="number"

class="form-control"

name="endYear"

value="${editDynasty.endYear}"

required>

</div>

<div class="col-md-6">

<label>Kinh đô</label>

<input
class="form-control"

name="capital"

value="${editDynasty.capital}"

required>

<br>

<label>Ảnh</label>

<input
type="file"

class="form-control"

name="image"

accept="image/*">
<c:if test="${not empty editDynasty.image}">

<br>

<img
src="${pageContext.request.contextPath}/assets/images/dynasties/${editDynasty.image}"
id="preview"
class="preview">

</c:if>

<c:if test="${empty editDynasty.image}">

<br>

<img
id="preview"
class="preview"
style="display:none;">

</c:if>

<br><br>

<label>Mô tả</label>

<textarea
class="form-control"
rows="5"
name="description">${editDynasty.description}</textarea>

</div>

</div>

</div>

<div class="modal-footer">

<button
type="button"
class="btn btn-secondary"
data-bs-dismiss="modal">

Đóng

</button>

<c:choose>

<c:when test="${not empty editDynasty}">

<button
class="btn btn-warning">

<i class="fa-solid fa-floppy-disk"></i>

Cập nhật

</button>

</c:when>

<c:otherwise>

<button
class="btn btn-success">

<i class="fa-solid fa-check"></i>

Lưu

</button>

</c:otherwise>

</c:choose>

</div>

</form>

</div>

</div>

</div>

</div>
</div>
</div>
<script>

// Preview ảnh

document.querySelector("input[name='image']")
.addEventListener("change",function(){

    const file=this.files[0];

    if(file){

        let img=document.getElementById("preview");

        img.src=URL.createObjectURL(file);

        img.style.display="block";

    }

});

</script>

</div><!-- /content -->
    <jsp:include page="../layout/footer.jsp"/>
  </div><!-- /main-content -->
</div><!-- /admin-wrapper -->

<c:if test="${not empty editDynasty}">
<script>
window.onload = function() {
  new bootstrap.Modal(document.getElementById("dynastyModal")).show();
}
</script>
</c:if>

<jsp:include page="../layout/footer.jsp"/>
</body>
</html>



