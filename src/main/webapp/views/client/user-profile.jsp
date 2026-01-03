<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Thông tin cá nhân</title>

    <style>
        .profile-card { max-width:900px; margin:3.5rem auto; }
        .avatar { width:140px; height:140px; object-fit:cover; border-radius:12px; }
        .field-label { font-weight:600; color:#333; }
        .field-value { color:#555; }
    </style>
</head>
<body>
<div class="container">
    <div class="profile-card card shadow-sm">
        <div class="card-body">
            <c:choose>
                <c:when test="${not empty sessionScope.user}">
                    <div class="d-flex align-items-center gap-4">
                        <div>
                            <c:choose>
                                <c:when test="${not empty sessionScope.user.avatar}">
                                    <img src="${pageContext.request.contextPath}/${sessionScope.user.avatar}" alt="Avatar" class="avatar img-thumbnail" />
                                </c:when>
                                <c:otherwise>
                                    <img src="${pageContext.request.contextPath}/common/image/default-avatar.png" alt="Avatar" class="avatar img-thumbnail" />
                                </c:otherwise>
                            </c:choose>
                        </div>
                        <div class="flex-grow-1">
                            <h3 class="mb-1">${sessionScope.user.fullname != null ? sessionScope.user.fullname : sessionScope.user.username}</h3>
                            <p class="text-muted mb-2">@${sessionScope.user.username}</p>
                            <div class="mb-3">
                                <a href="#" class="btn btn-outline-primary me-2">Chỉnh sửa hồ sơ</a>
                                <a href="${pageContext.request.contextPath}/home" class="btn btn-secondary">Về trang chủ</a>
                            </div>
                        </div>
                    </div>

                    <hr />

                    <div class="row gy-3">
                        <div class="col-md-6">
                            <div class="mb-2"><span class="field-label">Email:</span></div>
                            <div class="field-value">${sessionScope.user.email}</div>
                        </div>
                        <div class="col-md-6">
                            <div class="mb-2"><span class="field-label">Số điện thoại:</span></div>
                            <div class="field-value">${sessionScope.user.phone != null ? sessionScope.user.phone : '-'} </div>
                        </div>

                        <div class="col-md-6">
                            <div class="mb-2"><span class="field-label">Địa chỉ:</span></div>
                            <div class="field-value">${sessionScope.user.address != null ? sessionScope.user.address : '-'} </div>
                        </div>

                        <div class="col-md-6">
                            <div class="mb-2"><span class="field-label">Ngày đăng ký:</span></div>
                            <div class="field-value"><fmt:formatDate value="${sessionScope.user.createdate}" pattern="dd/MM/yyyy"/></div>
                        </div>

                        <div class="col-12 mt-3">
                            <h6>Thông tin khác</h6>
                            <p class="text-muted small">Bạn có thể cập nhật thông tin cá nhân bằng cách bấm "Chỉnh sửa hồ sơ".</p>
                        </div>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="text-center p-5">
                        <h4>Bạn chưa đăng nhập</h4>
                        <p class="text-muted">Vui lòng đăng nhập để xem thông tin tài khoản.</p>
                        <a href="${pageContext.request.contextPath}/login" class="btn btn-primary">Đăng nhập</a>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
</div>
</body>