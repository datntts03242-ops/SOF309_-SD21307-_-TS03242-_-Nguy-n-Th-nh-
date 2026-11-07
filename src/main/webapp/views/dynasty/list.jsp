<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<%
    request.setAttribute("activePage", "dynasties");
%>
<!DOCTYPE html>
<html lang="vi">
<head>
<title>Triều Đại Việt Nam – Sử Môn</title>
<jsp:include page="/common/head-resources.jsp"/>
<style>
*, *::before, *::after { box-sizing: border-box; margin: 0; padding: 0; }
:root {
    --bg-deep:#0f172a; --bg-card:#111827; --bg-card-hover:#141f35;
    --gold:#facc15; --gold-dim:#d4a80f; --gold-glow:rgba(250,204,21,0.20);
    --red:#dc3545; --text-primary:#f1f5f9; --text-muted:#94a3b8;
    --text-dim:#64748b; --border:rgba(250,204,21,0.10);
    --border-hover:rgba(250,204,21,0.35); --radius:18px;
    --ease:cubic-bezier(0.4,0,0.2,1); --t:0.32s;
}
html { scroll-behavior:smooth; }
body { background:var(--bg-deep); color:var(--text-primary); font-family:'Be Vietnam Pro',sans-serif; min-height:100vh; overflow-x:hidden; padding-top:72px; }

/* ─── AMBIENT BG ─────────────────────────────────────────────────────── */
body::before {
    content: '';
    position: fixed;
    inset: 0;
    background:
        radial-gradient(ellipse 70% 45% at 15% 8%,  rgba(250,204,21,0.05) 0%, transparent 55%),
        radial-gradient(ellipse 55% 40% at 85% 85%, rgba(220,53,69,0.05)  0%, transparent 55%),
        radial-gradient(ellipse 90% 60% at 50% 50%, rgba(30,41,70,0.6)    0%, transparent 70%);
    pointer-events: none;
    z-index: 0;
}

/* ─── PAGE WRAPPER ───────────────────────────────────────────────────── */
.page-wrapper {
    position: relative;
    z-index: 1;
    padding-top: 88px;
    padding-bottom: 90px;
}

/* ─── HERO ───────────────────────────────────────────────────────────── */
.page-hero {
    position: relative;
    padding: 64px 0 52px;
    text-align: center;
    overflow: hidden;
}

/* decorative horizontal rule */
.page-hero::before,
.page-hero::after {
    content: '';
    position: absolute;
    left: 50%;
    transform: translateX(-50%);
    height: 1px;
    width: 60%;
    max-width: 480px;
    background: linear-gradient(90deg, transparent, var(--gold), transparent);
    opacity: 0.4;
}
.page-hero::before { top: 28px; }
.page-hero::after  { bottom: 28px; }

.hero-eyebrow {
    font-family: 'Cinzel', serif;
    font-size: 0.68rem;
    letter-spacing: 0.38em;
    text-transform: uppercase;
    color: var(--gold);
    opacity: 0.65;
    margin-bottom: 16px;
    display: block;
}

.hero-title {
    font-family: 'Cinzel', serif;
    font-size: clamp(2.1rem, 5.5vw, 3.6rem);
    font-weight: 700;
    line-height: 1.12;
    color: var(--text-primary);
    margin-bottom: 14px;
    text-shadow: 0 2px 24px rgba(250,204,21,0.15);
}

.hero-title .icon {
    display: inline-block;
    filter: drop-shadow(0 0 10px rgba(250,204,21,0.4));
}

.hero-subtitle {
    font-size: 1.0rem;
    color: var(--text-muted);
    font-weight: 300;
    letter-spacing: 0.02em;
    max-width: 520px;
    margin: 0 auto;
    line-height: 1.65;
}

.hero-divider {
    margin: 26px auto 0;
    width: 80px;
    height: 3px;
    border-radius: 2px;
    background: linear-gradient(90deg, var(--red), var(--gold));
    opacity: 0.7;
}

/* ─── STATS BAR ──────────────────────────────────────────────────────── */
.stats-bar {
    display: flex;
    align-items: center;
    justify-content: space-between;
    gap: 12px;
    padding: 14px 0 32px;
    border-bottom: 1px solid var(--border);
    margin-bottom: 38px;
    flex-wrap: wrap;
}

