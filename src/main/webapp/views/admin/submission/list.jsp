<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>

<!DOCTYPE html>
<html>
<head>

<meta charset="UTF-8">

<title>Kiểm duyệt đóng góp</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/css/bootstrap.min.css" rel="stylesheet">

<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css" rel="stylesheet">

<link href="${pageContext.request.contextPath}/assets/css/admin.css" rel="stylesheet">

</head>

<body>

<div class="admin-wrapper">

    <jsp:include page="../layout/sidebar.jsp"/>

    <div class="main-content">

        <jsp:include page="../layout/header.jsp"/>

        <div class="content p-4">

            <h2 class="mb-4">
                Kiểm duyệt đóng góp
            </h2>

            <table class="table table-bordered table-hover align-middle">

                <thead class="table-dark">

                <tr>

                    <th>ID</th>

                    <th>Ảnh</th>

                    <th>Tên</th>

                    <th>Triều đại</th>

                    <th>Người gửi</th>

                    <th width="280">
                        Thao tác
                    </th>

                </tr>

                </thead>

                <tbody>

                <c:forEach items="${submissions}" var="c">

                    <tr>

                        <td>${c.id}</td>

                        <td>

                            <img
                            src="${pageContext.request.contextPath}/assets/images/submitted/${c.image}"
                            width="80"
                            style="border-radius:10px;">

                        </td>

                        <td>${c.name}</td>

                        <td>${c.dynasty}</td>

                        <td>${c.userId}</td>

                        <td>

                            <button
                            class="btn btn-info btn-sm"
                            data-bs-toggle="modal"
                            data-bs-target="#detail${c.id}">
                                Xem
                            </button>

                            <form
                            action="${pageContext.request.contextPath}/admin/submissions"
                            method="post"
                            style="display:inline">

                                <input type="hidden" name="action" value="approve">

                                <input type="hidden" name="id" value="${c.id}">

                                <button class="btn btn-success btn-sm">

                                    Duyệt

                                </button>

                            </form>

                            <form
                            action="${pageContext.request.contextPath}/admin/submissions"
                            method="post"
                            style="display:inline">

                                <input type="hidden" name="action" value="reject">

                                <input type="hidden" name="id" value="${c.id}">

                                <button
                                class="btn btn-danger btn-sm">

                                    Từ chối

                                </button>

                            </form>

                        </td>

                    </tr>

                    <!-- Modal -->

                    <div class="modal fade" id="detail${c.id}">

                        <div class="modal-dialog modal-lg">

                            <div class="modal-content">

                                <div class="modal-header">

                                    <h5>

                                        ${c.name}

                                    </h5>

                                    <button
                                    class="btn-close"
                                    data-bs-dismiss="modal">

                                    </button>

                                </div>

                                <div class="modal-body">

                                    <div class="text-center mb-3">

									<img
									src="${pageContext.request.contextPath}/assets/images/submitted/${c.image}"
									style="
									width:280px;
									height:360px;
									object-fit:cover;
									border-radius:12px;
									box-shadow:0 8px 20px rgba(0,0,0,.2);
									">
									
									</div>

                                    <h5>Triều đại</h5>

                                    <p>${c.dynasty}</p>

                                    <h5>Mô tả</h5>

                                    <p>${c.description}</p>

                                    <h5>Tiểu sử</h5>

                                    <p>${c.biography}</p>

                                    <h5>Thành tựu</h5>

                                    <p>${c.achievement}</p>

                                    <h5>Quê quán</h5>

                                    <p>${c.birthPlace}</p>

                                    <h5>Di tích</h5>

                                    <p>${c.historicalSite}</p>

                                </div>

                            </div>

                        </div>

                    </div>

                </c:forEach>

                </tbody>

            </table>

        </div>

    </div>

</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/js/bootstrap.bundle.min.js"></script>

</body>

</html>