<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!doctype html>
<html lang="vi">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title><c:out value="${pageTitle != null ? pageTitle : 'Admin - Web Bán Gạo'}"/></title>

    <!-- Bootstrap 3/4 styles may be used in admin area; include compatible CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@3.4.1/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">

    <style>
        .sidenav { background-color:#f5f5f5; padding:15px; min-height:400px; }
    </style>
</head>
<body>

    <%-- Admin header/nav --%>
    <jsp:include page="/common/admin/header.jsp" />

    <div class="container-fluid">
        <div class="row">
            <div class="col-sm-3">
                <jsp:include page="/common/admin/left.jsp" />
            </div>

            <div class="col-sm-9 main">
                <%-- Content JSP passed via request attribute 'body' --%>
                <c:choose>
                    <c:when test="${not empty body}">
                        <jsp:include page="${body}" />
                    </c:when>
                    <c:otherwise>
                        <h3>Trang quản trị</h3>
                        <p>Chọn mục để quản lý.</p>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </div>

    <jsp:include page="/common/admin/footer.jsp" />

    <!-- jQuery + Bootstrap JS -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@3.4.1/dist/js/bootstrap.min.js"></script>
</body>
</html>
