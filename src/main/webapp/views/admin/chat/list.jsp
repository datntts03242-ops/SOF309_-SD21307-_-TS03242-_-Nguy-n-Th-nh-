<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<!DOCTYPE html>
<html lang="vi">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Quản lý tin nhắn – Admin Sử Môn</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/css/bootstrap.min.css" rel="stylesheet">
  <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css" rel="stylesheet">
  <link href="${pageContext.request.contextPath}/assets/css/admin.css" rel="stylesheet">

  <style>
    .chat-wrapper {
      display: flex;
      gap: 16px;
      height: calc(100vh - 150px);
      min-height: 420px;
    }

    .chat-list-panel {
      width: 320px;
      flex-shrink: 0;
      background: var(--adm-surface);
      border: 1px solid var(--adm-border);
      border-radius: 12px;
      overflow-y: auto;
      display: flex;
      flex-direction: column;
    }

    .chat-list-tabs {
      display: flex;
      border-bottom: 1px solid var(--adm-border);
      flex-shrink: 0;
    }
    .chat-list-tab {
      flex: 1;
      text-align: center;
      padding: 10px 6px;
      font-size: .8rem;
      font-weight: 600;
      color: var(--adm-muted);
      cursor: pointer;
      border-bottom: 2px solid transparent;
      transition: color var(--adm-t), border-color var(--adm-t);
    }
    .chat-list-tab.active {
      color: var(--adm-blue);
      border-bottom-color: var(--adm-blue);
    }
    .chat-list-items { flex: 1; overflow-y: auto; }

    .chat-conv-item {
      display: flex;
      gap: 10px;
      padding: 12px 14px;
      border-bottom: 1px solid var(--adm-border);
      cursor: pointer;
      transition: background var(--adm-t);
      position: relative;
    }
    .chat-conv-item:hover { background: #F9FAFB; }
    .chat-conv-item.active { background: #EEF2FF; }

    .chat-conv-avatar {
      width: 40px; height: 40px; border-radius: 50%;
      background: var(--adm-dark); color: var(--adm-gold);
      display: flex; align-items: center; justify-content: center;
      font-weight: 700; font-size: .9rem; flex-shrink: 0; overflow: hidden;
    }
    .chat-conv-avatar img { width: 100%; height: 100%; object-fit: cover; }

    .chat-conv-info { flex: 1; min-width: 0; }
    .chat-conv-name { font-weight: 600; font-size: .875rem; color: var(--adm-text); display:flex; align-items:center; gap:6px; }
    .chat-conv-preview {
      font-size: .78rem; color: var(--adm-muted);
      white-space: nowrap; overflow: hidden; text-overflow: ellipsis;
      max-width: 195px;
    }
    .chat-conv-time { font-size: .68rem; color: #9CA3AF; white-space: nowrap; }

    .chat-unread-dot {
      background: var(--adm-red);
      color: #fff;
      font-size: .65rem;
      font-weight: 700;
      min-width: 18px; height: 18px;
      border-radius: 999px;
      display: flex; align-items: center; justify-content: center;
      padding: 0 4px;
    }

    .chat-guest-tag {
      font-size: .62rem;
      background: rgba(30,58,138,.1);
      color: var(--adm-blue);
      padding: 1px 6px;
      border-radius: 999px;
      font-weight: 600;
    }

    .chat-main-panel {
      flex: 1;
      display: flex;
      flex-direction: column;
      background: var(--adm-surface);
      border: 1px solid var(--adm-border);
      border-radius: 12px;
      overflow: hidden;
    }

    .chat-main-header {
      padding: 14px 18px;
      border-bottom: 1px solid var(--adm-border);
      font-weight: 700;
      color: var(--adm-text);
      flex-shrink: 0;
      display: flex;
      align-items: center;
      justify-content: space-between;
      gap: 10px;
    }
    .chat-main-header .chat-header-title {
      overflow: hidden;
      text-overflow: ellipsis;
      white-space: nowrap;
    }
    .chat-header-actions { display: flex; gap: 6px; flex-shrink: 0; }
    .chat-header-actions button {
      background: #F3F4F6;
      border: 1px solid var(--adm-border);
      color: var(--adm-text);
      font-size: .72rem;
      font-weight: 600;
      padding: 6px 10px;
      border-radius: 8px;
      cursor: pointer;
      white-space: nowrap;
      transition: background .15s ease;
    }
    .chat-header-actions button:hover { background: #E5E7EB; }
    .chat-header-actions button.danger { color: var(--adm-red); }
    .chat-header-actions button.active-toggle { background: #FEF3C7; border-color: #FCD34D; }

    .chat-blocked-banner {
      background: #FEF2F2;
      color: var(--adm-red);
      font-size: .78rem;
      padding: 8px 16px;
      border-bottom: 1px solid #FECACA;
      display: none;
    }
    .chat-blocked-banner.show { display: block; }

    .chat-msg-row { position: relative; }
    .chat-msg-delete-btn {
      display: none;
      position: absolute;
      top: -8px;
      background: #fff;
      border: 1px solid var(--adm-border);
      color: var(--adm-red);
      width: 20px; height: 20px;
      border-radius: 50%;
      font-size: .65rem;
      line-height: 1;
      cursor: pointer;
      align-items: center;
      justify-content: center;
    }
    .chat-msg-row.from-admin .chat-msg-delete-btn { left: -8px; }
    .chat-msg-row.from-user .chat-msg-delete-btn { right: -8px; }
    .chat-msg-row:hover .chat-msg-delete-btn { display: flex; }
    .chat-msg-row.is-deleted .chat-bubble {
      font-style: italic;
      color: #9CA3AF;
      background: #F3F4F6 !important;
      border-color: var(--adm-border) !important;
    }

    .chat-main-messages {
      flex: 1;
      overflow-y: auto;
      padding: 16px;
      background: var(--adm-bg);
      display: flex;
      flex-direction: column;
      gap: 10px;
    }

    .chat-empty-state {
      flex: 1;
      display: flex;
      align-items: center;
      justify-content: center;
      color: var(--adm-muted);
      font-size: .9rem;
      flex-direction: column;
      gap: 10px;
    }

    .chat-msg-row { display: flex; flex-direction: column; max-width: 70%; }
    .chat-msg-row.from-admin { align-self: flex-end; align-items: flex-end; }
    .chat-msg-row.from-user { align-self: flex-start; align-items: flex-start; }

    .chat-bubble {
      padding: 9px 13px;
      border-radius: 14px;
      font-size: .85rem;
      line-height: 1.45;
      word-wrap: break-word;
      white-space: pre-wrap;
    }
    .chat-msg-row.from-admin .chat-bubble {
      background: var(--adm-blue); color: #fff; border-bottom-right-radius: 4px;
    }
    .chat-msg-row.from-user .chat-bubble {
      background: #fff; border: 1px solid var(--adm-border); border-bottom-left-radius: 4px;
    }
    .chat-msg-time { font-size: .68rem; color: #9CA3AF; margin-top: 3px; padding: 0 3px; }

    .chat-main-input {
      display: none;
      align-items: flex-end;
      gap: 8px;
      padding: 12px;
      border-top: 1px solid var(--adm-border);
      flex-shrink: 0;
    }
    .chat-main-input textarea {
      flex: 1;
      resize: none;
      border: 1px solid var(--adm-border);
      border-radius: 14px;
      padding: 9px 13px;
      font-size: .85rem;
      outline: none;
      max-height: 90px;
      font-family: inherit;
    }
    .chat-main-input textarea:focus { border-color: var(--adm-blue); }
    .chat-main-input button {
      background: var(--adm-blue); color: #fff; border: none;
      width: 42px; height: 42px; border-radius: 50%; cursor: pointer; flex-shrink: 0;
    }
    .chat-main-input button:disabled { opacity: .5; cursor: not-allowed; }
  </style>
</head>
<body>
<div class="admin-wrapper">

  <jsp:include page="../layout/sidebar.jsp"/>

  <div class="main-content" id="mainContent">
    <jsp:include page="../layout/header.jsp"/>

    <div class="content">

      <div class="d-flex justify-content-between align-items-center mb-4">
        <h2 class="page-title">💬 Quản lý tin nhắn</h2>
      </div>

      <div class="chat-wrapper">

        <!-- DANH SÁCH HỘI THOẠI -->
        <div class="chat-list-panel" id="chatListPanel">
          <div class="chat-list-tabs">
            <div class="chat-list-tab active" id="tabInbox" onclick="switchTab('inbox')">💬 Hộp thư</div>
            <div class="chat-list-tab" id="tabArchived" onclick="switchTab('archived')">🗄️ Đã lưu trữ</div>
          </div>

          <div class="chat-list-items" id="chatListItems">
            <c:forEach items="${conversations}" var="conv">
              <div class="chat-conv-item" data-id="${conv.id}" onclick="openConversation(${conv.id})">
                <div class="chat-conv-avatar">
                  <c:choose>
                    <c:when test="${not empty conv.avatar}">
                      <img src="${pageContext.request.contextPath}/uploads/${conv.avatar}" alt="">
                    </c:when>
                    <c:otherwise>${fn:substring(conv.displayName, 0, 1)}</c:otherwise>
                  </c:choose>
                </div>
                <div class="chat-conv-info">
                  <div class="chat-conv-name">
                    <c:out value="${conv.displayName}"/>
                    <c:if test="${conv.guest}"><span class="chat-guest-tag">Khách</span></c:if>
                    <c:if test="${conv.blocked}"><span class="chat-guest-tag" style="background:rgba(165,0,0,.1);color:var(--adm-red);">Đã chặn</span></c:if>
                  </div>
                  <div class="chat-conv-preview"><c:out value="${conv.lastMessageContent}"/></div>
                </div>
                <div class="d-flex flex-column align-items-end gap-1">
                  <span class="chat-conv-time">
                    <fmt:formatDate value="${conv.lastMessageAt}" pattern="HH:mm dd/MM"/>
                  </span>
                  <c:if test="${conv.unreadCount > 0}">
                    <span class="chat-unread-dot">${conv.unreadCount}</span>
                  </c:if>
                </div>
              </div>
            </c:forEach>

            <c:if test="${empty conversations}">
              <div class="text-center text-muted py-4" style="font-size:.85rem;" id="chatListEmptyInitial">Chưa có cuộc trò chuyện nào</div>
            </c:if>
          </div>
        </div>

        <!-- NỘI DUNG CHAT -->
        <div class="chat-main-panel">
          <div id="chatEmptyState" class="chat-empty-state">
            <i class="fa-solid fa-comments" style="font-size:2.2rem;color:#D1D5DB;"></i>
            <span>Chọn một cuộc trò chuyện để bắt đầu</span>
          </div>

          <div id="chatActiveHeader" class="chat-main-header" style="display:none;">
            <span class="chat-header-title" id="chatActiveHeaderTitle"></span>
            <div class="chat-header-actions">
              <button id="btnArchive" onclick="toggleArchive()">🗄️ Lưu trữ</button>
              <button id="btnBlock" onclick="toggleBlock()">🚫 Chặn</button>
              <button class="danger" onclick="deleteCurrentConversation()">🗑️ Xóa</button>
            </div>
          </div>
          <div id="chatBlockedBanner" class="chat-blocked-banner">🚫 Người này đã bị chặn, họ không thể gửi tin nhắn mới nữa.</div>
          <div id="chatActiveMessages" class="chat-main-messages" style="display:none;"></div>

          <div id="chatActiveInput" class="chat-main-input">
            <textarea id="adminChatInput" rows="1" maxlength="1000" placeholder="Nhập tin nhắn..."></textarea>
            <button id="adminChatSendBtn" onclick="sendAdminMessage()"><i class="fa-solid fa-paper-plane"></i></button>
          </div>
        </div>

      </div>

    </div><!-- /content -->
    <jsp:include page="../layout/footer.jsp"/>
  </div><!-- /main-content -->
</div><!-- /admin-wrapper -->

<script>
(function () {
    const CP = "${pageContext.request.contextPath}";
    let currentConversationId = null;
    let currentArchived = false;
    let currentBlocked = false;
    let currentTab = "inbox"; // "inbox" | "archived"
    let lastMessageId = 0;
    let pollTimer = null;
    const POLL_INTERVAL_MS = 4000;

    function el(id) { return document.getElementById(id); }

    function post(params) {
        return fetch(CP + "/admin/chat", {
            method: "POST",
            headers: { "Content-Type": "application/x-www-form-urlencoded" },
            body: params
        }).then(r => r.json());
    }

    // ================= TABS: HỘP THƯ / ĐÃ LƯU TRỮ =================
    window.switchTab = function (tab) {
        currentTab = tab;
        el("tabInbox").classList.toggle("active", tab === "inbox");
        el("tabArchived").classList.toggle("active", tab === "archived");
        closeConversationView();
        refreshConversationList();
    };

    function closeConversationView() {
        currentConversationId = null;
        el("chatEmptyState").style.display = "flex";
        el("chatActiveHeader").style.display = "none";
        el("chatActiveMessages").style.display = "none";
        el("chatActiveInput").style.display = "none";
        el("chatBlockedBanner").classList.remove("show");
    }

    // ================= MỞ 1 HỘI THOẠI =================
    window.openConversation = function (conversationId) {
        currentConversationId = conversationId;
        lastMessageId = 0;

        document.querySelectorAll(".chat-conv-item").forEach(function (item) {
            item.classList.toggle("active", item.getAttribute("data-id") == conversationId);
            if (item.getAttribute("data-id") == conversationId) {
                const dot = item.querySelector(".chat-unread-dot");
                if (dot) dot.remove();
            }
        });

        fetch(CP + "/admin/chat?action=messages&conversationId=" + conversationId)
            .then(r => r.json())
            .then(data => {
                if (data.error) { alert(data.error); return; }

                currentArchived = !!data.isArchived;
                currentBlocked = !!data.isBlocked;
                updateHeaderToolbar();

                el("chatEmptyState").style.display = "none";
                el("chatActiveHeader").style.display = "flex";
                el("chatActiveMessages").style.display = "flex";
                el("chatActiveInput").style.display = "flex";

                el("chatActiveHeaderTitle").textContent = "💬 " + data.displayName;
                el("chatBlockedBanner").classList.toggle("show", currentBlocked);

                const box = el("chatActiveMessages");
                box.innerHTML = "";
                (data.messages || []).forEach(renderAdminMessage);
                box.scrollTop = box.scrollHeight;
            })
            .catch(() => {});
    };

    function updateHeaderToolbar() {
        el("btnArchive").textContent = currentArchived ? "↩️ Bỏ lưu trữ" : "🗄️ Lưu trữ";
        el("btnArchive").classList.toggle("active-toggle", currentArchived);
        el("btnBlock").textContent = currentBlocked ? "✅ Bỏ chặn" : "🚫 Chặn";
        el("btnBlock").classList.toggle("active-toggle", currentBlocked);
    }

    // ================= LƯU TRỮ / BỎ LƯU TRỮ =================
    window.toggleArchive = function () {
        if (!currentConversationId) return;
        const action = currentArchived ? "unarchive" : "archive";
        post("action=" + action + "&conversationId=" + currentConversationId).then(data => {
            if (data.error) { alert(data.error); return; }
            currentArchived = !currentArchived;
            updateHeaderToolbar();
            closeConversationView();
            refreshConversationList();
        });
    };

    // ================= CHẶN / BỎ CHẶN =================
    window.toggleBlock = function () {
        if (!currentConversationId) return;
        const action = currentBlocked ? "unblock" : "block";
        const msg = currentBlocked
            ? "Bỏ chặn người này? Họ sẽ gửi tin nhắn lại được."
            : "Chặn người này? Họ sẽ không thể gửi tin nhắn mới nữa (vẫn xem được lịch sử cũ).";
        if (!confirm(msg)) return;
        post("action=" + action + "&conversationId=" + currentConversationId).then(data => {
            if (data.error) { alert(data.error); return; }
            currentBlocked = !currentBlocked;
            updateHeaderToolbar();
            el("chatBlockedBanner").classList.toggle("show", currentBlocked);
            refreshConversationList();
        });
    };

    // ================= XÓA HỘI THOẠI (XÓA NGƯỜI DÙNG VỪA CHAT) =================
    window.deleteCurrentConversation = function () {
        if (!currentConversationId) return;
        if (!confirm("Xóa toàn bộ cuộc trò chuyện này? Hành động không thể hoàn tác.")) return;

        post("action=deleteConversation&conversationId=" + currentConversationId).then(data => {
            if (data.error) { alert(data.error); return; }
            closeConversationView();
            refreshConversationList();
        });
    };

    // ================= XÓA (THU HỒI) 1 TIN NHẮN =================
    window.deleteMessage = function (messageId, btnEl) {
        if (!confirm("Xóa tin nhắn này?")) return;
        post("action=deleteMessage&messageId=" + messageId).then(data => {
            if (data.error) { alert(data.error); return; }
            const row = btnEl.closest(".chat-msg-row");
            if (row) {
                row.classList.add("is-deleted");
                row.querySelector(".chat-bubble").textContent = "Tin nhắn đã bị xóa";
                btnEl.remove();
            }
        });
    };

    function renderAdminMessage(m) {
        const row = document.createElement("div");
        row.className = "chat-msg-row " + (m.fromAdmin ? "from-admin" : "from-user") + (m.deleted ? " is-deleted" : "");

        const bubble = document.createElement("div");
        bubble.className = "chat-bubble";
        bubble.textContent = m.content;
        row.appendChild(bubble);

        if (!m.deleted) {
            const delBtn = document.createElement("button");
            delBtn.className = "chat-msg-delete-btn";
            delBtn.title = "Xóa tin nhắn";
            delBtn.innerHTML = '<i class="fa-solid fa-xmark"></i>';
            delBtn.onclick = function () { deleteMessage(m.id, delBtn); };
            row.appendChild(delBtn);
        }

        const time = document.createElement("div");
        time.className = "chat-msg-time";
        time.textContent = m.sentAt;
        row.appendChild(time);

        el("chatActiveMessages").appendChild(row);

        if (m.id && m.id > lastMessageId) lastMessageId = m.id;
    }

    window.sendAdminMessage = function () {
        if (!currentConversationId) return;
        const input = el("adminChatInput");
        const content = input.value.trim();
        if (!content) return;

        const btn = el("adminChatSendBtn");
        btn.disabled = true;

        post("action=send&conversationId=" + currentConversationId + "&content=" + encodeURIComponent(content))
            .then(data => {
                if (data.error) { alert(data.error); return; }
                if (data.message) {
                    renderAdminMessage(data.message);
                    const box = el("chatActiveMessages");
                    box.scrollTop = box.scrollHeight;
                }
                input.value = "";
                refreshConversationList();
            })
            .catch(() => {})
            .finally(() => { btn.disabled = false; });
    };

    function pollActiveConversation() {
        if (!currentConversationId) return;
        fetch(CP + "/admin/chat?action=poll&conversationId=" + currentConversationId + "&afterId=" + lastMessageId)
            .then(r => r.json())
            .then(data => {
                const msgs = data.messages || [];
                if (msgs.length > 0) {
                    msgs.forEach(renderAdminMessage);
                    const box = el("chatActiveMessages");
                    box.scrollTop = box.scrollHeight;
                }
            })
            .catch(() => {});
    }

    function refreshConversationList() {
        fetch(CP + "/admin/chat?action=conversations&scope=" + currentTab)
            .then(r => r.json())
            .then(data => {
                const list = data.conversations || [];
                const panel = el("chatListItems");
                panel.innerHTML = "";

                if (list.length === 0) {
                    panel.innerHTML = '<div class="text-center text-muted py-4" style="font-size:.85rem;">'
                        + (currentTab === "archived" ? "Chưa lưu trữ hội thoại nào" : "Chưa có cuộc trò chuyện nào")
                        + '</div>';
                    return;
                }

                list.forEach(function (conv) {
                    const item = document.createElement("div");
                    item.className = "chat-conv-item" + (conv.id === currentConversationId ? " active" : "");
                    item.setAttribute("data-id", conv.id);
                    item.onclick = function () { openConversation(conv.id); };

                    const initial = (conv.displayName || "?").charAt(0).toUpperCase();
                    const avatarHtml = conv.avatar
                        ? '<img src="' + CP + '/uploads/' + conv.avatar + '" alt="">'
                        : initial;

                    const guestTag = conv.isGuest ? '<span class="chat-guest-tag">Khách</span>' : '';
                    const blockedTag = conv.isBlocked ? '<span class="chat-guest-tag" style="background:rgba(165,0,0,.1);color:var(--adm-red);">Đã chặn</span>' : '';
                    const unreadHtml = (conv.unreadCount > 0 && conv.id !== currentConversationId)
                        ? '<span class="chat-unread-dot">' + conv.unreadCount + '</span>' : '';

                    item.innerHTML =
                        '<div class="chat-conv-avatar">' + avatarHtml + '</div>' +
                        '<div class="chat-conv-info">' +
                        '  <div class="chat-conv-name">' + escapeHtml(conv.displayName) + guestTag + blockedTag + '</div>' +
                        '  <div class="chat-conv-preview">' + escapeHtml(conv.lastMessageContent) + '</div>' +
                        '</div>' +
                        '<div class="d-flex flex-column align-items-end gap-1">' +
                        '  <span class="chat-conv-time">' + conv.lastMessageAt + '</span>' +
                        unreadHtml +
                        '</div>';

                    panel.appendChild(item);
                });
            })
            .catch(() => {});
    }

    function escapeHtml(str) {
        const div = document.createElement("div");
        div.textContent = str || "";
        return div.innerHTML;
    }

    document.addEventListener("DOMContentLoaded", function () {
        const input = el("adminChatInput");
        if (input) {
            input.addEventListener("keydown", function (e) {
                if (e.key === "Enter" && !e.shiftKey) {
                    e.preventDefault();
                    sendAdminMessage();
                }
            });
        }

        pollTimer = setInterval(function () {
            pollActiveConversation();
            refreshConversationList();
        }, POLL_INTERVAL_MS);
    });
})();
</script>

</body>
</html>
