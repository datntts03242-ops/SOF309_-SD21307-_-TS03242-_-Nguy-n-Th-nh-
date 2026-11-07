<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fn" uri="jakarta.tags.functions"%>
<% request.setAttribute("activePage","quiz"); %>
<!DOCTYPE html>
<html lang="vi">
<head>
  <title>Quiz – Sử Môn</title>
  <jsp:include page="/common/head-resources.jsp"/>
  <style>
    .quiz-body { background: var(--c-bg); min-height: 100vh; }
    .quiz-header {
      background: linear-gradient(135deg, var(--c-primary), #1a0a0a);
      padding: 1.5rem 0; text-align: center; margin-bottom: 2rem;
    }
    .quiz-header h2 { font-family: var(--f-display); font-size: 1.8rem; color: #fff; margin: 0; }
    .quiz-progress { height: 4px; background: rgba(255,255,255,.1); border-radius: 2px; max-width: 400px; margin: .75rem auto 0; }
    .quiz-progress-fill { height: 100%; background: var(--c-gold); border-radius: 2px; transition: width .4s ease; }

    .q-card {
      background: var(--c-surface); border-radius: 16px; border: 1px solid var(--c-border);
      box-shadow: var(--sh-card); padding: 1.75rem; margin-bottom: 1.5rem;
    }
    .q-num { font-size: .78rem; font-weight: 700; letter-spacing: .12em; text-transform: uppercase; color: var(--c-red); margin-bottom: .5rem; }
    .q-text { font-size: 1rem; font-weight: 600; color: var(--c-primary); margin-bottom: 1.1rem; line-height: 1.6; }
    .q-img { max-height: 220px; border-radius: 10px; margin-bottom: 1rem; object-fit: cover; }

    .option-label {
      display: flex; align-items: center; gap: .75rem;
      padding: .7rem 1rem; border-radius: 10px; border: 1.5px solid var(--c-border);
      cursor: pointer; transition: var(--t-base); margin-bottom: .5rem; font-size: .9rem;
    }
    .option-label:hover { border-color: var(--c-red); background: rgba(165,0,0,.04); }
    input[type="radio"]:checked + .option-label { border-color: var(--c-red); background: rgba(165,0,0,.06); color: var(--c-red); font-weight: 600; }
  </style>
</head>
<body class="bg-light-page">
<jsp:include page="/common/header.jsp"/>

<div class="quiz-header">
  <h2>🏛️ Quiz Lịch Sử Việt Nam</h2>
  <div class="quiz-progress"><div class="quiz-progress-fill" id="progressBar" style="width:0%"></div></div>
</div>

<div class="container pb-5" style="max-width:760px;">
  <form action="${pageContext.request.contextPath}/quiz" method="post" id="quizForm">
    <c:forEach items="${questions}" var="q" varStatus="s">
      <div class="q-card">
        <div class="q-num">Câu ${s.index + 1} / ${fn:length(questions)}</div>
        <p class="q-text">${q.questionText}</p>
        <c:if test="${not empty q.image}">
          <img src="${pageContext.request.contextPath}/assets/images/characters/${q.image}" class="q-img img-fluid">
        </c:if>
        <c:forEach items="${q.options}" var="op">
          <div>
            <input type="radio" name="q${q.id}" value="${op}" id="q${q.id}_${op}" required style="display:none;">
            <label for="q${q.id}_${op}" class="option-label">${op}</label>
          </div>
        </c:forEach>
      </div>
    </c:forEach>

    <div class="text-center mt-4">
      <button type="submit" class="btn-su-gold" style="padding:.9rem 3rem;border-radius:12px;font-size:1rem;">
        ✅ Nộp bài
      </button>
    </div>
  </form>
</div>

<jsp:include page="/common/footer.jsp"/>
<script>
// Progress bar update as user answers
const totalQ = ${fn:length(questions)};
function updateProgress() {
  const answered = new Set(
    [...document.querySelectorAll('input[type=radio]:checked')].map(r => r.name)
  ).size;
  document.getElementById('progressBar').style.width = (answered / totalQ * 100) + '%';
}
document.querySelectorAll('input[type=radio]').forEach(r => r.addEventListener('change', updateProgress));
// Style checked radios
document.querySelectorAll('input[type=radio]').forEach(r => {
  r.addEventListener('change', function() {
    document.querySelectorAll('input[name="' + this.name + '"]').forEach(s => {
      s.nextElementSibling.style.borderColor = '';
      s.nextElementSibling.style.background = '';
    });
  });
});
</script>
</body>
</html>
