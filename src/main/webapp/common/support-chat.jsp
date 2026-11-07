<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>

<c:if test="${empty sessionScope.user || fn:toUpperCase(sessionScope.user.role) ne 'ADMIN'}">

<style>
.support-button {
    position: fixed;
    bottom: 84px;
    right: 20px;
    background: linear-gradient(135deg, var(--c-primary, #0F172A), #1E293B);
    color: var(--c-gold, #D4A017);
    border: 1px solid rgba(212,160,23,.4);
    width: 56px;
    height: 56px;
    border-radius: 50%;
    cursor: pointer;
    font-size: 1.4rem;
    z-index: 9998;
    display: flex;
    align-items: center;
    justify-content: center;
    box-shadow: 0 8px 24px rgba(15,23,42,.35);
    transition: transform .25s ease, box-shadow .25s ease;
}
.support-button:hover {
    transform: translateY(-3px) scale(1.05);
    box-shadow: 0 12px 30px rgba(212,160,23,.35);
}
.support-badge {
    position: absolute;
    top: -4px;
    right: -4px;
    background: var(--c-red, #A50000);
    color: #fff;
    font-size: .68rem;
    font-weight: 700;
    min-width: 19px;
    height: 19px;
    border-radius: 999px;
    display: none;
    align-items: center;
    justify-content: center;
    padding: 0 4px;
    border: 2px solid #fff;
}

.support-chat-box {
    position: fixed;
    bottom: 152px;
    right: 20px;
    width: 340px;
    max-width: calc(100vw - 32px);
    height: 460px;
    max-height: calc(100vh - 190px);
    background: #fff;
    border-radius: 18px;
    box-shadow: 0 20px 50px rgba(15,23,42,.28);
    display: none;
    flex-direction: column;
    overflow: hidden;
    z-index: 9999;
    opacity: 0;
    transform: translateY(14px);
    transition: opacity .22s ease, transform .22s ease;
}
.support-chat-box.open {
    display: flex;
    opacity: 1;
    transform: translateY(0);
}

.support-header {
    background: linear-gradient(135deg, var(--c-primary, #0F172A), #1E293B);
    color: #fff;
    padding: 14px 16px;
    display: flex;
    justify-content: space-between;
    align-items: center;
    font-weight: 600;
    font-family: var(--f-body, inherit);
    flex-shrink: 0;
}
.support-header span.title { color: var(--c-gold, #D4A017); font-size: .95rem; }
.support-header button {
    width: 30px;
    height: 30px;
    border: none;
    border-radius: 50%;
    background: rgba(255,255,255,.12);
    color: #fff;
    cursor: pointer;
    font-size: .95rem;
    line-height: 1;
}
.support-header button:hover { background: rgba(255,255,255,.22); }

.support-intro {
    padding: 12px 14px;
    background: #FFFBEB;
    color: #78350F;
    font-size: .8rem;
    line-height: 1.5;
    border-bottom: 1px solid #FDE68A;
    flex-shrink: 0;
}

.support-guest-name {
    padding: 8px 12px;
    border-bottom: 1px solid #eee;
    flex-shrink: 0;
}
.support-guest-name input {
    width: 100%;
    border: 1px solid #E2E8F0;
    border-radius: 8px;
    padding: 6px 10px;
    font-size: .8rem;
    outline: none;
}
.support-guest-name input:focus { border-color: var(--c-gold, #D4A017); }

.support-messages {
    flex: 1;
    padding: 12px;
    overflow-y: auto;
    background: #F8F9FB;
    display: flex;
    flex-direction: column;
    gap: 8px;
}

.support-msg-row { display: flex; flex-direction: column; max-width: 82%; }
.support-msg-row.mine { align-self: flex-end; align-items: flex-end; }
.support-msg-row.theirs { align-self: flex-start; align-items: flex-start; }

.support-bubble {
    padding: 9px 13px;
    border-radius: 14px;
    font-size: .85rem;
    line-height: 1.45;
    word-wrap: break-word;
    white-space: pre-wrap;
}
.support-msg-row.mine .support-bubble {
    background: var(--c-primary, #0F172A);
    color: #fff;
    border-bottom-right-radius: 4px;
}
.support-msg-row.theirs .support-bubble {
    background: #fff;
    color: #111827;
    border: 1px solid #E2E8F0;
    border-bottom-left-radius: 4px;
}
.support-msg-time {
    font-size: .68rem;
    color: #9CA3AF;
    margin-top: 3px;
    padding: 0 3px;
}

.support-msg-row.is-deleted .support-bubble {
    font-style: italic;
    color: #9CA3AF;
    background: #F3F4F6 !important;
    border-color: #E2E8F0 !important;
}

.support-blocked-banner {
    display: none;
    background: #FEF2F2;
    color: #A50000;
    font-size: .76rem;
    padding: 8px 12px;
    border-bottom: 1px solid #FECACA;
    flex-shrink: 0;
}
.support-blocked-banner.show { display: block; }

.support-input {
    display: flex;
    align-items: flex-end;
    gap: 8px;
    padding: 10px;
    border-top: 1px solid #eee;
    flex-shrink: 0;
    background: #fff;
}
.support-input textarea {
    flex: 1;
    resize: none;
    border: 1px solid #E2E8F0;
    border-radius: 16px;
    padding: 9px 13px;
    font-size: .85rem;
    outline: none;
    max-height: 80px;
    font-family: inherit;
}
.support-input textarea:focus { border-color: var(--c-gold, #D4A017); }
.support-input button {
    background: var(--c-gold, #D4A017);
    color: #1a1400;
    border: none;
    width: 40px;
    height: 40px;
    border-radius: 50%;
    cursor: pointer;
    font-size: 1rem;
    flex-shrink: 0;
    transition: filter .2s ease;
}
.support-input button:hover { filter: brightness(1.08); }
.support-input button:disabled { opacity: .5; cursor: not-allowed; }

@media (max-width: 480px) {
    .support-chat-box { width: calc(100vw - 24px); right: 12px; bottom: 140px; }
    .support-button { right: 14px; bottom: 78px; }
}
</style>

<button id="supportButton" class="support-button" onclick="toggleSupportChat()" title="Hỗ trợ Sử Môn" aria-label="Mở chat hỗ trợ">
    💬
    <span id="supportBadge" class="support-badge">0</span>
</button>

<div id="supportBox" class="support-chat-box">
    <div class="support-header">
        <span class="title">💬 Hỗ trợ Sử Môn</span>
        <button onclick="toggleSupportChat()" aria-label="Đóng chat">✕</button>
    </div>

    <div class="support-intro">
        Bạn dang cần giúp đỡ? Hãy chat ngay với admin để nhận trợ giúp
    </div>

    <div id="supportBlockedBanner" class="support-blocked-banner">
        🚫 Bạn đã bị quản trị viên chặn và không thể gửi tin nhắn mới. Bạn vẫn có thể xem lại lịch sử trò chuyện.
    </div>

    <div id="supportGuestNameBox" class="support-guest-name" style="display:none;">
        <input id="supportGuestName" type="text" maxlength="50" placeholder="Tên của bạn (không bắt buộc)">
    </div>

    <div id="supportMessages" class="support-messages"></div>

    <div class="support-input">
        <textarea id="supportInput" rows="1" maxlength="1000" placeholder="Nhập tin nhắn của bạn..."></textarea>
        <button id="supportSendBtn" onclick="sendSupportMessage()" aria-label="Gửi">➤</button>
    </div>
</div>

<script>
(function () {
    const CP = "${pageContext.request.contextPath}";

    let isOpen = false;
    let hasInitialized = false;
    let lastMessageId = 0;
    let identityType = null;
    let pollTimer = null;

    const POLL_INTERVAL_MS = 4000;

    function escapeIsHandledByTextContent() { /* dùng textContent khi render, không dùng innerHTML */ }

    function el(id) { return document.getElementById(id); }

    window.toggleSupportChat = function () {
        const box = el("supportBox");
        isOpen = !isOpen;

        if (isOpen) {
            box.classList.add("open");
            if (!hasInitialized) {
                initSupportChat();
                hasInitialized = true;
            } else {
                pollMessages();
            }
        } else {
            box.classList.remove("open");
        }
    };

    function renderMessage(m) {
        const row = document.createElement("div");
        row.className = "support-msg-row " + (m.mine ? "mine" : "theirs") + (m.deleted ? " is-deleted" : "");

        const bubble = document.createElement("div");
        bubble.className = "support-bubble";
        bubble.textContent = m.content; // textContent -> chống XSS

        const time = document.createElement("div");
        time.className = "support-msg-time";
        time.textContent = (m.mine ? "Bạn" : "Admin") + " · " + m.sentAt;

        row.appendChild(bubble);
        row.appendChild(time);
        el("supportMessages").appendChild(row);

        if (m.id && m.id > lastMessageId) lastMessageId = m.id;
    }

    function setBlockedState(blocked) {
        el("supportBlockedBanner").classList.toggle("show", !!blocked);
        el("supportInput").disabled = !!blocked;
        el("supportSendBtn").disabled = !!blocked;
        const guestInput = el("supportGuestName");
        if (guestInput) guestInput.disabled = !!blocked;
    }

    function scrollToBottom() {
        const box = el("supportMessages");
        box.scrollTop = box.scrollHeight;
    }

    function initSupportChat() {
        fetch(CP + "/chat?action=init")
            .then(r => r.json())
            .then(data => {
                identityType = data.identityType;

                if (identityType === "guest") {
                    el("supportGuestNameBox").style.display = "block";
                }

                const msgs = data.messages || [];
                el("supportMessages").innerHTML = "";
                msgs.forEach(renderMessage);
                scrollToBottom();

                setBlockedState(data.blocked);
                updateBadge(0);
                startPolling();
            })
            .catch(() => {});
    }

    function pollMessages() {
        fetch(CP + "/chat?action=poll&afterId=" + lastMessageId)
            .then(r => r.json())
            .then(data => {
                const msgs = data.messages || [];
                if (msgs.length > 0) {
                    msgs.forEach(renderMessage);
                    scrollToBottom();
                }
                setBlockedState(data.blocked);
                updateBadge(0);
            })
            .catch(() => {});
    }

    function pollBadgeOnly() {
        fetch(CP + "/chat?action=unread")
            .then(r => r.json())
            .then(data => updateBadge(data.unread || 0))
            .catch(() => {});
    }

    function updateBadge(count) {
        const badge = el("supportBadge");
        if (count > 0) {
            badge.textContent = count > 9 ? "9+" : count;
            badge.style.display = "flex";
        } else {
            badge.style.display = "none";
        }
    }

    function startPolling() {
        if (pollTimer) clearInterval(pollTimer);
        pollTimer = setInterval(function () {
            if (isOpen) {
                pollMessages();
            } else {
                pollBadgeOnly();
            }
        }, POLL_INTERVAL_MS);
    }

    function sendSupportMessage() {
        const input = el("supportInput");
        const content = input.value.trim();
        if (!content) return;

        const btn = el("supportSendBtn");
        btn.disabled = true;

        const guestNameInput = el("supportGuestName");
        const guestName = guestNameInput ? guestNameInput.value.trim() : "";

        const body = "action=send&content=" + encodeURIComponent(content)
            + (guestName ? "&guestName=" + encodeURIComponent(guestName) : "");

        fetch(CP + "/chat", {
            method: "POST",
            headers: { "Content-Type": "application/x-www-form-urlencoded" },
            body: body
        })
            .then(r => r.json())
            .then(data => {
                if (data.error) {
                    alert(data.error);
                    if (data.blocked) setBlockedState(true);
                    return;
                }
                if (data.message) {
                    renderMessage(data.message);
                    scrollToBottom();
                }
                input.value = "";
                if (!hasInitialized) {
                    hasInitialized = true;
                    startPolling();
                }
            })
            .catch(() => {})
            .finally(() => { btn.disabled = false; });
    }

    window.sendSupportMessage = sendSupportMessage;

    document.addEventListener("DOMContentLoaded", function () {
        const input = el("supportInput");
        if (input) {
            input.addEventListener("keydown", function (e) {
                if (e.key === "Enter" && !e.shiftKey) {
                    e.preventDefault();
                    sendSupportMessage();
                }
            });
        }
        // Cập nhật badge ngay khi trang tải, kể cả khi chưa mở chat lần nào
        pollBadgeOnly();
        startPolling();
    });
})();
</script>

</c:if>
