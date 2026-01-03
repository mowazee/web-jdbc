<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>${news.title}</title>
</head>
<body>
<div class="container py-4">
    <div class="row">
        <div class="col-12">
            <h1>${news.title}</h1>
            <p class="text-muted"><fmt:formatDate value="${news.createdate}" pattern="dd/MM/yyyy"/></p>
            <c:if test="${not empty news.thumbnail}">
                <img src="${pageContext.request.contextPath}/${news.thumbnail}" alt="${news.title}" style="width:100%; max-height:400px; object-fit:cover;"/>
            </c:if>
            <div class="mt-3">
                <p>${news.content}</p>
            </div>
            <a href="${pageContext.request.contextPath}/news" class="btn btn-outline-secondary mt-3">Quay lại danh sách</a>
        </div>
    </div>
</div>
</body>
</html>