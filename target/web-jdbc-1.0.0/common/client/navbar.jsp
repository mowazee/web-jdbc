<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<div class="container">
  <nav class="navbar navbar-expand-lg navbar-dark bg-light rounded-3 shadow-sm">
    <div class="container-fluid">
      <a class="navbar-brand d-lg-none" href="${pageContext.request.contextPath}/home">Menu</a>
      <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#mainNav" aria-controls="mainNav" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
      </button>

      <div class="collapse navbar-collapse" id="mainNav">
        <ul class="navbar-nav me-auto mb-2 mb-lg-0">
          <li class="nav-item">
            <a class="nav-link text-secondary" href="${pageContext.request.contextPath}/home">Trang chủ</a>
          </li>
          <li class="nav-item">
            <a class="nav-link text-secondary" href="${pageContext.request.contextPath}/about">Giới thiệu</a>
          </li>

          <!-- Sản phẩm dropdown: show first 4 categories, then 'Tất cả sản phẩm' -->
          <li class="nav-item dropdown">
            <a class="nav-link dropdown-toggle text-secondary" href="#" id="productDrop" role="button" data-bs-toggle="dropdown" aria-expanded="false">Sản phẩm</a>
            <ul class="dropdown-menu" aria-labelledby="productDrop">
              <c:choose>
                <c:when test="${not empty categories}">
                  <c:forEach var="c" items="${categories}" varStatus="st">
                    <c:if test="${st.index lt 4}">
                      <li><a class="dropdown-item" href="${pageContext.request.contextPath}/products/category?cateid=${c.cateid}"><c:out value="${c.catename}"/></a></li>
                    </c:if>
                  </c:forEach>
                  <li><hr class="dropdown-divider"/></li>
                  <li><a class="dropdown-item" href="${pageContext.request.contextPath}/products/category">Tất cả sản phẩm</a></li>
                </c:when>
                <c:otherwise>
                  <li><a class="dropdown-item" href="${pageContext.request.contextPath}/products/category?cateid=1">Gạo thơm</a></li>
                  <li><a class="dropdown-item" href="${pageContext.request.contextPath}/products/category?cateid=2">Gạo đặc sản</a></li>
                  <li><a class="dropdown-item" href="${pageContext.request.contextPath}/products/category?cateid=3">Gạo nếp</a></li>
                  <li><hr class="dropdown-divider"/></li>
                  <li><a class="dropdown-item" href="${pageContext.request.contextPath}/products/category">Tất cả sản phẩm</a></li>
                </c:otherwise>
              </c:choose>
            </ul>
          </li>

          <li class="nav-item">
            <a class="nav-link text-secondary" href="${pageContext.request.contextPath}/news">Tin tức</a>
          </li>
          <li class="nav-item">
            <a class="nav-link text-secondary" href="${pageContext.request.contextPath}/contact">Liên hệ</a>
          </li>
        </ul>

        <!-- Search (center/right) -->
        <form class="d-flex mx-3" action="${pageContext.request.contextPath}/products" method="get">
          <input name="q" class="form-control form-control-sm me-2" type="search" placeholder="Tìm kiếm sản phẩm..." aria-label="Tìm kiếm">
          <button class="btn btn-light btn-sm" type="submit"><i class="fa fa-search text-primary"></i></button>
        </form>

        <!-- Right: Login/Register and Cart (moved from header) -->
        <ul class="navbar-nav ms-auto d-flex align-items-center">
          <c:if test="${empty sessionScope.username}">
            <li class="nav-item me-2">
              <a class="btn btn-light btn-sm text-secondary fw-bold" href="${pageContext.request.contextPath}/login">Đăng nhập</a>
            </li>
          </c:if>

          <c:if test="${not empty sessionScope.username}">
            <li class="nav-item dropdown me-2">
              <a class="btn btn-outline-light btn-sm dropdown-toggle text-dark" href="#" id="userDropNav" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                Chào bạn <c:out value="${sessionScope.user != null ? sessionScope.user.fullname : sessionScope.username}"/>
              </a>
              <ul class="dropdown-menu dropdown-menu-end shadow" aria-labelledby="userDropNav">
                <c:choose>
                  <c:when test="${not empty sessionScope.user and sessionScope.user.roleid == 1}">
                    <li><a class="dropdown-item" href="${pageContext.request.contextPath}/admin/home"><i class="fa-solid fa-gauge me-2"></i>Trang Admin</a></li>
                    <li><hr class="dropdown-divider"></li>
                    <li><a class="dropdown-item text-danger" href="${pageContext.request.contextPath}/logout"><i class="fa-solid fa-right-from-bracket me-2"></i>Đăng xuất</a></li>
                  </c:when>
                  <c:otherwise>
                    <li><a class="dropdown-item" href="${pageContext.request.contextPath}/profile"><i class="fa-solid fa-id-card me-2"></i>Hồ sơ</a></li>
                    <li><hr class="dropdown-divider"></li>
                    <li><a class="dropdown-item text-danger" href="${pageContext.request.contextPath}/logout"><i class="fa-solid fa-right-from-bracket me-2"></i>Đăng xuất</a></li>
                  </c:otherwise>
                </c:choose>
              </ul>
            </li>
          </c:if>

          <li class="nav-item">
            <a class="btn btn-warning btn-sm text-dark fw-bold" href="${pageContext.request.contextPath}/cart">
              <i class="fa-solid fa-cart-shopping me-1"></i>Giỏ hàng
              <c:if test="${not empty sessionScope.cart}">
                <span id="cart-badge" class="badge bg-danger ms-2">${sessionScope.cart.totalQuantity}</span>
              </c:if>
            </a>
          </li>
        </ul>
      </div>
    </div>
  </nav>
</div>