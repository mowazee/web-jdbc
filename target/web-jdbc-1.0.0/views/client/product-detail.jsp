<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>${product.name}</title>
</head>
<body>
<div class="container py-4">
    <div class="row g-4">
        <div class="col-12 col-md-5">
            <c:choose>
                <c:when test="${not empty product.image}">
                    <img src="${pageContext.request.contextPath}/${product.image}" alt="${product.name}" style="width:100%; object-fit:cover; max-height:480px;"/>
                </c:when>
                <c:otherwise>
                    <div style="height:360px; background:#f5f5f5; display:flex; align-items:center; justify-content:center; color:#999;">No image</div>
                </c:otherwise>
            </c:choose>
        </div>
        <div class="col-12 col-md-7">
            <h2>${product.name}</h2>
            <div class="mb-3"><strong>Giá:</strong> <span class="text-primary fw-bold"><fmt:formatNumber value="${product.price}" pattern="#,##0"/> VNĐ</span></div>
            <div class="mb-3"><strong>Số lượng:</strong> ${product.quantity}</div>
            <div class="mb-3"><strong>Danh mục:</strong> ${product.cateid}</div>
            <div class="mb-3"><strong>Mô tả:</strong>
                <p class="text-muted">${product.description}</p>
            </div>
            <div>
                <button id="btnAddToCart" class="btn btn-primary">Thêm vào giỏ</button>
                <a class="btn btn-outline-secondary ms-2" href="${pageContext.request.contextPath}/products">Tiếp tục mua sắm</a>
            </div>
        </div>
    </div>
</div>
<script>
document.getElementById('btnAddToCart').addEventListener('click', function(){
    const url = '${pageContext.request.contextPath}/cart/add?id=${product.id}';
    fetch(url, {headers: {'X-Requested-With': 'XMLHttpRequest'}})
        .then(res => {
            if (res.status === 401) {
                // not logged in -> redirect to login
                window.location = '${pageContext.request.contextPath}/login';
                return null;
            }
            return res.json();
        })
        .then(data => {
            if (!data) return; // handled redirect
            if (data.error) {
                alert(data.error);
                return;
            }
            // update badge if present
            const badge = document.getElementById('cart-badge');
            if (badge) badge.textContent = data.totalQuantity;
            alert('Đã thêm vào giỏ (Tổng: ' + data.totalQuantity + ' sản phẩm).');
        }).catch(err => {
            console.error(err);
            alert('Lỗi khi thêm vào giỏ hàng');
        });
});
</script>
</body>
</html>