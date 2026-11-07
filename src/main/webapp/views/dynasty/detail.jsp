<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<% request.setAttribute("activePage","dynasties"); %>
<!DOCTYPE html>
<html lang="vi">
<head>
<title><c:out value="${dynasty.name}" default="Triều Đại" /> – Sử Môn</title>
<jsp:include page="/common/head-resources.jsp"/>
<style>
*, *::before, *::after { box-sizing: border-box; margin: 0; padding: 0; }
html { scroll-behavior: smooth; }
body { background: #0f172a; color: #e2e8f0; font-family: 'Be Vietnam Pro', sans-serif; min-height: 100vh; overflow-x: hidden; padding-top: 72px; }
::-webkit-scrollbar { width: 5px; }
::-webkit-scrollbar-track { background: #0f172a; }
::-webkit-scrollbar-thumb { background: rgba(250,204,21,.22); border-radius: 3px; }

/* ─── HERO CINEMATIC ────────────────────────────────────────── */
.sm-hero {
    position: relative;
    width: 100%;
    min-height: 92vh;
    display: flex;
    align-items: flex-end;
    overflow: hidden;
    isolation: isolate;
}

/* parallax bg image */
.sm-hero-bg {
    position: absolute;
    inset: -60px;               /* oversized so JS parallax has room */
    background-size: cover;
    background-position: center 30%;
    background-repeat: no-repeat;
    will-change: transform;
    transition: transform .05s linear;
    z-index: -3;
}

/* fallback pattern when no image */
.sm-hero-bg-fallback {
    position: absolute;
    inset: 0;
    background:
        radial-gradient(ellipse 80% 60% at 50% 20%, rgba(250,204,21,.08), transparent 65%),
        radial-gradient(ellipse 60% 50% at 15% 80%, rgba(220,53,69,.07), transparent 60%),
        linear-gradient(160deg, #111827 0%, #0f172a 100%);
    z-index: -3;
}

/* cinematic gradient overlay */
.sm-hero::before {
    content: '';
    position: absolute;
    inset: 0;
    background:
        linear-gradient(to top,
            #0f172a 0%,
            rgba(15,23,42,.88) 30%,
            rgba(15,23,42,.45) 65%,
            rgba(15,23,42,.25) 100%);
    z-index: -2;
}

/* vignette sides */
.sm-hero::after {
    content: '';
    position: absolute;
    inset: 0;
    background:
        radial-gradient(ellipse 120% 100% at 50% 50%,
            transparent 40%,
            rgba(0,0,0,.55) 100%);
    z-index: -1;
}

.sm-hero-content {
    width: 100%;
    padding: 0 0 64px;
}

.hero-breadcrumb {
    font-size: .72rem;
    letter-spacing: .15em;
    text-transform: uppercase;
    color: rgba(250,204,21,.55);
    margin-bottom: 20px;
    display: flex;
    align-items: center;
    gap: 8px;
}

.hero-breadcrumb a {
    color: rgba(250,204,21,.55);
    text-decoration: none;
    transition: color .2s;
}
.hero-breadcrumb a:hover { color: #facc15; }

.hero-breadcrumb .sep { opacity: .40; }

.hero-eyebrow {
    display: inline-block;
    font-size: .68rem;
    font-weight: 600;
    letter-spacing: .20em;
    text-transform: uppercase;
    color: #facc15;
    border: 1px solid rgba(250,204,21,.28);
    border-radius: 99px;
    padding: 3px 14px;
    margin-bottom: 18px;
    backdrop-filter: blur(6px);
}

.hero-title {
    font-family: 'Cinzel', serif;
    font-size: clamp(2.4rem, 6vw, 5rem);
    font-weight: 900;
    line-height: 1.05;
    color: #f8fafc;
    text-shadow:
        0 2px 4px rgba(0,0,0,.6),
        0 0 60px rgba(250,204,21,.18);
    margin-bottom: 20px;
    letter-spacing: -.01em;
}

.hero-period {
    font-family: 'Cinzel', serif;
    font-size: clamp(1rem, 2.5vw, 1.35rem);
    font-weight: 600;
    color: #facc15;
    letter-spacing: .12em;
    margin-bottom: 28px;
    display: flex;
    align-items: center;
    gap: 10px;
}

.hero-period::before, .hero-period::after {
    content: '';
    display: block;
    height: 1px;
    width: 40px;
    background: rgba(250,204,21,.40);
}

.hero-meta-row {
    display: flex;
    flex-wrap: wrap;
    gap: 12px;
    margin-bottom: 36px;
}

.hero-badge {
    display: inline-flex;
    align-items: center;
    gap: 7px;
    background: rgba(255,255,255,.06);
    border: 1px solid rgba(255,255,255,.10);
    border-radius: 10px;
    padding: 8px 16px;
    font-size: .83rem;
    color: #cbd5e1;
    backdrop-filter: blur(10px);
    transition: border-color .25s, background .25s;
}

.hero-badge:hover {
    border-color: rgba(250,204,21,.35);
    background: rgba(250,204,21,.06);
}

.hero-badge .badge-icon { font-size: 1em; }
.hero-badge .badge-label { color: #64748b; font-size: .72rem; text-transform: uppercase; letter-spacing: .08em; }
.hero-badge .badge-value { color: #f1f5f9; font-weight: 500; }

.hero-actions {
    display: flex;
    gap: 12px;
    flex-wrap: wrap;
}

.btn-sm-back {
    display: inline-flex;
    align-items: center;
    gap: 8px;
    padding: 10px 22px;
    border-radius: 99px;
    border: 1px solid rgba(255,255,255,.15);
    background: rgba(255,255,255,.05);
    color: #cbd5e1;
    font-size: .82rem;
    font-weight: 500;
    text-decoration: none;
    backdrop-filter: blur(8px);
    transition: all .25s;
}

.btn-sm-back:hover {
    border-color: rgba(255,255,255,.35);
    background: rgba(255,255,255,.10);
    color: #f1f5f9;
    transform: translateX(-2px);
}

.btn-sm-chars {
    display: inline-flex;
    align-items: center;
    gap: 8px;
    padding: 10px 22px;
    border-radius: 99px;
    border: 1px solid rgba(250,204,21,.35);
    background: rgba(250,204,21,.08);
    color: #facc15;
    font-size: .82rem;
    font-weight: 600;
    text-decoration: none;
    backdrop-filter: blur(8px);
    transition: all .25s;
}

.btn-sm-chars:hover {
    background: rgba(250,204,21,.18);
    border-color: rgba(250,204,21,.65);
    color: #fde68a;
    box-shadow: 0 0 24px rgba(250,204,21,.18);
}

/* scroll indicator */
.scroll-hint {
    position: absolute;
    bottom: 24px;
    left: 50%;
    transform: translateX(-50%);
    display: flex;
    flex-direction: column;
    align-items: center;
    gap: 6px;
    opacity: .35;
    animation: floatUp 2s ease-in-out infinite;
}

.scroll-hint span {
    font-size: .60rem;
    letter-spacing: .15em;
    text-transform: uppercase;
    color: #facc15;
}

.scroll-mouse {
    width: 20px; height: 30px;
    border: 1.5px solid rgba(250,204,21,.50);
    border-radius: 10px;
    display: flex;
    justify-content: center;
    padding-top: 4px;
}

.scroll-dot {
    width: 3px; height: 6px;
    background: #facc15;
    border-radius: 99px;
    animation: scrollDot 1.8s ease-in-out infinite;
}

@keyframes scrollDot {
    0%   { transform: translateY(0); opacity: 1; }
    100% { transform: translateY(10px); opacity: 0; }
}

@keyframes floatUp {
    0%, 100% { transform: translateX(-50%) translateY(0); }
    50%       { transform: translateX(-50%) translateY(-5px); }
}

/* ─── CONTENT AREA ──────────────────────────────────────────── */
.sm-content {
    position: relative;
    z-index: 1;
    padding-bottom: 80px;
}

/* section label */
.sm-section-label {
    display: flex;
    align-items: center;
    gap: 12px;
    margin-bottom: 28px;
}

.sm-section-label .label-icon {
    font-size: 1.25rem;
}

.sm-section-label h2 {
    font-family: 'Cinzel', serif;
    font-size: 1.15rem;
    font-weight: 700;
    color: #f1f5f9;
    letter-spacing: .04em;
    margin: 0;
}

.sm-section-label::after {
    content: '';
    flex: 1;
    height: 1px;
    background: linear-gradient(90deg, rgba(250,204,21,.25), transparent);
}

/* ─── SECTION 1: DESCRIPTION GLASS CARD ───────────────────── */
.sm-glass-card {
    background: rgba(30,41,59,.60);
    border: 1px solid rgba(255,255,255,.07);
    border-radius: 20px;
    padding: 36px 40px;
    backdrop-filter: blur(14px);
    -webkit-backdrop-filter: blur(14px);
    box-shadow: 0 8px 32px rgba(0,0,0,.35);
    position: relative;
    overflow: hidden;
}

.sm-glass-card::before {
    content: '';
    position: absolute;
    top: 0; left: 0; right: 0;
    height: 2px;
    background: linear-gradient(90deg, #dc3545, #facc15 50%, transparent);
}

.sm-desc-text {
    font-size: 1.02rem;
    line-height: 1.85;
    color: #94a3b8;
    font-weight: 300;
    letter-spacing: .01em;
}

.sm-desc-text::first-letter {
    font-family: 'Cinzel', serif;
    font-size: 2.8rem;
    font-weight: 700;
    color: #facc15;
    float: left;
    line-height: .85;
    margin: 4px 10px 0 0;
    text-shadow: 0 0 30px rgba(250,204,21,.35);
}

/* ─── SECTION 2: TIMELINE ────────────────────────────────── */
.sm-timeline-wrap {
    position: relative;
    padding: 20px 0 12px;
}

/* central spine */
.sm-timeline-wrap::before {
    content: '';
    position: absolute;
    left: 50%;
    top: 0; bottom: 0;
    width: 1px;
    background: linear-gradient(180deg,
        transparent 0%,
        rgba(250,204,21,.30) 15%,
        rgba(250,204,21,.30) 85%,
        transparent 100%);
    transform: translateX(-50%);
}

.tl-item {
    display: flex;
    align-items: flex-start;
    gap: 0;
    margin-bottom: 36px;
    position: relative;
}

/* alternate left / right */
.tl-item:nth-child(odd)  { flex-direction: row; }
.tl-item:nth-child(even) { flex-direction: row-reverse; }

.tl-side {
    flex: 1;
    padding: 0 32px;
}

.tl-item:nth-child(odd)  .tl-side { text-align: right; }
.tl-item:nth-child(even) .tl-side { text-align: left; }

/* dot */
.tl-dot {
    flex-shrink: 0;
    width: 14px; height: 14px;
    border-radius: 50%;
    background: #facc15;
    box-shadow: 0 0 0 3px rgba(250,204,21,.18), 0 0 16px rgba(250,204,21,.30);
    margin-top: 4px;
    position: relative;
    z-index: 1;
}

.tl-dot-center { flex-shrink: 0; width: 14px; }

.tl-year {
    font-family: 'Cinzel', serif;
    font-size: 1.10rem;
    font-weight: 700;
    color: #facc15;
    margin-bottom: 4px;
}

.tl-label {
    font-size: .82rem;
    color: #64748b;
    text-transform: uppercase;
    letter-spacing: .10em;
    font-weight: 500;
}

.tl-duration {
    display: flex;
    flex-direction: column;
    align-items: center;
    justify-content: center;
    padding: 16px 0;
    gap: 4px;
}

.tl-duration .dur-line {
    width: 1px;
    height: 40px;
    background: linear-gradient(180deg, rgba(250,204,21,.20), rgba(250,204,21,.60), rgba(250,204,21,.20));
}

.tl-duration .dur-label {
    font-family: 'Cinzel', serif;
    font-size: .70rem;
    letter-spacing: .12em;
    color: rgba(250,204,21,.50);
    text-transform: uppercase;
    white-space: nowrap;
    transform: rotate(0deg);
    text-align: center;
}

/* horizontal bar under spine for mobile */
@media (max-width: 640px) {
    .sm-timeline-wrap::before { left: 20px; }
    .tl-item, .tl-item:nth-child(even) { flex-direction: column; padding-left: 50px; }
    .tl-dot { position: absolute; left: 14px; top: 4px; }
    .tl-side, .tl-item:nth-child(odd) .tl-side { text-align: left; padding: 0; }
    .tl-empty { display: none; }
    .tl-duration { flex-direction: row; padding: 0 0 0 50px; }
    .tl-duration .dur-line { width: 40px; height: 1px; }
}

/* ─── SECTION 3: CHARACTER CARDS ──────────────────────────── */
.char-grid { display: grid; grid-template-columns: repeat(auto-fill, minmax(190px, 1fr)); gap: 20px; }

.char-card-link {
    display: block;
    text-decoration: none;
    color: inherit;
    height: 100%;
}

.char-card {
    position: relative;
    border-radius: 16px;
    overflow: hidden;
    background: rgba(30,41,59,.70);
    border: 1px solid rgba(255,255,255,.06);
    backdrop-filter: blur(10px);
    transition: transform .30s cubic-bezier(.22,.68,0,1.2),
                border-color .30s ease,
                box-shadow .30s ease;
    height: 100%;
}

.char-card:hover {
    transform: translateY(-6px);
    border-color: rgba(250,204,21,.40);
    box-shadow:
        0 12px 36px rgba(0,0,0,.50),
        0 0 32px rgba(250,204,21,.10);
}

.char-img-wrap {
    position: relative;
    height: 210px;
    overflow: hidden;
    background: linear-gradient(135deg, #1e293b, #111827);
}

.char-img-wrap img {
    width: 100%;
    height: 100%;
    object-fit: cover;
    transition: transform .40s ease;
    display: block;
}

.char-card:hover .char-img-wrap img {
    transform: scale(1.07);
}

/* placeholder when no image */
.char-img-placeholder {
    width: 100%;
    height: 100%;
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 56px;
    background:
        radial-gradient(ellipse 70% 70% at 50% 40%, rgba(250,204,21,.06), transparent),
        linear-gradient(135deg, #1e293b, #0f172a);
}

/* gold shimmer overlay on hover */
.char-img-wrap::after {
    content: '';
    position: absolute;
    inset: 0;
    background: linear-gradient(180deg, transparent 50%, rgba(15,23,42,.85) 100%);
}

.char-body {
    padding: 14px 16px 16px;
}

.char-name {
    font-family: 'Cinzel', serif;
    font-size: .92rem;
    font-weight: 700;
    color: #f1f5f9;
    margin-bottom: 4px;
    line-height: 1.25;
    transition: color .25s;
}

.char-card:hover .char-name { color: #facc15; }

.char-desc {
    font-size: .74rem;
    color: #64748b;
    line-height: 1.55;
    display: -webkit-box;
    -webkit-line-clamp: 2;
    -webkit-box-orient: vertical;
    overflow: hidden;
}

.char-cta {
    margin-top: 10px;
    font-size: .68rem;
    letter-spacing: .10em;
    text-transform: uppercase;
    color: rgba(250,204,21,.35);
    font-weight: 600;
    transition: color .25s;
    display: flex;
    align-items: center;
    gap: 4px;
}

.char-card:hover .char-cta { color: #facc15; }

/* top accent bar on hover */
.char-card::before {
    content: '';
    position: absolute;
    top: 0; left: 0; right: 0;
    height: 2px;
    background: linear-gradient(90deg, #dc3545, #facc15);
    opacity: 0;
    transition: opacity .30s;
    z-index: 2;
}

.char-card:hover::before { opacity: 1; }

/* ─── SECTION 4: CAPITAL MAP CARD ─────────────────────────── */
.capital-card {
    background: rgba(30,41,59,.60);
    border: 1px solid rgba(255,255,255,.07);
    border-radius: 20px;
    overflow: hidden;
    backdrop-filter: blur(14px);
    display: flex;
    flex-direction: column;
}

@media (min-width: 768px) { .capital-card { flex-direction: row; } }

.capital-map-placeholder {
    flex-shrink: 0;
    width: 100%;
    height: 200px;
    background:
        radial-gradient(circle at 50% 50%, rgba(250,204,21,.08) 0%, transparent 65%),
        linear-gradient(135deg, #1e293b 0%, #0f172a 100%);
    display: flex;
    align-items: center;
    justify-content: center;
    position: relative;
    overflow: hidden;
}

@media (min-width: 768px) {
    .capital-map-placeholder { width: 260px; height: auto; }
}

/* grid dots */
.capital-map-placeholder::before {
    content: '';
    position: absolute;
    inset: 0;
    background-image:
        radial-gradient(circle, rgba(250,204,21,.12) 1px, transparent 1px);
    background-size: 24px 24px;
}

/* pulse ring */
.map-pulse {
    position: relative;
    z-index: 1;
    display: flex;
    align-items: center;
    justify-content: center;
}

.map-pulse::before, .map-pulse::after {
    content: '';
    position: absolute;
    border-radius: 50%;
    border: 1px solid rgba(250,204,21,.30);
    animation: pulseRing 2.4s ease-out infinite;
}

.map-pulse::before { width: 60px; height: 60px; animation-delay: 0s; }
.map-pulse::after  { width: 90px; height: 90px; animation-delay: .6s; }

@keyframes pulseRing {
    0%   { opacity: .60; transform: scale(.85); }
    100% { opacity: 0;   transform: scale(1.40); }
}

.map-icon { font-size: 2.4rem; position: relative; z-index: 1; }

.capital-info {
    padding: 28px 32px;
    display: flex;
    flex-direction: column;
    justify-content: center;
    gap: 10px;
}

.capital-label {
    font-size: .68rem;
    letter-spacing: .18em;
    text-transform: uppercase;
    color: #475569;
    font-weight: 600;
}

.capital-name {
    font-family: 'Cinzel', serif;
    font-size: 1.55rem;
    font-weight: 700;
    color: #facc15;
    text-shadow: 0 0 30px rgba(250,204,21,.22);
}

.capital-note {
    font-size: .82rem;
    color: #64748b;
    line-height: 1.6;
}

/* ─── EMPTY STATE ──────────────────────────────────────────── */
.sm-empty {
    min-height: 70vh;
    display: flex;
    flex-direction: column;
    align-items: center;
    justify-content: center;
    text-align: center;
    gap: 16px;
    padding: 60px 24px;
}

.empty-icon-xl { font-size: 100px; opacity: .18; }

.empty-title {
    font-family: 'Cinzel', serif;
    font-size: 1.6rem;
    font-weight: 700;
    color: #334155;
}

.empty-sub {
    font-size: .88rem;
    color: #1e293b;
    max-width: 300px;
    line-height: 1.65;
}

.btn-empty {
    display: inline-block;
    margin-top: 8px;
    padding: 11px 28px;
    border-radius: 99px;
    border: 1px solid rgba(250,204,21,.35);
    color: #facc15;
    font-size: .83rem;
    font-weight: 600;
    letter-spacing: .06em;
    text-decoration: none;
    transition: background .25s, box-shadow .25s;
}

.btn-empty:hover {
    background: rgba(250,204,21,.10);
    box-shadow: 0 0 24px rgba(250,204,21,.14);
    color: #fde68a;
}

/* ─── SCROLL-REVEAL ANIMATION ─────────────────────────────── */
.sm-reveal {
    opacity: 0;
    transform: translateY(30px);
    transition: opacity .65s ease, transform .65s cubic-bezier(.22,.68,0,1);
}

.sm-reveal.is-visible {
    opacity: 1;
    transform: translateY(0);
}

.sm-reveal-delay-1 { transition-delay: .10s; }
.sm-reveal-delay-2 { transition-delay: .20s; }
.sm-reveal-delay-3 { transition-delay: .30s; }

/* char cards stagger */
.char-col { opacity: 0; transform: translateY(20px); transition: opacity .45s ease, transform .45s cubic-bezier(.22,.68,0,1); }
.char-col.is-visible { opacity: 1; transform: translateY(0); }
.char-col:nth-child(1) { transition-delay: .05s; }
.char-col:nth-child(2) { transition-delay: .12s; }
.char-col:nth-child(3) { transition-delay: .19s; }
.char-col:nth-child(4) { transition-delay: .26s; }
.char-col:nth-child(5) { transition-delay: .33s; }
.char-col:nth-child(6) { transition-delay: .40s; }
.char-col:nth-child(7) { transition-delay: .47s; }
.char-col:nth-child(8) { transition-delay: .54s; }

/* ─── SPACING HELPERS ─────────────────────────────────────── */
.sm-section { margin-top: 64px; }

/* ─── REDUCE MOTION ───────────────────────────────────────── */
@media (prefers-reduced-motion: reduce) {
    .sm-reveal, .char-col { transition: none; opacity: 1; transform: none; }
    .sm-hero-bg { transition: none; }
    .scroll-hint, .map-pulse::before, .map-pulse::after, .scroll-dot { animation: none; }
}

</style>

</head>

<body class="bg-dark-page">

<jsp:include page="/common/header.jsp"/>

<!-- ══════════════════════════════════════════ EMPTY STATE GUARD -->
<c:choose>

<c:when test="${empty dynasty}">

    <div class="container">
        <div class="sm-empty">
            <div class="empty-icon-xl">🏯</div>
            <p class="empty-title">Không tìm thấy triều đại</p>
            <p class="empty-sub">Triều đại này không tồn tại hoặc đã bị xoá khỏi hệ thống.</p>
            <a href="${pageContext.request.contextPath}/dynasties" class="btn-empty">← Quay lại danh sách</a>
        </div>
    </div>

</c:when>

<c:otherwise>

<!-- ══════════════════════════════════════════ HERO CINEMATIC -->
<section class="sm-hero" id="sm-hero-top">

    <%-- Background image (parallax target) --%>
    <c:choose>
        <c:when test="${not empty dynasty.image}">
            <div class="sm-hero-bg" id="heroBg"
                 style="background-image:url('${pageContext.request.contextPath}/assets/images/dynasties/${dynasty.image}')">
            </div>
        </c:when>
        <c:otherwise>
            <div class="sm-hero-bg-fallback"></div>
        </c:otherwise>
    </c:choose>

    <div class="container sm-hero-content">

        <!-- breadcrumb -->
        <div class="hero-breadcrumb">
            <a href="${pageContext.request.contextPath}/">Trang chủ</a>
            <span class="sep">›</span>
            <a href="${pageContext.request.contextPath}/dynasties">Triều đại</a>
            <span class="sep">›</span>
            <span>${dynasty.name}</span>
        </div>

        <!-- eyebrow -->
        <div class="hero-eyebrow">Sử Môn · Lịch Sử Việt Nam</div>

        <!-- main title -->
        <h1 class="hero-title">🏯 ${dynasty.name}</h1>

        <!-- period -->
        <div class="hero-period">
            ${dynasty.startYear} &nbsp;–&nbsp; ${dynasty.endYear}
        </div>

        <!-- meta badges -->
        <div class="hero-meta-row">

            <c:if test="${not empty dynasty.founder}">
            <div class="hero-badge">
                <span class="badge-icon">👑</span>
                <span>
                    <span class="badge-label d-block">Người sáng lập</span>
                    <span class="badge-value">${dynasty.founder}</span>
                </span>
            </div>
            </c:if>

            <c:if test="${not empty dynasty.capital}">
            <div class="hero-badge">
                <span class="badge-icon">🏛️</span>
                <span>
                    <span class="badge-label d-block">Kinh đô</span>
                    <span class="badge-value">${dynasty.capital}</span>
                </span>
            </div>
            </c:if>

        </div>

        <!-- actions -->
        <div class="hero-actions">
            <a href="${pageContext.request.contextPath}/dynasties" class="btn-sm-back">
                ← Danh sách triều đại
            </a>
            <c:if test="${not empty characters}">
            <a href="#characters-section" class="btn-sm-chars">
                👥 Xem nhân vật
            </a>
            </c:if>
        </div>

    </div>

    <!-- scroll hint -->
    <div class="scroll-hint" aria-hidden="true">
        <div class="scroll-mouse"><div class="scroll-dot"></div></div>
        <span>Cuộn xuống</span>
    </div>

</section>

<!-- ══════════════════════════════════════════ MAIN CONTENT -->
<main class="sm-content">
<div class="container">

    <!-- ─── SECTION 1: GIỚI THIỆU ────────────────────────── -->
    <div class="sm-section sm-reveal">

        <div class="sm-section-label">
            <span class="label-icon">📜</span>
            <h2>Tổng quan</h2>
        </div>

        <div class="sm-glass-card">
            <p class="sm-desc-text">${dynasty.description}</p>
        </div>

    </div>

    <!-- ─── SECTION 2: TIMELINE ───────────────────────────── -->
    <div class="sm-section sm-reveal sm-reveal-delay-1">

        <div class="sm-section-label">
            <span class="label-icon">🕰️</span>
            <h2>Dòng thời gian</h2>
        </div>

        <div class="sm-glass-card" style="padding:40px 36px;">
            <div class="sm-timeline-wrap">

                <!-- FOUNDED -->
                <div class="tl-item">
                    <div class="tl-side">
                        <div class="tl-year">${dynasty.startYear}</div>
                        <div class="tl-label">Khai quốc</div>
                    </div>
                    <div class="tl-dot"></div>
                    <div class="tl-side tl-empty"></div>
                </div>

                <!-- DURATION INDICATOR -->
                <div class="tl-item" style="align-items:center; justify-content:center; margin-bottom:0;">
                    <div class="tl-side" style="display:flex;justify-content:flex-end;padding-right:32px;">
                        <div></div>
                    </div>
                    <div style="display:flex;flex-direction:column;align-items:center;gap:6px;padding:10px 0;">
                        <div style="width:1px;height:30px;background:rgba(250,204,21,.25);"></div>
                        <span style="font-family:'Cinzel',serif;font-size:.68rem;letter-spacing:.12em;color:rgba(250,204,21,.45);text-transform:uppercase;white-space:nowrap;">
                            <%-- approximate duration badge via JSTL --%>
                            Tồn tại qua nhiều thế kỷ
                        </span>
                        <div style="width:1px;height:30px;background:rgba(250,204,21,.25);"></div>
                    </div>
                    <div class="tl-side"></div>
                </div>

                <!-- EVENTS / MILESTONES placeholder row -->
                <c:if test="${not empty dynasty.founder}">
                <div class="tl-item">
                    <div class="tl-side tl-empty"></div>
                    <div class="tl-dot" style="background:#dc3545;box-shadow:0 0 0 3px rgba(220,53,69,.18),0 0 16px rgba(220,53,69,.25);"></div>
                    <div class="tl-side">
                        <div class="tl-year" style="color:#f87171;">Người lập quốc</div>
                        <div class="tl-label">${dynasty.founder}</div>
                    </div>
                </div>
                </c:if>

                <c:if test="${not empty dynasty.capital}">
                <div class="tl-item">
                    <div class="tl-side">
                        <div class="tl-year" style="color:#a78bfa;">Định đô</div>
                        <div class="tl-label">${dynasty.capital}</div>
                    </div>
                    <div class="tl-dot" style="background:#a78bfa;box-shadow:0 0 0 3px rgba(167,139,250,.18),0 0 16px rgba(167,139,250,.22);"></div>
                    <div class="tl-side tl-empty"></div>
                </div>
                </c:if>

                <!-- END -->
                <div class="tl-item">
                    <div class="tl-side tl-empty"></div>
                    <div class="tl-dot" style="background:#475569;box-shadow:0 0 0 3px rgba(71,85,105,.25);"></div>
                    <div class="tl-side">
                        <div class="tl-year" style="color:#64748b;">${dynasty.endYear}</div>
                        <div class="tl-label">Kết thúc</div>
                    </div>
                </div>

            </div>
        </div>

    </div>

    <!-- ─── SECTION 3: CHARACTERS ─────────────────────────── -->
    <c:if test="${not empty characters}">

    <div class="sm-section" id="characters-section">

        <div class="sm-section-label sm-reveal">
            <span class="label-icon">👤</span>
            <h2>Nhân vật tiêu biểu</h2>
        </div>

        <div class="char-grid">

            <c:forEach items="${characters}" var="c" varStatus="cs">

            <div class="char-col">

                <a href="${pageContext.request.contextPath}/characters?id=${c.id}"
                   class="char-card-link"
                   aria-label="Xem chi tiết ${c.name}">

                    <div class="char-card">

                        <div class="char-img-wrap">
                            <c:choose>
                                <c:when test="${not empty c.image}">
                                    <img src="${pageContext.request.contextPath}/assets/images/characters/${c.image}"
                                         alt="${c.name}"
                                         loading="lazy">
                                </c:when>
                                <c:otherwise>
                                    <div class="char-img-placeholder">⚔️</div>
                                </c:otherwise>
                            </c:choose>
                        </div>

                        <div class="char-body">
                            <div class="char-name">${c.name}</div>
                            <p class="char-desc">${c.description}</p>
                            <div class="char-cta">Xem chi tiết <span>›</span></div>
                        </div>

                    </div>

                </a>

            </div>

            </c:forEach>

        </div>

    </div>

    </c:if>

    <!-- ─── SECTION 4: CAPITAL CARD ───────────────────────── -->
    <c:if test="${not empty dynasty.capital}">

    <div class="sm-section sm-reveal sm-reveal-delay-2">

        <div class="sm-section-label">
            <span class="label-icon">🗺️</span>
            <h2>Kinh đô</h2>
        </div>

        <div class="capital-card">

            <div class="capital-map-placeholder">
                <div class="map-pulse">
                    <div class="map-icon">🏛️</div>
                </div>
            </div>

            <div class="capital-info">
                <div class="capital-label">Trung tâm quyền lực</div>
                <div class="capital-name">${dynasty.capital}</div>
                <p class="capital-note">
                    Kinh đô của triều đại <strong style="color:#f1f5f9;">${dynasty.name}</strong> —
                    nơi tập trung chính trị, văn hoá và quân sự trong suốt thời kỳ
                    <strong style="color:#facc15;">${dynasty.startYear} – ${dynasty.endYear}</strong>.
                </p>
            </div>

        </div>

    </div>

    </c:if>

    <!-- ─── BOTTOM NAVIGATION ──────────────────────────────── -->
    <div class="sm-section sm-reveal sm-reveal-delay-3"
         style="display:flex;gap:12px;flex-wrap:wrap;padding-bottom:20px;">
        <a href="${pageContext.request.contextPath}/dynasties" class="btn-sm-back">
            ← Quay lại danh sách
        </a>
        <c:if test="${not empty characters}">
        <a href="#characters-section" class="btn-sm-chars">
            ❤️ Xem nhân vật khác
        </a>
        </c:if>
    </div>

</div>
</main>

</c:otherwise>
</c:choose>

<jsp:include page="/common/footer.jsp"/>


<script>
(function () {

    /* ── PARALLAX HERO ── */
    var heroBg = document.getElementById('heroBg');
    if (heroBg) {
        var lastY = 0;
        var ticking = false;
        function applyParallax() {
            var sy = window.scrollY;
            heroBg.style.transform = 'translateY(' + (sy * 0.30) + 'px)';
            ticking = false;
        }
        window.addEventListener('scroll', function () {
            lastY = window.scrollY;
            if (!ticking) {
                window.requestAnimationFrame(applyParallax);
                ticking = true;
            }
        }, { passive: true });
    }

    /* ── SCROLL REVEAL ── */
    if ('IntersectionObserver' in window) {

        /* sections */
        var reveals = document.querySelectorAll('.sm-reveal');
        var revealIO = new IntersectionObserver(function (entries) {
            entries.forEach(function (e) {
                if (e.isIntersecting) {
                    e.target.classList.add('is-visible');
                    revealIO.unobserve(e.target);
                }
            });
        }, { threshold: 0.10 });
        reveals.forEach(function (el) { revealIO.observe(el); });

        /* character cards stagger */
        var charCols = document.querySelectorAll('.char-col');
        var charIO = new IntersectionObserver(function (entries) {
            entries.forEach(function (e) {
                if (e.isIntersecting) {
                    e.target.classList.add('is-visible');
                    charIO.unobserve(e.target);
                }
            });
        }, { threshold: 0.08 });
        charCols.forEach(function (el) { charIO.observe(el); });

    } else {
        /* fallback: show everything immediately */
        document.querySelectorAll('.sm-reveal, .char-col').forEach(function (el) {
            el.style.opacity = '1';
            el.style.transform = 'none';
        });
    }

    /* ── SMOOTH ANCHOR SCROLL ── */
    document.querySelectorAll('a[href^="#"]').forEach(function (a) {
        a.addEventListener('click', function (e) {
            var target = document.querySelector(a.getAttribute('href'));
            if (target) {
                e.preventDefault();
                target.scrollIntoView({ behavior: 'smooth', block: 'start' });
            }
        });
    });

})();
</script>

</body>
</html>


