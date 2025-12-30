<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Form danh mục</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<div class="container mt-4" style="max-width:720px;">
    <h3>${category.cateid == 0 ? 'Tạo mới danh mục' : 'Chỉnh sửa danh mục'}</h3>

    <c:if test="${not empty requestScope.error}">
        <div class="alert alert-danger">${requestScope.error}</div>
    </c:if>

    <form action="<c:url value='/admin/category'/>" method="post" enctype="multipart/form-data">
        <!-- submit action: create (new) or update (existing) -->
        <input type="hidden" name="action" value="${category.cateid == 0 ? 'create' : 'update'}"/>
        <input type="hidden" name="id" value="${category.cateid}"/>

        <div class="mb-3">
            <label for="catename" class="form-label">Tên danh mục</label>
            <input type="text" class="form-control" id="catename" name="catename" value="${category.catename}" required>
        </div>

        <div class="mb-3">
            <label for="iconFile" class="form-label">Icon (ảnh - tùy chọn)</label>
            <input type="file" class="form-control" id="iconFile" name="icon" accept="image/*">
            <div class="form-text">Bạn có thể upload một ảnh (jpg/png/gif).</div>
            <c:if test="${not empty category.icon}">
                <div class="mt-2">
                    <img src="${pageContext.request.contextPath}/image/${category.icon}" alt="icon-preview" style="max-height:120px;">
                </div>
            </c:if>
        </div>

<!--         <div class="mb-3"> -->
<!--             <label for="icon" class="form-label">Icon (tên class hoặc URL, tùy chọn)</label> -->
<%--             <input type="text" class="form-control" id="icon" name="icon" value="${category.icon}"> --%>
<!--         </div> -->

        <div class="mb-3">
            <label for="description" class="form-label">Mô tả</label>
            <textarea class="form-control" id="description" name="description" rows="4">${category.description}</textarea>
        </div>

        <div class="d-flex gap-2">
            <button type="submit" class="btn btn-success">Lưu</button>
            <a href="<c:url value='/admin/category'/>" class="btn btn-secondary">Hủy</a>
        </div>
    </form>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>