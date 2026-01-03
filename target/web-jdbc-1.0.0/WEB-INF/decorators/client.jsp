<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="HT Store - Hệ thống bán lẻ gạo sạch"/>
    <meta name="author" content="Han Trinh"/>

    <title><sitemesh:write property="title"/> - WP Store</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" />
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/static/client/css/basic.css">
    
<style>

</style>
    
    <sitemesh:write property="head"/>
</head>
<body>
<div class="wrapper">

    <!-- flash messages for purchase form -->
    <div style="position:fixed; top:16px; right:16px; z-index:20000;">
        <c:if test="${not empty sessionScope.purchaseSuccess}">
            <div class="alert alert-success alert-dismissible fade show" role="alert">
                ${sessionScope.purchaseSuccess}
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
            <c:remove var="purchaseSuccess" scope="session" />
        </c:if>
        <c:if test="${not empty sessionScope.purchaseError}">
            <div class="alert alert-danger alert-dismissible fade show" role="alert">
                ${sessionScope.purchaseError}
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
            <c:remove var="purchaseError" scope="session" />
        </c:if>
    </div>

    <header>
        <div class="header-main border-bottom py-3">
            <%@ include file="/common/client/header.jsp" %>
        </div>
        <div class="navbar-bar navbar-expand-lg navbar-container mx-auto px-3 px-lg-2">
            <%@ include file="/common/client/navbar.jsp" %>
        </div>
    </header>

    <main class="container py-1">
		    <div class="row justify-content-center">
		        <div class="py-2" style="width: 100%;">
		        	<c:if test="${not empty hideSlidebar ? !hideSlidebar : true}">
		        	    <jsp:include page="/common/client/slidebar.jsp" />
		        	</c:if>
		        	</div>
		    </div>
        <div class="row justify-content-center mb-4">
            <div class="content-card p-4 shadow-sm rounded-3" style="width: 100%;">
                    <sitemesh:write property="body"/>
            </div>
        </div>
    </main>

    <footer class="mt-auto">
        <div class="container py-1">
            <%@ include file="/common/client/footer.jsp" %>
        </div>
        <div class="footer-bottom text-center">
            <div class="container">
                <p class="mb-0 text-dark">&copy; 2026 WP Store - Bản quyền thuộc về Web Bán Hàng!</p>
            </div>
        </div>
    </footer>

</div>

<div class="contact-group-fixed">
    <div class="purchase-popup-wrapper">
        <button class="btn-contact-item btn-purchase-toggle" onclick="togglePurchaseForm()">
            <i class="fa-solid fa-cart-shopping"></i>
            <span class="badge-text">Mua hàng</span>
        </button>

        <div id="purchaseFormPopup" class="purchase-form-card">
            <div class="form-header">
                <span><i class="fa-solid fa-paper-plane me-2"></i>Đăng ký mua hàng</span>
                <button type="button" class="btn-close-form" onclick="togglePurchaseForm()">&times;</button>
            </div>
            <form id="orderForm" action="${pageContext.request.contextPath}/purchase-register" method="post" class="form-body">
                <div class="input-group-custom">
                    <i class="fa-solid fa-user"></i>
                    <input type="text" name="customerName" placeholder="Họ và tên *" required>
                </div>
                <div class="input-group-custom">
                    <i class="fa-solid fa-phone"></i>
                    <input type="tel" name="customerPhone" placeholder="Số điện thoại *" required>
                </div>
                <div class="input-group-custom">
                    <i class="fa-solid fa-pen-to-square"></i>
                    <input type="text" name="productInterest" placeholder="Sản phẩm quan tâm *" required>
                </div>
                <div class="input-group-custom">
                    <i class="fa-solid fa-location-dot"></i>
                    <textarea name="address" rows="2" placeholder="Địa chỉ giao hàng *" required></textarea>
                </div>
                <button type="submit" class="btn-submit-order">GỬI YÊU CẦU NGAY</button>
            </form>
        </div>
    </div>

    <a href="https://zalo.me/0911539809" target="_blank" class="btn-contact-item btn-zalo">
        <img src="https://upload.wikimedia.org/wikipedia/commons/9/91/Icon_of_Zalo.svg" alt="Zalo">
        <span class="badge-text">Zalo</span>
    </a>

    <a href="tel:0911539809" class="btn-contact-item btn-call">
        <i class="fa-solid fa-phone"></i>
        <span class="badge-text">Gọi điện</span>
    </a>
</div>

<script>
    function togglePurchaseForm() {
        const form = document.getElementById('purchaseFormPopup');
        form.style.display = (form.style.display === 'block') ? 'none' : 'block';
    }
</script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>