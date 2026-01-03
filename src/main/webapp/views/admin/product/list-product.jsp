<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<head>
    <meta charset="UTF-8">
    <title>Quản lý sản phẩm</title>
</head>
<body>
<div class="container mt-4">
    <div class="d-flex justify-content-between align-items-center mb-3">
        <h3>Sản phẩm</h3>
        <a href="<c:url value='/admin/product?action=create'/>" class="btn btn-primary">Tạo mới</a>
    </div>

    <c:if test="${not empty requestScope.message}">
        <div class="alert alert-success">${requestScope.message}</div>
    </c:if>
    <c:if test="${not empty requestScope.error}">
        <div class="alert alert-danger">${requestScope.error}</div>
    </c:if>

    <table class="table table-striped table-bordered">
        <thead>
        <tr>
            <th>#</th>
            <th>Tên</th>
            <th>Giá</th>
            <th>Số lượng</th>
            <th>Ảnh</th>
            <th>Danh mục</th>
            <th>Hành động</th>
        </tr>
        </thead>
        <tbody>
        <c:choose>
            <c:when test="${not empty products}">
                <c:set var="startIndex" value="${(currentPage - 1) * pageSize + 1}" />
                <c:forEach var="p" items="${products}" varStatus="st">
                    <tr>
                        <td>${startIndex + st.index}</td>
                        <td>${p.name}</td>
                        <td>${p.price}</td>
                        <td>${p.quantity}</td>
                        <td><c:if test="${not empty p.image}"><img src="${pageContext.request.contextPath}/${p.image}" alt="" style="height:50px;"/></c:if></td>
                        <td>
                            <c:choose>
                                <c:when test="${not empty categories}">
                                    <c:forEach var="cat" items="${categories}">
                                        <c:if test="${cat.cateid == p.cateid}">
                                            <c:out value="${cat.catename}"/>
                                        </c:if>
                                    </c:forEach>
                                </c:when>
                                <c:otherwise>
                                    ${p.cateid}
                                </c:otherwise>
                            </c:choose>
                        </td>
                        <td>
                            <a href="<c:url value='/admin/product?action=edit&id='/>${p.id}" class="btn btn-sm btn-warning">Sửa</a>
                            <form action="<c:url value='/admin/product?action=delete'/>" method="post" style="display:inline-block;" onsubmit="return confirm('Bạn có chắc muốn xóa?');">
                                <input type="hidden" name="action" value="delete"/>
                                <input type="hidden" name="id" value="${p.id}"/>
                                <button type="submit" class="btn btn-sm btn-danger">Xóa</button>
                            </form>
                        </td>
                    </tr>
                </c:forEach>
            </c:when>
            <c:otherwise>
                <tr><td colspan="7" class="text-center">Không có sản phẩm.</td></tr>
            </c:otherwise>
        </c:choose>
        </tbody>
    </table>

    <!-- pagination controls -->
    <c:if test="${totalPages > 1}">
        <nav>
            <ul class="pagination">
                <li class="page-item ${currentPage == 1 ? 'disabled' : ''}"><a class="page-link" href="${pageContext.request.contextPath}/admin/products?page=${currentPage-1}">Trang trước</a></li>
                <c:forEach var="i" begin="1" end="${totalPages}">
                    <li class="page-item ${i == currentPage ? 'active' : ''}"><a class="page-link" href="${pageContext.request.contextPath}/admin/products?page=${i}">${i}</a></li>
                </c:forEach>
                <li class="page-item ${currentPage == totalPages ? 'disabled' : ''}"><a class="page-link" href="${pageContext.request.contextPath}/admin/products?page=${currentPage+1}">Trang sau</a></li>
            </ul>
        </nav>
    </c:if>
</div>
</body>