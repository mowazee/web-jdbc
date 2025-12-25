<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>  

<%-- 
  QUAN TRỌNG: File decorator (web.jsp) phải nhúng Bootstrap 5 CSS và JS 
  và Font Awesome để các class dưới đây hoạt động chính xác!
--%>

<div class="bg-light border-bottom py-2">
    <div class="container d-flex justify-content-end">
        <ul class="list-unstyled d-flex align-items-center m-0">
            <c:choose>
                <c:when test="${sessionScope.currentUser == null}">
                    <li class="me-3">
                        <a href="<c:url value='/login'/>" class="text-decoration-none text-secondary small">
                            <i class="fas fa-sign-in-alt"></i> Đăng nhập
                        </a>
                    </li>
                    <li class="me-3">
                        <a href="<c:url value='/register'/>" class="text-decoration-none text-secondary small">
                            <i class="fas fa-user-plus"></i> Đăng ký
                        </a>
                    </li>
                </c:when>
                <c:otherwise>
                    <li class="me-3">
                        <a href="<c:url value='/member/myaccount'/>" class="text-decoration-none text-primary small fw-bold">
                            <i class="fas fa-user-circle"></i> Xin chào, ${sessionScope.currentUser.fullName}
                        </a>
                    </li>
                    <li>
                        <a href="<c:url value='/logout'/>" class="text-decoration-none text-secondary small">
                            <i class="fas fa-sign-out-alt"></i> Đăng Xuất
                        </a>
                    </li>
                </c:otherwise>
            </c:choose>
            
            <%-- Nút tìm kiếm --%>
            <li class="ms-3"><a href="#" class="text-secondary"><i class="fas fa-search"></i></a></li>
        </ul>
    </div>
</div>

<nav class="navbar navbar-expand-lg navbar-light bg-white shadow-sm py-3">
    <div class="container">
        
        <a class="navbar-brand fw-bolder fs-4 text-dark" href="<c:url value='/'/>">
            <i class="fas fa-store text-primary"></i> Web Bán Hàng
        </a>
        
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#mainNavbar" 
                aria-controls="mainNavbar" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        
        <div class="collapse navbar-collapse" id="mainNavbar">
            <ul class="navbar-nav ms-auto mb-2 mb-lg-0">
                <li class="nav-item">
                    <a class="nav-link active fw-bold text-dark" aria-current="page" href="<c:url value='/'/>">Trang Chủ</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link text-dark" href="<c:url value='/products'/>">Sản phẩm</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link text-dark" href="#">Giới Thiệu</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link text-dark" href="#">Dịch Vụ</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link text-dark" href="#">Liên Hệ</a>
                </li>
                
                <%-- Nút Giỏ hàng nổi bật: Giữ lại màu primary để làm nổi bật hành động chính --%>
                <li class="nav-item ms-lg-3">
                    <a class="btn btn-primary" href="<c:url value='/cart'/>">
                        <i class="fas fa-shopping-cart"></i> Giỏ hàng
                    </a>
                </li>
            </ul>
        </div>
        
    </div>
</nav>