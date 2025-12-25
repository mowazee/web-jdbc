<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!doctype html>
<html lang="vi">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title><c:out value="${pageTitle != null ? pageTitle : 'Web Bán Gạo Đặc Sản'}"/></title>

    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="" crossorigin="anonymous">
    <!-- Font Awesome -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">

    <style>
        /* Small site-specific styles */
        body { padding-top: 0; }
        .product-card img { width:100%; height:180px; object-fit:cover; }
    </style>
</head>
<body>

    <%-- Top user actions + main navbar (includes client/header.jsp) --%>
    <jsp:include page="/common/client/header.jsp" />

    <%-- Category navbar --%>
    <jsp:include page="/common/client/navbar.jsp" />

    <%-- Optional hero/slider on homepage (include if attribute showHero is true) --%>
    <c:if test="${showHero == true}">
        <jsp:include page="/common/client/slidebar.jsp" />
    </c:if>

    <main class="container my-4">
        <%-- Content JSP to include is passed via request attribute 'body' --%>
        <c:choose>
            <c:when test="${not empty body}">
                <jsp:include page="${body}" />
            </c:when>
            <c:otherwise>
                <h2>Chào mừng tới cửa hàng Gạo Đặc Sản</h2>
                <p>Vui lòng chọn sản phẩm từ menu.</p>
            </c:otherwise>
        </c:choose>
    </main>

    <%-- Footer --%>
    <jsp:include page="/common/client/footer.jsp" />

    <!-- Bootstrap JS Bundle (includes Popper) -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js" integrity="" crossorigin="anonymous"></script>
</body>
</html>
