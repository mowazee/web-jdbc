<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!doctype html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Thông báo</title>
    <style>
        .center-box { max-width:760px; margin:48px auto; }
        .msg-box { padding:24px; border-radius:8px; box-shadow:0 2px 10px rgba(0,0,0,0.06); }
        .success { background:#e9f7ef; border:1px solid #c7efd5; color:#0f5132; }
        .error { background:#fff4f4; border:1px solid #ffd6d6; color:#6a1a1a; }
        .btn-row { margin-top:18px; display:flex; gap:12px; }
    </style>
</head>
<body>
<div class="center-box">
    <h2>Thông báo</h2>

    <c:choose>
        <c:when test="${not empty sessionScope.purchaseRegisterMessage}">
            <c:set var="_msg" value="${sessionScope.purchaseRegisterMessage}" />
            <c:set var="_ok" value="${sessionScope.purchaseRegisterSuccess}" />
            <!-- remove from session so message won't persist on reload -->
            <c:remove var="purchaseRegisterMessage" scope="session" />
            <c:remove var="purchaseRegisterSuccess" scope="session" />

            <div class="msg-box ${_ok == true ? 'success' : 'error'}">
                <h4>${_ok == true ? 'Thành công' : 'Thông báo'}</h4>
                <p style="white-space:pre-wrap;">${_msg}</p>
                <div class="btn-row">
                    <a href="${pageContext.request.contextPath}/home" class="btn btn-primary">Về trang chủ</a>
                    <a href="${pageContext.request.contextPath}/contact" class="btn btn-outline-secondary">Liên hệ</a>
                </div>
            </div>
        </c:when>
        <c:otherwise>
            <div class="msg-box" style="background:#f8f9fa;border:1px solid #e9ecef;">
                <h4>Không có thông báo</h4>
                <p>Không có thông báo mới. Nếu bạn vừa gửi yêu cầu, có thể bạn sẽ được chuyển tiếp về trang này ngay lập tức — hãy thử tải lại trang nếu cần.</p>
                <div class="btn-row">
                    <a href="${pageContext.request.contextPath}/home" class="btn btn-primary">Về trang chủ</a>
                    <a href="${pageContext.request.contextPath}/contact" class="btn btn-outline-secondary">Liên hệ</a>
                </div>
            </div>
        </c:otherwise>
    </c:choose>

</div>
</body>
</html>