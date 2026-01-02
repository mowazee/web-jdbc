<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<head>
    <meta charset="UTF-8">
    <title>Form người dùng</title>
</head>
<body>
<div class="container mt-4" style="max-width:620px;">
    <h3>${requestScope.user.id == 0 ? 'Tạo mới người dùng' : 'Chỉnh sửa người dùng'}</h3>

    <c:if test="${not empty requestScope.error}">
        <div class="alert alert-danger">${requestScope.error}</div>
    </c:if>

    <form action="<c:url value='/admin/user'/>" method="post">
        <!-- Set action based on whether we're creating or updating. Use requestScope to avoid colliding with session user -->
        <c:choose>
            <c:when test="${requestScope.user.id == 0}">
                <input type="hidden" name="action" value="create"/>
            </c:when>
            <c:otherwise>
                <input type="hidden" name="action" value="save"/>
            </c:otherwise>
        </c:choose>
        <input type="hidden" name="id" value="${requestScope.user.id}"/>

        <div class="row">
            <div class="col-md-6">
                <div class="mb-3">
                    <label for="email" class="form-label">Email</label>
                    <input type="email" class="form-control" id="email" name="email" value="${requestScope.user.email}" required>
                </div>
                <div class="mb-3">
                    <label for="username" class="form-label">Username</label>
                    <input type="text" class="form-control" id="username" name="username" value="${requestScope.user.username}" required>
                </div>
                <div class="mb-3">
                    <label for="password" class="form-label">Mật khẩu</label>
                    <input type="password" class="form-control" id="password" name="password" placeholder="Để trống nếu không đổi">
                </div>
                <div class="mb-3">
                    <label for="roleid" class="form-label">Role ID</label>
                    <input type="number" class="form-control" id="roleid" name="roleid" value="${requestScope.user.roleid == 0 ? 2 : requestScope.user.roleid}">
                </div>
            </div>
            <div class="col-md-6">
                <div class="mb-3">
                    <label for="fullname" class="form-label">Fullname</label>
                    <input type="text" class="form-control" id="fullname" name="fullname" value="${requestScope.user.fullname}">
                </div>
                <div class="mb-3">
                    <label for="phone" class="form-label">Phone</label>
                    <input type="text" class="form-control" id="phone" name="phone" value="${requestScope.user.phone}">
                </div>
                <div class="mb-3">
                    <label for="avatar" class="form-label">Avatar (URL)</label>
                    <input type="text" class="form-control" id="avatar" name="avatar" value="${requestScope.user.avatar}">
                </div>
            </div>
        </div>

        <div class="d-flex gap-2">
            <button type="submit" class="btn btn-success">Lưu</button>
            <a href="<c:url value='/admin/user'/>" class="btn btn-secondary">Hủy</a>
        </div>
    </form>
</div>
</body>