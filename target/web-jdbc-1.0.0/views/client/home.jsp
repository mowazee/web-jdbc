<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>HT Store - Trang chủ</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        .hero {
            background: linear-gradient(90deg, rgba(165,94,234,0.12), rgba(255,121,198,0.08)), url('https://images.unsplash.com/photo-1542291026-7eec264c27ff?q=80&w=1400&auto=format&fit=crop&ixlib=rb-4.0.3&s=') center/cover no-repeat;
            border-radius: 12px;
            padding: 48px;
            margin-bottom: 32px;
            color: #222;
        }
        .hero h1 { font-weight: 800; letter-spacing: -1px; }
        .product-card img { height:160px; object-fit:cover; border-top-left-radius: .5rem; border-top-right-radius: .5rem; }
        .news-item { border-left:4px solid #a55eea; padding-left:12px; margin-bottom:14px; }
    </style>
</head>
<body>
<div class="container py-4">
    <div class="hero d-flex align-items-center justify-content-between">
        <div class="hero-text">
            <h1>Chào mừng đến HT Store</h1>
            <p class="lead">Sản phẩm chất lượng — Giá tốt — Giao nhanh toàn quốc.</p>
            <p><a href="${pageContext.request.contextPath}/products" class="btn btn-lg btn-primary me-2">Khám phá sản phẩm</a>
            <a href="${pageContext.request.contextPath}/news" class="btn btn-outline-primary">Xem tin tức</a></p>
        </div>
        <div class="hero-image d-none d-md-block" style="width:360px;">
            <img src="https://images.unsplash.com/photo-1603791440384-56cd371ee9a7?q=80&w=720&auto=format&fit=crop&ixlib=rb-4.0.3&s=" alt="hero" class="img-fluid rounded-3" />
        </div>
    </div>

    <div class="row mb-4">
        <div class="col-md-8">
            <div class="d-flex align-items-center justify-content-between mb-3">
                <h4 class="mb-0">Sản phẩm nổi bật</h4>
                <a href="${pageContext.request.contextPath}/products" class="small">Xem tất cả</a>
            </div>
            <div class="row g-3">
                <c:choose>
                    <c:when test="${not empty products}">
                        <c:forEach var="p" items="${products}" varStatus="st">
                            <div class="col-6 col-sm-4 col-md-3">
                                <div class="card product-card shadow-sm h-100">
                                    <img src="${p.imageUrl != null ? p.imageUrl : 'https://via.placeholder.com/400x300?text=Product'}" class="card-img-top" alt="${p.name}" />
                                    <div class="card-body d-flex flex-column">
                                        <h6 class="card-title mb-1">${p.name}</h6>
                                        <p class="card-text text-danger fw-bold mb-2"><fmt:formatNumber value="${p.price}" pattern="#"/> VNĐ</p>
                                        <div class="mt-auto d-flex justify-content-between align-items-center">
                                            <a href="${pageContext.request.contextPath}/product/detail?id=${p.id}" class="btn btn-outline-primary btn-sm">Xem</a>
                                            <form action="${pageContext.request.contextPath}/cart/add" method="get" class="m-0">
                                                <input type="hidden" name="id" value="${p.id}">
                                                <button class="btn btn-primary btn-sm">Mua</button>
                                            </form>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <!-- static sample products -->
                        <div class="col-6 col-sm-4 col-md-3">
                            <div class="card product-card shadow-sm h-100">
                                <img src="https://images.unsplash.com/photo-1528825871115-3581a5387919?q=80&w=720&auto=format&fit=crop&ixlib=rb-4.0.3&s=" class="card-img-top" alt="Bộ ly sứ đẹp" />
                                <div class="card-body d-flex flex-column">
                                    <h6 class="card-title mb-1">Bộ ly sứ đẹp</h6>
                                    <p class="card-text text-danger fw-bold mb-2">199.000 VNĐ</p>
                                    <div class="mt-auto d-flex justify-content-between align-items-center">
                                        <a href="#" class="btn btn-outline-primary btn-sm">Xem</a>
                                        <a href="#" class="btn btn-primary btn-sm">Mua</a>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-6 col-sm-4 col-md-3">
                            <div class="card product-card shadow-sm h-100">
                                <img src="https://images.unsplash.com/photo-1542293787938-c9e299b8809a?q=80&w=720&auto=format&fit=crop&ixlib=rb-4.0.3&s=" class="card-img-top" alt="Túi vải thời trang" />
                                <div class="card-body d-flex flex-column">
                                    <h6 class="card-title mb-1">Túi vải thời trang</h6>
                                    <p class="card-text text-danger fw-bold mb-2">249.000 VNĐ</p>
                                    <div class="mt-auto d-flex justify-content-between align-items-center">
                                        <a href="#" class="btn btn-outline-primary btn-sm">Xem</a>
                                        <a href="#" class="btn btn-primary btn-sm">Mua</a>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-6 col-sm-4 col-md-3">
                            <div class="card product-card shadow-sm h-100">
                                <img src="https://images.unsplash.com/photo-1524758631624-e2822e304c36?q=80&w=720&auto=format&fit=crop&ixlib=rb-4.0.3&s=" class="card-img-top" alt="Đèn để bàn hiện đại" />
                                <div class="card-body d-flex flex-column">
                                    <h6 class="card-title mb-1">Đèn để bàn hiện đại</h6>
                                    <p class="card-text text-danger fw-bold mb-2">399.000 VNĐ</p>
                                    <div class="mt-auto d-flex justify-content-between align-items-center">
                                        <a href="#" class="btn btn-outline-primary btn-sm">Xem</a>
                                        <a href="#" class="btn btn-primary btn-sm">Mua</a>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
        <div class="col-md-4">
            <div class="mb-3">
                <h5>Tin tức mới</h5>
            </div>
            <div class="mb-3">
                <c:choose>
                    <c:when test="${not empty news}">
                        <c:forEach var="n" items="${news}">
                            <div class="news-item">
                                <a href="${pageContext.request.contextPath}/news/detail?id=${n.id}"><strong>${n.title}</strong></a>
                                <p class="mb-0 small text-muted">${n.publishedDate}</p>
                            </div>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <div class="news-item">
                            <a href="#"><strong>Ra mắt chương trình giảm giá tháng 1</strong></a>
                            <p class="mb-0 small text-muted">02/01/2026</p>
                        </div>
                        <div class="news-item">
                            <a href="#"><strong>Hướng dẫn bảo quản sản phẩm</strong></a>
                            <p class="mb-0 small text-muted">28/12/2025</p>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
            <div class="card p-3">
                <h6>Đăng ký nhận tin</h6>
                <form action="${pageContext.request.contextPath}/subscribe" method="post">
                    <div class="mb-2">
                        <input type="email" name="email" class="form-control form-control-sm" placeholder="Email của bạn" required>
                    </div>
                    <button class="btn btn-sm btn-primary">Đăng ký</button>
                </form>
            </div>
        </div>
    </div>

    <hr />
</div>
</body>
