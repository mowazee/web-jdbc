<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<nav class="navbar navbar-expand-lg navbar-light bg-light shadow-sm">
  <div class="container-fluid">
    <a class="navbar-brand fw-bold" href="${pageContext.request.contextPath}/admin/home">
      <i class="fa-solid fa-wheat-awn text-warning me-2"></i>DASHBOARD
    </a>

    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarAdmin" aria-controls="navbarAdmin" aria-expanded="false" aria-label="Toggle navigation">
      <span class="navbar-toggler-icon"></span>
    </button>

    <div class="collapse navbar-collapse" id="navbarAdmin">
      <ul class="navbar-nav me-auto mb-2 mb-lg-0">
        <li class="nav-item">
          <a class="nav-link active" href="${pageContext.request.contextPath}/admin/home">
            <i class="fa-solid fa-house-chimney me-1"></i> Trang chủ
          </a>
        </li>
        
        <li class="nav-item dropdown">
          <a class="nav-link dropdown-toggle" href="#" id="manageDrop" role="button" data-bs-toggle="dropdown" aria-expanded="false">
            <i class="fa-solid fa-list-check me-1"></i> Quản lý
          </a>
          <ul class="dropdown-menu shadow" aria-labelledby="manageDrop">
            <li><a class="dropdown-item" href="${pageContext.request.contextPath}/admin/category"><i class="fa-solid fa-tags me-2"></i>Danh mục</a></li>
            <li><a class="dropdown-item" href="${pageContext.request.contextPath}/admin/product"><i class="fa-solid fa-box me-2"></i>Sản phẩm</a></li>
            <li><hr class="dropdown-divider"></li>
            <li><a class="dropdown-item" href="${pageContext.request.contextPath}/admin/orders"><i class="fa-solid fa-cart-shopping me-2"></i>Đơn hàng</a></li>
          </ul>
        </li>
        
        <li class="nav-item">
          <a class="nav-link" href="${pageContext.request.contextPath}/admin/news">
            <i class="fa-solid fa-newspaper me-1"></i> Tin tức
          </a>
        </li>
      </ul>

      <ul class="navbar-nav ms-auto">
        <li class="nav-item dropdown">
          <a class="nav-link dropdown-toggle text-secondary" href="#" id="userDrop" role="button" data-bs-toggle="dropdown" aria-expanded="false">
            <i class="fa-solid fa-circle-user me-1"></i> Chào bạn Admin
          </a>
          <ul class="dropdown-menu dropdown-menu-end shadow" aria-labelledby="userDrop">
            <li><a class="dropdown-item" href="#"><i class="fa-solid fa-user-pen me-2"></i>Hồ sơ</a></li>
            <li><hr class="dropdown-divider"></li>
            <li>
              <a class="dropdown-item text-danger" href="${pageContext.request.contextPath}/logout">
                <i class="fa-solid fa-power-off me-2"></i> Đăng xuất
              </a>
            </li>
          </ul>
        </li>
      </ul>
    </div>
  </div>
</nav>