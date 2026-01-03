<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Giới thiệu - WP Store</title>
<style>
    .hero { background:#f8f9fa; padding:30px 0; }
    .hero .hero-img { width:100%; max-height:360px; object-fit:cover; border-radius:6px; }
    .feature { padding:24px 0; }
    .feature .icon { width:64px; height:64px; background:#fff; display:flex;align-items:center;justify-content:center;border-radius:8px;box-shadow:0 2px 6px rgba(0,0,0,0.06); }
    .news-card img { width:100%; height:140px; object-fit:cover; border-radius:4px; }
    .muted { color:#6c757d; }
</style>
</head>
<body>
<div class="container mt-4">
    <!-- Hero -->
    <section class="hero mb-4">
        <div class="row align-items-center">
            <div class="col-md-6">
                <h1>Gạo sạch Đồng Tháp - Hương vị quê hương</h1>
                <p class="muted">Chúng tôi tự hào mang đến những sản phẩm gạo chất lượng, từ đồng ruộng Đồng Tháp đến bữa cơm gia đình Việt.</p>
                <p>Gạo chúng tôi cung cấp được chọn lọc kỹ lưỡng, sấy và đóng gói theo tiêu chuẩn an toàn thực phẩm, giữ trọn hương vị đặc trưng vùng Đồng Tháp.</p>
                <p><a class="btn btn-primary" href="${pageContext.request.contextPath}/home">Khám phá sản phẩm</a>
                <a class="btn btn-outline-secondary" href="${pageContext.request.contextPath}/contact">Liên hệ</a></p>
            </div>
            <div class="col-md-6">
                <img src="${pageContext.request.contextPath}/static/placeholder-hero.jpg" alt="Gạo Đồng Tháp" class="hero-img shadow-sm">
            </div>
        </div>
    </section>

    <!-- Company intro -->
    <section class="feature mb-4">
        <div class="row">
            <div class="col-md-8">
                <h3>Về chúng tôi</h3>
                <p class="muted">Là doanh nghiệp địa phương của Đồng Tháp, chúng tôi kết nối người nông dân với người tiêu dùng, đảm bảo chuỗi cung ứng gạo minh bạch và bền vững. Từ chọn giống, canh tác, thu hoạch đến chế biến, mỗi công đoạn đều được kiểm soát để giữ lại giá trị dinh dưỡng và hương thơm tự nhiên của gạo.</p>
                <ul>
                    <li>Nguồn gốc rõ ràng: Hợp tác trực tiếp với nông dân Đồng Tháp.</li>
                    <li>Quy trình khép kín: Thu hoạch – Sấy – Làm sạch – Đóng gói.</li>
                    <li>Kiểm soát chất lượng: Kiểm nghiệm an toàn thực phẩm theo tiêu chuẩn.</li>
                </ul>
            </div>
            <div class="col-md-4">
                <h5>Điểm mạnh</h5>
                <div class="mb-2">
                    <strong>Hương thơm tự nhiên</strong>
                    <p class="muted small">Giữ trọn mùi thơm đặc trưng của gạo Đồng Tháp.</p>
                </div>
                <div class="mb-2">
                    <strong>Chất lượng ổn định</strong>
                    <p class="muted small">Quy trình kiểm soát nghiêm ngặt từ đồng ruộng.</p>
                </div>
                <div class="mb-2">
                    <strong>Giao hàng tận nơi</strong>
                    <p class="muted small">Hệ thống giao hàng nhanh, đóng gói bảo quản cẩn thận.</p>
                </div>
            </div>
        </div>
    </section>

    <hr style="border:0;height:1px;background:linear-gradient(90deg,transparent,#ddd,transparent);margin:32px 0;" />

    <!-- Products teaser -->
    <section class="mb-4">
        <div class="d-flex justify-content-between align-items-center mb-3">
            <h4>Sản phẩm tiêu biểu</h4>
            <a class="btn btn-sm btn-outline-primary" href="${pageContext.request.contextPath}/products/category">Xem tất cả sản phẩm</a>
        </div>
        <div class="row">
            <c:choose>
                <c:when test="${not empty products}">
                    <c:forEach var="p" items="${products}">
                        <div class="col-6 col-md-3 mb-3">
                            <div class="card h-100">
                                <c:choose>
                                    <c:when test="${not empty p.image}">
                                        <img src="${pageContext.request.contextPath}/${p.image}" class="card-img-top" alt="${p.name}" style="height:140px;object-fit:cover;"/>
                                    </c:when>
                                    <c:otherwise>
                                        <div style="height:140px;background:#f5f5f5;display:flex;align-items:center;justify-content:center;color:#999;">No image</div>
                                    </c:otherwise>
                                </c:choose>
                                <div class="card-body d-flex flex-column">
                                    <h6 class="card-title" style="min-height:2.5em;">${p.name}</h6>
                                    <p class="muted mb-2"><fmt:formatNumber value="${p.price}" pattern="#,##0"/> VNĐ</p>
                                    <a class="btn btn-outline-primary btn-sm mt-auto" href="${pageContext.request.contextPath}/product/detail?id=${p.id}">Xem chi tiết</a>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </c:when>
                <c:otherwise>
                    <div class="col-12"><p class="muted">Không có sản phẩm để hiển thị.</p></div>
                </c:otherwise>
            </c:choose>
        </div>
    </section>

    <hr style="border:0;height:1px;background:linear-gradient(90deg,transparent,#ddd,transparent);margin:32px 0;" />

    <!-- News from Đồng Tháp -->
    <section class="mb-4">
        <div class="d-flex justify-content-between align-items-center mb-3">
            <h4>Tin tức Đồng Tháp</h4>
            <a class="btn btn-sm btn-outline-primary" href="${pageContext.request.contextPath}/news">Xem tất cả tin</a>
        </div>
        <div class="row">
            <c:choose>
                <c:when test="${not empty newsList}">
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
                                    <p class="muted small mb-2">Ngày: <fmt:formatDate value="${n.createdate}" pattern="dd/MM/yyyy"/></p>
                                    <a class="mt-auto btn btn-outline-primary btn-sm" href="${pageContext.request.contextPath}/news/${n.id}">Xem chi tiết</a>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </c:when>
                <c:otherwise>
                    <div class="col-12"><p class="muted">Chưa có tin tức.</p></div>
                </c:otherwise>
            </c:choose>
        </div>
    </section>

</div>
</body>