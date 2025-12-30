<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Quản lý đơn hàng</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<div class="container mt-4">
    <h3>Đơn hàng</h3>

    <table class="table table-striped table-bordered">
        <thead>
        <tr>
            <th>#</th>
            <th>Người mua (user_id)</th>
            <th>Ngày</th>
            <th>Tổng</th>
            <th>Trạng thái</th>
            <th>Hành động</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach var="o" items="${orders}">
            <tr>
                <td>${o.id}</td>
                <td>${o.userid}</td>
                <td>${o.orderdate}</td>
                <td>${o.total}</td>
                <td>
                    <c:choose>
                        <c:when test="${o.status == 0}">Mới</c:when>
                        <c:when test="${o.status == 1}">Đang xử lý</c:when>
                        <c:when test="${o.status == 2}">Đã gửi</c:when>
                        <c:when test="${o.status == 3}">Hoàn thành</c:when>
                        <c:otherwise>Không xác định</c:otherwise>
                    </c:choose>
                </td>
                <td>
                    <a href="<c:url value='/admin/order?action=detail&id='/>${o.id}" class="btn btn-sm btn-info">Chi tiết</a>
                    <form action="<c:url value='/admin/order'/>" method="post" style="display:inline-block;" onsubmit="return confirm('Bạn có chắc muốn xóa?');">
                        <input type="hidden" name="action" value="delete"/>
                        <input type="hidden" name="id" value="${o.id}"/>
                        <button type="submit" class="btn btn-sm btn-danger">Xóa</button>
                    </form>
                </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>