.stats-label {
    font-size: 0.83rem;
    color: var(--text-dim);
    letter-spacing: 0.04em;
}
.stats-label strong {
    color: var(--gold);
    font-weight: 600;
}

.stats-dots {
    display: flex;
    gap: 5px;
    align-items: center;
}
.dot {
    width: 6px; height: 6px;
    border-radius: 50%;
    background: var(--gold);
    opacity: 0.3;
}
.dot:nth-child(1) { opacity: 0.9; }
.dot:nth-child(2) { opacity: 0.55; }
.dot:nth-child(3) { opacity: 0.28; }

/* ─── GRID ───────────────────────────────────────────────────────────── */
.dynasty-grid {
    display: grid;
    grid-template-columns: repeat(3, 1fr);
    gap: 24px;
}

@media (max-width: 1199px) { .dynasty-grid { grid-template-columns: repeat(2, 1fr); } }
@media (max-width: 575px)  { .dynasty-grid { grid-template-columns: 1fr; gap: 16px; } }

/* ─── CARD LINK WRAPPER ──────────────────────────────────────────────── */
.card-link {
    text-decoration: none;
    color: inherit;
    display: block;
    height: 100%;

    opacity: 0;
    transform: translateY(28px);
    animation: cardIn 0.52s var(--ease) forwards;
}

/* ─── CARD ───────────────────────────────────────────────────────────── */
.dynasty-card {
    position: relative;
    background: var(--bg-card);
    border-radius: var(--radius);
    overflow: hidden;
    border: 1px solid var(--border);
    height: 100%;
    display: flex;
    flex-direction: column;
    transition:
        transform   var(--t) var(--ease),
        border-color var(--t) var(--ease),
        box-shadow  var(--t) var(--ease),
        background  var(--t) var(--ease);
}

.card-link:hover .dynasty-card {
    transform: translateY(-6px);
    border-color: var(--border-hover);
    background: var(--bg-card-hover);
    box-shadow:
        0 0 0 1px rgba(250,204,21,0.15),
        0 12px 40px rgba(0,0,0,0.55),
        0 0 28px var(--gold-glow);
}

/* ─── IMAGE ──────────────────────────────────────────────────────────── */
.card-img-wrap {
    position: relative;
    width: 100%;
    overflow: hidden;
    aspect-ratio: 16 / 9;
    flex-shrink: 0;
}

.card-img-wrap img {
    width: 100%;
    height: 100%;
    object-fit: cover;
    object-position: center;
    display: block;
    transition: transform 0.48s var(--ease), filter 0.48s ease;
}

.card-link:hover .card-img-wrap img {
    transform: scale(1.06);
    filter: brightness(0.6) saturate(0.85);
}

/* gradient fade into card body */
.card-img-wrap::after {
    content: '';
    position: absolute;
    bottom: 0; left: 0; right: 0;
    height: 55%;
    background: linear-gradient(to top, var(--bg-card) 0%, transparent 100%);
    pointer-events: none;
}

