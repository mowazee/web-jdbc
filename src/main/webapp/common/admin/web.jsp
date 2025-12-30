<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!doctype html>
<html lang="vi">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title><c:out value="${pageTitle != null ? pageTitle : 'Admin - Web Bán Gạo'}"/></title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@3.4.1/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">

    <style>
        /* Đảm bảo nội dung không bị dính sát vào mép màn hình */
        .main-content { padding: 20px 0; min-height: 500px; }
    </style>
</head>
<body>

    <%-- 1. Admin header --%>
    <jsp:include page="/common/admin/header.jsp" />

    <%-- 2. Main Body Content --%>
    <div class="container">
        <div class="row">
            <div class="col-sm-12 main-content">
                <c:choose>
                    <c:when test="${not empty body}">
                        <jsp:include page="${body}" />
                    </c:when>
                    <c:otherwise>
                        <div class="jumbotron">
                            <h3>Trang quản trị</h3>
                            <p>Chào mừng bạn đến với hệ thống quản lý bán gạo.</p>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </div>

    <%-- 3. Footer --%>
    <jsp:include page="/common/admin/footer.jsp" />

    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@3.4.1/dist/js/bootstrap.min.js"></script>
</body>
</html>