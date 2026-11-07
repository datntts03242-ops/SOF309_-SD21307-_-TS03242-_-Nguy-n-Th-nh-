<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<footer class="su-footer mt-5">
  <div class="container">
    <div class="row g-4 pb-4 border-bottom" style="border-color:rgba(255,255,255,.07)!important;">

      <div class="col-md-4">
        <a href="${pageContext.request.contextPath}/" class="d-flex align-items-center gap-2 text-decoration-none mb-3">
          <img src="${pageContext.request.contextPath}/assets/images/logo-su-mon.png" height="36" alt="logo">
          <span class="brand-name">Sử Môn</span>
        </a>
        <p style="font-size:.85rem;color:rgba(255,255,255,.4);line-height:1.75;max-width:280px;">
          Nền tảng khám phá lịch sử Việt Nam — nhân vật, triều đại và sự kiện.
        </p>
      </div>

      <div class="col-md-2 offset-md-1">
        <p style="font-size:.7rem;letter-spacing:.2em;text-transform:uppercase;color:rgba(212,160,23,.8);font-weight:600;margin-bottom:.75rem;">Khám phá</p>
        <ul class="list-unstyled d-flex flex-column gap-2">
          <li><a href="${pageContext.request.contextPath}/characters">Nhân vật</a></li>
          <li><a href="${pageContext.request.contextPath}/dynasties">Triều đại</a></li>
          <li><a href="${pageContext.request.contextPath}/timeline">Dòng thời gian</a></li>
          <li><a href="${pageContext.request.contextPath}/quiz">Quiz lịch sử</a></li>
        </ul>
      </div>

      <div class="col-md-2">
        <p style="font-size:.7rem;letter-spacing:.2em;text-transform:uppercase;color:rgba(212,160,23,.8);font-weight:600;margin-bottom:.75rem;">Tài khoản</p>
        <ul class="list-unstyled d-flex flex-column gap-2">
          <li><a href="${pageContext.request.contextPath}/login">Đăng nhập</a></li>
          <li><a href="${pageContext.request.contextPath}/register">Đăng ký</a></li>
          <li><a href="${pageContext.request.contextPath}/profile">Hồ sơ</a></li>
          <li><a href="${pageContext.request.contextPath}/favorites">Yêu thích</a></li>
        </ul>
      </div>

    </div>

    <div class="d-flex justify-content-between align-items-center flex-wrap gap-2 pt-3">
      <span style="font-size:.78rem;color:rgba(255,255,255,.25);">© 2026 Sử Môn. All rights reserved.</span>
      <span style="font-size:.72rem;color:rgba(255,255,255,.18);letter-spacing:.1em;text-transform:uppercase;">Lịch sử Việt Nam</span>
    </div>
  </div>
</footer>

<%-- Bootstrap JS chỉ load 1 lần ở đây, KHÔNG load trong head-resources.jsp --%>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/js/bootstrap.bundle.min.js"></script>
<jsp:include page="/common/ai-chat.jsp"/>
<jsp:include page="/common/support-chat.jsp"/>
