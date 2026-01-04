<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>


<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Danh mục sản phẩm</title>
    <!-- Assume Bootstrap CSS is available in the site header; minimal local styles below -->
    <style>
        .category-menu { max-height: 75vh; overflow:auto; }
        .product-card img { width:100%; height:180px; object-fit:cover; }
        .product-grid .card { margin-bottom:1rem; }
        .category-list .list-group-item.active { background-color:#0d6efd; border-color:#0d6efd; }
        .pagination .page-item .page-link { border-radius:6px; }
    </style>
</head>
<body>
<div class="container mt-4">
    <div class="row">
        <div class="col-12 mb-3">
            <h2>Danh mục sản phẩm</h2>
            <p class="text-muted">Chọn danh mục bên trái để xem sản phẩm tương ứng.</p>
        </div>
    </div>

    <div class="row">
        <!-- left: categories menu -->
        <div class="col-md-3">
            <div class="card category-list">
                <div class="card-body p-2">
                    <c:choose>
                        <c:when test="${not empty categories}">
                            <!-- compute currentId: prefer request attribute 'currentCategoryId' (controller), then request param 'cateid', otherwise use first category id -->
                            <c:choose>
                                <c:when test="${not empty requestScope.currentCategoryId}">
                                    <c:set var="currentId" value="${requestScope.currentCategoryId}" />
                                </c:when>
                                <c:when test="${not empty param.cateid}">
                                    <c:set var="currentId" value="${param.cateid}" />
                                </c:when>
                                <c:otherwise>
                                    <c:forEach var="cat0" items="${categories}" varStatus="st0">
                                        <c:if test="${st0.index == 0}">
                                            <c:set var="currentId" value="${cat0.cateid}" />
                                        </c:if>
                                    </c:forEach>
                                </c:otherwise>
                            </c:choose>

                            <div class="list-group category-menu">
                                <c:forEach var="cat" items="${categories}">
                                    <c:set var="catLink" value="${pageContext.request.contextPath}/products/category?cateid=${cat.cateid}" />
                                    <a href="${catLink}" class="list-group-item list-group-item-action ${cat.cateid == currentId ? 'active' : ''}">
                                        <div class="d-flex align-items-center">
<%--                                             <c:if test="${not empty cat.icon}"> --%>
<%--                                                 <img src="${pageContext.request.contextPath}/${cat.icon}" alt="icon-${cat.cateid}" style="width:40px;height:40px;object-fit:cover;border-radius:4px;margin-right:8px;" /> --%>
<%--                                             </c:if> --%>
                                            <div>
                                                <div class="fw-bold">${cat.catename}</div>
                                            </div>
                                        </div>
                                    </a>
                                </c:forEach>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <div class="text-muted">Không có danh mục.</div>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </div>

        <!-- right: products grid for selected category -->
        <div class="col-md-9">
            <div class="card">
                <div class="card-body">
                    <!-- figure out selected category object for display title -->
                    <c:set var="selectedCategory" value="" />
                    <c:if test="${not empty categories}">
                        <c:forEach var="c" items="${categories}">
                            <c:if test="${c.cateid == currentId}">
                                <c:set var="selectedCategory" value="${c}" />
                            </c:if>
                        </c:forEach>
                    </c:if>

                    <h4 class="card-title">Sản phẩm: <c:out value="${selectedCategory.catename}" default="Tất cả"/></h4>
                    <p class="text-muted">Các sản phẩm thuộc danh mục đã chọn. (<fmt:formatNumber value="${totalResults}" pattern="#,###"/> sản phẩm)</p>

                    <c:choose>
                        <c:when test="${not empty products}">
                            <div class="row product-grid g-4">
                                <c:forEach var="p" items="${products}">
                                    <div class="col-6 col-md-4">
                                        <div class="card h-100">
                                            <a href="${pageContext.request.contextPath}/product/detail?id=${p.id}">
                                                <c:choose>
                                                    <c:when test="${not empty p.image}">
                                                        <img class="card-img-top product-card" src="${pageContext.request.contextPath}/${p.image}" alt="${p.name}" />
                                                    </c:when>
                                                    <c:otherwise>
                                                        <div style="height:180px; background:#f5f5f5; display:flex; align-items:center; justify-content:center; color:#999;">No image</div>
                                                    </c:otherwise>
                                                </c:choose>
                                            </a>
                                            <div class="card-body d-flex flex-column">
                                                <h6 class="card-title" style="min-height:44px;">${p.name}</h6>
                                                <div class="mt-auto">
                                                    <div class="fw-bold text-danger">${p.price}</div>
                                                    <a href="${pageContext.request.contextPath}/product/detail?id=${p.id}" class="btn btn-sm btn-outline-primary mt-2">Xem chi tiết</a>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </c:forEach>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <div class="text-center py-5">
                                <p class="mb-2">Chưa có sản phẩm cho danh mục này.</p>
                                <a href="${pageContext.request.contextPath}/" class="btn btn-sm btn-secondary">Về trang chủ</a>
                            </div>
                        </c:otherwise>
                    </c:choose>

                    <!-- Pagination controls -->
                    <div class="mt-4 d-flex justify-content-center">
                        <nav aria-label="Page navigation">
                            <ul class="pagination">
                                <c:set var="baseUrl" value="${pageContext.request.contextPath}/products/category" />
                                <c:set var="queryParams" value="cateid=${currentCategoryId}" />

                                <!-- Previous -->
                                <li class="page-item ${currentPage <= 1 ? 'disabled' : ''}">
                                    <a class="page-link" href="${baseUrl}?${queryParams}&page=${currentPage-1}&pageSize=${pageSize}" aria-label="Previous">
                                        <span aria-hidden="true">&laquo;</span>
                                    </a>
                                </li>

                                <!-- Page numbers: window around current page -->
                                <c:set var="start" value="1" />
                                <c:set var="end" value="${totalPages}" />
                                <c:if test="${totalPages > 7}">
                                    <c:set var="start" value="${currentPage - 3}" />
                                    <c:set var="end" value="${currentPage + 3}" />
                                    <c:if test="${start lt 1}"><c:set var="start" value="1"/></c:if>
                                    <c:if test="${end gt totalPages}"><c:set var="end" value="${totalPages}"/></c:if>
                                </c:if>

                                <c:forEach begin="${start}" end="${end}" var="i">
                                    <li class="page-item ${i == currentPage ? 'active' : ''}">
                                        <a class="page-link" href="${baseUrl}?${queryParams}&page=${i}&pageSize=${pageSize}">${i}</a>
                                    </li>
                                </c:forEach>

                                <!-- Next -->
                                <li class="page-item ${currentPage >= totalPages ? 'disabled' : ''}">
                                    <a class="page-link" href="${baseUrl}?${queryParams}&page=${currentPage+1}&pageSize=${pageSize}" aria-label="Next">
                                        <span aria-hidden="true">&raquo;</span>
                                    </a>
                                </li>
                            </ul>
                        </nav>
                    </div>

                </div>
            </div>
        </div>
    </div>
</div>

</body>