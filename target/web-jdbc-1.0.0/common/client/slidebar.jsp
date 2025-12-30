<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!-- Hero carousel fragment (do not include <html>/<head> here) -->
<div class="container mt-4">
    <div id="homeCarousel" class="carousel slide" data-bs-ride="carousel">
        <div class="carousel-indicators">
            <button type="button" data-bs-target="#homeCarousel" data-bs-slide-to="0" class="active" aria-current="true" aria-label="Slide 1"></button>
            <button type="button" data-bs-target="#homeCarousel" data-bs-slide-to="1" aria-label="Slide 2"></button>
            <button type="button" data-bs-target="#homeCarousel" data-bs-slide-to="2" aria-label="Slide 3"></button>
        </div>
        <div class="carousel-inner rounded">
            <div class="carousel-item active">
                <img src="<c:url value='/common/image/hero1.jpg'/>" class="d-block w-100" alt="Gạo đặc sản" style="max-height:400px; object-fit:cover;">
                <div class="carousel-caption d-none d-md-block">
                    <h5>Gạo ST24 - Hạt cơm dẻo, thơm tinh tế</h5>
                    <p>Món quà đất trời cho bữa cơm gia đình.</p>
                </div>
            </div>
            <div class="carousel-item">
                <img src="<c:url value='/common/image/hero2.jpg'/>" class="d-block w-100" alt="Gạo quê hương" style="max-height:400px; object-fit:cover;">
                <div class="carousel-caption d-none d-md-block">
                    <h5>Gạo Tám Thơm - Hương vị truyền thống</h5>
                    <p>Chắt lọc từ những cánh đồng trù phú.</p>
                </div>
            </div>
            <div class="carousel-item">
                <img src="<c:url value='/common/image/hero3.jpg'/>" class="d-block w-100" alt="Combo quà tặng" style="max-height:400px; object-fit:cover;">
                <div class="carousel-caption d-none d-md-block">
                    <h5>Combo Quà Tặng - Sang trọng, ý nghĩa</h5>
                    <p>Lựa chọn hoàn hảo cho dịp lễ và biếu tặng.</p>
                </div>
            </div>
        </div>
        <button class="carousel-control-prev" type="button" data-bs-target="#homeCarousel" data-bs-slide="prev">
            <span class="carousel-control-prev-icon" aria-hidden="true"></span>
            <span class="visually-hidden">Previous</span>
        </button>
        <button class="carousel-control-next" type="button" data-bs-target="#homeCarousel" data-bs-slide="next">
            <span class="carousel-control-next-icon" aria-hidden="true"></span>
            <span class="visually-hidden">Next</span>
        </button>
    </div>
</div>