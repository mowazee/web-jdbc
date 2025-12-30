<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!-- Navbar fragment for product categories and quick links -->
<div class="container mt-3">
    <ul class="nav nav-pills justify-content-center" role="tablist">
        <li class="nav-item">
            <a class="nav-link" href="<c:url value='/products'/>">Tất cả sản phẩm</a>
        </li>
        <li class="nav-item">
            <a class="nav-link" href="<c:url value='/products/category?id=1'/>">Gạo ST24</a>
        </li>
        <li class="nav-item">
            <a class="nav-link" href="<c:url value='/products/category?id=2'/>">Gạo Tám Thơm</a>
        </li>
        <li class="nav-item">
            <a class="nav-link" href="<c:url value='/products/category?id=3'/>">Gạo Nếp</a>
        </li>
        <li class="nav-item">
            <a class="nav-link" href="<c:url value='/products/special'/>">Combo Quà Tặng</a>
        </li>
    </ul>
</div>