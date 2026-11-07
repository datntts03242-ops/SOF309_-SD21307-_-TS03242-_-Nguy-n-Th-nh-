<%@ page contentType="text/html;charset=UTF-8" %>
<% request.setAttribute("activePage","quiz"); %>
<!DOCTYPE html>
<html lang="vi">
<head>
  <title>Quiz Lịch Sử – Sử Môn</title>
  <jsp:include page="/common/head-resources.jsp"/>
  <style>
    .quiz-start-wrap {
      min-height: 100vh; padding-top: 72px;
      display: flex; align-items: center; justify-content: center;
      background: linear-gradient(135deg, #0F172A 0%, #1a0a0a 100%);
      padding: 6rem 1rem 2rem;
    }
    .quiz-start-card {
      background: #fff; border-radius: 24px;
      padding: 3.5rem 3rem; max-width: 520px; width: 100%;
      box-shadow: 0 24px 64px rgba(0,0,0,.35); text-align: center;
    }
    .quiz-icon { font-size: 4rem; margin-bottom: 1.5rem; }
    .quiz-start-card h1 { font-family: 'Cormorant Garamond',serif; font-size: 2.4rem; font-weight: 700; color: #0F172A; margin-bottom: .5rem; }
    .quiz-start-card p { color: #64748B; font-size: .95rem; line-height: 1.7; margin-bottom: 2rem; }
    .quiz-info { display: flex; justify-content: center; gap: 2rem; margin-bottom: 2rem; }
    .quiz-info-item { text-align: center; }
    .quiz-info-item .val { font-size: 1.5rem; font-weight: 800; color: #A50000; }
    .quiz-info-item .lbl { font-size: .78rem; color: #64748B; text-transform: uppercase; letter-spacing: .08em; }
  </style>
</head>
<body style="background:#0F172A;padding-top:0;">
<jsp:include page="/common/header.jsp"/>
<div class="quiz-start-wrap">
  <div class="quiz-start-card">
    <div class="quiz-icon">🏛️</div>
    <h1>Quiz Lịch Sử</h1>
    <p>Thử thách kiến thức lịch sử Việt Nam qua 10 câu hỏi ngẫu nhiên về nhân vật, triều đại và sự kiện.</p>

    <div class="quiz-info">
      <div class="quiz-info-item">
        <div class="val">10</div>
        <div class="lbl">câu hỏi</div>
      </div>
      <div class="quiz-info-item">
        <div class="val">4</div>
        <div class="lbl">đáp án / câu</div>
      </div>
      <div class="quiz-info-item">
        <div class="val">5</div>
        <div class="lbl">loại câu hỏi</div>
      </div>
    </div>

    <a href="${pageContext.request.contextPath}/quiz?action=start" class="btn-su-primary w-100 justify-content-center" style="border-radius:12px;padding:.9rem;">
      🚀 Bắt đầu Quiz
    </a>
    <a href="${pageContext.request.contextPath}/" class="btn-su-outline mt-3 w-100 justify-content-center" style="border-radius:12px;">← Quay lại</a>
  </div>
</div>
<jsp:include page="/common/footer.jsp"/>
</body>
</html>

