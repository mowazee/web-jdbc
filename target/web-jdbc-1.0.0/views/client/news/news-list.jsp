<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Tin tức</title>
</head>
<body>
<div class="container py-4">
    <div class="row">
        <div class="col-12">
            <h1 class="mb-4">Tin tức</h1>
        </div>
    </div>
    <div class="row">
        <c:forEach var="n" items="${newsList}">
            <div class="col-12 col-md-6 mb-4">
                <div class="card h-100">
                    <c:if test="${not empty n.thumbnail}">
                        <img src="${pageContext.request.contextPath}/${n.thumbnail}" class="card-img-top" alt="${n.title}" style="height:200px; object-fit:cover;"/>
                    </c:if>
                    <div class="card-body d-flex flex-column">
                        <h5 class="card-title">${n.title}</h5>
                        <p class="card-text text-muted">${n.preview}</p>
                        <div class="mt-auto">
                            <a href="${pageContext.request.contextPath}/news/${n.id}" class="btn btn-primary">Xem chi tiết</a>
                            <small class="text-muted ms-2"><fmt:formatDate value="${n.createdate}" pattern="dd/MM/yyyy"/></small>
                        </div>
                    </div>
                </div>
            </div>
        </c:forEach>
        <c:if test="${empty newsList}">
            <div class="col-12">
                <p>Chưa có tin tức.</p>
            </div>
        </c:if>
    </div>

    <!-- Pagination controls -->
    <c:if test="${totalPages != null && totalPages > 1}">
        <div class="row">
            <div class="col-12">
                <nav aria-label="Page navigation">
                    <ul class="pagination justify-content-center">
                        <c:set var="ctx" value="${pageContext.request.contextPath}" />
                        <c:set var="sizeParam" value="${pageSize}" />
                        <!-- Previous -->
                        <li class="page-item ${currentPage == 1 ? 'disabled' : ''}">
                            <a class="page-link" href="${ctx}/news?page=${currentPage - 1}&size=${sizeParam}" aria-label="Previous">
                                <span aria-hidden="true">&laquo;</span>
                            </a>
                        </li>
                        <!-- page numbers -->
                        <c:forEach var="i" begin="1" end="${totalPages}">
                            <li class="page-item ${i == currentPage ? 'active' : ''}">
                                <a class="page-link" href="${ctx}/news?page=${i}&size=${sizeParam}">${i}</a>
                            </li>
                        </c:forEach>
                        <!-- Next -->
                        <li class="page-item ${currentPage == totalPages ? 'disabled' : ''}">
                            <a class="page-link" href="${ctx}/news?page=${currentPage + 1}&size=${sizeParam}" aria-label="Next">
                                <span aria-hidden="true">&raquo;</span>
                            </a>
                        </li>
                    </ul>
                </nav>
            </div>
        </div>
    </c:if>
</div>
</body>
</html>