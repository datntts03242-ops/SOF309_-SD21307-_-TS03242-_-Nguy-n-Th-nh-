<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<% request.setAttribute("activePage", "favorites"); %>
<!DOCTYPE html>
<html lang="vi">
<head>
<title>Nhân Vật Yêu Thích – Sử Môn</title>
<jsp:include page="/common/head-resources.jsp"/>
<style>
*, *::before, *::after { box-sizing: border-box; margin: 0; padding: 0; }
:root {
    --bg-deep:#0f172a; --bg-card:#111827; --bg-card-alt:#1a2235;
    --gold:#facc15; --gold-dim:#d4a80f; --gold-glow:rgba(250,204,21,0.22);
    --red:#dc3545; --red-dim:rgba(220,53,69,0.18);
    --text-primary:#f1f5f9; --text-muted:#94a3b8;
    --border:rgba(250,204,21,0.12); --radius-card:18px;
    --transition:0.32s cubic-bezier(0.4,0,0.2,1);
}
html { scroll-behavior:smooth; }
body { background:var(--bg-deep); color:var(--text-primary); font-family:'Be Vietnam Pro',sans-serif; min-height:100vh; overflow-x:hidden; padding-top:72px; }

/* ─── AMBIENT BACKGROUND ────────────────────────────────────────────── */
body::before {
    content: '';
    position: fixed;
    inset: 0;
    background:
        radial-gradient(ellipse 80% 50% at 20% 10%, rgba(250,204,21,0.04) 0%, transparent 60%),
        radial-gradient(ellipse 60% 40% at 80% 80%, rgba(220,53,69,0.05) 0%, transparent 55%);
    pointer-events: none;
    z-index: 0;
}

/* ─── PAGE WRAPPER ──────────────────────────────────────────────────── */
.page-wrapper {
    position: relative;
    z-index: 1;
    padding-top: 90px;
    padding-bottom: 80px;
}

/* ─── PAGE HERO ─────────────────────────────────────────────────────── */
.page-hero {
    text-align: center;
    padding: 48px 0 40px;
    position: relative;
}

.page-hero::after {
    content: '';
    display: block;
    margin: 28px auto 0;
    width: 120px;
    height: 2px;
    background: linear-gradient(90deg, transparent, var(--gold), transparent);
}

.hero-eyebrow {
    font-family: 'Cinzel', serif;
    font-size: 0.72rem;
    letter-spacing: 0.35em;
    text-transform: uppercase;
    color: var(--gold);
    opacity: 0.7;
    margin-bottom: 14px;
}

.hero-title {
    font-family: 'Cinzel', serif;
    font-size: clamp(2rem, 5vw, 3.2rem);
    font-weight: 700;
    color: var(--text-primary);
    line-height: 1.15;
    margin-bottom: 10px;
}

.hero-title .icon-heart {
    color: var(--red);
    filter: drop-shadow(0 0 8px rgba(220,53,69,0.5));
}

.hero-subtitle {
    font-size: 0.95rem;
    color: var(--text-muted);
    font-weight: 300;
    letter-spacing: 0.02em;
}

/* ─── ACTION BAR ────────────────────────────────────────────────────── */
.action-bar {
    display: flex;
    align-items: center;
    justify-content: space-between;
    flex-wrap: wrap;
    gap: 12px;
    margin-bottom: 40px;
    padding-bottom: 20px;
    border-bottom: 1px solid var(--border);
}

.count-badge {
    font-size: 0.82rem;
    color: var(--text-muted);
    font-weight: 400;
}

.count-badge strong {
    color: var(--gold);
    font-weight: 600;
}

.action-bar-btns {
    display: flex;
    gap: 10px;
    flex-wrap: wrap;
}

