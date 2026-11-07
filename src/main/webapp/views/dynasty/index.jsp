<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<% request.setAttribute("activePage","dynasty"); %>
<!DOCTYPE html>
<html lang="vi">
<head>
<title>Triều Đại Việt Nam – Sử Môn</title>
<jsp:include page="/common/head-resources.jsp"/>
<style>
*, *::before, *::after { box-sizing: border-box; margin: 0; padding: 0; }
body { background: #0f172a; color: #e2e8f0; font-family: 'Be Vietnam Pro', sans-serif; min-height: 100vh; overflow-x: hidden; padding-top: 72px; }
/* ─── HERO SECTION ──────────────────────────────────── */
.su-mon-hero {
    position: relative;
    padding: 100px 0 72px;
    text-align: center;
    overflow: hidden;
    isolation: isolate;
}

/* layered gradient sky */
.su-mon-hero::before {
    content: '';
    position: absolute;
    inset: 0;
    background:
        radial-gradient(ellipse 80% 60% at 50% 0%, rgba(250,204,21,.10) 0%, transparent 70%),
        radial-gradient(ellipse 60% 40% at 20% 100%, rgba(220,53,69,.07) 0%, transparent 60%),
        linear-gradient(180deg, #111827 0%, #0f172a 100%);
    z-index: -2;
}

/* faint temple silhouette SVG drawn in CSS */
.su-mon-hero::after {
    content: '';
    position: absolute;
    bottom: 0; left: 50%;
    transform: translateX(-50%);
    width: 900px; max-width: 100%;
    height: 200px;
    background-image: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 900 200'%3E%3Cg fill='%23facc15' opacity='.04'%3E%3Crect x='390' y='60' width='120' height='140'/%3E%3Crect x='350' y='100' width='200' height='100'/%3E%3Crect x='300' y='130' width='300' height='70'/%3E%3Cpolygon points='450,20 390,80 510,80'/%3E%3Crect x='370' y='80' width='16' height='40'/%3E%3Crect x='514' y='80' width='16' height='40'/%3E%3Crect x='100' y='100' width='80' height='100'/%3E%3Crect x='80' y='130' width='120' height='70'/%3E%3Cpolygon points='140,70 100,110 180,110'/%3E%3Crect x='720' y='110' width='80' height='90'/%3E%3Crect x='700' y='140' width='120' height='60'/%3E%3Cpolygon points='760,80 720,120 800,120'/%3E%3C/g%3E%3C/svg%3E");
    background-repeat: no-repeat;
    background-position: center bottom;
    background-size: contain;
    z-index: -1;
    pointer-events: none;
}

.hero-eyebrow {
    display: inline-block;
    font-family: 'Cinzel', serif;
    font-size: .72rem;
    font-weight: 600;
    letter-spacing: .22em;
    text-transform: uppercase;
    color: #facc15;
    border: 1px solid rgba(250,204,21,.30);
    border-radius: 99px;
    padding: 4px 18px;
    margin-bottom: 20px;
    backdrop-filter: blur(4px);
}

.hero-title {
    font-family: 'Cinzel', serif;
    font-size: clamp(2rem, 5vw, 3.4rem);
    font-weight: 900;
    line-height: 1.15;
    color: #f8fafc;
    text-shadow: 0 2px 40px rgba(250,204,21,.25);
    margin-bottom: 16px;
    letter-spacing: -.01em;
}

.hero-title .accent-gold { color: #facc15; }

.hero-subtitle {
    font-size: 1.05rem;
    color: #94a3b8;
    max-width: 540px;
    margin: 0 auto 36px;
    line-height: 1.7;
    font-weight: 300;
}

.hero-divider {
    display: flex;
    align-items: center;
    justify-content: center;
    gap: 12px;
    margin-bottom: 8px;
}

.hero-divider span {
    display: block;
    width: 60px; height: 1px;
    background: linear-gradient(90deg, transparent, rgba(250,204,21,.50));
}

.hero-divider span:last-child {
    background: linear-gradient(90deg, rgba(250,204,21,.50), transparent);
}

.hero-divider .diamond {
    width: 6px; height: 6px;
    background: #facc15;
    transform: rotate(45deg);
    opacity: .80;
}

/* ─── GRID WRAPPER ──────────────────────────────────── */
.dynasty-grid-section {
    padding: 24px 0 80px;
}

.dynasty-count-label {
    font-size: .78rem;
    letter-spacing: .12em;
    text-transform: uppercase;
    color: #475569;
    margin-bottom: 28px;
    padding-left: 2px;
}

/* ─── DYNASTY CARD ──────────────────────────────────── */
.dynasty-card-link {
    text-decoration: none;
    color: inherit;
    display: block;
    height: 100%;
}

.dynasty-card {
    position: relative;
    height: 100%;
    border-radius: 18px;
    background: linear-gradient(145deg, rgba(30,41,59,.90) 0%, rgba(15,23,42,.95) 100%);
    border: 1px solid rgba(250,204,21,.10);
    box-shadow: 0 4px 24px rgba(0,0,0,.40);
    overflow: hidden;
    transition: transform .32s cubic-bezier(.22,.68,0,1.2),
                box-shadow .32s ease,
                border-color .32s ease;
    display: flex;
    flex-direction: column;

    /* glassmorphism */
    backdrop-filter: blur(12px);
    -webkit-backdrop-filter: blur(12px);
}

.dynasty-card:hover {
    transform: translateY(-6px);
    border-color: rgba(250,204,21,.45);
    box-shadow:
        0 8px 32px rgba(0,0,0,.55),
        0 0 0 1px rgba(250,204,21,.18),
        0 0 40px rgba(250,204,21,.10);
}

/* top accent bar */
.dynasty-card::before {
    content: '';
    position: absolute;
    top: 0; left: 0; right: 0;
    height: 3px;
    background: linear-gradient(90deg, #dc3545 0%, #facc15 60%, transparent 100%);
    opacity: 0;
    transition: opacity .32s ease;
}

.dynasty-card:hover::before { opacity: 1; }

/* ── placeholder image area ── */
.dynasty-thumb {
    position: relative;
    height: 190px;
    background: linear-gradient(135deg, #1e293b 0%, #0f172a 100%);
    display: flex;
    align-items: center;
    justify-content: center;
    overflow: hidden;
    flex-shrink: 0;
}

/* subtle grid texture */
.dynasty-thumb::before {
    content: '';
    position: absolute;
    inset: 0;
    background-image:
        linear-gradient(rgba(250,204,21,.04) 1px, transparent 1px),
        linear-gradient(90deg, rgba(250,204,21,.04) 1px, transparent 1px);
    background-size: 32px 32px;
}

/* radial glow behind emoji */
.dynasty-thumb::after {
    content: '';
    position: absolute;
    inset: 0;
    background: radial-gradient(ellipse 60% 60% at 50% 50%, rgba(250,204,21,.07), transparent 70%);
    transition: opacity .32s ease;
    opacity: 0;
}

.dynasty-card:hover .dynasty-thumb::after { opacity: 1; }

.thumb-icon {
    font-size: 72px;
    line-height: 1;
    position: relative;
    z-index: 1;
    transition: transform .32s cubic-bezier(.22,.68,0,1.2);
    filter: drop-shadow(0 4px 12px rgba(0,0,0,.50));
}

.dynasty-card:hover .thumb-icon {
    transform: scale(1.10);
}

/* dynasty number badge */
.dynasty-badge {
    position: absolute;
    top: 12px; right: 12px;
    background: rgba(250,204,21,.12);
    border: 1px solid rgba(250,204,21,.25);
    border-radius: 8px;
    padding: 2px 9px;
    font-family: 'Cinzel', serif;
    font-size: .65rem;
    font-weight: 700;
    letter-spacing: .1em;
    color: #facc15;
    backdrop-filter: blur(6px);
    z-index: 2;
}

/* ── card body ── */
.dynasty-body {
    padding: 22px 22px 20px;
    display: flex;
    flex-direction: column;
    flex: 1;
    gap: 0;
}

.dynasty-name {
    font-family: 'Cinzel', serif;
    font-size: 1.12rem;
    font-weight: 700;
    color: #f1f5f9;
    margin-bottom: 6px;
    letter-spacing: .01em;
    line-height: 1.3;
    transition: color .25s ease;
}

.dynasty-card:hover .dynasty-name { color: #facc15; }

.dynasty-period {
    font-size: .82rem;
    font-weight: 600;
    color: #facc15;
    letter-spacing: .08em;
    margin-bottom: 14px;
    display: flex;
    align-items: center;
    gap: 6px;
}

.dynasty-period::before {
    content: '';
    display: inline-block;
    width: 18px; height: 1.5px;
    background: #facc15;
    border-radius: 2px;
    opacity: .60;
}

.dynasty-meta {
    display: flex;
    flex-direction: column;
    gap: 7px;
    margin-bottom: 14px;
}

.meta-item {
    display: flex;
    align-items: flex-start;
    gap: 8px;
    font-size: .82rem;
    color: #94a3b8;
    line-height: 1.4;
}

.meta-item .meta-icon {
    flex-shrink: 0;
    font-size: .9em;
    margin-top: 1px;
    opacity: .85;
}

.meta-item .meta-label {
    color: #64748b;
    font-weight: 500;
    margin-right: 4px;
}

.meta-item .meta-value {
    color: #cbd5e1;
}

/* description with clamp */
.dynasty-desc {
    font-size: .80rem;
    color: #64748b;
    line-height: 1.65;
    display: -webkit-box;
    -webkit-line-clamp: 3;
    -webkit-box-orient: vertical;
    overflow: hidden;
    margin-top: auto;
    padding-top: 12px;
    border-top: 1px solid rgba(255,255,255,.05);
}

/* "Xem chi tiết" CTA row */
.dynasty-cta {
    margin-top: 16px;
    display: flex;
    align-items: center;
    justify-content: space-between;
    font-size: .75rem;
    letter-spacing: .08em;
    text-transform: uppercase;
    font-weight: 600;
    color: rgba(250,204,21,.45);
    transition: color .25s ease;
}

.dynasty-card:hover .dynasty-cta { color: #facc15; }

.cta-arrow {
    display: inline-flex;
    align-items: center;
    justify-content: center;
    width: 28px; height: 28px;
    border-radius: 50%;
    border: 1px solid rgba(250,204,21,.25);
    font-size: .80rem;
    transition: background .25s ease, border-color .25s ease, transform .25s ease;
}

.dynasty-card:hover .cta-arrow {
    background: rgba(250,204,21,.15);
    border-color: rgba(250,204,21,.60);
    transform: translateX(3px);
}

/* ─── EMPTY STATE ────────────────────────────────────── */
.empty-state {
    text-align: center;
    padding: 100px 24px;
    display: flex;
    flex-direction: column;
    align-items: center;
    gap: 16px;
}

.empty-icon {
    font-size: 96px;
    opacity: .25;
    filter: grayscale(1);
}

.empty-title {
    font-family: 'Cinzel', serif;
    font-size: 1.4rem;
    font-weight: 700;
    color: #475569;
}

.empty-sub {
    font-size: .90rem;
    color: #334155;
    max-width: 320px;
    line-height: 1.6;
}

.btn-empty-home {
    margin-top: 8px;
    display: inline-block;
    padding: 11px 30px;
    border-radius: 99px;
    border: 1px solid rgba(250,204,21,.40);
    color: #facc15;
    font-size: .85rem;
    font-weight: 600;
    letter-spacing: .06em;
    text-decoration: none;
    transition: background .25s, color .25s;
}

.btn-empty-home:hover {
    background: rgba(250,204,21,.12);
    color: #fde68a;
}

/* ─── STAGGER FADE-IN ────────────────────────────────── */
@keyframes cardFadeUp {
    from { opacity: 0; transform: translateY(28px); }
    to   { opacity: 1; transform: translateY(0); }
}

.dynasty-col {
    opacity: 0;
    animation: cardFadeUp .55s cubic-bezier(.22,.68,0,1) forwards;
}

/* stagger up to 12 cards */
.dynasty-col:nth-child(1)  { animation-delay: .05s; }
.dynasty-col:nth-child(2)  { animation-delay: .12s; }
.dynasty-col:nth-child(3)  { animation-delay: .19s; }
.dynasty-col:nth-child(4)  { animation-delay: .26s; }
.dynasty-col:nth-child(5)  { animation-delay: .33s; }
.dynasty-col:nth-child(6)  { animation-delay: .40s; }
.dynasty-col:nth-child(7)  { animation-delay: .47s; }
.dynasty-col:nth-child(8)  { animation-delay: .54s; }
.dynasty-col:nth-child(9)  { animation-delay: .61s; }
.dynasty-col:nth-child(10) { animation-delay: .68s; }
.dynasty-col:nth-child(11) { animation-delay: .75s; }
.dynasty-col:nth-child(12) { animation-delay: .82s; }

/* ─── SCROLLBAR ──────────────────────────────────────── */
::-webkit-scrollbar { width: 6px; }
::-webkit-scrollbar-track { background: #0f172a; }
::-webkit-scrollbar-thumb { background: rgba(250,204,21,.20); border-radius: 3px; }

/* ─── REDUCE MOTION ──────────────────────────────────── */
@media (prefers-reduced-motion: reduce) {
    .dynasty-col { animation: none; opacity: 1; }
    .dynasty-card, .dynasty-card:hover,
    .thumb-icon, .cta-arrow { transition: none; transform: none; }
}

</style>

</head>

<body class="bg-dark-page">

<jsp:include page="/common/header.jsp"/>

<!-- ═══════════════════════════════════════════════════════ HERO -->
<section class="su-mon-hero">
    <div class="container">

        <div class="hero-eyebrow">Sử Môn · Lịch Sử Việt Nam</div>

        <h1 class="hero-title">
            🏯 Các <span class="accent-gold">Triều Đại</span><br>Việt Nam
        </h1>

        <p class="hero-subtitle">
            Hành trình lịch sử qua các triều đại phong kiến Việt Nam — từ buổi bình minh dựng nước đến thời đại cận đại.
        </p>

        <div class="hero-divider">
            <span></span>
            <div class="diamond"></div>
            <span></span>
        </div>

    </div>
</section>

<!-- ═══════════════════════════════════════════════════════ GRID -->
<section class="dynasty-grid-section">
    <div class="container">

        <c:choose>

            <%-- ── HAS DATA ── --%>
            <c:when test="${not empty list}">

                <p class="dynasty-count-label">
                    Tổng cộng <c:out value="${fn:length(list)}" default=""/> triều đại được lưu trữ
                </p>

                <div class="row g-4">
                    <c:forEach items="${list}" var="d" varStatus="loop">

                    <div class="col-lg-4 col-md-6 dynasty-col">

                        <a href="${pageContext.request.contextPath}/dynasty?id=${d.id}"
                           class="dynasty-card-link"
                           aria-label="Xem chi tiết triều đại ${d.name}">

                            <div class="dynasty-card">

                                <!-- thumbnail -->
                                <div class="dynasty-thumb">
                                    <span class="dynasty-badge">#${loop.index + 1}</span>
                                    <div class="thumb-icon">🏯</div>
                                </div>

                                <!-- body -->
                                <div class="dynasty-body">

                                    <h2 class="dynasty-name">${d.name}</h2>

                                    <div class="dynasty-period">
                                        ${d.startYear} – ${d.endYear}
                                    </div>

                                    <div class="dynasty-meta">
                                        <div class="meta-item">
                                            <span class="meta-icon">👑</span>
                                            <span>
                                                <span class="meta-label">Người sáng lập:</span>
                                                <span class="meta-value">${d.founder}</span>
                                            </span>
                                        </div>
                                        <div class="meta-item">
                                            <span class="meta-icon">🏛️</span>
                                            <span>
                                                <span class="meta-label">Kinh đô:</span>
                                                <span class="meta-value">${d.capital}</span>
                                            </span>
                                        </div>
                                    </div>

                                    <p class="dynasty-desc">${d.description}</p>

                                    <div class="dynasty-cta">
                                        <span>Xem chi tiết</span>
                                        <span class="cta-arrow">›</span>
                                    </div>

                                </div>

                            </div>

                        </a>

                    </div>

                    </c:forEach>
                </div>

            </c:when>

            <%-- ── EMPTY STATE ── --%>
            <c:otherwise>

                <div class="empty-state">
                    <div class="empty-icon">🏯</div>
                    <p class="empty-title">Chưa có dữ liệu triều đại</p>
                    <p class="empty-sub">
                        Chưa có triều đại nào được lưu trữ trong hệ thống.<br>
                        Hãy quay lại sau hoặc liên hệ quản trị viên.
                    </p>
                    <a href="${pageContext.request.contextPath}/"
                       class="btn-empty-home">
                        ← Quay lại trang chủ
                    </a>
                </div>

            </c:otherwise>

        </c:choose>

    </div>
</section>

<jsp:include page="/common/footer.jsp"/>


<script>
/* Intersection Observer: cards that scroll into view after first load
   also fade in (covers long lists where CSS stagger already played) */
(function () {
    if (!('IntersectionObserver' in window)) return;

    const cards = document.querySelectorAll('.dynasty-col');
    const io = new IntersectionObserver((entries) => {
        entries.forEach(e => {
            if (e.isIntersecting) {
                e.target.style.opacity = '1';
                e.target.style.transform = 'translateY(0)';
                io.unobserve(e.target);
            }
        });
    }, { threshold: 0.12 });

    cards.forEach(c => io.observe(c));
})();
</script>

</body>
</html>

