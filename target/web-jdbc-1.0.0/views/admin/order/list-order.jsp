<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<head>
    <meta charset="UTF-8">
    <title>Quản lý đơn hàng</title>
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
        <c:choose>
            <c:when test="${not empty orders}">
                <c:set var="startIndex" value="${(currentPage - 1) * pageSize + 1}" />
                <c:forEach var="o" items="${orders}" varStatus="st">
                    <tr>
                        <td>${startIndex + st.index}</td>
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
                            <a href="<c:url value='/admin/orders?action=detail&id='/>${o.id}" class="btn btn-sm btn-info">Chi tiết</a>
                            <form action="<c:url value='/admin/orders'/>" method="post" style="display:inline-block;" onsubmit="return confirm('Bạn có chắc muốn xóa?');">
                                <input type="hidden" name="action" value="delete"/>
                                <input type="hidden" name="id" value="${o.id}"/>
                                <button type="submit" class="btn btn-sm btn-danger">Xóa</button>
                            </form>
                        </td>
                    </tr>
                </c:forEach>
            </c:when>
            <c:otherwise>
                <tr><td colspan="6" class="text-center">Không có đơn hàng.</td></tr>
            </c:otherwise>
        </c:choose>
        </tbody>
    </table>
    <c:if test="${totalPages > 1}">
        <nav>
            <ul class="pagination">
                <li class="page-item ${currentPage == 1 ? 'disabled' : ''}"><a class="page-link" href="${pageContext.request.contextPath}/admin/orders?page=${currentPage-1}">Trang trước</a></li>
                <c:forEach var="i" begin="1" end="${totalPages}">
                    <li class="page-item ${i == currentPage ? 'active' : ''}"><a class="page-link" href="${pageContext.request.contextPath}/admin/orders?page=${i}">${i}</a></li>
                </c:forEach>
                <li class="page-item ${currentPage == totalPages ? 'disabled' : ''}"><a class="page-link" href="${pageContext.request.contextPath}/admin/orders?page=${currentPage+1}">Trang sau</a></li>
            </ul>
        </nav>
    </c:if>
</div>
</body>