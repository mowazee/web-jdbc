<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<div class="mb-4">
    <div id="homeCarousel" class="carousel slide carousel-fade shadow-sm rounded-3 overflow-hidden" data-bs-ride="carousel">
        <div class="carousel-indicators">
            <button type="button" data-bs-target="#homeCarousel" data-bs-slide-to="0" class="active" aria-current="true"></button>
            <button type="button" data-bs-target="#homeCarousel" data-bs-slide-to="1"></button>
            <button type="button" data-bs-target="#homeCarousel" data-bs-slide-to="2"></button>
        </div>

        <div class="carousel-inner">
            <div class="carousel-item active" data-bs-interval="5000">
                <div class="carousel-img-container">
                    <img src="<c:url value='/common/image/hero1.jpg'/>" class="d-block w-100" alt="Gạo đặc sản">
                </div>
                <div class="carousel-caption d-none d-md-block animated-caption">
                    <h5 class="fw-bold text-uppercase">Gạo ST24 - Hạt cơm dẻo, thơm tinh tế</h5>
                    <p class="small">Món quà đất trời cho bữa cơm gia đình.</p>
                    <a href="#" class="btn btn-warning btn-sm px-4 fw-bold shadow-sm">Mua ngay</a>
                </div>
            </div>

            <div class="carousel-item" data-bs-interval="5000">
                <div class="carousel-img-container">
                    <img src="<c:url value='/common/image/hero2.jpg'/>" class="d-block w-100" alt="Gạo quê hương">
                </div>
                <div class="carousel-caption d-none d-md-block animated-caption">
                    <h5 class="fw-bold text-uppercase">Gạo Tám Thơm - Hương vị truyền thống</h5>
                    <p class="small">Chắt lọc từ những cánh đồng trù phú.</p>
                    <a href="#" class="btn btn-warning btn-sm px-4 fw-bold shadow-sm">Xem chi tiết</a>
                </div>
            </div>

            <div class="carousel-item" data-bs-interval="5000">
                <div class="carousel-img-container">
                    <img src="<c:url value='/common/image/hero3.jpg'/>" class="d-block w-100" alt="Combo quà tặng">
                </div>
                <div class="carousel-caption d-none d-md-block animated-caption">
                    <h5 class="fw-bold text-uppercase">Combo Quà Tặng - Sang trọng, ý nghĩa</h5>
                    <p class="small">Lựa chọn hoàn hảo cho dịp lễ và biếu tặng.</p>
                    <a href="#" class="btn btn-warning btn-sm px-4 fw-bold shadow-sm">Khám phá</a>
                </div>
            </div>
        </div>

        <button class="carousel-control-prev" type="button" data-bs-target="#homeCarousel" data-bs-slide="prev">
            <span class="carousel-control-prev-icon p-3 bg-dark bg-opacity-25 rounded-circle" aria-hidden="true"></span>
            <span class="visually-hidden">Previous</span>
        </button>
        <button class="carousel-control-next" type="button" data-bs-target="#homeCarousel" data-bs-slide="next">
            <span class="carousel-control-next-icon p-3 bg-dark bg-opacity-25 rounded-circle" aria-hidden="true"></span>
            <span class="visually-hidden">Next</span>
        </button>
    </div>
</div>

<style>
    /* CSS hỗ trợ đồng bộ với thiết kế client.jsp */
    .carousel-img-container {
        height: 400px;
        width: 100%;
        overflow: hidden;
    }
    
    .carousel-img-container img {
        height: 100%;
        width: 100%;
        object-fit: cover; /* Giữ tỉ lệ ảnh như bạn muốn */
        transition: transform 10s linear;
    }

    /* Hiệu ứng zoom nhẹ khi slide đang active */
    .carousel-item.active .carousel-img-container img {
        transform: scale(1.1);
    }

    /* Hiệu ứng chữ hiện ra mượt mà */
    .animated-caption {
        background: rgba(0, 0, 0, 0.4); /* Làm tối nền để chữ rõ hơn */
        border-radius: 15px;
        padding: 20px;
        bottom: 20%;
        backdrop-filter: blur(5px); /* Hiệu ứng kính mờ hiện đại */
        animation: fadeInUp 0.8s ease-out;
    }

    @keyframes fadeInUp {
        from { opacity: 0; transform: translateY(20px); }
        to { opacity: 1; transform: translateY(0); }
    }
</style>