.btn-back {
    display: inline-flex;
    align-items: center;
    gap: 7px;
    padding: 9px 20px;
    border-radius: 10px;
    border: 1px solid rgba(255,255,255,0.15);
    background: rgba(255,255,255,0.04);
    color: var(--text-primary);
    font-size: 0.87rem;
    font-weight: 500;
    text-decoration: none;
    transition: var(--transition);
    cursor: pointer;
}
.btn-back:hover {
    border-color: rgba(255,255,255,0.35);
    background: rgba(255,255,255,0.09);
    color: #fff;
    transform: translateX(-2px);
}

.btn-clear-all {
    display: inline-flex;
    align-items: center;
    gap: 7px;
    padding: 9px 20px;
    border-radius: 10px;
    border: 1px solid rgba(220,53,69,0.3);
    background: var(--red-dim);
    color: #f87171;
    font-size: 0.87rem;
    font-weight: 500;
    text-decoration: none;
    transition: var(--transition);
    cursor: pointer;
}
.btn-clear-all:hover {
    border-color: var(--red);
    background: rgba(220,53,69,0.28);
    color: #fca5a5;
}

/* ─── CARD GRID ─────────────────────────────────────────────────────── */
.fav-grid {
    display: grid;
    grid-template-columns: repeat(4, 1fr);
    gap: 22px;
}

@media (max-width: 1199px) { .fav-grid { grid-template-columns: repeat(3, 1fr); } }
@media (max-width: 767px)  { .fav-grid { grid-template-columns: repeat(2, 1fr); gap: 14px; } }
@media (max-width: 479px)  { .fav-grid { grid-template-columns: 1fr; } }

/* ─── CARD ──────────────────────────────────────────────────────────── */
.fav-card {
    position: relative;
    background: var(--bg-card);
    border-radius: var(--radius-card);
    overflow: hidden;
    border: 1px solid var(--border);
    transition: var(--transition);
    cursor: pointer;

    /* stagger fade-in */
    opacity: 0;
    transform: translateY(24px);
    animation: cardIn 0.5s ease forwards;
}

.fav-card:hover {
    transform: translateY(-4px) scale(1.01);
    border-color: rgba(250, 204, 21, 0.35);
    box-shadow:
        0 0 0 1px rgba(250,204,21,0.18),
        0 8px 32px rgba(0,0,0,0.5),
        0 0 24px var(--gold-glow);
}

/* ─── IMAGE AREA ────────────────────────────────────────────────────── */
.card-img-wrap {
    position: relative;
    width: 100%;
    aspect-ratio: 3 / 4;
    overflow: hidden;
}

.card-img-wrap img {
    width: 100%;
    height: 100%;
    object-fit: cover;
    object-position: top center;
    transition: transform 0.45s cubic-bezier(0.4, 0, 0.2, 1),
                filter 0.45s ease;
    display: block;
}

.fav-card:hover .card-img-wrap img {
    transform: scale(1.06);
    filter: brightness(0.55);
}

/* ─── OVERLAY ───────────────────────────────────────────────────────── */
.card-overlay {
    position: absolute;
    inset: 0;
    background: var(--overlay-grad);
    opacity: 0;
    transition: opacity var(--transition);
    pointer-events: none;
}

.fav-card:hover .card-overlay {
    opacity: 1;
}

/* ─── INFO STRIP (always visible, bottom) ───────────────────────────── */
.card-info {
    position: absolute;
    bottom: 0;
    left: 0; right: 0;
    padding: 18px 16px 14px;
    background: linear-gradient(to top, rgba(10,14,28,0.95) 0%, transparent 100%);
    z-index: 2;
}

.card-name {
    font-family: 'Cinzel', serif;
    font-size: 0.97rem;
    font-weight: 600;
    color: #fff;
    line-height: 1.3;
    margin-bottom: 3px;
    text-shadow: 0 1px 6px rgba(0,0,0,0.8);
    white-space: nowrap;
    overflow: hidden;
    text-overflow: ellipsis;
}

.card-dynasty {
    font-size: 0.75rem;
    font-weight: 400;
    color: var(--gold);
    opacity: 0.8;
    letter-spacing: 0.04em;
    white-space: nowrap;
    overflow: hidden;
    text-overflow: ellipsis;
}

