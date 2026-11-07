<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Bảng Xếp Hạng - SuMon Lịch Sử Việt Nam</title>

    <!-- Google Fonts: font lịch sử sang trọng -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link href="https://fonts.googleapis.com/css2?family=Cinzel:wght@500;600;700&family=Marcellus&family=Be+Vietnam+Pro:wght@400;500;600;700&display=swap" rel="stylesheet">

    <!-- AOS Animation -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/aos/2.3.1/aos.css" rel="stylesheet">

    <!-- Bootstrap 5: header dùng navbar/dropdown/collapse cần thư viện này -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">

    <!-- CSS riêng của trang -->
    <style>
    .ranking-page {
    --brown-primary: #8B5E3C;
    --gold-primary: #C89B3C;
    --bg-cream: #F5F1E8;
    --bg-light: #fffaf3;
    --text-dark: #3E2C1C;
    --gold-light: #E8C77A;
    --silver: #B8C0C8;
    --bronze: #B87333;
    --radius-lg: 20px;
    --radius-md: 16px;
    --shadow-soft: 0 8px 24px rgba(139, 94, 60, 0.15);
    --shadow-hover: 0 14px 32px rgba(139, 94, 60, 0.25);

    background: var(--bg-cream);
    font-family: 'Be Vietnam Pro', sans-serif;
    color: var(--text-dark);
    isolation: isolate; /* tránh z-index/stacking rò ra ngoài phạm vi trang */
    position: relative;
    z-index: 0;

    /* Header dùng class "fixed-top" (Bootstrap) => position:fixed, bị đưa ra
       khỏi luồng layout và ĐÈ lên nội dung ngay bên dưới nếu không bù khoảng trống.
       --navbar-offset sẽ được JavaScript tự đo và ghi đè chính xác theo
       chiều cao thật của header lúc trang chạy (xem script cuối ranking.jsp). */
    --navbar-offset: 90px;
    padding-top: var(--navbar-offset);
}

@media (max-width: 991.98px) {
    .ranking-page {
        --navbar-offset: 76px; /* fallback khi JS chưa kịp chạy, navbar-expand-lg thu gọn ở mobile/tablet */
    }
}

.ranking-page *,
.ranking-page *::before,
.ranking-page *::after {
    box-sizing: border-box;
}

