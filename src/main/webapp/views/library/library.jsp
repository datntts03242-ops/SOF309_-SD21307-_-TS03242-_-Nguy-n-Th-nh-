<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
<title>Lịch sử xem – Sử Môn</title>
<jsp:include page="/common/head-resources.jsp"/>
<style>
*, *::before, *::after { box-sizing: border-box; }
body { background: linear-gradient(180deg,#0f172a 0%,#111827 100%); color:#f1f5f9; font-family:'Be Vietnam Pro',sans-serif; min-height:100vh; padding-top:72px; }
:root { --bg-dark:#0f172a; --bg-card:#111827; --gold:#facc15; --red:#dc3545; }

/* ===== HERO HEADER ===== */
.library-hero{
    position:relative;
    padding:60px 0 40px;
    text-align:center;
    border-bottom:1px solid rgba(250,204,21,0.15);
    margin-bottom:30px;
    overflow:hidden;
}

.library-hero::before{
    content:"";
    position:absolute;
    top:-100px;
    left:50%;
    transform:translateX(-50%);
    width:600px;
    height:300px;
    background:radial-gradient(circle, rgba(250,204,21,0.12) 0%, transparent 70%);
    pointer-events:none;
}

.library-hero h2{
    font-size:2.4rem;
    font-weight:800;
    letter-spacing:1px;
    color:#fff;
    text-shadow:0 0 20px rgba(250,204,21,0.4);
    margin-bottom:10px;
    position:relative;
    z-index:1;
}

.library-hero p{
    color:#94a3b8;
    font-size:1rem;
    margin-bottom:25px;
    position:relative;
    z-index:1;
}

.library-actions{
    display:flex;
    justify-content:center;
    gap:14px;
    flex-wrap:wrap;
    position:relative;
    z-index:1;
}

.btn-gold{
    background:var(--gold);
    border:none;
    color:#1e1b00;
    font-weight:700;
    padding:10px 22px;
    border-radius:50px;
    transition:.3s;
    box-shadow:0 0 0 rgba(250,204,21,0.0);
}

.btn-gold:hover{
    background:#fde047;
    box-shadow:0 0 18px rgba(250,204,21,0.6);
    color:#1e1b00;
    transform:translateY(-2px);
}

.btn-outline-soft{
    background:transparent;
    border:1px solid rgba(255,255,255,0.25);
    color:#e2e8f0;
    font-weight:600;
    padding:10px 22px;
    border-radius:50px;
    transition:.3s;
}

.btn-outline-soft:hover{
    border-color:var(--gold);
    color:var(--gold);
    background:rgba(250,204,21,0.08);
    transform:translateY(-2px);
}

.btn-danger-glow{
    background:var(--red);
    border:none;
    color:#fff;
    font-weight:700;
    padding:10px 22px;
    border-radius:50px;
    transition:.3s;
}

.btn-danger-glow:hover{
    box-shadow:0 0 18px rgba(220,53,69,0.6);
    background:#e85362;
    transform:translateY(-2px);
}

/* ===== DATE SECTION ===== */
.date-section{
    margin-bottom:40px;
    animation:fadeIn 0.6s ease forwards;
    opacity:0;
}

.date-title{
    display:flex;
    align-items:center;
    gap:12px;
    font-weight:700;
    color:var(--gold);
    font-size:1.2rem;
    margin:30px 0 18px;
    letter-spacing:0.5px;
}

.date-title::after{
    content:"";
    flex:1;
    height:1px;
    background:linear-gradient(90deg, rgba(250,204,21,0.4), transparent);
}

/* ===== HISTORY CARD ===== */
.history-card{
    position:relative;
    border-radius:18px;
    overflow:hidden;
    background:rgba(17,24,39,0.6);
    backdrop-filter:blur(8px);
    border:1px solid rgba(255,255,255,0.06);
    box-shadow:0 8px 24px rgba(0,0,0,0.35);
    transition:transform .35s ease, box-shadow .35s ease, border-color .35s ease;
    opacity:0;
    transform:translateY(20px);
    animation:fadeUp 0.6s ease forwards;
    height:100%;
}

.history-card:hover{
    transform:translateY(-6px);
    box-shadow:0 0 28px rgba(250,204,21,0.35), 0 12px 30px rgba(0,0,0,0.45);
    border-color:rgba(250,204,21,0.45);
}

.history-img-wrap{
    position:relative;
    width:100%;
    height:230px;
    overflow:hidden;
}

.history-img-wrap img{
    width:100%;
    height:100%;
    object-fit:cover;
    transition:transform .5s ease, filter .5s ease;
    display:block;
}

.history-card:hover .history-img-wrap img{
    transform:scale(1.05);
    filter:brightness(0.45);
}

.history-overlay{
    position:absolute;
    inset:0;
    display:flex;
    flex-direction:column;
    justify-content:flex-end;
    align-items:center;
    gap:10px;
    padding:0 16px 20px;
    background:linear-gradient(180deg, transparent 30%, rgba(15,23,42,0.85) 100%);
    opacity:0;
    transition:opacity .35s ease;
}

.history-card:hover .history-overlay{
    opacity:1;
}

.overlay-actions{
    display:flex;
    gap:8px;
    width:100%;
    transform:translateY(20px);
    transition:transform .35s ease;
}

.history-card:hover .overlay-actions{
    transform:translateY(0);
}

.btn-watch{
    flex:1;
    background:var(--gold);
    color:#1e1b00;
    border:none;
    font-weight:700;
    font-size:13px;
    padding:8px 10px;
    border-radius:10px;
    text-decoration:none;
    text-align:center;
    transition:.25s;
}

.btn-watch:hover{
    background:#fde047;
    box-shadow:0 0 14px rgba(250,204,21,0.6);
    color:#1e1b00;
}

.btn-delete{
    flex:0 0 auto;
    background:rgba(220,53,69,0.85);
    color:#fff;
    border:none;
    font-weight:700;
    font-size:13px;
    padding:8px 12px;
    border-radius:10px;
    transition:.25s;
}

.btn-delete:hover{
    background:var(--red);
    box-shadow:0 0 14px rgba(220,53,69,0.6);
}

.history-info{
    padding:14px 16px 16px;
}

.history-info .char-name{
    font-weight:700;
    color:#fff;
    font-size:1rem;
    margin-bottom:4px;
    white-space:nowrap;
    overflow:hidden;
    text-overflow:ellipsis;
}

.history-info .view-time{
    color:#94a3b8;
    font-size:0.78rem;
    display:flex;
    align-items:center;
    gap:6px;
}

/* ===== EMPTY STATE ===== */
.empty-state{
    text-align:center;
    padding:80px 20px;
    animation:fadeIn 0.8s ease forwards;
}

.empty-state .icon{
    font-size:5rem;
    margin-bottom:20px;
    opacity:0.7;
    filter:drop-shadow(0 0 18px rgba(250,204,21,0.3));
}

.empty-state h4{
    color:#e2e8f0;
    font-weight:700;
    margin-bottom:20px;
}

/* ===== ANIMATIONS ===== */
@keyframes fadeIn{
    from{ opacity:0; }
    to{ opacity:1; }
}

@keyframes fadeUp{
    from{ opacity:0; transform:translateY(20px); }
    to{ opacity:1; transform:translateY(0); }
}

html{
    scroll-behavior:smooth;
}
</style>
</head>

<body class="bg-dark-page">

<jsp:include page="/common/header.jsp"/>

<div class="container">

    <!-- HERO HEADER -->
    <div class="library-hero">
        <h2>📚 Lịch Sử Xem</h2>
        <p>Những nhân vật bạn đã khám phá trong hành trình Sử Môn</p>

        <div class="library-actions">

            <!-- DELETE ALL -->
            <form method="post"
                  action="${pageContext.request.contextPath}/library"
                  onsubmit="return confirm('Xoá toàn bộ lịch sử?')">

                <input type="hidden" name="action" value="all">

                <button class="btn-danger-glow">
                    🗑 Xóa toàn bộ lịch sử
                </button>
            </form>

            <a class="btn-outline-soft" href="${pageContext.request.contextPath}/characters">
                🔙 Quay lại danh sách nhân vật
            </a>

        </div>
    </div>

    <!-- EMPTY -->
    <c:if test="${empty historyMap}">
        <div class="empty-state">
            <div class="icon">📚</div>
            <h4>Chưa có lịch sử xem</h4>
            <a class="btn-gold" href="${pageContext.request.contextPath}/characters">
                Khám phá nhân vật
            </a>
        </div>
    </c:if>

    <!-- GROUP BY DATE -->
    <c:forEach items="${historyMap}" var="entry" varStatus="dateStatus">

        <div class="date-section" style="animation-delay:${dateStatus.index * 0.1}s;">

            <div class="date-title">
                📅 ${entry.key}
            </div>

            <div class="row">

                <c:forEach items="${entry.value}" var="h" varStatus="status">

                    <div class="col-6 col-md-4 col-lg-3 mb-4">

                        <div class="history-card" style="animation-delay:${status.index * 0.08}s;">

                            <div class="history-img-wrap">
                                <img src="${pageContext.request.contextPath}/assets/images/characters/${h.image}" alt="${h.characterName}">

                                <div class="history-overlay">
                                    <div class="overlay-actions">

                                        <a class="btn-watch"
                                           href="${pageContext.request.contextPath}/characters?id=${h.characterId}">
                                            👁 Xem lại
                                        </a>

                                        <!-- DELETE ONE -->
                                        <form method="post"
                                              action="${pageContext.request.contextPath}/history/delete"
                                              onsubmit="return confirm('Xoá mục này?')">

                                            <input type="hidden" name="id" value="${h.id}">

                                            <button type="submit" class="btn-delete">
                                                🗑
                                            </button>
                                        </form>

                                    </div>
                                </div>
                            </div>

                            <div class="history-info">
                                <div class="char-name">${h.characterName}</div>
                                <div class="view-time">🕒 ${h.viewTime}</div>
                            </div>

                        </div>

                    </div>

                </c:forEach>

            </div>

        </div>

    </c:forEach>

</div>

<jsp:include page="/common/footer.jsp"/>
</body>
</html>
