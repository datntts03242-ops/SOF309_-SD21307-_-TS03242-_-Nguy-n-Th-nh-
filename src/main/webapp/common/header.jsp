<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>

<%
    String active = (String) request.getAttribute("activePage");
    if (active == null) active = "";
%>

<nav class="navbar navbar-expand-lg navbar-dark fixed-top shadow-sm">

    <div class="container">

        <!-- ================= LOGO ================= -->
        <a class="navbar-brand d-flex align-items-center gap-2 logo-link"
           href="${pageContext.request.contextPath}/about">

            <img src="${pageContext.request.contextPath}/assets/images/logo-su-mon.png"
                 height="38"
                 alt="Logo">

            <span>Sử Môn</span>

        </a>

        <button class="navbar-toggler border-0"
                type="button"
                data-bs-toggle="collapse"
                data-bs-target="#navMain"
                aria-controls="navMain"
                aria-expanded="false"
                aria-label="Toggle navigation">

            <span class="navbar-toggler-icon"></span>

        </button>

        <div class="collapse navbar-collapse" id="navMain">

            <ul class="navbar-nav ms-auto align-items-center gap-1">

                <!-- HOME -->
                <li class="nav-item">
                    <a class="nav-link <%= "home".equals(active) ? "active" : "" %>"
                       href="${pageContext.request.contextPath}/">

                        Trang Chủ

                    </a>
                </li>

                <!-- CHARACTER -->
                <li class="nav-item">
                    <a class="nav-link <%= "characters".equals(active) ? "active" : "" %>"
                       href="${pageContext.request.contextPath}/characters">

                        Nhân Vật

                    </a>
                </li>

                <!-- DYNASTY -->
                <li class="nav-item">
                    <a class="nav-link <%= "dynasty".equals(active) || "dynasties".equals(active) ? "active" : "" %>"
                       href="${pageContext.request.contextPath}/dynasties">

                        Triều Đại

                    </a>
                </li>

                <!-- TIMELINE -->
                <li class="nav-item">
                    <a class="nav-link <%= "timeline".equals(active) ? "active" : "" %>"
                       href="${pageContext.request.contextPath}/timeline">

                        Dòng Thời Gian

                    </a>
                </li>

                <!-- QUIZ -->
                <li class="nav-item">
                    <a class="nav-link <%= "quiz".equals(active) ? "active" : "" %>"
                       href="${pageContext.request.contextPath}/quiz">

                        Quiz

                    </a>
                </li>

                <!-- ADMIN -->
                <c:if test="${fn:toUpperCase(sessionScope.user.role) eq 'ADMIN'}">

                    <li class="nav-item">

                        <a class="nav-link text-warning fw-semibold"
                           href="${pageContext.request.contextPath}/admin/dashboard">

                            ⚙ Quản trị

                        </a>

                    </li>

                </c:if>

                <!-- AI -->
                <li class="nav-item ms-1">

                    <a class="nav-link px-3 py-1 rounded-pill fw-semibold"

                       style="background:rgba(212,160,23,.15);
                              color:var(--c-gold)!important;
                              border:1px solid rgba(212,160,23,.3);
                              cursor:pointer;"

                       href="#"

                       onclick="toggleAIChatBox(); return false;">

                        🤖 AI

                    </a>

                </li>

                <!-- USER -->
                <c:choose>

                    <c:when test="${not empty sessionScope.user}">

                        <li class="nav-item dropdown ms-2">

                            <a class="nav-link dropdown-toggle d-flex align-items-center gap-2 px-2 py-1 rounded-pill"

                               style="background:rgba(255,255,255,.07);"

                               href="#"

                               data-bs-toggle="dropdown">

                                <img src="${not empty sessionScope.user.avatar
                                           ? pageContext.request.contextPath.concat('/uploads/').concat(sessionScope.user.avatar)
                                           : pageContext.request.contextPath.concat('/assets/images/default-avatar.png')}"

                                     class="user-avatar"

                                     alt="avatar"/>

                                <span style="color:var(--c-gold);
                                             font-size:.85rem;
                                             font-weight:600;">

                                    ${sessionScope.user.fullname}

                                </span>

                            </a>

                            <ul class="dropdown-menu dropdown-menu-end">

                                <li>
                                    <a class="dropdown-item"
                                       href="${pageContext.request.contextPath}/profile">

                                        👤 Hồ sơ

                                    </a>
                                </li>

                                <li>
                                    <a class="dropdown-item"
                                       href="${pageContext.request.contextPath}/favorites">

                                        ❤️ Yêu thích

                                    </a>
                                </li>

                                <li>
                                    <a class="dropdown-item"
                                       href="${pageContext.request.contextPath}/library">

                                        📚 Lịch sử xem

                                    </a>
                                </li>

                                <li><hr class="dropdown-divider my-1"></li>

                                <li>
                                    <a class="dropdown-item text-danger"
                                       href="${pageContext.request.contextPath}/logout">

                                        🚪 Đăng xuất

                                    </a>
                                </li>

                            </ul>

                        </li>

                    </c:when>

                    <c:otherwise>

                        <li class="nav-item ms-2">

                            <a class="btn btn-warning px-4 py-2 fw-semibold"
                               href="${pageContext.request.contextPath}/login">

                                Đăng nhập

                            </a>

                        </li>

                    </c:otherwise>

                </c:choose>

            </ul>

        </div>

    </div>

</nav>