<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!-- Top info bar: left logo, right contact/info fields -->
<div class="bg-white border-bottom">
  <div class="container d-flex justify-content-between align-items-center py-2">
    <div class="d-flex align-items-center">
      <a class="navbar-brand fw-bold mb-0" href="${pageContext.request.contextPath}/home">
        <i class="fa-solid fa-wheat-awn text-warning me-2"></i> HT Store
      </a>
    </div>

    <div class="d-flex align-items-center gap-4 text-muted small">
      <div><i class="fa-solid fa-location-dot me-2 text-primary"></i>HCMUTE - TP.HCM</div>
      <div><i class="fa-regular fa-envelope me-2 text-primary"></i>contact@htstore.vn</div>
      <div><i class="fa-regular fa-clock me-2 text-primary"></i>08:00 - 17:00</div>
      <div><i class="fa-solid fa-phone me-2 text-primary"></i>0912345678</div>
    </div>
  </div>
</div>