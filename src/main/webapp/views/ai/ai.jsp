<%@ page contentType="text/html; charset=UTF-8" %>
<% request.setAttribute("activePage","ai"); %>
<!DOCTYPE html>
<html lang="vi">
<head>
  <title>Sử Môn AI – Trợ lý Lịch sử</title>
  <jsp:include page="/common/head-resources.jsp"/>
  <style>
    body { background: var(--c-bg); }
    .ai-page-hero {
      background: linear-gradient(135deg, var(--c-primary) 0%, #1a0a0a 100%);
      padding: 3rem 1rem 2.5rem; text-align: center;
    }
    .ai-page-hero h1 { font-family: var(--f-display); color: #fff; font-size: clamp(1.8rem,4vw,2.8rem); margin-bottom: .5rem; }
    .ai-page-hero p { color: rgba(255,255,255,.6); font-size: .95rem; }
    .ai-fullbox {
      max-width: 760px; margin: 2rem auto; background: var(--c-surface);
      border-radius: 20px; box-shadow: var(--sh-hover); overflow: hidden;
      border: 1px solid var(--c-border); display: flex; flex-direction: column;
      height: 560px;
    }
    .ai-fullbox-header {
      background: linear-gradient(135deg, var(--c-red), #8b0000);
      color: #fff; padding: 1rem 1.25rem; font-weight: 600; font-size: .95rem;
      display: flex; align-items: center; gap: .5rem;
    }
    .ai-fullbox-messages {
      flex: 1; padding: 1rem; overflow-y: auto; background: #f8fafc; display: flex; flex-direction: column; gap: .6rem;
    }
    .ai-fullbox-msg { padding: .7rem .9rem; border-radius: 12px; font-size: .875rem; line-height: 1.55; max-width: 85%; }
    .ai-fullbox-msg.bot { background: #fff; color: var(--c-primary); border: 1px solid var(--c-border); align-self: flex-start; border-bottom-left-radius: 4px; }
    .ai-fullbox-msg.user { background: var(--c-red); color: #fff; align-self: flex-end; border-bottom-right-radius: 4px; }
    .ai-fullbox-input { display: flex; border-top: 1px solid var(--c-border); background: #fff; }
    .ai-fullbox-input input { flex: 1; padding: .85rem 1rem; border: none; outline: none; font-size: .875rem; font-family: var(--f-body); }
    .ai-fullbox-input button { background: var(--c-red); color: #fff; border: none; padding: .85rem 1.25rem; cursor: pointer; font-weight: 600; font-size: .875rem; transition: background .2s; }
    .ai-fullbox-input button:hover { background: #8b0000; }
  </style>
</head>
<body class="bg-light-page">
<jsp:include page="/common/header.jsp"/>

<div class="ai-page-hero">
  <h1>🤖 Sử Môn AI</h1>
  <p>Trợ lý trí tuệ nhân tạo — hỏi đáp về lịch sử Việt Nam</p>
</div>

<div class="container">
  <div class="ai-fullbox">
    <div class="ai-fullbox-header">🤖 Trợ lý Sử Môn AI</div>
    <div class="ai-fullbox-messages" id="aiFullMessages">
      <div class="ai-fullbox-msg bot">Xin chào! Tôi là Sử Môn AI. Hãy hỏi tôi bất kỳ điều gì về lịch sử Việt Nam! 🏯</div>
    </div>
    <div class="ai-fullbox-input">
      <input id="aiFullInput" type="text" placeholder="Ví dụ: Trần Hưng Đạo đã đánh bại quân Nguyên như thế nào?">
      <button onclick="sendFullMsg()">Gửi ➤</button>
    </div>
  </div>
</div>

<jsp:include page="/common/footer.jsp"/>

<script>
async function sendFullMsg() {
  const input = document.getElementById('aiFullInput');
  const msg = input.value.trim();
  if (!msg) return;
  addMsg(msg, 'user');
  input.value = '';
  addMsg('Đang suy nghĩ...', 'bot');
  try {
    const res = await fetch('${pageContext.request.contextPath}/ai-chat', {
      method: 'POST',
      headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
      body: 'message=' + encodeURIComponent(msg)
    });
    const data = await res.json();
    const bots = document.querySelectorAll('.ai-fullbox-msg.bot');
    bots[bots.length - 1].textContent = data.reply;
  } catch {
    const bots = document.querySelectorAll('.ai-fullbox-msg.bot');
    bots[bots.length - 1].textContent = 'Không thể kết nối AI. Thử lại sau.';
  }
}
function addMsg(text, type) {
  const box = document.getElementById('aiFullMessages');
  const div = document.createElement('div');
  div.className = 'ai-fullbox-msg ' + type;
  div.textContent = text;
  box.appendChild(div);
  box.scrollTop = box.scrollHeight;
}
document.getElementById('aiFullInput').addEventListener('keypress', e => {
  if (e.key === 'Enter') sendFullMsg();
});
</script>
</body>
</html>
