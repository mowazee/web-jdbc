<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<head>
    <meta charset="UTF-8">
    <title>Quản lý tin tức</title>
</head>
<body>
<div class="container mt-4">
    <div class="d-flex justify-content-between align-items-center mb-3">
        <h3>Tin tức</h3>
        <a href="<c:url value='/admin/news?action=create'/>" class="btn btn-primary">Tạo mới</a>
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
            <th>Tiêu đề</th>
            <th>Tác giả</th>
            <th>Hình</th>
            <th>Ngày đăng</th>
            <th>Hành động</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach var="n" items="${newsList}">
            <tr>
                <td>${n.id}</td>
                <td>${n.title}</td>
                <td>${n.authorid}</td>
                <td>
                    <c:choose>
                        <c:when test="${not empty n.image}">
                            <img src="${pageContext.request.contextPath}/${n.image}" style="height:50px;"/>
                        </c:when>
                        <c:when test="${not empty n.thumbnail}">
                            <img src="${pageContext.request.contextPath}/${n.thumbnail}" style="height:50px;"/>
                        </c:when>
                        <c:otherwise>-</c:otherwise>
                    </c:choose>
                </td>
                <td>${n.createdate}</td>
                <td>
                    <a href="<c:url value='/admin/news?action=edit&id='/>${n.id}" class="btn btn-sm btn-warning">Sửa</a>
                    <form action="<c:url value='/admin/news'/>" method="post" style="display:inline-block;" onsubmit="return confirm('Bạn có chắc muốn xóa?');">
                        <input type="hidden" name="action" value="delete"/>
                        <input type="hidden" name="id" value="${n.id}"/>
                        <button type="submit" class="btn btn-sm btn-danger">Xóa</button>
                    </form>
                </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
</div>
</body>