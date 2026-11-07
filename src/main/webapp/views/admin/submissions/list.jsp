<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Duyệt đóng góp – Admin</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/css/bootstrap.min.css" rel="stylesheet">
  <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css" rel="stylesheet">
  <link href="${pageContext.request.contextPath}/assets/css/admin.css" rel="stylesheet">
  <style>
    /* Table: td tối, th thead trắng trên nền xanh */
    .table tbody td { color: #111827 !important; }
    .table thead th { background: #1e3a8a !important; color: #fff !important; }
    .status-badge { font-size:.75rem; font-weight:600; padding:.3rem .75rem; border-radius:99px; }
    .status-Pending  { background:rgba(217,119,6,.12);  color:#b45309 !important; }
    .status-Approved { background:rgba(22,163,74,.12);  color:#15803d !important; }
    .status-Rejected { background:rgba(220,53,69,.12);  color:#dc2626 !important; }
    .desc-cell { max-width:220px; overflow:hidden; text-overflow:ellipsis; white-space:nowrap; font-size:.82rem; color:#6B7280 !important; }
  </style>
</head>
<body>
<div class="admin-wrapper">

  <jsp:include page="../layout/sidebar.jsp"/>

  <div class="main-content" id="mainContent">
    <jsp:include page="../layout/header.jsp"/>

    <div class="content">

      <!-- HEADER -->
      <div class="d-flex justify-content-between align-items-center mb-4 flex-wrap gap-2">
        <div>
          <h2 class="page-title">Duyệt Đóng Góp Nhân Vật</h2>
          <c:if test="${pendingCount > 0}">
            <span class="badge status-Pending">${pendingCount} chờ duyệt</span>
          </c:if>
        </div>
      </div>

      <!-- FILTER TABS -->
      <div class="top-card mb-3 p-2">
        <div class="d-flex gap-2 flex-wrap">
          <a href="${pageContext.request.contextPath}/admin/submissions?status=Pending"
             class="btn btn-sm ${currentStatus == 'Pending' ? 'btn-primary' : 'btn-outline-secondary'}">
            ⏳ Chờ duyệt
          </a>
          <a href="${pageContext.request.contextPath}/admin/submissions?status=Approved"
             class="btn btn-sm ${currentStatus == 'Approved' ? 'btn-primary' : 'btn-outline-secondary'}">
            ✅ Đã duyệt
          </a>
          <a href="${pageContext.request.contextPath}/admin/submissions?status=Rejected"
             class="btn btn-sm ${currentStatus == 'Rejected' ? 'btn-primary' : 'btn-outline-secondary'}">
            ❌ Từ chối
          </a>
        </div>
      </div>

      <!-- TABLE -->
      <div class="table-card">
        <table class="table align-middle">
          <thead>
            <tr>
              <th style="width:50px;">ID</th>
              <th>Tên nhân vật</th>
              <th>Triều đại</th>
              <th>Mô tả</th>
              <th>Người gửi</th>
              <th>Ngày gửi</th>
              <th>Trạng thái</th>
              <th style="width:160px;">Thao tác</th>
            </tr>
          </thead>
          <tbody>
            <c:forEach items="${submissions}" var="s">
              <tr>
                <td style="color:#9CA3AF;">${s.id}</td>
                <td class="fw-semibold">${s.name}</td>
                <td style="font-size:.875rem;">${s.dynasty}</td>
                <td class="desc-cell" title="${s.description}">${s.description}</td>
                <td style="font-size:.82rem;color:#6B7280;">${s.submitterUsername}</td>
                <td style="font-size:.78rem;color:#9CA3AF;">
                  <fmt:formatDate value="${s.createdAt}" pattern="dd/MM/yyyy"/>
                </td>
                <td>
                  <span class="status-badge status-${s.status}">${s.status}</span>
                </td>
                <td>
                  <c:if test="${s.status == 'Pending'}">
                    <!-- Duyệt — dùng modal thay vì confirm() để tránh giật -->
                    <form id="approve-form-${s.id}" method="post"
                          action="${pageContext.request.contextPath}/admin/submissions"
                          style="display:inline;">
                      <input type="hidden" name="action" value="approve">
                      <input type="hidden" name="id" value="${s.id}">
                    </form>
                    <button type="button" class="btn btn-success btn-sm btn-action"
                            onclick="openApproveModal(${s.id}, '${s.name}')"
                            title="Duyệt">
                      <i class="fa-solid fa-check"></i>
                    </button>
                    <!-- Từ chối (mở modal) -->
                    <button class="btn btn-danger btn-sm btn-action ms-1"
                            onclick="openRejectModal(${s.id}, '${s.name}')"
                            title="Từ chối">
                      <i class="fa-solid fa-xmark"></i>
                    </button>
                  </c:if>
                  <!-- Xem chi tiết -->
                  <button class="btn btn-outline-secondary btn-sm btn-action ms-1"
                          onclick="openDetailModal(${s.id})"
                          title="Xem chi tiết">
                    <i class="fa-solid fa-eye"></i>
                  </button>
                </td>
              </tr>
            </c:forEach>
            <c:if test="${empty submissions}">
              <tr>
                <td colspan="8" class="text-center text-muted py-5">
                  <i class="fa-solid fa-inbox fa-2x mb-2 d-block" style="color:#E5E7EB;"></i>
                  Không có đóng góp nào với trạng thái "${currentStatus}"
                </td>
              </tr>
            </c:if>
          </tbody>
        </table>
      </div>

    </div><!-- /content -->
    <jsp:include page="../layout/footer.jsp"/>
  </div>
</div>

<!-- Toast thông báo -->
<c:if test="${param.msg == 'approved'}">
<div id="adminToast" style="position:fixed;bottom:24px;right:24px;z-index:9999;
  background:#15803d;color:#fff;padding:.85rem 1.25rem;border-radius:12px;
  font-size:.875rem;font-weight:600;box-shadow:0 8px 28px rgba(0,0,0,.2);
  display:flex;align-items:center;gap:.5rem;animation:slideIn .3s ease;">
  <i class="fa-solid fa-circle-check"></i> Đã duyệt và thêm vào danh sách nhân vật!
</div>
<style>@keyframes slideIn{from{opacity:0;transform:translateY(20px)}to{opacity:1;transform:translateY(0)}}</style>
<script>setTimeout(()=>{const t=document.getElementById('adminToast');if(t){t.style.opacity='0';t.style.transition='opacity .4s';setTimeout(()=>t.remove(),400);}},3000);</script>
</c:if>

<!-- APPROVE MODAL -->
<div class="modal fade" id="approveModal" tabindex="-1">
  <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content">
      <div class="modal-header" style="background:#15803d;color:#fff;border-radius:14px 14px 0 0;">
        <h5 class="modal-title">✅ Xác nhận duyệt đóng góp</h5>
        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
      </div>
      <div class="modal-body">
        <p style="color:#111827;">Bạn có chắc muốn duyệt nhân vật <strong id="approveName"></strong>?</p>
        <p style="color:#6B7280;font-size:.875rem;margin-top:.5rem;">Nhân vật này sẽ được thêm vào danh sách nhân vật chính thức.</p>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
        <button type="button" class="btn btn-success" id="approveConfirmBtn">
          <i class="fa-solid fa-check me-1"></i> Xác nhận duyệt
        </button>
      </div>
    </div>
  </div>
</div>

<!-- REJECT MODAL -->
<div class="modal fade" id="rejectModal" tabindex="-1">
  <div class="modal-dialog">
    <div class="modal-content">
      <form method="post" action="${pageContext.request.contextPath}/admin/submissions">
        <input type="hidden" name="action" value="reject">
        <input type="hidden" name="id" id="rejectId">
        <div class="modal-header">
          <h5 class="modal-title">❌ Từ chối đóng góp</h5>
          <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
        </div>
        <div class="modal-body">
          <p class="mb-3">Nhân vật: <strong id="rejectName"></strong></p>
          <label class="form-label fw-semibold">Lý do từ chối</label>
          <textarea name="reason" class="form-control" rows="3"
                    placeholder="Ví dụ: Thiếu thông tin, nội dung không chính xác..." required></textarea>
        </div>
        <div class="modal-footer">
          <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
          <button type="submit" class="btn btn-danger">Xác nhận từ chối</button>
        </div>
      </form>
    </div>
  </div>
</div>

<!-- DETAIL MODAL (inline data) -->
<div class="modal fade" id="detailModal" tabindex="-1">
  <div class="modal-dialog modal-lg">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title">📋 Chi tiết đóng góp</h5>
        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
      </div>
      <div class="modal-body" id="detailBody">
        <c:forEach items="${submissions}" var="s">
          <div id="detail-${s.id}" style="display:none;">
            <table class="table table-borderless">
              <tr><th style="width:140px;color:#6B7280;">Tên</th><td class="fw-semibold">${s.name}</td></tr>
              <tr><th style="color:#6B7280;">Triều đại</th><td>${s.dynasty}</td></tr>
              <tr><th style="color:#6B7280;">Mô tả</th><td>${s.description}</td></tr>
              <tr><th style="color:#6B7280;">Tiểu sử</th><td style="white-space:pre-wrap;">${s.biography}</td></tr>
              <tr><th style="color:#6B7280;">Thành tựu</th><td>${s.achievement}</td></tr>
              <tr><th style="color:#6B7280;">Quê quán</th><td>${s.birthPlace}</td></tr>
              <tr><th style="color:#6B7280;">Di tích</th><td>${s.historicalSite}</td></tr>
              <tr><th style="color:#6B7280;">Người gửi</th><td>${s.submitterUsername}</td></tr>
              <tr><th style="color:#6B7280;">Ngày gửi</th><td><fmt:formatDate value="${s.createdAt}" pattern="dd/MM/yyyy HH:mm"/></td></tr>
              <c:if test="${not empty s.rejectReason}">
                <tr><th style="color:#dc2626;">Lý do từ chối</th><td style="color:#dc2626;">${s.rejectReason}</td></tr>
              </c:if>
            </table>
          </div>
        </c:forEach>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Đóng</button>
      </div>
    </div>
  </div>
</div>

<script>
let currentApproveId = null;

function openApproveModal(id, name) {
  currentApproveId = id;
  document.getElementById('approveName').textContent = name;
  new bootstrap.Modal(document.getElementById('approveModal')).show();
}

document.addEventListener('DOMContentLoaded', function() {
  document.getElementById('approveConfirmBtn').addEventListener('click', function() {
    if (currentApproveId) {
      // Đóng modal trước rồi submit sau — tránh giật
      const modal = bootstrap.Modal.getInstance(document.getElementById('approveModal'));
      if (modal) modal.hide();
      setTimeout(() => {
        document.getElementById('approve-form-' + currentApproveId).submit();
      }, 200);
    }
  });
});

function openRejectModal(id, name) {
  document.getElementById('rejectId').value = id;
  document.getElementById('rejectName').textContent = name;
  new bootstrap.Modal(document.getElementById('rejectModal')).show();
}

function openDetailModal(id) {
  document.querySelectorAll('[id^="detail-"]').forEach(el => el.style.display = 'none');
  const el = document.getElementById('detail-' + id);
  if (el) el.style.display = 'block';
  new bootstrap.Modal(document.getElementById('detailModal')).show();
}
</script>
</body>
</html>
