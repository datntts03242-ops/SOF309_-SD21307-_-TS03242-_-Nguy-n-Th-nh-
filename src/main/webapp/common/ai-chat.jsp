<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<style>
.ai-button {
    position: fixed;
    bottom: 20px;
    right: 20px;
    background: linear-gradient(135deg,#dc3545,#b02a37);
    color: white;
    border: none;
    padding: 12px 18px;
    border-radius: 50px;
    cursor: pointer;
    font-weight: bold;
    z-index: 9999;

    /* ❌ BAN ĐẦU ẨN NÚT */
    display: none;
}

.ai-chat-box {
    position: fixed;
    bottom: 80px;
    right: 20px;
    width: 340px;
    height: 450px;
    background: #fff;
    border-radius: 16px;
    box-shadow: 0 15px 40px rgba(0,0,0,0.25);

    display: none;

    flex-direction: column;
    overflow: hidden;
    z-index: 10000;
}

.ai-header {
    background: linear-gradient(135deg,#dc3545,#b02a37);
    color: white;
    padding: 14px;
    display: flex;
    justify-content: space-between;
    align-items: center;
    font-weight: 600;
}

.ai-header button {
    width: 32px;
    height: 32px;
    border: none;
    border-radius: 50%;
    background: rgba(255,255,255,0.2);
    color: white;
    cursor: pointer;
}

.ai-messages {
    flex: 1;
    padding: 10px;
    overflow-y: auto;
    background: #f8f9fa;
}

.ai-msg {
    margin-bottom: 10px;
    padding: 10px;
    border-radius: 12px;
}

.bot {
    background: #e9ecef;
}

.user {
    background: #dc3545;
    color: white;
    text-align: right;
}

.ai-input {
    display: flex;
    padding: 10px;
    gap: 8px;
    border-top: 1px solid #eee;
}

.ai-input input {
    flex: 1;
    padding: 10px;
    border-radius: 20px;
    border: 1px solid #ddd;
    outline: none;
}

.ai-input button {
    background: #dc3545;
    color: white;
    border: none;
    padding: 10px 16px;
    border-radius: 20px;
    cursor: pointer;
}
</style>

<!-- BUTTON (ẩn ban đầu) -->
<button id="aiButton" class="ai-button" onclick="toggleAIChatBox()">
    🤖 Sử Môn AI
</button>

<!-- CHAT BOX -->
<div id="aiBox" class="ai-chat-box">

    <div class="ai-header">
        <span>🤖 Sử Môn AI</span>
        <button onclick="toggleAIChatBox()">✖</button>
    </div>

    <div id="aiMessages" class="ai-messages">
        <div class="ai-msg bot">
            Xin chào! Tôi là Sử Môn AI.
        </div>
    </div>

    <div class="ai-input">
        <input id="aiInput" type="text" placeholder="Hỏi về lịch sử Việt Nam...">
        <button onclick="sendMsg()">Gửi</button>
    </div>

</div>

<script>

/* =====================
   1. MỞ TỪ MENU
===================== */
function showAIButton() {

    const btn = document.getElementById("aiButton");

    if (!btn) return;

    if (btn.style.display === "block") {

        btn.style.display = "none";

        // ❌ luôn đóng chat nếu đang mở
        const box = document.getElementById("aiBox");
        if (box) box.style.display = "none";

    } else {

        btn.style.display = "block";
    }
}

/* =====================
   2. TOGGLE CHAT BOX
===================== */
function toggleAIChatBox() {

    const box = document.getElementById("aiBox");
    if (!box) return;

    if (box.style.display === "none" || box.style.display === "") {
        box.style.display = "flex";
    } else {
        box.style.display = "none";
    }
}

/* =====================
   3. SEND MESSAGE
===================== */
async function sendMsg() {

    const input = document.getElementById("aiInput");
    const msg = input.value.trim();

    if (!msg) return;

    addMsg(msg, "user");
    input.value = "";

    addMsg("Đang suy nghĩ...", "bot");

    try {
        const res = await fetch("${pageContext.request.contextPath}/ai-chat", {
            method: "POST",
            headers: {
                "Content-Type": "application/x-www-form-urlencoded"
            },
            body: "message=" + encodeURIComponent(msg)
        });

        const data = await res.json();

        const bots = document.querySelectorAll(".bot");
        bots[bots.length - 1].innerText = data.reply;

    } catch (e) {

        const bots = document.querySelectorAll(".bot");
        bots[bots.length - 1].innerText = "Không thể kết nối AI.";
    }
}

/* =====================
   4. ADD MESSAGE
===================== */
function addMsg(text, type) {

    const box = document.getElementById("aiMessages");

    const div = document.createElement("div");
    div.classList.add("ai-msg", type);
    div.innerText = text;

    box.appendChild(div);
    box.scrollTop = box.scrollHeight;
}

/* =====================
   5. ENTER KEY
===================== */
document.addEventListener("DOMContentLoaded", function () {

    const input = document.getElementById("aiInput");

    if (input) {
        input.addEventListener("keypress", function (e) {
            if (e.key === "Enter") {
                sendMsg();
            }
        });
    }
});
</script>