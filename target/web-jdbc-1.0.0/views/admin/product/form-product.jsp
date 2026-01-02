<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<head>
    <meta charset="UTF-8">
    <title>Form sản phẩm</title>
</head>
<body>
<div class="container mt-4" style="max-width:900px;">
    <h3>${product.id == 0 ? 'Tạo mới sản phẩm' : 'Chỉnh sửa sản phẩm'}</h3>

    <c:if test="${not empty requestScope.error}">
        <div class="alert alert-danger">${requestScope.error}</div>
    </c:if>

    <form action="<c:url value='/admin/product'/>" method="post" enctype="multipart/form-data">
        <input type="hidden" name="action" value="${product.id == 0 ? 'create' : 'update'}"/>
        <input type="hidden" name="id" value="${product.id}"/>

        <div class="row">
            <div class="col-md-8">
                <div class="mb-3">
                    <label for="name" class="form-label">Tên sản phẩm</label>
                    <input type="text" class="form-control" id="name" name="name" value="${product.name}" required>
                </div>
                <div class="mb-3">
                    <label for="description" class="form-label">Mô tả</label>
                    <textarea class="form-control" id="description" name="description" rows="6">${product.description}</textarea>
                </div>
            </div>
            <div class="col-md-4">
                <div class="mb-3">
                    <label for="price" class="form-label">Giá</label>
                    <input type="number" step="0.01" class="form-control" id="price" name="price" value="${product.price}">
                </div>
                <div class="mb-3">
                    <label for="quantity" class="form-label">Số lượng</label>
                    <input type="number" class="form-control" id="quantity" name="quantity" value="${product.quantity}">
                </div>
                <div class="mb-3">
                    <label for="cateid" class="form-label">Danh mục</label>
                    <select id="cateid" name="cateid" class="form-select">
                        <option value="0">Chọn danh mục</option>
                        <c:forEach var="c" items="${categories}">
                            <option value="${c.cateid}" ${c.cateid == product.cateid ? 'selected' : ''}>${c.catename}</option>
                        </c:forEach>
                    </select>
                </div>
                <div class="mb-3">
                    <label for="image" class="form-label">Ảnh sản phẩm</label>
                    <input type="file" class="form-control" id="image" name="image" accept="image/*">
                    <c:if test="${not empty product.image}">
                        <div class="mt-2"><img src="${pageContext.request.contextPath}/${product.image}" alt="" style="max-height:120px;"/></div>
                    </c:if>
                </div>
            </div>
        </div>

        <div class="d-flex gap-2 mt-3">
            <button type="submit" class="btn btn-success">Lưu</button>
            <a href="<c:url value='/admin/product'/>" class="btn btn-secondary">Hủy</a>
        </div>
    </form>
</div>

</body>