/* ─── HOVER ACTION BUTTONS ──────────────────────────────────────────── */
.card-actions {
    position: absolute;
    bottom: 70px;
    left: 0; right: 0;
    display: flex;
    flex-direction: column;
    gap: 8px;
    padding: 0 14px;
    z-index: 3;
    transform: translateY(12px);
    opacity: 0;
    transition: opacity var(--transition), transform var(--transition);
    pointer-events: none;
}

.fav-card:hover .card-actions {
    opacity: 1;
    transform: translateY(0);
    pointer-events: auto;
}

.btn-detail,
.btn-unfav {
    display: flex;
    align-items: center;
    justify-content: center;
    gap: 6px;
    width: 100%;
    padding: 8px 12px;
    border-radius: 9px;
    font-size: 0.80rem;
    font-weight: 600;
    text-decoration: none;
    border: none;
    cursor: pointer;
    transition: var(--transition);
    letter-spacing: 0.02em;
}

.btn-detail {
    background: var(--gold);
    color: #0f172a;
}
.btn-detail:hover {
    background: #fde047;
    color: #0f172a;
    transform: scale(1.02);
}

.btn-unfav {
    background: rgba(220,53,69,0.18);
    color: #f87171;
    border: 1px solid rgba(220,53,69,0.3);
}
.btn-unfav:hover {
    background: rgba(220,53,69,0.32);
    border-color: var(--red);
    color: #fca5a5;
}

/* ─── EMPTY STATE ───────────────────────────────────────────────────── */
.empty-state {
    grid-column: 1 / -1;
    display: flex;
    flex-direction: column;
    align-items: center;
    justify-content: center;
    padding: 80px 24px;
    text-align: center;
    gap: 16px;
}

.empty-icon {
    font-size: 4.5rem;
    filter: grayscale(0.3) opacity(0.65);
    animation: pulse 2.8s ease-in-out infinite;
}

.empty-title {
    font-family: 'Cinzel', serif;
    font-size: 1.35rem;
    font-weight: 600;
    color: var(--text-primary);
    opacity: 0.75;
}

.empty-sub {
    font-size: 0.9rem;
    color: var(--text-muted);
    max-width: 320px;
    line-height: 1.6;
}

.btn-explore {
    display: inline-flex;
    align-items: center;
    gap: 8px;
    padding: 12px 28px;
    border-radius: 12px;
    background: linear-gradient(135deg, var(--gold) 0%, var(--gold-dim) 100%);
    color: #0f172a;
    font-weight: 700;
    font-size: 0.92rem;
    text-decoration: none;
    transition: var(--transition);
    margin-top: 8px;
    box-shadow: 0 4px 18px rgba(250,204,21,0.25);
}
.btn-explore:hover {
    transform: translateY(-2px) scale(1.03);
    box-shadow: 0 8px 28px rgba(250,204,21,0.38);
    color: #0f172a;
}

/* ─── ANIMATIONS ────────────────────────────────────────────────────── */
@keyframes cardIn {
    to { opacity: 1; transform: translateY(0); }
}

@keyframes pulse {
    0%, 100% { transform: scale(1); }
    50%       { transform: scale(1.08); }
}

/* ─── FORM HIDDEN (unfav POST) ─────────────────────────────────────── */
.hidden-form { display: none; }

/* ─── SCROLLBAR ─────────────────────────────────────────────────────── */
::-webkit-scrollbar { width: 6px; }
::-webkit-scrollbar-track { background: var(--bg-deep); }
::-webkit-scrollbar-thumb { background: rgba(250,204,21,0.25); border-radius: 3px; }
::-webkit-scrollbar-thumb:hover { background: rgba(250,204,21,0.45); }
</style>
</head>

<body class="bg-dark-page">

<!-- NAV -->
<jsp:include page="/common/header.jsp"/>

