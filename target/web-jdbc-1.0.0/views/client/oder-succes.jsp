<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>Đặt hàng thành công</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        .success-card { max-width: 640px; margin: 6rem auto; padding: 2rem; border-radius: 12px; box-shadow: 0 8px 30px rgba(0,0,0,0.08); }
        .success-icon { width:96px; height:96px; display:flex; align-items:center; justify-content:center; border-radius:50%; background:linear-gradient(135deg,#a55eea,#ff79c6); color:#fff; font-size:48px; margin:0 auto 1rem; }
    </style>
</head>
<body>
<div class="container">
    <div class="card success-card text-center">
        <div class="card-body">
            <div class="success-icon">
                <i class="bi bi-check-lg"></i>
            </div>
            <h2 class="card-title">Đặt hàng thành công!</h2>
            <p class="lead text-muted">Cảm ơn bạn đã đặt hàng. Chúng tôi đã nhận đơn và sẽ xử lý trong thời gian sớm nhất.</p>
            <div class="mt-4">
                <a href="${pageContext.request.contextPath}/home" class="btn btn-primary btn-lg me-2">Về trang chủ</a>
                <a href="#" class="btn btn-outline-secondary btn-lg">Xem đơn hàng của tôi</a>
            </div>
            <p class="mt-3 text-muted small">Bạn sẽ nhận được email xác nhận nếu đã cung cấp địa chỉ email khi đặt hàng.</p>
        </div>
    </div>
</div>
</body>