/* placeholder when no image */
.card-img-placeholder {
    width: 100%;
    aspect-ratio: 16 / 9;
    background: linear-gradient(135deg, #1a2640 0%, #0d1526 100%);
    display: flex;
    flex-direction: column;
    align-items: center;
    justify-content: center;
    gap: 8px;
    flex-shrink: 0;
}
.placeholder-icon {
    font-size: 3rem;
    opacity: 0.35;
    filter: grayscale(0.2);
}
.placeholder-label {
    font-family: 'Cinzel', serif;
    font-size: 0.65rem;
    letter-spacing: 0.25em;
    color: var(--gold);
    opacity: 0.3;
    text-transform: uppercase;
}

/* ─── CARD BODY ──────────────────────────────────────────────────────── */
.card-body-inner {
    padding: 18px 20px 22px;
    display: flex;
    flex-direction: column;
    gap: 10px;
    flex: 1;
}

/* period badge */
.card-period {
    display: inline-flex;
    align-items: center;
    gap: 6px;
    background: rgba(250,204,21,0.10);
    border: 1px solid rgba(250,204,21,0.22);
    border-radius: 6px;
    padding: 4px 10px;
    font-size: 0.76rem;
    font-weight: 600;
    color: var(--gold);
    letter-spacing: 0.06em;
    width: fit-content;
    font-variant-numeric: tabular-nums;
}

.card-name {
    font-family: 'Cinzel', serif;
    font-size: 1.13rem;
    font-weight: 700;
    color: var(--text-primary);
    line-height: 1.3;
    transition: color var(--t);
}
.card-link:hover .card-name {
    color: #fff;
    text-shadow: 0 0 12px rgba(250,204,21,0.2);
}

/* meta row */
.card-meta {
    display: flex;
    flex-direction: column;
    gap: 5px;
}

.meta-row {
    display: flex;
    align-items: center;
    gap: 7px;
    font-size: 0.81rem;
    color: var(--text-muted);
    line-height: 1.4;
}

.meta-icon {
    font-size: 0.85em;
    flex-shrink: 0;
    opacity: 0.75;
}

.meta-value {
    overflow: hidden;
    white-space: nowrap;
    text-overflow: ellipsis;
}

/* description */
.card-desc {
    font-size: 0.82rem;
    color: var(--text-dim);
    line-height: 1.65;
    display: -webkit-box;
    -webkit-box-orient: vertical;
    -webkit-line-clamp: 3;
    overflow: hidden;
    margin-top: 2px;
}

/* CTA arrow */
.card-cta {
    margin-top: auto;
    padding-top: 12px;
    border-top: 1px solid rgba(255,255,255,0.05);
    display: flex;
    align-items: center;
    justify-content: space-between;
    font-size: 0.78rem;
    color: var(--text-dim);
    transition: color var(--t);
}
.card-link:hover .card-cta {
    color: var(--gold);
}

.cta-arrow {
    display: inline-flex;
    align-items: center;
    justify-content: center;
    width: 28px; height: 28px;
    border-radius: 50%;
    border: 1px solid currentColor;
    font-size: 0.85rem;
    transition: transform var(--t), background var(--t);
}
.card-link:hover .cta-arrow {
    transform: translateX(3px);
    background: var(--gold);
    color: #0f172a;
    border-color: var(--gold);
}

/* ─── EMPTY STATE ────────────────────────────────────────────────────── */
.empty-state {
    grid-column: 1 / -1;
    display: flex;
    flex-direction: column;
    align-items: center;
    justify-content: center;
    padding: 100px 24px;
    gap: 18px;
    text-align: center;
}

.empty-icon {
    font-size: 5rem;
    opacity: 0.4;
    animation: pulse 3s ease-in-out infinite;
}

.empty-title {
    font-family: 'Cinzel', serif;
    font-size: 1.4rem;
    font-weight: 600;
    color: var(--text-primary);
    opacity: 0.65;
}

.empty-sub {
    font-size: 0.9rem;
    color: var(--text-dim);
    max-width: 340px;
    line-height: 1.6;
}

.btn-home {
    display: inline-flex;
    align-items: center;
    gap: 8px;
    padding: 11px 28px;
    border-radius: 11px;
    background: linear-gradient(135deg, var(--gold), var(--gold-dim));
    color: #0f172a;
    font-weight: 700;
    font-size: 0.9rem;
    text-decoration: none;
    transition: transform var(--t), box-shadow var(--t);
    box-shadow: 0 4px 18px rgba(250,204,21,0.25);
    margin-top: 6px;
}
.btn-home:hover {
    transform: translateY(-2px) scale(1.03);
    box-shadow: 0 8px 28px rgba(250,204,21,0.38);
    color: #0f172a;
}

/* ─── ANIMATIONS ─────────────────────────────────────────────────────── */
@keyframes cardIn {
    to { opacity: 1; transform: translateY(0); }
}

@keyframes pulse {
    0%, 100% { transform: scale(1);    opacity: 0.40; }
    50%       { transform: scale(1.08); opacity: 0.55; }
}

/* ─── SCROLLBAR ──────────────────────────────────────────────────────── */
::-webkit-scrollbar { width: 6px; }
::-webkit-scrollbar-track { background: var(--bg-deep); }
::-webkit-scrollbar-thumb { background: rgba(250,204,21,0.22); border-radius: 3px; }
::-webkit-scrollbar-thumb:hover { background: rgba(250,204,21,0.42); }
</style>
</head>

<body class="bg-dark-page">
<jsp:include page="/common/header.jsp"/>

<div class="page-wrapper">
<div class="container">

    <!-- ── HERO ─────────────────────────────────────────────────────── -->
    <section class="page-hero">
        <span class="hero-eyebrow">Biên niên sử – Sử Môn</span>
        <h1 class="hero-title">
            <span class="icon">🏯</span> Các Triều Đại Việt Nam
        </h1>
        <p class="hero-subtitle">
            Hành trình lịch sử qua các triều đại phong kiến Việt Nam — từ buổi bình minh dựng nước đến thời đại cận đại.
        </p>
        <div class="hero-divider"></div>
    </section>

    <!-- ── STATS BAR ─────────────────────────────────────────────────── -->
    <div class="stats-bar">
        <span class="stats-label">
            <c:choose>
                <c:when test="${not empty list}">
                    Tổng cộng <strong>${fn:length(list)}</strong> triều đại được lưu trữ
                </c:when>
                <c:otherwise>Chưa có dữ liệu</c:otherwise>
            </c:choose>
        </span>
        <div class="stats-dots">
            <div class="dot"></div>
            <div class="dot"></div>
            <div class="dot"></div>
        </div>
    </div>

    <!-- ── GRID ──────────────────────────────────────────────────────── -->
    <div class="dynasty-grid">

        <c:choose>

            <%-- ── EMPTY STATE ────────────────────────────────────────── --%>
            <c:when test="${empty list}">
                <div class="empty-state">
                    <div class="empty-icon">🏯</div>
                    <h2 class="empty-title">Chưa có dữ liệu triều đại</h2>
                    <p class="empty-sub">Hệ thống chưa ghi nhận triều đại nào. Vui lòng quay lại sau.</p>
                    <a href="${pageContext.request.contextPath}/" class="btn-home">
                        🏠 Quay về trang chủ
                    </a>
                </div>
            </c:when>

            <%-- ── CARD LIST ───────────────────────────────────────────── --%>
            <c:otherwise>
                <c:forEach items="${list}" var="d" varStatus="loop">

                    <a href="${pageContext.request.contextPath}/dynasty?id=${d.id}"
                       class="card-link"
                       style="animation-delay: ${loop.index * 75}ms;">

                        <div class="dynasty-card">

                            <!-- IMAGE / PLACEHOLDER -->
                            <c:choose>
                                <c:when test="${not empty d.image}">
                                    <div class="card-img-wrap">
                                        <img src="${pageContext.request.contextPath}/assets/images/dynasties/${d.image}"
                                             alt="${d.name}"
                                             loading="lazy"
                                             onerror="this.parentElement.innerHTML='<div class=\'card-img-placeholder\'><span class=\'placeholder-icon\'>🏯</span><span class=\'placeholder-label\'>Triều đại</span></div>'"/>
                                    </div>
                                </c:when>
                                <c:otherwise>
                                    <div class="card-img-placeholder">
                                        <span class="placeholder-icon">🏯</span>
                                        <span class="placeholder-label">Triều đại</span>
                                    </div>
                                </c:otherwise>
                            </c:choose>

                            <!-- BODY -->
                            <div class="card-body-inner">

                                <!-- Period badge -->
                                <span class="card-period">
                                    ⏳ ${d.startYear} – ${d.endYear}
                                </span>

                                <!-- Name -->
                                <h3 class="card-name">${d.name}</h3>

                                <!-- Meta: founder + capital -->
                                <div class="card-meta">
                                    <c:if test="${not empty d.founder}">
                                        <div class="meta-row">
                                            <span class="meta-icon">👑</span>
                                            <span class="meta-value">${d.founder}</span>
                                        </div>
                                    </c:if>
                                    <c:if test="${not empty d.capital}">
                                        <div class="meta-row">
                                            <span class="meta-icon">🏛</span>
                                            <span class="meta-value">${d.capital}</span>
                                        </div>
                                    </c:if>
                                </div>

                                <!-- Description (3-line clamp) -->
                                <c:if test="${not empty d.description}">
                                    <p class="card-desc">${d.description}</p>
                                </c:if>

                                <!-- CTA row -->
                                <div class="card-cta">
                                    <span>Xem chi tiết</span>
                                    <span class="cta-arrow">→</span>
                                </div>

                            </div><%-- /card-body-inner --%>

                        </div><%-- /dynasty-card --%>

                    </a><%-- /card-link --%>

                </c:forEach>
            </c:otherwise>

        </c:choose>

    </div><%-- /dynasty-grid --%>

</div><%-- /container --%>
</div><%-- /page-wrapper --%>

<jsp:include page="/common/footer.jsp"/>
</body>
</html>

