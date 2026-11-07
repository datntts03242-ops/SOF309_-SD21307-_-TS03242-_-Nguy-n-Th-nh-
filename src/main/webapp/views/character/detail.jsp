<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<!DOCTYPE html>
<html lang="vi">
<head>
  <title>${character.name} – Sử Môn</title>
  <jsp:include page="/common/head-resources.jsp"/>
  <style>
    .detail-hero {
      background: linear-gradient(135deg, var(--c-primary) 0%, #1a0a0a 100%);
      padding: 3rem 0 2rem; margin-bottom: 0;
    }
    .detail-img {
      width: 100%; aspect-ratio: 3/4; object-fit: cover; object-position: top center;
      border-radius: 16px; box-shadow: 0 16px 48px rgba(0,0,0,.4);
    }
    .dynasty-badge {
      display: inline-block; font-size: .72rem; font-weight: 600; letter-spacing: .14em;
      text-transform: uppercase; color: var(--c-gold);
      background: rgba(212,160,23,.15); border: 1px solid rgba(212,160,23,.3);
      border-radius: 999px; padding: .3rem .9rem; margin-bottom: 1rem;
    }

    /* TABS */
    .tab-nav { display: flex; gap: .25rem; border-bottom: 2px solid var(--c-border); margin-bottom: 1.25rem; }
    .tab-btn {
      padding: .65rem 1.1rem; font-size: .875rem; font-weight: 600;
      color: var(--c-muted); background: none; border: none; border-bottom: 3px solid transparent;
      margin-bottom: -2px; cursor: pointer; border-radius: 8px 8px 0 0; transition: var(--t-base);
    }
    .tab-btn:hover { color: var(--c-primary); background: rgba(15,23,42,.04); }
    .tab-btn.active { color: var(--c-red); border-bottom-color: var(--c-red); }
    .tab-panel { display: none; animation: fadeIn .2s ease; }
    .tab-panel.active { display: block; }
    @keyframes fadeIn { from{opacity:0;transform:translateY(8px)} to{opacity:1;transform:translateY(0)} }

    /* FUN FACT */
    .fun-fact {
      border-left: 4px solid var(--c-gold); background: #fffbeb;
      padding: 1rem 1.1rem; border-radius: 0 10px 10px 0; margin-top: 1rem;
    }
    .fun-fact h6 { color: #92400e; font-weight: 700; margin-bottom: .35rem; }
    .fun-fact p { color: #78350f; font-size: .875rem; margin: 0; }

    /* COMMENT */
    .comment-item { border-bottom: 1px solid var(--c-border); padding: 1rem 0; }
    .comment-item:last-child { border-bottom: none; }
    .comment-username { font-weight: 700; font-size: .9rem; color: var(--c-primary); }

    /* STICKY DETAIL CARD */
    .detail-main-card {
      background: var(--c-surface); border-radius: 16px;
      box-shadow: var(--sh-card); border: 1px solid var(--c-border);
      padding: 1.75rem; height: 100%;
    }

    /* fix màu p trong tab panels */
    .tab-panel p { color: #374151; }
    /* fix màu p trong comment */
    .comment-item p { color: #374151; }
    .fav-btn {
      display: inline-flex; align-items: center; gap: .4rem;
      padding: .5rem 1.1rem; border-radius: 8px; font-size: .875rem; font-weight: 600;
      background: rgba(220,53,69,.08); color: var(--c-red-lt);
      border: 1.5px solid rgba(220,53,69,.25); cursor: pointer; transition: var(--t-base);
    }
    .fav-btn:hover, .fav-btn.active { background: var(--c-red-lt); color: #fff; border-color: var(--c-red-lt); }
    .fav-btn .fav-icon { font-size: 1rem; }
  </style>
</head>
<body class="bg-light-page">
<jsp:include page="/common/header.jsp"/>

<main>

  <!-- DETAIL HERO -->
  <div class="detail-hero">
    <div class="container">
      <nav aria-label="breadcrumb" style="margin-bottom:1rem;">
        <ol class="breadcrumb mb-0" style="background:none;padding:0;font-size:.82rem;">
          <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/" style="color:rgba(255,255,255,.5);text-decoration:none;">Trang chủ</a></li>
          <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/characters" style="color:rgba(255,255,255,.5);text-decoration:none;">Nhân vật</a></li>
          <li class="breadcrumb-item active" style="color:rgba(255,255,255,.75);">${character.name}</li>
        </ol>
      </nav>

      <div class="row g-4 align-items-start">
        <!-- IMAGE -->
        <div class="col-md-3">
          <img class="detail-img"
               src="${pageContext.request.contextPath}/assets/images/characters/${character.image}"
               alt="${character.name}"
               onerror="this.style.background='linear-gradient(135deg,#1e293b,#0f172a)';this.src='data:image/gif;base64,R0lGODlhAQABAIAAAAAAAP///yH5BAEAAAAALAAAAAABAAEAAAIBRAA7'">
        </div>

        <!-- INFO -->
        <div class="col-md-9">
          <span class="dynasty-badge">${character.dynasty}</span>
          <h1 style="font-family:var(--f-display);font-size:clamp(2rem,4vw,3rem);font-weight:700;color:#fff;margin-bottom:.5rem;">${character.name}</h1>
          <p style="color:rgba(255,255,255,.65);font-size:1rem;max-width:580px;line-height:1.7;">${character.description}</p>

          <div class="d-flex align-items-center gap-3 mt-3 flex-wrap">
            <!-- Favorite -->
            <button class="fav-btn ${isFavorite ? 'active' : ''}" id="favBtn"
                    onclick="toggleFav(${character.id})">
              <span class="fav-icon">♥</span>
              <span id="favText">${isFavorite ? 'Đã yêu thích' : 'Yêu thích'}</span>
            </button>
            <!-- Rating -->
            <span style="color:rgba(255,255,255,.6);font-size:.875rem;">
              <span style="color:#FBBF24;">★</span> ${avgRating} (${totalReviews} đánh giá)
            </span>
          </div>
        </div>
      </div>
    </div>
  </div>

  <!-- MAIN CONTENT -->
  <div class="container py-4">
    <div class="row g-4 align-items-start">

      <!-- LEFT: TABS -->
      <div class="col-lg-8">
        <div class="detail-main-card">
          <div class="tab-nav">
            <button class="tab-btn active" onclick="openTab(event,'bio')">📜 Tiểu sử</button>
            <button class="tab-btn" onclick="openTab(event,'achieve')">🏆 Thành tựu</button>
            <button class="tab-btn" onclick="openTab(event,'video')">▶ Video</button>
            <button class="tab-btn" onclick="openTab(event,'map')">🗺 Bản đồ</button>
          </div>

          <div id="bio" class="tab-panel active">
            <p style="line-height:1.85;color:#374151;">${character.biography}</p>
            <c:if test="${not empty funFact}">
              <div class="fun-fact">
                <h6>🧠 ${funFact.title}</h6>
                <p id="factContent">${funFact.content}</p>
                <button class="btn-su-outline mt-2" style="font-size:.8rem;padding:.4rem .9rem;" onclick="loadFact()">🔄 Góc thú vị khác</button>
              </div>
            </c:if>
          </div>

          <div id="achieve" class="tab-panel">
            <p style="line-height:1.85;color:#374151;">${character.achievement}</p>
          </div>

          <div id="video" class="tab-panel">
            <div id="videoBox" class="mb-3">
              <div style="background:#f1f5f9;border-radius:12px;padding:2rem;text-align:center;color:var(--c-muted);">
                Nhấn nút bên dưới để tải video
              </div>
            </div>
            <button class="btn-su-primary" onclick="loadVideo()">▶ Xem video YouTube</button>
          </div>

          <div id="map" class="tab-panel">
            <div class="d-flex gap-4 mb-3 flex-wrap">
              <div><strong>Nơi sinh:</strong> <span style="color:var(--c-muted);">${character.birthPlace}</span></div>
              <div><strong>Di tích:</strong> <span style="color:var(--c-muted);">${character.historical_site}</span></div>
            </div>
            <iframe width="100%" height="300" style="border-radius:12px;border:1px solid var(--c-border);"
                    src="https://www.google.com/maps?q=${fn:escapeXml(character.historical_site)}&output=embed"
                    loading="lazy" title="Bản đồ di tích"></iframe>
          </div>
        </div>

        <!-- COMMENTS -->
        <div class="su-card mt-4 p-4">
          <h5 class="mb-4">💬 Bình luận & Đánh giá
            <span style="font-size:.82rem;font-weight:400;color:var(--c-muted);">(${totalReviews} đánh giá)</span>
          </h5>

          <c:if test="${not empty sessionScope.flashMessage}">
            <div style="border-left:4px solid var(--c-red-lt);background:#fef2f2;color:#991b1b;
                        padding:.9rem 1.1rem;border-radius:0 10px 10px 0;margin-bottom:1.25rem;font-size:.9rem;">
              ${sessionScope.flashMessage}
            </div>
            <c:remove var="flashMessage" scope="session"/>
          </c:if>

          <form method="post" action="${pageContext.request.contextPath}/comment" class="mb-4">
            <c:choose>
              <c:when test="${sessionScope.user != null}">
                <input type="hidden" name="uid" value="${sessionScope.user.id}">
                <input type="hidden" name="cid" value="${character.id}">
                <input type="hidden" name="score" id="scoreInput" value="5">
                <div class="mb-3 star-rating">
                  <c:forEach begin="1" end="5" var="i">
                    <span class="star active" data-score="${i}">★</span>
                  </c:forEach>
                </div>
                <textarea class="form-control mb-3" rows="3" name="content" required placeholder="Chia sẻ cảm nhận của bạn..."></textarea>
                <button type="submit" class="btn-su-primary">Gửi đánh giá</button>
              </c:when>
              <c:otherwise>
                <div style="background:#f8f9fa;border-radius:10px;padding:1.25rem;text-align:center;border:1px solid var(--c-border);">
                  <p style="margin-bottom:.75rem;color:var(--c-muted);">Bạn cần đăng nhập để viết đánh giá</p>
                  <a href="${pageContext.request.contextPath}/login" class="btn-su-primary" style="border-radius:8px;">Đăng nhập</a>
                </div>
              </c:otherwise>
            </c:choose>
          </form>

          <c:forEach items="${comments}" var="cm">
            <div class="comment-item">
              <div class="d-flex justify-content-between align-items-start mb-1">
                <span class="comment-username">${not empty cm.username ? cm.username : 'Người dùng'}</span>
                <small style="color:var(--c-muted);">${cm.createdAt}</small>
              </div>
              <div class="mb-1" style="font-size:.88rem;">
                <c:forEach begin="1" end="5" var="i">
                  <span style="color:${i <= cm.score ? '#FBBF24' : '#ddd'};">★</span>
                </c:forEach>
              </div>
              <p style="font-size:.9rem;color:#374151;margin:0;">${cm.content}</p>
            </div>
          </c:forEach>
        </div>
      </div>

      <!-- RIGHT: SIDEBAR -->
      <div class="col-lg-4">
        <div class="su-card p-4 mb-4">
          <h6 class="fw-bold mb-3" style="font-size:.8rem;letter-spacing:.12em;text-transform:uppercase;color:var(--c-muted);">Thông tin</h6>
          <dl style="font-size:.875rem;">
            <dt style="color:var(--c-muted);font-weight:500;">Triều đại</dt>
            <dd class="mb-3 fw-semibold">${character.dynasty}</dd>
            <dt style="color:var(--c-muted);font-weight:500;">Quê quán</dt>
            <dd class="mb-3 fw-semibold">${character.birthPlace}</dd>
            <dt style="color:var(--c-muted);font-weight:500;">Di tích</dt>
            <dd class="mb-0 fw-semibold">${character.historical_site}</dd>
          </dl>
        </div>

        <a href="${pageContext.request.contextPath}/characters" class="btn-su-outline w-100 justify-content-center">← Quay lại danh sách</a>
      </div>

    </div>
  </div>

</main>
<jsp:include page="/common/footer.jsp"/>

<script>
function openTab(e, id) {
  document.querySelectorAll('.tab-panel').forEach(p => p.classList.remove('active'));
  document.querySelectorAll('.tab-btn').forEach(b => b.classList.remove('active'));
  document.getElementById(id).classList.add('active');
  e.currentTarget.classList.add('active');
}

function loadVideo() {
  let yt = '<c:out value="${character.youtubeLink}" default=""/>';
  if (!yt) { document.getElementById('videoBox').innerHTML = '<p style="color:#64748B;">Chưa có video cho nhân vật này.</p>'; return; }
  const match = yt.match(/(?:v=|youtu\.be\/)([A-Za-z0-9_\-]{11})/);
  const videoId = match ? match[1] : yt;
  document.getElementById('videoBox').innerHTML =
    '<iframe width="100%" height="360" style="border-radius:12px;" src="https://www.youtube.com/embed/' + videoId + '" frameborder="0" allowfullscreen></iframe>';
}

function loadFact() {
  fetch('${pageContext.request.contextPath}/random-fact?characterId=${character.id}')
    .then(r => r.json()).then(d => {
      document.getElementById('factContent').textContent = d.content;
    });
}

function toggleFav(cid) {
  const btn = document.getElementById('favBtn');
  const uid = '${sessionScope.user.id}';
  if (!uid || uid === '') { alert('Bạn cần đăng nhập!'); return; }
  fetch('${pageContext.request.contextPath}/favorite', {
    method: 'POST',
    headers: {'Content-Type': 'application/x-www-form-urlencoded'},
    body: 'uid=' + uid + '&cid=' + cid
  }).then(r => r.json()).then(d => {
    btn.classList.toggle('active', d.favorite);
    document.getElementById('favText').textContent = d.favorite ? 'Đã yêu thích' : 'Yêu thích';
  });
}

// Star rating — hover preview + click to set
const stars = document.querySelectorAll('.star-rating .star');
const scoreInput = document.getElementById('scoreInput');
if (stars.length && scoreInput) {
  // Giữ 5 sao mặc định
  scoreInput.value = 5;
  stars.forEach(s => s.classList.add('active'));

  stars.forEach(star => {
    // hover preview
    star.addEventListener('mouseenter', () => {
      const hv = +star.dataset.score;
      stars.forEach(s => s.classList.toggle('active', +s.dataset.score <= hv));
    });
    // hover out — restore to current selection
    star.addEventListener('mouseleave', () => {
      const cur = +scoreInput.value;
      stars.forEach(s => s.classList.toggle('active', +s.dataset.score <= cur));
    });
    // click
    star.addEventListener('click', () => {
      const score = +star.dataset.score;
      scoreInput.value = score;
      stars.forEach(s => s.classList.toggle('active', +s.dataset.score <= score));
    });
  });
}
</script>
</body>
</html>
