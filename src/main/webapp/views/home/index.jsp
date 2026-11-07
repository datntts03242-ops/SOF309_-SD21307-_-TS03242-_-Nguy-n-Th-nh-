<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<% request.setAttribute("activePage","home"); %>
<!DOCTYPE html>
<html lang="vi">
<head>
<title>Sử Môn – Khai Mở Lịch Sử Việt Nam</title>
<jsp:include page="/common/head-resources.jsp"/>
<style>
*,*::before,*::after{box-sizing:border-box;margin:0;padding:0;}
body{font-family:'Be Vietnam Pro',sans-serif;background:#0F172A;color:#fff;padding-top:0;overflow-x:hidden;}

/* ── HERO ── */
.hp-hero{position:relative;min-height:100vh;display:flex;align-items:center;justify-content:center;text-align:center;overflow:hidden;}
.hp-hero-bg{position:absolute;inset:0;background:url('${pageContext.request.contextPath}/assets/images/backgrounds/hero-bg.png') center/cover no-repeat;}
.hp-hero-overlay{position:absolute;inset:0;background:linear-gradient(160deg,rgba(10,15,30,.82) 0%,rgba(10,15,30,.55) 50%,rgba(10,15,30,.92) 100%);}
.hp-hero-content{position:relative;z-index:2;padding:7rem 1.5rem 5rem;max-width:880px;animation:hpFade .9s .1s both;}
@keyframes hpFade{from{opacity:0;transform:translateY(36px)}to{opacity:1;transform:translateY(0)}}

.hp-badge{display:inline-flex;align-items:center;gap:.5rem;font-size:.7rem;font-weight:700;letter-spacing:.28em;text-transform:uppercase;color:#D4A017;background:rgba(212,160,23,.1);border:1px solid rgba(212,160,23,.28);border-radius:999px;padding:.38rem 1.1rem;margin-bottom:1.75rem;}
.hp-badge::before{content:'';width:6px;height:6px;border-radius:50%;background:#D4A017;animation:pulse 2s infinite;}
@keyframes pulse{0%,100%{opacity:1;transform:scale(1)}50%{opacity:.5;transform:scale(1.4)}}

.hp-title{font-family:'Cormorant Garamond',Georgia,serif;font-size:clamp(3.5rem,10vw,8rem);font-weight:700;line-height:.92;color:#fff;letter-spacing:-.03em;margin-bottom:.5rem;}
.hp-title span{color:#D4A017;position:relative;}
.hp-title-line{width:80px;height:2px;background:linear-gradient(90deg,#D4A017,transparent);margin:.75rem auto 1.25rem;}
.hp-sub{font-family:'Cormorant Garamond',Georgia,serif;font-size:clamp(1.1rem,2.2vw,1.5rem);font-style:italic;color:rgba(255,255,255,.68);margin-bottom:.9rem;}
.hp-desc{font-size:.97rem;color:rgba(255,255,255,.7)!important;max-width:490px;margin:0 auto 2.75rem;line-height:1.85;}


/* ── BUTTONS ── */
.hp-btn-gold{display:inline-flex;align-items:center;gap:.5rem;background:#D4A017;color:#0F172A;font-weight:700;font-size:.9rem;padding:.9rem 2.25rem;border-radius:999px;border:none;text-decoration:none;transition:.3s;letter-spacing:.02em;}
.hp-btn-gold:hover{background:#F0C84A;transform:translateY(-3px);box-shadow:0 10px 32px rgba(212,160,23,.45);color:#0F172A;}
.hp-btn-ghost{display:inline-flex;align-items:center;gap:.5rem;background:transparent;color:rgba(255,255,255,.82);font-weight:500;font-size:.9rem;padding:.9rem 2rem;border-radius:999px;border:1.5px solid rgba(255,255,255,.22);text-decoration:none;transition:.3s;backdrop-filter:blur(6px);}
.hp-btn-ghost:hover{background:rgba(255,255,255,.08);border-color:rgba(255,255,255,.5);color:#fff;transform:translateY(-2px);}
.hp-actions{display:flex;gap:1rem;justify-content:center;flex-wrap:wrap;}

/* ── SCROLL HINT ── */
.hp-scroll{position:absolute;bottom:2.5rem;left:50%;transform:translateX(-50%);z-index:2;display:flex;flex-direction:column;align-items:center;gap:.4rem;opacity:.4;animation:hpBounce 2.4s ease-in-out infinite;}
.hp-scroll-lbl{font-size:.6rem;letter-spacing:.18em;text-transform:uppercase;color:#D4A017;}
@keyframes hpBounce{0%,100%{transform:translateX(-50%) translateY(0)}50%{transform:translateX(-50%) translateY(-7px)}}

/* ── STATS ── */
.hp-stats{background:#fff;}
.hp-stats-grid{display:grid;grid-template-columns:repeat(4,1fr);max-width:1100px;margin:0 auto;}
.hp-stat{padding:2.25rem 1.5rem;text-align:center;border-right:1px solid #E2E8F0;position:relative;overflow:hidden;}
.hp-stat:last-child{border-right:none;}
.hp-stat::before{content:'';position:absolute;top:0;left:0;right:0;height:3px;background:linear-gradient(90deg,#A50000,#D4A017);transform:scaleX(0);transform-origin:left;transition:.4s;}
.hp-stat:hover::before{transform:scaleX(1);}
.hp-stat:hover{background:#FFFBF0;}
.hp-stat-num{font-family:'Cormorant Garamond',Georgia,serif;font-size:2.8rem;font-weight:700;color:#0F172A;line-height:1;margin-bottom:.3rem;}
.hp-stat-num em{font-style:normal;color:#D4A017;}
.hp-stat-lbl{font-size:.72rem;font-weight:700;letter-spacing:.12em;text-transform:uppercase;color:#64748B;}
.hp-stat-icon{font-size:1.4rem;margin-bottom:.5rem;display:block;}

/* ── ABOUT ── */
.hp-about{background:linear-gradient(135deg,#0a0f1e 0%,#0F172A 100%);padding:5rem 1.5rem;text-align:center;position:relative;overflow:hidden;}
.hp-about::before{content:'';position:absolute;top:50%;left:50%;transform:translate(-50%,-50%);width:600px;height:600px;background:radial-gradient(circle,rgba(212,160,23,.06),transparent 70%);pointer-events:none;}
.hp-about-inner{max-width:700px;margin:0 auto;position:relative;z-index:1;}
.hp-about-tag{display:inline-block;font-size:.68rem;font-weight:700;letter-spacing:.25em;text-transform:uppercase;color:#D4A017;border-bottom:1px solid rgba(212,160,23,.35);padding-bottom:.35rem;margin-bottom:1.75rem;}
.hp-about-title{font-family:'Cormorant Garamond',Georgia,serif;font-size:clamp(1.8rem,3.5vw,2.8rem);font-weight:700;color:#fff!important;margin-bottom:1.25rem;line-height:1.2;}
.hp-about-text{font-size:.97rem;color:rgba(255,255,255,.65)!important;line-height:1.9;margin-bottom:2rem;}
.hp-about-divider{width:60px;height:2px;background:linear-gradient(90deg,#A50000,#D4A017);margin:0 auto;}

/* ── FEATURES ── */
.hp-features{background:#F8F9FB;padding:5rem 1.5rem;}
.hp-sec-hdr{text-align:center;margin-bottom:3rem;}
.hp-sec-ey{font-size:.68rem;font-weight:700;letter-spacing:.3em;text-transform:uppercase;color:#A50000;display:block;margin-bottom:.75rem;}
.hp-sec-title{font-family:'Cormorant Garamond',Georgia,serif;font-size:clamp(1.8rem,3.5vw,2.6rem);font-weight:700;color:#0F172A;margin-bottom:.75rem;line-height:1.2;}
.hp-sec-desc{font-size:.95rem;color:#64748B;max-width:480px;margin:0 auto;line-height:1.75;}
.hp-divider{width:50px;height:2.5px;background:linear-gradient(90deg,#A50000,#D4A017);border-radius:2px;margin:1.25rem auto 0;}

.hp-features-grid{display:grid;grid-template-columns:repeat(3,1fr);gap:1.75rem;max-width:1100px;margin:0 auto;}
.hp-feat-card{display:flex;flex-direction:column;background:#fff;border:1px solid #E8ECF0;border-radius:20px;padding:2.5rem 2rem;text-decoration:none;color:#0F172A;box-shadow:0 2px 16px rgba(15,23,42,.05);transition:.35s;position:relative;overflow:hidden;}
.hp-feat-card::after{content:'';position:absolute;inset:0;border-radius:20px;box-shadow:0 0 0 0 rgba(212,160,23,0);transition:box-shadow .35s;}
.hp-feat-card:hover{transform:translateY(-8px);box-shadow:0 16px 48px rgba(15,23,42,.12);border-color:rgba(212,160,23,.3);color:#0F172A;}
.hp-feat-card:hover::after{box-shadow:0 0 0 3px rgba(212,160,23,.15);}
.hp-feat-card::before{content:'';position:absolute;top:0;left:0;right:0;height:4px;background:linear-gradient(90deg,#A50000,#D4A017);transform:scaleX(0);transform-origin:left;transition:.35s;border-radius:4px 4px 0 0;}
.hp-feat-card:hover::before{transform:scaleX(1);}
.hp-feat-icon{width:68px;height:68px;border-radius:18px;background:linear-gradient(135deg,rgba(212,160,23,.15),rgba(212,160,23,.05));border:1px solid rgba(212,160,23,.22);display:flex;align-items:center;justify-content:center;font-size:2rem;margin-bottom:1.5rem;transition:.35s;}
.hp-feat-card:hover .hp-feat-icon{transform:scale(1.1) rotate(-4deg);background:linear-gradient(135deg,rgba(212,160,23,.25),rgba(212,160,23,.1));}
.hp-feat-title{font-family:'Cormorant Garamond',Georgia,serif;font-size:1.5rem;font-weight:700;color:#0F172A;margin-bottom:.6rem;}
.hp-feat-desc{font-size:.875rem;color:#64748B;line-height:1.75;flex:1;}
.hp-feat-cta{display:inline-flex;align-items:center;gap:.4rem;font-size:.78rem;font-weight:700;color:#D4A017;margin-top:1.5rem;letter-spacing:.06em;text-transform:uppercase;transition:gap .25s;}
.hp-feat-card:hover .hp-feat-cta{gap:.7rem;}

/* ── CHARACTERS ── */
.hp-chars{background:#0F172A;padding:5.5rem 1.5rem;position:relative;overflow:hidden;}
.hp-chars::before{content:'';position:absolute;top:-120px;right:-120px;width:480px;height:480px;background:radial-gradient(circle,rgba(212,160,23,.07),transparent 65%);pointer-events:none;}
.hp-chars::after{content:'';position:absolute;bottom:-80px;left:-80px;width:320px;height:320px;background:radial-gradient(circle,rgba(165,0,0,.06),transparent 65%);pointer-events:none;}
.hp-chars-inner{max-width:1100px;margin:0 auto;position:relative;z-index:1;}
.hp-chars-hdr{text-align:center;margin-bottom:3.5rem;}
.hp-chars-hdr .hp-sec-ey{color:#D4A017;}
.hp-chars-hdr .hp-sec-title{color:#fff!important;}
.hp-chars-hdr .hp-sec-desc{color:rgba(255,255,255,.55)!important;}
.hp-chars-hdr .hp-divider{background:linear-gradient(90deg,#D4A017,rgba(212,160,23,.15));}

.hp-chars-grid{display:grid;grid-template-columns:repeat(3,1fr);gap:1.5rem;}
.hp-char-card{position:relative;border-radius:18px;overflow:hidden;background:#1a2438;box-shadow:0 4px 24px rgba(0,0,0,.35);transition:.35s;cursor:pointer;border:1px solid rgba(255,255,255,.05);}
.hp-char-card:hover{transform:translateY(-10px);box-shadow:0 24px 60px rgba(0,0,0,.55);border-color:rgba(212,160,23,.25);}
.hp-char-img-wrap{position:relative;aspect-ratio:3/4;overflow:hidden;}
.hp-char-img{width:100%;height:100%;object-fit:cover;object-position:top;transition:transform .6s;display:block;}
.hp-char-card:hover .hp-char-img{transform:scale(1.08);}
.hp-char-grad{position:absolute;inset:0;background:linear-gradient(to top,rgba(10,15,28,.98) 0%,rgba(10,15,28,.6) 45%,rgba(10,15,28,.1) 80%);}
.hp-char-body{position:absolute;bottom:0;left:0;right:0;padding:1.6rem 1.35rem;}
.hp-char-dynasty{display:inline-block;font-size:.65rem;font-weight:700;letter-spacing:.15em;text-transform:uppercase;color:#D4A017;background:rgba(212,160,23,.14);border:1px solid rgba(212,160,23,.28);border-radius:999px;padding:.28rem .85rem;margin-bottom:.65rem;}
.hp-char-name{font-family:'Cormorant Garamond',Georgia,serif;font-size:1.45rem;font-weight:700;color:#fff!important;margin-bottom:.45rem;line-height:1.15;}
.hp-char-desc{font-size:.82rem;color:rgba(255,255,255,.6)!important;line-height:1.6;overflow:hidden;max-height:0;opacity:0;transition:max-height .4s,opacity .35s;}
.hp-char-card:hover .hp-char-desc{max-height:3.8rem;opacity:1;}
.hp-char-link{display:inline-flex;align-items:center;gap:.35rem;margin-top:.9rem;font-size:.72rem;font-weight:700;color:#D4A017;text-decoration:none;letter-spacing:.07em;text-transform:uppercase;opacity:0;transform:translateY(8px);transition:opacity .3s .06s,transform .3s .06s;}
.hp-char-card:hover .hp-char-link{opacity:1;transform:translateY(0);}
.hp-chars-more{text-align:center;margin-top:3rem;}
.hp-btn-og{display:inline-flex;align-items:center;gap:.5rem;background:transparent;color:#D4A017;font-weight:700;font-size:.875rem;letter-spacing:.07em;text-transform:uppercase;padding:.85rem 2.5rem;border-radius:999px;border:1.5px solid rgba(212,160,23,.38);text-decoration:none;transition:.3s;}
.hp-btn-og:hover{background:rgba(212,160,23,.09);border-color:#D4A017;color:#F0C84A;transform:translateY(-2px);}

/* ── QUIZ BANNER ── */
.hp-quiz{background:linear-gradient(135deg,#7b0000 0%,#A50000 50%,#7b0000 100%);padding:5rem 1.5rem;text-align:center;position:relative;overflow:hidden;}
.hp-quiz::before{content:'';position:absolute;inset:0;background-image:radial-gradient(rgba(255,255,255,.04) 1px,transparent 1px);background-size:24px 24px;}
.hp-quiz-inner{position:relative;z-index:1;max-width:560px;margin:0 auto;}
.hp-quiz h2{font-family:'Cormorant Garamond',Georgia,serif;font-size:clamp(1.9rem,3.5vw,2.8rem);color:#fff!important;margin-bottom:.85rem;line-height:1.15;}
.hp-quiz p{color:rgba(255,255,255,.72)!important;font-size:.97rem;margin-bottom:2.25rem;line-height:1.75;}
.hp-btn-white{display:inline-flex;align-items:center;gap:.6rem;background:#fff;color:#A50000;font-weight:800;font-size:.92rem;padding:.9rem 2.25rem;border-radius:999px;border:none;text-decoration:none;transition:.3s;letter-spacing:.02em;}
.hp-btn-white:hover{background:#F0C84A;color:#0F172A;transform:translateY(-3px);box-shadow:0 10px 32px rgba(0,0,0,.25);}

/* ── REVEAL ── */
.reveal{opacity:0;transform:translateY(30px);transition:opacity .7s,transform .7s;}
.reveal.visible{opacity:1;transform:translateY(0);}
.d1{transition-delay:.08s}.d2{transition-delay:.16s}.d3{transition-delay:.24s}.d4{transition-delay:.32s}

/* ── RESPONSIVE ── */
@media(max-width:991px){
  .hp-stats-grid{grid-template-columns:repeat(2,1fr);}
  .hp-features-grid{grid-template-columns:repeat(2,1fr);}
  .hp-chars-grid{grid-template-columns:repeat(2,1fr);}
}
@media(max-width:575px){
  .hp-stats-grid{grid-template-columns:repeat(2,1fr);}
  .hp-stat{border-right:none;border-bottom:1px solid #E2E8F0;}
  .hp-features-grid{grid-template-columns:1fr;}
  .hp-chars-grid{grid-template-columns:1fr;}
  .hp-actions{flex-direction:column;align-items:center;}
  .hp-btn-gold,.hp-btn-ghost{width:100%;max-width:300px;justify-content:center;}
}
@media(prefers-reduced-motion:reduce){*,*::before,*::after{animation-duration:.01ms!important;transition-duration:.01ms!important;}}
</style>
</head>
<body class="bg-dark-page" style="padding-top:0;">
<jsp:include page="/common/header.jsp"/>

<%-- ═══ HERO ═══ --%>
<section class="hp-hero">
  <div class="hp-hero-bg"></div>
  <div class="hp-hero-overlay"></div>
  <div class="hp-hero-content">
    <span class="hp-badge">🏯 Nền Tảng Tri Thức Lịch Sử</span>
    <h1 class="hp-title">Sử <span>Môn</span></h1>
    <div class="hp-title-line"></div>
    <p class="hp-sub">Cánh Cổng Lịch Sử Việt Nam</p>
    <p class="hp-desc">Khám phá hơn 4000 năm lịch sử qua nhân vật, triều đại và sự kiện — được trình bày trực quan, sinh động và chuyên sâu.</p>
    <div class="hp-actions">
      <a href="${pageContext.request.contextPath}/characters" class="hp-btn-gold">▶ Khám Phá Ngay</a>
      <a href="#featured" class="hp-btn-ghost">Nhân Vật Tiêu Biểu ↓</a>
    </div>
  </div>
  <div class="hp-scroll" aria-hidden="true">
    <span class="hp-scroll-lbl">Cuộn xuống</span>
    <span style="font-size:1rem;color:#D4A017;">↓</span>
  </div>
</section>

<%-- ═══ STATS ═══ --%>
<div class="hp-stats">
  <div class="hp-stats-grid">
    <div class="hp-stat reveal d1">
      <span class="hp-stat-icon">⏳</span>
      <div class="hp-stat-num"><em>4000</em>+</div>
      <div class="hp-stat-lbl">Năm lịch sử</div>
    </div>
    <div class="hp-stat reveal d2">
      <span class="hp-stat-icon">👤</span>
      <div class="hp-stat-num"><em>100</em>+</div>
      <div class="hp-stat-lbl">Nhân vật</div>
    </div>
    <div class="hp-stat reveal d3">
      <span class="hp-stat-icon">🏯</span>
      <div class="hp-stat-num"><em>15</em></div>
      <div class="hp-stat-lbl">Triều đại</div>
    </div>
    <div class="hp-stat reveal d4">
      <span class="hp-stat-icon">🧩</span>
      <div class="hp-stat-num"><em>5</em></div>
      <div class="hp-stat-lbl">Loại câu đố</div>
    </div>
  </div>
</div>

<%-- ═══ ABOUT ═══ --%>
<section class="hp-about">
  <div class="hp-about-inner reveal">
    <span class="hp-about-tag">Về Sử Môn</span>
    <h2 class="hp-about-title">Nơi lịch sử sống lại</h2>
    <p class="hp-about-text">Sử Môn là nền tảng học lịch sử Việt Nam theo cách hiện đại — từ những anh hùng dân tộc đến các triều đại huy hoàng, tất cả được kể lại một cách trực quan, sinh động và dễ tiếp cận với mọi lứa tuổi.</p>
    <div class="hp-about-divider"></div>
  </div>
</section>

<%-- ═══ FEATURES ═══ --%>
<section class="hp-features">
  <div class="hp-sec-hdr reveal">
    <span class="hp-sec-ey">Khám Phá</span>
    <h2 class="hp-sec-title">Chọn hành trình của bạn</h2>
    <p class="hp-sec-desc">Ba cánh cổng dẫn vào chiều sâu lịch sử Việt Nam</p>
    <div class="hp-divider"></div>
  </div>
  <div class="hp-features-grid">
    <a href="${pageContext.request.contextPath}/characters" class="hp-feat-card reveal d1">
      <div class="hp-feat-icon">👤</div>
      <h3 class="hp-feat-title">Nhân Vật</h3>
      <p class="hp-feat-desc">Khám phá những anh hùng, danh nhân đã định hình lịch sử Việt Nam — từ thời Hùng Vương đến cận đại.</p>
      <span class="hp-feat-cta">Xem nhân vật →</span>
    </a>
    <a href="${pageContext.request.contextPath}/dynasties" class="hp-feat-card reveal d2">
      <div class="hp-feat-icon">🏯</div>
      <h3 class="hp-feat-title">Triều Đại</h3>
      <p class="hp-feat-desc">Tìm hiểu sự hưng vong của 15 triều đại phong kiến — từ Văn Lang đến nhà Nguyễn.</p>
      <span class="hp-feat-cta">Xem triều đại →</span>
    </a>
    <a href="${pageContext.request.contextPath}/timeline" class="hp-feat-card reveal d3">
      <div class="hp-feat-icon">📅</div>
      <h3 class="hp-feat-title">Dòng Thời Gian</h3>
      <p class="hp-feat-desc">Theo dõi các cột mốc quan trọng theo trục thời gian — từ dựng nước đến thống nhất đất nước.</p>
      <span class="hp-feat-cta">Xem timeline →</span>
    </a>
  </div>
</section>

<%-- ═══ CHARACTERS ═══ --%>
<section id="featured" class="hp-chars">
  <div class="hp-chars-inner">
    <div class="hp-chars-hdr reveal">
      <span class="hp-sec-ey">Nhân Vật Tiêu Biểu</span>
      <h2 class="hp-sec-title">Những huyền thoại lịch sử</h2>
      <p class="hp-sec-desc">Những con người làm rạng danh non sông qua 4000 năm lịch sử</p>
      <div class="hp-divider"></div>
    </div>
    <div class="hp-chars-grid">
      <c:forEach items="${top6}" var="c" varStatus="st">
        <div class="hp-char-card reveal" style="transition-delay:${st.index * 75}ms;">
          <div class="hp-char-img-wrap">
            <img class="hp-char-img"
                 src="${pageContext.request.contextPath}/assets/images/characters/${c.image}"
                 alt="${c.name}"
                 onerror="this.style.background='linear-gradient(135deg,#1e293b,#0f172a)';this.src='data:image/gif;base64,R0lGODlhAQABAIAAAAAAAP///yH5BAEAAAAALAAAAAABAAEAAAIBRAA7'">
            <div class="hp-char-grad"></div>
          </div>
          <div class="hp-char-body">
            <span class="hp-char-dynasty">${c.dynasty}</span>
            <h3 class="hp-char-name">${c.name}</h3>
            <p class="hp-char-desc">${c.description}</p>
            <a href="${pageContext.request.contextPath}/characters?id=${c.id}" class="hp-char-link">Xem chi tiết →</a>
          </div>
        </div>
      </c:forEach>
      <c:if test="${empty top6}">
        <div style="grid-column:1/-1;text-align:center;padding:3rem;color:rgba(255,255,255,.4);font-size:.95rem;">
          Chưa có dữ liệu nhân vật.
        </div>
      </c:if>
    </div>
    <div class="hp-chars-more reveal">
      <a href="${pageContext.request.contextPath}/characters" class="hp-btn-og">Xem tất cả nhân vật →</a>
    </div>
  </div>
</section>

<%-- ═══ QUIZ BANNER ═══ --%>
<section class="hp-quiz">
  <div class="hp-quiz-inner reveal">
    <h2>🏛️ Thử Thách Kiến Thức Lịch Sử</h2>
    <p>10 câu hỏi ngẫu nhiên về nhân vật, triều đại và sự kiện — kiểm tra hiểu biết của bạn ngay hôm nay!</p>
    <a href="${pageContext.request.contextPath}/quiz" class="hp-btn-white">🚀 Bắt đầu Quiz ngay</a>
  </div>
</section>

<jsp:include page="/common/footer.jsp"/>

<script>
const obs = new IntersectionObserver(entries => {
  entries.forEach(e => {
    if (e.isIntersecting) { e.target.classList.add('visible'); obs.unobserve(e.target); }
  });
}, { threshold: 0.1 });
document.querySelectorAll('.reveal').forEach(el => obs.observe(el));
</script>
</body>
</html>