/* ================= HERO BANNER ================= */
.ranking-page .ranking-hero {
    position: relative;
    padding: 56px 20px 70px;
    text-align: center;
    background: linear-gradient(135deg, #8B5E3C 0%, #6f4a2f 100%);
    overflow: hidden;
    color: #fffaf3;
}

.ranking-page .hero-pattern-overlay {
    position: absolute;
    inset: 0;
    background-image:
        repeating-linear-gradient(45deg, rgba(200,155,60,0.08) 0, rgba(200,155,60,0.08) 2px, transparent 2px, transparent 22px),
        repeating-linear-gradient(-45deg, rgba(255,250,243,0.06) 0, rgba(255,250,243,0.06) 2px, transparent 2px, transparent 22px);
    pointer-events: none;
}

.ranking-page .hero-content {
    position: relative;
    z-index: 2;
    max-width: 800px;
    margin: 0 auto;
}

.ranking-page .hero-title {
    font-family: 'Cinzel', serif;
    font-size: clamp(1.8rem, 4vw, 2.8rem);
    font-weight: 700;
    letter-spacing: 1px;
    color: #FFF7E8;
    text-shadow: 0 3px 10px rgba(0,0,0,0.35);
    margin-bottom: 16px;
}

.ranking-page .hero-subtitle {
    font-family: 'Marcellus', serif;
    font-size: 1.05rem;
    color: #F0DDBB;
    opacity: 0.95;
}

/* ================= MAIN CONTAINER ================= */
.ranking-page .ranking-main {
    max-width: 1200px;
    margin: 0 auto;
    padding: 60px 24px 80px;
}

.ranking-page .empty-ranking {
    text-align: center;
    background: var(--bg-light);
    border-radius: var(--radius-lg);
    padding: 60px 30px;
    box-shadow: var(--shadow-soft);
    font-size: 1.1rem;
    color: var(--brown-primary);
}

.ranking-page .section-title {
    font-family: 'Cinzel', serif;
    text-align: center;
    color: var(--brown-primary);
    font-size: 1.8rem;
    margin-bottom: 36px;
    letter-spacing: 0.5px;
}

/* ================= PODIUM TOP 3 ================= */
.ranking-page .podium-section {
    margin-bottom: 70px;
}

.ranking-page .podium-wrap {
    display: grid;
    grid-template-columns: repeat(3, 1fr);
    gap: 28px;
    align-items: end;
}

.ranking-page .podium-card {
    background: var(--bg-light);
    border-radius: var(--radius-lg);
    padding: 36px 20px 30px;
    text-align: center;
    box-shadow: var(--shadow-soft);
    position: relative;
    transition: transform 0.35s ease, box-shadow 0.35s ease;
    border: 2px solid transparent;
}

.ranking-page .podium-card:hover {
    transform: translateY(-10px);
    box-shadow: var(--shadow-hover);
}

.ranking-page .podium-medal {
    font-size: 2.6rem;
    margin-bottom: 10px;
}

.ranking-page .avatar-circle {
    width: 82px;
    height: 82px;
    border-radius: 50%;
    display: flex;
    align-items: center;
    justify-content: center;
    margin: 0 auto 16px;
    font-family: 'Cinzel', serif;
    font-size: 1.9rem;
    font-weight: 700;
    color: #fff;
    background: linear-gradient(135deg, var(--brown-primary), var(--gold-primary));
    box-shadow: 0 4px 14px rgba(139,94,60,0.35);
}

.ranking-page .podium-name {
    font-family: 'Marcellus', serif;
    font-size: 1.2rem;
    margin-bottom: 8px;
    color: var(--text-dark);
}

.ranking-page .podium-score {
    font-size: 1.3rem;
    font-weight: 700;
    color: var(--brown-primary);
    margin-bottom: 14px;
}

.ranking-page .podium-badge {
    display: inline-block;
    padding: 6px 18px;
    border-radius: 999px;
    font-size: 0.85rem;
    font-weight: 600;
    font-family: 'Marcellus', serif;
    background: var(--bg-cream);
    color: var(--brown-primary);
    border: 1px solid var(--gold-primary);
}

/* --- Top 1: vàng --- */
.ranking-page .podium-first {
    order: 2;
    transform: scale(1.08);
    border-color: var(--gold-primary);
    box-shadow: 0 0 0 4px rgba(200,155,60,0.15), 0 0 40px rgba(200,155,60,0.45), var(--shadow-soft);
    animation: ranking-glow-gold 2.4s ease-in-out infinite;
}
.ranking-page .podium-first:hover { transform: scale(1.08) translateY(-10px); }
.ranking-page .podium-first .avatar-circle {
    background: linear-gradient(135deg, #C89B3C, #F3D479);
}
.ranking-page .podium-first .podium-badge {
    background: linear-gradient(135deg, #C89B3C, #F3D479);
    color: #4a3418;
    border: none;
}

@keyframes ranking-glow-gold {
    0%, 100% { box-shadow: 0 0 0 4px rgba(200,155,60,0.12), 0 0 28px rgba(200,155,60,0.35), var(--shadow-soft); }
    50% { box-shadow: 0 0 0 6px rgba(200,155,60,0.2), 0 0 48px rgba(200,155,60,0.6), var(--shadow-soft); }
}

/* --- Top 2: bạc --- */
.ranking-page .podium-second {
    order: 1;
    border-color: var(--silver);
    box-shadow: 0 0 24px rgba(184,192,200,0.5), var(--shadow-soft);
}
.ranking-page .podium-second .avatar-circle {
    background: linear-gradient(135deg, #9AA5AD, #D9E0E5);
}

/* --- Top 3: đồng --- */
.ranking-page .podium-third {
    order: 3;
    border-color: var(--bronze);
    box-shadow: 0 0 24px rgba(184,115,51,0.4), var(--shadow-soft);
}
.ranking-page .podium-third .avatar-circle {
    background: linear-gradient(135deg, #B87333, #E0A56F);
}

/* ================= RANKING TABLE ================= */
.ranking-page .ranking-table-section {
    margin-bottom: 60px;
}

.ranking-page .ranking-table-wrap {
    background: var(--bg-light);
    border-radius: var(--radius-lg);
    box-shadow: var(--shadow-soft);
    overflow-x: auto;
    padding: 10px;
}

.ranking-page .ranking-table {
    width: 100%;
    border-collapse: separate;
    border-spacing: 0;
    min-width: 780px;
}

.ranking-page .ranking-table thead th {
    font-family: 'Marcellus', serif;
    background: var(--brown-primary);
    color: #fffaf3;
    padding: 16px 14px;
    text-align: left;
    font-size: 0.95rem;
    letter-spacing: 0.3px;
}

.ranking-page .ranking-table thead th:first-child {
    border-top-left-radius: var(--radius-md);
}
.ranking-page .ranking-table thead th:last-child {
    border-top-right-radius: var(--radius-md);
}

.ranking-page .ranking-table tbody td {
    padding: 14px;
    border-bottom: 1px solid rgba(139,94,60,0.12);
    font-size: 0.95rem;
    vertical-align: middle;
}

.ranking-page .ranking-row {
    transition: background 0.25s ease, transform 0.25s ease;
}

.ranking-page .ranking-row:hover {
    background: var(--bg-cream);
    transform: scale(1.005);
}

.ranking-page .ranking-row.top-row {
    background: rgba(200,155,60,0.08);
    font-weight: 600;
}

.ranking-page .col-rank {
    text-align: center;
    width: 60px;
}

.ranking-page .rank-icon {
    font-size: 1.4rem;
}

.ranking-page .rank-number {
    font-family: 'Cinzel', serif;
    color: var(--brown-primary);
    font-weight: 700;
}

.ranking-page .col-name {
    font-family: 'Marcellus', serif;
    color: var(--text-dark);
}

.ranking-page .score-star {
    color: var(--gold-primary);
}

.ranking-page .col-score {
    font-weight: 700;
    color: var(--brown-primary);
    white-space: nowrap;
}

/* --- Progress bar % --- */
.ranking-page .percent-wrap {
    display: flex;
    align-items: center;
    gap: 10px;
    min-width: 140px;
}

.ranking-page .percent-bar-bg {
    flex: 1;
    height: 10px;
    background: rgba(139,94,60,0.15);
    border-radius: 999px;
    overflow: hidden;
}

.ranking-page .percent-bar-fill {
    height: 100%;
    background: linear-gradient(90deg, var(--gold-primary), var(--brown-primary));
    border-radius: 999px;
    transition: width 0.6s ease;
}

.ranking-page .percent-text {
    font-size: 0.85rem;
    font-weight: 600;
    color: var(--brown-primary);
    min-width: 38px;
}

/* --- Badge mức độ --- */
.ranking-page .badge-difficulty {
    display: inline-block;
    padding: 5px 14px;
    border-radius: 999px;
    font-size: 0.82rem;
    font-weight: 600;
    color: #fff;
}

.ranking-page .badge-easy {
    background: #4CAF50;
}

.ranking-page .badge-medium {
    background: #D9A441;
}

.ranking-page .badge-hard {
    background: #C0392B;
}

.ranking-page .col-date {
    white-space: nowrap;
    color: #6b5a48;
    font-size: 0.88rem;
}

/* ================= ACTION BUTTONS ================= */
.ranking-page .ranking-actions {
    display: flex;
    justify-content: center;
    gap: 20px;
    flex-wrap: wrap;
    margin-top: 40px;
}

.ranking-page .btn-ranking {
    font-family: 'Marcellus', serif;
    font-size: 1rem;
    padding: 14px 34px;
    border-radius: var(--radius-md);
    text-decoration: none;
    font-weight: 600;
    box-shadow: var(--shadow-soft);
    transition: transform 0.25s ease, box-shadow 0.25s ease;
    display: inline-block;
}

.ranking-page .btn-ranking:hover {
    transform: translateY(-4px);
    box-shadow: var(--shadow-hover);
}

.ranking-page .btn-replay {
    background: linear-gradient(135deg, var(--brown-primary), #6f4a2f);
    color: #fffaf3;
}

.ranking-page .btn-home {
    background: var(--bg-light);
    color: var(--brown-primary);
    border: 2px solid var(--gold-primary);
}

/* ================= RESPONSIVE ================= */
@media (max-width: 900px) {
    .ranking-page .podium-wrap {
        grid-template-columns: 1fr;
    }
    .ranking-page .podium-first,
    .ranking-page .podium-second,
    .ranking-page .podium-third {
        order: initial;
        transform: none;
    }
    .ranking-page .podium-first:hover {
        transform: translateY(-8px);
    }
}

@media (max-width: 600px) {
    .ranking-page .ranking-hero {
        padding: 36px 16px 50px;
    }
    .ranking-page .ranking-main {
        padding: 40px 14px 60px;
    }
    .ranking-page .btn-ranking {
        width: 100%;
        text-align: center;
    }
}
    
    </style>
    <link rel="stylesheet"
href="${pageContext.request.contextPath}/assets/css/style.css">
</head>
<body>

<jsp:include page="/common/header.jsp"/>

<div class="ranking-page">

<!-- ================= HERO BANNER ================= -->
<section class="ranking-hero">
    <div class="hero-pattern-overlay"></div>
    <div class="hero-content" data-aos="fade-down" data-aos-duration="900">
        <h1 class="hero-title">🏆 BẢNG XẾP HẠNG NHÀ THÔNG THÁI LỊCH SỬ</h1>
        <p class="hero-subtitle">Những người chơi đạt thành tích cao nhất trong thử thách lịch sử Việt Nam.</p>
    </div>
</section>

<!-- ================= MAIN CONTENT ================= -->
<main class="ranking-main">

    <c:choose>
        <c:when test="${empty ranking}">
            <div class="empty-ranking" data-aos="fade-up">
                <p>📜 Chưa có dữ liệu xếp hạng. Hãy là người đầu tiên chinh phục thử thách lịch sử!</p>
            </div>
        </c:when>
        <c:otherwise>

        <!-- ================= TOP 3 PODIUM ================= -->
        <section class="podium-section">
            <div class="podium-wrap">

                <c:forEach var="r" items="${ranking}" varStatus="s" begin="0" end="2">
                    <c:set var="rank" value="${s.index + 1}"/>

                    <c:choose>
                        <c:when test="${rank == 1}"><c:set var="podiumClass" value="podium-card podium-first"/></c:when>
                        <c:when test="${rank == 2}"><c:set var="podiumClass" value="podium-card podium-second"/></c:when>
                        <c:otherwise><c:set var="podiumClass" value="podium-card podium-third"/></c:otherwise>
                    </c:choose>

                    <c:choose>
                        <c:when test="${rank == 1}"><c:set var="medal" value="🥇"/></c:when>
                        <c:when test="${rank == 2}"><c:set var="medal" value="🥈"/></c:when>
                        <c:otherwise><c:set var="medal" value="🥉"/></c:otherwise>
                    </c:choose>

                    <c:choose>
                        <c:when test="${rank == 1}"><c:set var="aosDelay" value="0"/></c:when>
                        <c:when test="${rank == 2}"><c:set var="aosDelay" value="150"/></c:when>
                        <c:otherwise><c:set var="aosDelay" value="300"/></c:otherwise>
                    </c:choose>

                    <div class="${podiumClass}" data-aos="zoom-in" data-aos-delay="${aosDelay}">
                        <div class="podium-medal">${medal}</div>
                        <div class="podium-avatar">
                            <div class="avatar-circle">
                                ${fn:toUpperCase(fn:substring(r.userName, 0, 1))}
                            </div>
                        </div>
                        <h3 class="podium-name">${r.userName}</h3>
                        <div class="podium-score">⭐ ${r.score}</div>
                        <span class="podium-badge">
                            <c:choose>
                                <c:when test="${rank == 1}">Nhà Sử Học</c:when>
                                <c:when test="${rank == 2}">Học Giả Uyên Bác</c:when>
                                <c:otherwise>Người Am Hiểu Sử Việt</c:otherwise>
                            </c:choose>
                        </span>
                    </div>

                </c:forEach>

            </div>
        </section>

        <!-- ================= FULL RANKING TABLE ================= -->
        <section class="ranking-table-section" data-aos="fade-up">
            <h2 class="section-title">📊 Bảng Xếp Hạng Chi Tiết</h2>

            <div class="ranking-table-wrap">
                <table class="ranking-table">
                    <thead>
                        <tr>
                            <th class="col-rank">#</th>
                            <th class="col-name">Người Chơi</th>
                            <th class="col-score">Điểm</th>
                            <th class="col-correct">Đúng</th>
                            <th class="col-wrong">Sai</th>
                            <th class="col-percent">%</th>
                            <th class="col-difficulty">Mức Độ</th>
                            <th class="col-date">Ngày Chơi</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="r" items="${ranking}" varStatus="s">
                            <c:set var="rank" value="${s.index + 1}"/>
                            <tr class="ranking-row ${rank <= 3 ? 'top-row' : ''}" data-aos="fade-up" data-aos-delay="${s.index * 40}">
                                <td class="col-rank">
                                    <c:choose>
                                        <c:when test="${rank == 1}"><span class="rank-icon">🥇</span></c:when>
                                        <c:when test="${rank == 2}"><span class="rank-icon">🥈</span></c:when>
                                        <c:when test="${rank == 3}"><span class="rank-icon">🥉</span></c:when>
                                        <c:otherwise><span class="rank-number">${rank}</span></c:otherwise>
                                    </c:choose>
                                </td>
                                <td class="col-name">${r.userName}</td>
                                <td class="col-score"><span class="score-star">⭐</span> ${r.score}</td>
                                <td class="col-correct">${r.correctCount}</td>
                                <td class="col-wrong">${r.wrongCount}</td>
                                <td class="col-percent">
                                    <div class="percent-wrap">
                                        <div class="percent-bar-bg">
                                            <div class="percent-bar-fill" style="width:${r.percentage}%;"></div>
                                        </div>
                                        <span class="percent-text">${r.percentage}%</span>
                                    </div>
                                </td>
                                <td class="col-difficulty">
                                    <c:choose>
                                        <c:when test="${r.difficulty == 1}">
                                            <span class="badge-difficulty badge-easy">Dễ</span>
                                        </c:when>
                                        <c:when test="${r.difficulty == 2}">
                                            <span class="badge-difficulty badge-medium">Trung Bình</span>
                                        </c:when>
                                        <c:when test="${r.difficulty == 3}">
                                            <span class="badge-difficulty badge-hard">Khó</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="badge-difficulty">Không rõ</span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td class="col-date">
                                    <fmt:formatDate value="${r.createdAt}" pattern="dd/MM/yyyy HH:mm"/>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </section>

        </c:otherwise>
    </c:choose>

    <!-- ================= ACTION BUTTONS ================= -->
    <section class="ranking-actions" data-aos="fade-up">
        <a href="${pageContext.request.contextPath}/quiz" class="btn-ranking btn-replay">🔄 Chơi Lại</a>
        <a href="${pageContext.request.contextPath}/" class="btn-ranking btn-home">🏠 Trang Chủ</a>
    </section>

</main>

</div><!-- /.ranking-page -->

<jsp:include page="/common/footer.jsp"/>

<!-- Bootstrap JS bundle (Popper + Bootstrap) - cần cho dropdown/collapse của header -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

<!-- AOS JS -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/aos/2.3.1/aos.js"></script>
<script>
    AOS.init({
        duration: 800,
        easing: 'ease-out-cubic',
        once: true
    });

    // ===== Tự đo chiều cao THẬT của header (fixed-top) để chống bị đè =====
    // Vì header dùng position:fixed nên trình duyệt không tự trừ khoảng trống,
    // ta phải đo chiều cao thực tế rồi gán làm padding-top cho .ranking-page.
    (function () {
        var page = document.querySelector('.ranking-page');
        var nav = document.querySelector('nav.fixed-top, .navbar.fixed-top, header nav');

        if (!page || !nav) return;

        function syncOffset() {
            var h = nav.getBoundingClientRect().height;
            if (h > 0) {
                page.style.setProperty('--navbar-offset', h + 'px');
            }
        }

        // Đo ngay khi DOM sẵn sàng
        syncOffset();
        // Đo lại khi ảnh logo load xong (logo có thể làm navbar cao hơn dự kiến)
        window.addEventListener('load', syncOffset);
        // Đo lại khi resize (navbar-expand-lg đổi chiều cao giữa desktop/mobile)
        window.addEventListener('resize', syncOffset);
        // Đo lại khi menu mobile mở/đóng (collapse có thể đổi chiều cao nếu wrap dòng)
        nav.addEventListener('shown.bs.collapse', syncOffset);
        nav.addEventListener('hidden.bs.collapse', syncOffset);
    })();
</script>

</body>
</html>
