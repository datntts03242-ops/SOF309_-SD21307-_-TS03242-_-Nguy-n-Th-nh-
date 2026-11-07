<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Đăng nhập – Sử Môn</title>
  <jsp:include page="/common/head-resources.jsp"/>
  <style>
    body {
      background: #0F172A !important;
      padding-top: 0;
      min-height: 100vh;
      display: flex;
      align-items: center;
      justify-content: center;
    }

    .auth-wrapper {
      display: grid; grid-template-columns: 1fr 1fr; min-height: 100vh; width: 100%;
    }

    /* Left panel */
    .auth-left {
      background: linear-gradient(145deg, #1a0a0a 0%, var(--c-primary) 60%);
      display: flex; flex-direction: column; align-items: center; justify-content: center;
      padding: 3rem; position: relative; overflow: hidden;
    }
    .auth-left::before {
      content: ''; position: absolute; top: -80px; left: -80px;
      width: 320px; height: 320px;
      background: radial-gradient(circle, rgba(212,160,23,.12) 0%, transparent 70%);
      pointer-events: none;
    }
    .auth-left::after {
      content: ''; position: absolute; bottom: -60px; right: -60px;
      width: 250px; height: 250px;
      background: radial-gradient(circle, rgba(165,0,0,.1) 0%, transparent 70%);
      pointer-events: none;
    }
    .auth-left img { width: 90px; margin-bottom: 1.5rem; filter: drop-shadow(0 4px 20px rgba(212,160,23,.4)); position: relative; z-index: 1; }
    .auth-left h1 { font-family: var(--f-display); font-size: 3rem; font-weight: 700; color: #fff; margin-bottom: .5rem; position: relative; z-index: 1; }
    .auth-left h1 span { color: var(--c-gold); }
    .auth-left p { color: rgba(255,255,255,.55); font-size: .95rem; text-align: center; max-width: 280px; position: relative; z-index: 1; }

    /* Right panel */
    .auth-right {
      background: #fff; display: flex; flex-direction: column;
      align-items: center; justify-content: center; padding: 3rem 2.5rem;
    }
    .auth-form-box { width: 100%; max-width: 380px; }
    .auth-form-box h2 { font-size: 1.6rem; font-weight: 700; color: var(--c-primary); margin-bottom: .35rem; }
    .auth-form-box .subtitle { font-size: .875rem; color: var(--c-muted); margin-bottom: 2rem; }

    .form-label { font-size: .82rem; font-weight: 600; color: #374151; margin-bottom: .35rem; }

    .btn-auth {
      width: 100%; padding: .8rem; border-radius: 10px; border: none;
      background: var(--c-red); color: #fff; font-weight: 700; font-size: .95rem;
      cursor: pointer; transition: var(--t-base); margin-top: .5rem;
    }
    .btn-auth:hover { background: #8b0000; transform: translateY(-2px); box-shadow: 0 8px 24px rgba(165,0,0,.3); }

    .auth-divider { display: flex; align-items: center; gap: .75rem; margin: 1.25rem 0; }
    .auth-divider span { font-size: .78rem; color: var(--c-muted); white-space: nowrap; }
    .auth-divider::before, .auth-divider::after { content: ''; flex: 1; height: 1px; background: var(--c-border); }

    .auth-link { font-size: .875rem; color: var(--c-muted); text-align: center; margin-top: 1.25rem; }
    .auth-link a { color: var(--c-red); font-weight: 600; text-decoration: none; }
    .auth-link a:hover { text-decoration: underline; }

    .alert-error {
      background: #fff5f5; border: 1px solid #fed7d7; color: #c53030;
      border-radius: 8px; padding: .7rem 1rem; font-size: .875rem; margin-bottom: 1rem;
      display: flex; align-items: center; gap: .5rem;
    }

    @media (max-width: 767px) {
      .auth-wrapper { grid-template-columns: 1fr; }
      .auth-left { display: none; }
      .auth-right { padding: 2rem 1.25rem; }
    }
  </style>
</head>
<body>
<div class="auth-wrapper">

  <!-- LEFT PANEL -->
  <div class="auth-left">
    <img src="${pageContext.request.contextPath}/assets/images/logo-su-mon.png" alt="Logo">
    <h1>Sử <span>Môn</span></h1>
    <p>Cánh cổng khám phá 4000 năm lịch sử Việt Nam</p>
  </div>

  <!-- RIGHT PANEL -->
  <div class="auth-right">
    <div class="auth-form-box">
      <h2>Chào mừng trở lại</h2>
      <p class="subtitle">Đăng nhập để tiếp tục hành trình lịch sử</p>

      <c:if test="${not empty error}">
        <div class="alert-error">⚠ ${error}</div>
      </c:if>

      <form method="post" action="${pageContext.request.contextPath}/login">
        <div class="mb-3">
          <label class="form-label">Tài khoản</label>
          <input type="text" name="username" class="form-control" placeholder="Nhập tài khoản" required autofocus>
        </div>
        <div class="mb-3">
          <label class="form-label">Mật khẩu</label>
          <input type="password" name="password" class="form-control" placeholder="••••••••" required>
        </div>
        <button type="submit" class="btn-auth">Đăng nhập</button>
      </form>

      <div class="auth-link">
        Chưa có tài khoản? <a href="${pageContext.request.contextPath}/register">Đăng ký ngay</a>
      </div>
      <div class="auth-link mt-2">
        <a href="${pageContext.request.contextPath}/">← Quay về trang chủ</a>
      </div>
    </div>
  </div>

</div>
</body>
</html>

