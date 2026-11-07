<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<% request.setAttribute("activePage","characters"); %>
<!DOCTYPE html>
<html lang="vi">
<head>
  <title>Đóng góp nhân vật – Sử Môn</title>
  <jsp:include page="/common/head-resources.jsp"/>
  <style>
    .submit-card {
      background: #fff; border-radius: 18px; border: 1px solid var(--c-border);
      box-shadow: var(--sh-card); padding: 2.5rem;
    }
    .submit-hero {
      background: linear-gradient(135deg, #0F172A, #1a0a0a);
      padding: 3rem 1rem 2.5rem; text-align: center;
    }
    .submit-hero h1,
    .submit-hero h2,
    .submit-hero p,
    .submit-hero span {
      color: #fff !important;
    }
    .submit-hero p { opacity: .75; font-size:.95rem; margin:.5rem 0 0; }
    .req { color: var(--c-red); }
    .preview-img {
      width: 120px; height: 150px; object-fit: cover; border-radius: 10px;
      border: 2px dashed var(--c-border);
    }
  </style>
</head>
<body class="bg-light-page">
<jsp:include page="/common/header.jsp"/>

<!-- HERO -->
<div class="submit-hero">
  <h1>📝 Đóng Góp Nhân Vật Lịch Sử</h1>
  <p>Chia sẻ kiến thức — đóng góp sẽ được admin xem xét và duyệt</p>
</div>

<div class="container py-4" style="max-width:800px;">

  <!-- ERROR -->
  <c:if test="${not empty error}">
    <div class="alert alert-danger rounded-3 mb-4">
      <i class="fa-solid fa-triangle-exclamation me-2"></i>${error}
    </div>
  </c:if>

  <div class="submit-card">
    <form action="${pageContext.request.contextPath}/submit-character"
          method="post" enctype="multipart/form-data">

      <div class="row g-3">

        <!-- Tên + Triều đại -->
        <div class="col-md-6">
          <label class="form-label fw-semibold">Tên nhân vật <span class="req">*</span></label>
          <input name="name" class="form-control" placeholder="Ví dụ: Trần Hưng Đạo" required>
        </div>
        <div class="col-md-6">
          <label class="form-label fw-semibold">Triều đại <span class="req">*</span></label>
          <input name="dynasty" class="form-control" placeholder="Ví dụ: Nhà Trần" required>
        </div>

        <!-- Ảnh + Mô tả cùng hàng -->
        <div class="col-md-3">
          <label class="form-label fw-semibold">Ảnh nhân vật</label>
          <input type="file" name="image" class="form-control mb-2" accept="image/*"
                 onchange="previewImg(event)">
          <img id="preview" class="preview-img"
               src="${pageContext.request.contextPath}/assets/images/no-image.png">
        </div>

        <!-- Mô tả -->
        <div class="col-md-9">
          <label class="form-label fw-semibold">Mô tả ngắn <span class="req">*</span></label>
          <textarea name="description" class="form-control" rows="4"
                    placeholder="Một đoạn ngắn giới thiệu nhân vật..." required></textarea>
        </div>

        <!-- Tiểu sử -->
        <div class="col-12">
          <label class="form-label fw-semibold">Tiểu sử</label>
          <textarea name="biography" class="form-control" rows="5"
                    placeholder="Cuộc đời, sự nghiệp..."></textarea>
        </div>

        <!-- Thành tựu -->
        <div class="col-12">
          <label class="form-label fw-semibold">Thành tựu nổi bật</label>
          <textarea name="achievement" class="form-control" rows="4"
                    placeholder="Những đóng góp, chiến công..."></textarea>
        </div>

        <!-- Quê quán + Di tích -->
        <div class="col-md-6">
          <label class="form-label fw-semibold">Quê quán</label>
          <input name="birthPlace" class="form-control" placeholder="Tỉnh / thành phố">
        </div>
        <div class="col-md-6">
          <label class="form-label fw-semibold">Địa danh lịch sử</label>
          <input name="historicalSite" class="form-control" placeholder="Đền, lăng, di tích...">
        </div>

        <!-- Buttons -->
        <div class="col-12 d-flex gap-3 pt-2">
          <button type="submit" class="btn-su-primary">
            <i class="fa-solid fa-paper-plane me-1"></i> Gửi xét duyệt
          </button>
          <a href="${pageContext.request.contextPath}/characters" class="btn-su-outline">
            ← Quay lại
          </a>
        </div>

      </div>
    </form>
  </div>

  <!-- INFO BOX -->
  <div class="mt-4 p-3 rounded-3" style="background:#fffbeb;border:1px solid #fcd34d;">
    <h6 style="color:#92400e;font-weight:700;">📌 Lưu ý khi đóng góp</h6>
    <ul style="color:#78350f;font-size:.875rem;margin:.5rem 0 0;padding-left:1.25rem;">
      <li>Thông tin phải chính xác và có nguồn gốc rõ ràng</li>
      <li>Admin sẽ xem xét trong vòng 1–3 ngày</li>
      <li>Đóng góp được duyệt sẽ hiển thị trong danh sách nhân vật</li>
    </ul>
  </div>

</div>

<jsp:include page="/common/footer.jsp"/>
<script>
function previewImg(e) {
  if (!e.target.files.length) return;
  const reader = new FileReader();
  reader.onload = ev => document.getElementById('preview').src = ev.target.result;
  reader.readAsDataURL(e.target.files[0]);
}
</script>
</body>
</html>
