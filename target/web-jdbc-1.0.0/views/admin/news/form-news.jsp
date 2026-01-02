<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<head>
    <meta charset="UTF-8">
    <title>Form tin tức</title>

</head>
<body>
<div class="container mt-4" style="max-width:900px;">
    <h3>${news.id == 0 ? 'Tạo mới tin' : 'Chỉnh sửa tin'}</h3>

    <c:if test="${not empty requestScope.error}">
        <div class="alert alert-danger">${requestScope.error}</div>
    </c:if>

    <form action="<c:url value='/admin/news'/>" method="post" enctype="multipart/form-data">
        <input type="hidden" name="action" value="save"/>
        <input type="hidden" name="id" value="${news.id}"/>

        <div class="mb-3">
            <label for="title" class="form-label">Tiêu đề</label>
            <input type="text" class="form-control" id="title" name="title" value="${news.title}" required>
        </div>
        <div class="mb-3">
            <label for="summary" class="form-label">Tóm tắt</label>
            <textarea class="form-control" id="summary" name="summary" rows="3">${news.preview}</textarea>
        </div>
        <div class="mb-3">
            <label for="content" class="form-label">Nội dung</label>
            <textarea class="form-control" id="content" name="content" rows="8">${news.content}</textarea>
        </div>
        <div class="row">
            <div class="col-md-6">
                <div class="mb-3">
                    <label for="authorid" class="form-label">Author ID</label>
                    <input type="number" class="form-control" id="authorid" name="authorid" value="${news.authorid}">
                </div>
            </div>
            <div class="col-md-6">
                <div class="mb-3">
                    <label for="thumbnail" class="form-label">Thumbnail</label>
                    <input type="file" class="form-control" id="thumbnail" name="thumbnail" accept="image/*">
                    <c:if test="${not empty news.thumbnail}">
                        <div class="mt-2"><img src="${pageContext.request.contextPath}/${news.thumbnail}" alt="" style="max-height:120px;"/></div>
                    </c:if>
                </div>
            </div>
        </div>
        <div class="d-flex gap-2 mt-3">
            <button type="submit" class="btn btn-success">Lưu</button>
            <a href="<c:url value='/admin/news'/>" class="btn btn-secondary">Hủy</a>
        </div>
    </form>
</div>

</body>