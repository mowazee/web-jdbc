<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Đặt lại mật khẩu</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<div class="container" style="min-height:60vh; display:flex; align-items:center; justify-content:center;">
    <div style="width:420px; background:rgba(255,255,255,0.95); padding:24px; border-radius:12px;">
        <h4 class="mb-3">Đặt lại mật khẩu</h4>
        <c:if test="${not empty alert}">
            <div class="alert alert-danger">${alert}</div>
        </c:if>
        <form action="<c:url value='/resetpassword'/>" method="post">
            <input type="hidden" name="token" value="${token}" />
            <div class="mb-3">
                <label class="form-label">Mật khẩu mới</label>
                <input type="password" class="form-control" name="password" required minlength="6">
            </div>
            <div class="mb-3">
                <label class="form-label">Nhập lại mật khẩu</label>
                <input type="password" class="form-control" name="confirmPassword" required minlength="6">
            </div>
            <button class="btn btn-primary w-100" type="submit">Cập nhật mật khẩu</button>
        </form>
    </div>
</div>
</body>
</html>
