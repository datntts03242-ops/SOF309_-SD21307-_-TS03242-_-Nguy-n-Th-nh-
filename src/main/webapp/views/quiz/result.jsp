<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html lang="vi">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Kết quả Quiz – Sử Môn</title>
  <jsp:include page="/common/head-resources.jsp"/>
  <style>
    .result-hero { background: linear-gradient(135deg, var(--c-primary), #1a0a0a); padding: 3rem 1rem; text-align: center; }
    .score-circle {
      width: 140px; height: 140px; border-radius: 50%; margin: 0 auto 1.5rem;
      display: flex; flex-direction: column; align-items: center; justify-content: center;
      background: #1e293b;
      box-shadow: 0 0 0 8px rgba(212,160,23,.12);
      position: relative;
    }
    .score-circle .pct { font-family: var(--f-display); font-size: 2rem; font-weight: 700; color: #fff; line-height: 1; }
    .score-circle .lbl { font-size: .72rem; color: rgba(255,255,255,.6); text-transform: uppercase; letter-spacing: .1em; }
    .result-hero h2 { font-family: var(--f-display); font-size: 2rem; color: #fff; margin-bottom: .5rem; }
    .result-hero p { color: rgba(255,255,255,.6); }
    .stats-row { display: flex; justify-content: center; gap: 2.5rem; margin-top: 1.5rem; flex-wrap: wrap; }
    .stat-item .num { font-size: 2rem; font-weight: 800; }
    .stat-item .tag { font-size: .78rem; text-transform: uppercase; letter-spacing: .1em; color: rgba(255,255,255,.5); }
    .correct-num { color: #34d399; }
    .wrong-num { color: #f87171; }

    .wrong-card { background: var(--c-surface); border-radius: 14px; border: 1px solid var(--c-border); padding: 1.25rem; margin-bottom: 1rem; }
    .wrong-card .q-text { font-weight: 600; color: var(--c-primary); margin-bottom: .75rem; }
    .wrong-answer { color: #e53e3e; font-size: .875rem; }
    .correct-answer { color: #38a169; font-size: .875rem; font-weight: 600; }
  </style>
</head>
<body class="bg-light-page">
<jsp:include page="/common/header.jsp"/>

<div class="result-hero">
  <div class="score-circle">
    <span class="pct">${result.percentage}%</span>
    <span class="lbl">Điểm</span>
  </div>
  <h2>Kết quả Quiz</h2>
  <p>Bạn đã hoàn thành bài quiz lịch sử!</p>
  <div class="stats-row">
    <div class="stat-item text-center">
      <div class="num correct-num">${result.correctCount}</div>
      <div class="tag">Đúng</div>
    </div>
    <div class="stat-item text-center">
      <div class="num wrong-num">${result.wrongCount}</div>
      <div class="tag">Sai</div>
    </div>
    <div class="stat-item text-center">
      <div class="num" style="color:#fff;">${result.totalQuestion}</div>
      <div class="tag">Tổng</div>
    </div>
  </div>
</div>

<div class="container py-4" style="max-width:760px;">
  <div class="progress mb-4" style="height:10px;border-radius:99px;">
    <div class="progress-bar" style="width:${result.percentage}%;background:var(--c-gold);border-radius:99px;"></div>
  </div>

  <c:if test="${not empty result.wrongQuestions}">
    <h5 class="fw-bold mb-3" style="color:var(--c-primary);">❌ Các câu trả lời sai</h5>
    <c:forEach items="${result.wrongQuestions}" var="q">
      <div class="wrong-card">
        <p class="q-text">${q.questionText}</p>
        <p class="wrong-answer">✗ Bạn chọn: ${q.userAnswer}</p>
        <p class="correct-answer">✓ Đáp án đúng: ${q.correctAnswer}</p>
      </div>
    </c:forEach>
  </c:if>

  <c:if test="${empty result.wrongQuestions}">
    <div class="text-center py-4">
      <div style="font-size:3rem;margin-bottom:.75rem;">🎉</div>
      <h5 class="fw-bold">Hoàn hảo! Bạn trả lời đúng tất cả!</h5>
    </div>
  </c:if>

  <div class="d-flex gap-3 justify-content-center mt-4 flex-wrap">
    <a href="${pageContext.request.contextPath}/quiz" class="btn-su-gold">🔄 Làm lại</a>
    <a href="${pageContext.request.contextPath}/characters" class="btn-su-outline">Khám phá nhân vật</a>
  </div>
</div>

<jsp:include page="/common/footer.jsp"/>
<script>
// Set conic-gradient bằng JS để tránh EL trong CSS
const pct = parseFloat('${result.percentage}') || 0;
document.querySelector('.score-circle').style.background =
  'conic-gradient(#D4A017 ' + pct + '%, rgba(255,255,255,.08) 0)';
</script>
</body>
</html>