<div class="page-wrapper">
<div class="container">

    <!-- HERO -->
    <div class="page-hero">
        <p class="hero-eyebrow">Bộ sưu tập cá nhân</p>
        <h1 class="hero-title">
            <span class="icon-heart">❤</span> Favorite Characters
        </h1>
        <p class="hero-subtitle">Danh sách nhân vật bạn yêu thích</p>
    </div>

    <!-- ACTION BAR -->
    <div class="action-bar">
        <span class="count-badge">
            <c:choose>
                <c:when test="${not empty favorites}">
                    Đang lưu <strong>${fn:length(favorites)}</strong> nhân vật
                </c:when>
                <c:otherwise>
                    Chưa có nhân vật nào
                </c:otherwise>
            </c:choose>
        </span>
        <div class="action-bar-btns">
            <a href="${pageContext.request.contextPath}/characters" class="btn-back">
                ← Quay lại
            </a>
            <c:if test="${not empty favorites}">
                <form method="post" action="${pageContext.request.contextPath}/favorite" style="margin:0;">
                    <input type="hidden" name="action" value="clearAll"/>
                    <button type="submit" class="btn-clear-all"
                            onclick="return confirm('Xóa tất cả nhân vật yêu thích?')">
                        🗑 Xóa tất cả
                    </button>
                </form>
            </c:if>
        </div>
    </div>

    <!-- GRID -->
    <div class="fav-grid">

        <c:choose>

            <%-- ── EMPTY STATE ─────────────────────────────────────────── --%>
            <c:when test="${empty favorites}">
                <div class="empty-state">
                    <div class="empty-icon">❤️</div>
                    <h2 class="empty-title">Bạn chưa có nhân vật yêu thích</h2>
                    <p class="empty-sub">Hãy khám phá và lưu những anh hùng lịch sử bạn ngưỡng mộ.</p>
                    <a href="${pageContext.request.contextPath}/characters" class="btn-explore">
                        🔍 Khám phá nhân vật
                    </a>
                </div>
            </c:when>

            <%-- ── CARD LIST ────────────────────────────────────────────── --%>
            <c:otherwise>
                <c:forEach items="${favorites}" var="item" varStatus="loop">

                    <%-- Stagger delay via inline style --%>
                    <div class="fav-card"
                         style="animation-delay: ${loop.index * 80}ms;">

                        <div class="card-img-wrap">

                            <img src="${pageContext.request.contextPath}/assets/images/characters/${item.image}"
                                 alt="${item.name}"
                                 loading="lazy"
                                 onerror="this.src='${pageContext.request.contextPath}/assets/images/no-image.png'"/>

                            <div class="card-overlay"></div>

                            <!-- HOVER BUTTONS -->
                            <div class="card-actions">
                                <a href="${pageContext.request.contextPath}/characters?id=${item.id}"
                                   class="btn-detail">
                                    👁 Xem chi tiết
                                </a>
                                <button type="button"
                                        class="btn-unfav"
                                        onclick="submitUnfav('${item.id}')">
                                    ❤ Bỏ yêu thích
                                </button>
                            </div>

                        </div><%-- /card-img-wrap --%>

                        <!-- INFO STRIP -->
                        <div class="card-info">
                            <div class="card-name">${item.name}</div>
                            <div class="card-dynasty">${item.dynasty}</div>
                        </div>

                        <!-- HIDDEN UNFAV FORM -->
                        <form id="unfav-form-${item.id}"
                              class="hidden-form"
                              method="post"
                              action="${pageContext.request.contextPath}/favorite">
                            <input type="hidden" name="action" value="remove"/>
                            <input type="hidden" name="cid"    value="${item.id}"/>
                        </form>

                    </div><%-- /fav-card --%>

                </c:forEach>
            </c:otherwise>

        </c:choose>

    </div><%-- /fav-grid --%>

</div><%-- /container --%>
</div><%-- /page-wrapper --%>


<script>
/**
 * Submit the hidden unfav form for a given character ID.
 */
function submitUnfav(cid) {
    const form = document.getElementById('unfav-form-' + cid);
    if (form) form.submit();
}
</script>

<jsp:include page="/common/footer.jsp"/>
</body>
</html>

