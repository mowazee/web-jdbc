<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>

<div class="admin-sidebar">
    <div class="sidebar-header mb-4">
        <h5 class="fw-bold text-uppercase text-primary">
            <i class="fa-solid fa-user-gear me-2"></i>Quản trị viên
        </h5>
        <hr>
    </div>

    <ul class="nav nav-pills flex-column mb-auto admin-nav">
        <li class="nav-item">
            <a href="${pageContext.request.contextPath}/admin/home" 
               class="nav-link ${fn:contains(pageContext.request.requestURI, '/admin/home') ? 'active' : ''}">
                <i class="fa-solid fa-chart-line"></i> <span>Báo cáo / Thống kê</span>
            </a>
        </li>
        <li class="nav-item">
            <a href="${pageContext.request.contextPath}/admin/categories" 
               class="nav-link ${fn:contains(pageContext.request.requestURI, '/admin/categories') ? 'active' : ''}">
                <i class="fa-solid fa-tags"></i> <span>Quản lý danh mục</span>
            </a>
        </li>
        <li class="nav-item">
            <a href="${pageContext.request.contextPath}/admin/products" 
               class="nav-link ${fn:contains(pageContext.request.requestURI, '/admin/products') ? 'active' : ''}">
                <i class="fa-solid fa-boxes-stacked"></i> <span>Quản lý sản phẩm</span>
            </a>
        </li>
        <li class="nav-item">
            <a href="${pageContext.request.contextPath}/admin/orders" 
               class="nav-link ${fn:contains(pageContext.request.requestURI, '/admin/orders') ? 'active' : ''}">
                <i class="fa-solid fa-receipt"></i> <span>Quản lý đơn hàng</span>
            </a>
        </li>
        <li class="nav-item">
            <a href="${pageContext.request.contextPath}/admin/users" 
               class="nav-link ${fn:contains(pageContext.request.requestURI, '/admin/users') ? 'active' : ''}">
                <i class="fa-solid fa-users"></i> <span>Quản lý người dùng</span>
            </a>
        </li>
    </ul>

    <div class="sidebar-search mt-4 p-3 bg-light rounded-3">
        <label class="form-label small fw-bold text-muted">Tìm kiếm nhanh</label>
        <form action="#" method="get">
            <div class="input-group input-group-sm">
                <input type="search" name="q" class="form-control border-primary" placeholder="Tìm kiếm...">
                <button class="btn btn-primary" type="submit"><i class="fa fa-search"></i></button>
            </div>
        </form>
    </div>
</div>