<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<head>
    <meta charset="UTF-8">
    <title>Quản lý danh mục</title>
</head>
<body>
<div class="container mt-4" style="max-width:760px;">
    <div class="d-flex justify-content-between align-items-center mb-3">
        <h3>Danh mục</h3>
        <a href="<c:url value='/admin/category?action=create'/>" class="btn btn-primary">Tạo mới</a>
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
            <th>Tên danh mục</th>
            <th>Mô tả</th>
            <th>Icon</th>
            <th>Hành động</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach var="c" items="${categories}">
            <tr>
                <td>${c.cateid}</td>
                <td>${c.catename}</td>
                <td style="max-width:320px; white-space:nowrap; overflow:hidden; text-overflow:ellipsis;">
                    <c:out value="${c.description}"/>
                </td>
                <td>
                    <c:choose>
                        <c:when test="${not empty c.icon}">
                            <img src="${pageContext.request.contextPath}/image/${c.icon}" alt="icon-${c.cateid}" style="max-height:60px; max-width:120px;"/>
                            <div class="small text-muted mt-1">
                                <a href="${pageContext.request.contextPath}/image/${c.icon}" target="_blank">Xem ảnh</a>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <span class="text-muted">(Không có ảnh)</span>
                        </c:otherwise>
                    </c:choose>
                </td>
                <td>
                    <a href="<c:url value='/admin/category?action=edit&id='/>${c.cateid}" class="btn btn-sm btn-warning">Sửa</a>
                    <form action="<c:url value='/admin/category?action=delete'/>" method="post" style="display:inline-block;" onsubmit="return confirm('Bạn có chắc muốn xóa?');">
                        <input type="hidden" name="action" value="delete"/>
                        <input type="hidden" name="id" value="${c.cateid}"/>
                        <button type="submit" class="btn btn-sm btn-danger">Xóa</button>
                    </form>
                </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
</div>
</body>