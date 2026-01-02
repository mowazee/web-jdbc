<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Thanh toán</title>
</head>
<body>
<div class="container py-4">
    <h4>Thông tin người nhận</h4>
    <c:if test="${not empty error}">
        <div class="alert alert-danger">${error}</div>
    </c:if>
    <form id="checkoutForm" action="${pageContext.request.contextPath}/checkout" method="post">
        <div class="mb-3">
            <label for="recipientName" class="form-label">Họ và tên</label>
            <input type="text" id="recipientName" name="recipientName" class="form-control" required />
        </div>
        <div class="mb-3">
            <label for="recipientPhone" class="form-label">Số điện thoại</label>
            <input type="tel" id="recipientPhone" name="recipientPhone" class="form-control" pattern="[0-9]{9,12}" required />
        </div>
        <div class="mb-3">
            <label for="recipientAddress" class="form-label">Địa chỉ</label>
            <textarea id="recipientAddress" name="recipientAddress" class="form-control" rows="3" required></textarea>
        </div>
        <div class="d-flex gap-2">
            <button type="submit" class="btn btn-primary">Xác nhận và thanh toán</button>
            <a class="btn btn-secondary" href="${pageContext.request.contextPath}/cart">Quay lại Giỏ hàng</a>
        </div>
    </form>
</div>
<script>
document.getElementById('checkoutForm').addEventListener('submit', function(e){
    // Simple client-side validation
    const name = document.getElementById('recipientName').value.trim();
    const phone = document.getElementById('recipientPhone').value.trim();
    const address = document.getElementById('recipientAddress').value.trim();
    if(!name || !phone || !address){
        e.preventDefault();
        alert('Vui lòng điền đầy đủ thông tin người nhận.');
    }
});
</script>
</body>