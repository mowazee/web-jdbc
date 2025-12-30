<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Chi tiết đơn hàng</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<div class="container mt-4">
    <h3>Chi tiết đơn hàng #${order.id}</h3>

    <div class="mb-3">
        <strong>Người mua:</strong> ${order.userid}
    </div>
    <div class="mb-3">
        <strong>Ngày:</strong> ${order.orderdate}
    </div>
    <div class="mb-3">
        <strong>Tổng:</strong> ${order.total}
    </div>
    <div class="mb-3">
        <strong>Trạng thái:</strong> ${order.status}
    </div>

    <h5>Items</h5>
    <table class="table">
        <thead>
            <tr>
                <th>#</th>
                <th>Product</th>
                <th>Price</th>
                <th>Quantity</th>
                <th>Subtotal</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="it" items="${order.items}">
                <tr>
                    <td>${it.id}</td>
                    <td>${it.productName}</td>
                    <td>${it.price}</td>
                    <td>${it.quantity}</td>
                    <td>${it.subtotal}</td>
                </tr>
            </c:forEach>
        </tbody>
    </table>

    <div class="mt-3">
        <form action="<c:url value='/admin/order'/>" method="post">
            <input type="hidden" name="action" value="updateStatus"/>
            <input type="hidden" name="id" value="${order.id}"/>
            <div class="input-group" style="max-width:360px;">
                <select name="status" class="form-select">
                    <option value="0" ${order.status == 0 ? 'selected' : ''}>Mới</option>
                    <option value="1" ${order.status == 1 ? 'selected' : ''}>Đang xử lý</option>
                    <option value="2" ${order.status == 2 ? 'selected' : ''}>Đã gửi</option>
                    <option value="3" ${order.status == 3 ? 'selected' : ''}>Hoàn thành</option>
                </select>
                <button class="btn btn-primary" type="submit">Cập nhật trạng thái</button>
            </div>
        </form>
    </div>

    <div class="mt-3">
        <a href="<c:url value='/admin/order'/>" class="btn btn-secondary">Quay lại</a>
    </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>