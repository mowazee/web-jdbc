<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>Đặt hàng thành công</title>

    <style>
        .card-success { max-width:720px; margin:6rem auto; padding:2.5rem; border-radius:12px; box-shadow:0 10px 30px rgba(0,0,0,0.08); text-align:center; }
        .tick { font-size:4rem; color:#28a745; }
    </style>
</head>
<body style="background:#f8fafc;">
<div class="container">
    <div class="card card-success">
        <div class="card-body">
            <div class="mb-3">
                <span class="tick">✔</span>
            </div>
            <h2>Đặt hàng thành công</h2>
            <p class="text-muted">Cảm ơn bạn đã mua sắm tại cửa hàng chúng tôi!</p>
            <c:if test="${not empty orderId}">
                <p class="fw-semibold">Mã đơn hàng của bạn: <span class="text-primary">#${orderId}</span></p>
            </c:if>
            <div class="mt-4">
                <a href="${pageContext.request.contextPath}/home" class="btn btn-primary btn-lg me-2">Về trang chủ</a>
                <a href="#" class="btn btn-outline-secondary btn-lg">Xem đơn hàng của tôi</a>
            </div>
            <p class="small text-muted mt-3">Bạn sẽ nhận được email xác nhận nếu đã cung cấp địa chỉ email khi đặt hàng.</p>
        </div>
    </div>
</div>
</body>
