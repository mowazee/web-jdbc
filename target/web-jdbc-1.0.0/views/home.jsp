<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>WP Store - Trang chủ</title>
    <style>
        .hero-img { width:100%; max-width:500px; height:320px; object-fit:cover; }
        .product-card img { width:100%; height:180px; object-fit:cover; }
        .news-card img { width:100%; height:140px; object-fit:cover; }
        /* Section separator with subtle gradient/shadow effect */
        .section-sep {
            height:4px;
            border:0;
            margin:1.75rem 0;
            background: linear-gradient(90deg, rgba(0,0,0,0.05), rgba(13,110,253,0.25), rgba(0,0,0,0.05));
            box-shadow: 0 2px 6px rgba(13,110,253,0.03);
            border-radius:4px;
        }
        /* Partners row */
        .partners-row { display:flex; gap:16px; justify-content:center; align-items:center; flex-wrap:wrap; }
        .partner-item { width:250px; height:150px; background:#f5f5f5; display:flex; align-items:center; justify-content:center; overflow:hidden; border-radius:6px; }
        .partner-item img { width:100%; height:100%; object-fit:cover; }
    </style>
</head>
<body>
<div class="container mt-4">

    <!-- Block 1: Intro (image left, text right) -->
    <div class="row align-items-center mb-5">
        <div class="col-md-6">
            <img src="${pageContext.request.contextPath}/static/placeholder-hero.jpg" alt="Hero" class="hero-img rounded shadow-sm">
        </div>
        <div class="col-md-6">
            <h2>Giới thiệu về doanh nghiệp</h2>
            <p class="text-muted">Chúng tôi cung cấp các loại gạo chất lượng cao, an toàn và thơm ngon. Với nhiều năm kinh nghiệm trong ngành, chúng tôi cam kết mang đến khách hàng sản phẩm tốt nhất và dịch vụ chu đáo.</p>
            <p>Đội ngũ của chúng tôi luôn tận tâm chọn lựa nguồn gạo, kiểm tra chất lượng và đóng gói cẩn thận để bảo đảm sự hài lòng của khách hàng.</p>
            <a href="${pageContext.request.contextPath}/about" class="btn btn-primary">Xem chi tiết</a>
        </div>
    </div>

    <hr class="section-sep" />

    <!-- Block 2: Featured products (4 items) -->
    <div class="row mb-4">
        <div class="col-12 d-flex justify-content-between align-items-center mb-3">
            <h4>Sản phẩm nổi bật</h4>
            <a href="${pageContext.request.contextPath}/products/category" class="btn btn-outline-primary btn-sm">Xem tất cả</a>
        </div>

        <c:if test="${not empty products}">
            <c:forEach var="p" items="${products}">
                <div class="col-6 col-md-3 mb-3">
                    <div class="card h-100 shadow-sm">
                        <c:choose>
                            <c:when test="${not empty p.image}">
                                <img src="${pageContext.request.contextPath}/${p.image}" class="card-img-top" alt="${p.name}" style="height:160px;object-fit:cover;"/>
                            </c:when>
                            <c:otherwise>
                                <div style="height:160px;background:#f5f5f5;display:flex;align-items:center;justify-content:center;color:#999;">No image</div>
                            </c:otherwise>
                        </c:choose>
                        <div class="card-body d-flex flex-column">
                            <h6 class="card-title mb-2" style="min-height:3em;">${p.name}</h6>
                            <div class="mt-auto d-flex justify-content-between align-items-center">
                                <div class="fw-bold text-primary"><fmt:formatNumber value="${p.price}" pattern="#,##0"/> VNĐ</div>
                                <a class="btn btn-outline-primary btn-sm" href="${pageContext.request.contextPath}/product/detail?id=${p.id}">Xem</a>
                            </div>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </c:if>
        <c:if test="${empty products}">
            <div class="col-12">
                <div class="alert alert-info">Chưa có sản phẩm để hiển thị.</div>
            </div>
        </c:if>
    </div>

    <hr class="section-sep" />

    <!-- Block 3: News (3 items) -->
    <div class="row mb-5">
        <div class="col-12 d-flex justify-content-between align-items-center mb-3">
            <h4>Tin tức mới</h4>
            <a href="${pageContext.request.contextPath}/news" class="btn btn-outline-primary btn-sm">Xem tất cả</a>
        </div>

        <c:if test="${not empty newsList}">
            <c:forEach var="n" items="${newsList}">
                <div class="col-md-4 mb-3">
                    <div class="card h-100">
                        <c:choose>
                            <c:when test="${not empty n.thumbnail}">
                                <img src="${pageContext.request.contextPath}/${n.thumbnail}" class="card-img-top news-card" alt="${n.title}"/>
                            </c:when>
                            <c:when test="${not empty n.image}">
                                <img src="${pageContext.request.contextPath}/${n.image}" class="card-img-top news-card" alt="${n.title}"/>
                            </c:when>
                            <c:otherwise>
                                <div style="height:140px;background:#f5f5f5;display:flex;align-items:center;justify-content:center;color:#999;">No image</div>
                            </c:otherwise>
                        </c:choose>
                        <div class="card-body d-flex flex-column">
                            <h6 class="card-title mb-2">${n.title}</h6>
                            <p class="text-muted small mb-2">Ngày: <fmt:formatDate value="${n.createdate}" pattern="dd/MM/yyyy"/></p>
                            <a class="mt-auto btn btn-outline-primary btn-sm" href="${pageContext.request.contextPath}/news/${n.id}">Xem chi tiết</a>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </c:if>
        <c:if test="${empty newsList}">
            <div class="col-12">
                <div class="alert alert-info">Chưa có tin tức để hiển thị.</div>
            </div>
        </c:if>
    </div>

    <hr class="section-sep" />

    <!-- Block 4: Partners / Sponsors strip -->
    <div class="row mb-5">
        <div class="col-12 text-center mb-3">
            <h5 class="fw-bold">ĐỒNG HÀNH CÙNG CHÚNG TÔI</h5>
            <p class="text-muted">Các đối tác và nhà cung cấp tiêu biểu</p>
        </div>
        <div class="col-12">
            <div class="partners-row">
                <div class="partner-item"><img src="${pageContext.request.contextPath}/static/placeholder-250x150.png" alt="partner-1"></div>
                <div class="partner-item"><img src="${pageContext.request.contextPath}/static/placeholder-250x150.png" alt="partner-2"></div>
                <div class="partner-item"><img src="${pageContext.request.contextPath}/static/placeholder-250x150.png" alt="partner-3"></div>
                <div class="partner-item"><img src="${pageContext.request.contextPath}/static/placeholder-250x150.png" alt="partner-4"></div>
                <div class="partner-item"><img src="${pageContext.request.contextPath}/static/placeholder-250x150.png" alt="partner-5"></div>
            </div>
        </div>
    </div>

</div>
</body>