<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Sản phẩm</title>
    <style>
        .pagination .page-item .page-link { border-radius: 6px; }
    </style>
</head>
<body>
<div class="container">
    <div class="mb-4 d-flex justify-content-between align-items-center">
        <div>
            <c:choose>
                <c:when test="${not empty searchQuery}">
                    <h4>Kết quả tìm kiếm cho "${searchQuery}" (<span class="text-muted"><fmt:formatNumber value="${totalResults}" pattern="#,###"/></span>)</h4>
                </c:when>
                <c:when test="${not empty currentCategoryId}">
                    <h4>Danh mục (#${currentCategoryId}) - (<span class="text-muted"><fmt:formatNumber value="${totalResults}" pattern="#,###"/></span> sản phẩm)</h4>
                </c:when>
                <c:otherwise>
                    <h4>Tất cả sản phẩm (<span class="text-muted"><fmt:formatNumber value="${totalResults}" pattern="#,###"/></span>)</h4>
                </c:otherwise>
            </c:choose>
        </div>
        <div class="d-flex align-items-center gap-3">
            <div class="text-muted small">Hiển thị trang ${currentPage} / ${totalPages}</div>
            <form method="get" action="${pageContext.request.contextPath}/products" class="d-flex align-items-center">
                <c:choose>
                    <c:when test="${not empty searchQuery}">
                        <input type="hidden" name="q" value="${fn:escapeXml(searchQuery)}" />
                    </c:when>
                    <c:when test="${not empty currentCategoryId}">
                        <input type="hidden" name="id" value="${currentCategoryId}" />
                    </c:when>
                </c:choose>
                <label for="pageSize" class="me-2 small text-muted">Số hàng:</label>
                <select name="pageSize" id="pageSize" class="form-select form-select-sm" onchange="this.form.submit()">
                    <option value="6" ${pageSize==6? 'selected':''}>6</option>
                    <option value="12" ${pageSize==12? 'selected':''}>12</option>
                    <option value="24" ${pageSize==24? 'selected':''}>24</option>
                    <option value="48" ${pageSize==48? 'selected':''}>48</option>
                </select>
            </form>
        </div>
    </div>

    <div class="row g-4">
        <c:if test="${empty products}">
            <div class="col-12">
                <div class="alert alert-warning">Không tìm thấy sản phẩm nào.</div>
            </div>
        </c:if>

        <c:forEach var="p" items="${products}">
            <div class="col-6 col-md-4 col-lg-3">
                <div class="card h-100 shadow-sm">
                    <c:choose>
                        <c:when test="${not empty p.image}">
                            <img src="${pageContext.request.contextPath}/${p.image}" class="card-img-top" alt="${p.name}" style="height:160px; object-fit:cover;"/>
                        </c:when>
                        <c:otherwise>
                            <div style="height:160px; background:#f5f5f5; display:flex; align-items:center; justify-content:center; color:#999;">No image</div>
                        </c:otherwise>
                    </c:choose>
                    <div class="card-body d-flex flex-column">
                        <h6 class="card-title mb-2" style="min-height:3em;">${p.name}</h6>
                        <p class="mb-2 text-muted small">${p.description}</p>
                        <div class="mb-2 text-muted small">Danh mục: <c:out value="${categoryMap[p.cateid]}" default="Không xác định"/></div>
                        <div class="mt-auto d-flex justify-content-between align-items-center">
                            <div class="fw-bold text-primary"><fmt:formatNumber value="${p.price}" pattern="#,##0"/> VNĐ</div>
                            <a class="btn btn-outline-primary btn-sm" href="${pageContext.request.contextPath}/product/detail?id=${p.id}">Xem</a>
                        </div>
                    </div>
                </div>
            </div>
        </c:forEach>
    </div>

    <!-- Pagination controls -->
    <div class="mt-4 d-flex justify-content-center">
        <nav aria-label="Page navigation">
            <ul class="pagination">
                <c:set var="baseUrl" value="${pageContext.request.contextPath}/products" />
                <c:choose>
                    <c:when test="${not empty searchQuery}">
                        <c:set var="queryParams" value="q=${fn:escapeXml(searchQuery)}" />
                    </c:when>
                    <c:when test="${not empty currentCategoryId}">
                        <c:set var="queryParams" value="id=${currentCategoryId}" />
                    </c:when>
                    <c:otherwise>
                        <c:set var="queryParams" value="" />
                    </c:otherwise>
                </c:choose>

                <!-- Previous -->
                <li class="page-item ${currentPage <= 1 ? 'disabled' : ''}">
                    <a class="page-link" href="${baseUrl}?${queryParams}&page=${currentPage-1}" aria-label="Previous">
                        <span aria-hidden="true">&laquo;</span>
                    </a>
                </li>

                <!-- Page numbers: show a window around current page -->
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
                        <a class="page-link" href="${baseUrl}?${queryParams}&page=${i}">${i}</a>
                    </li>
                </c:forEach>

                <!-- Next -->
                <li class="page-item ${currentPage >= totalPages ? 'disabled' : ''}">
                    <a class="page-link" href="${baseUrl}?${queryParams}&page=${currentPage+1}" aria-label="Next">
                        <span aria-hidden="true">&raquo;</span>
                    </a>
                </li>
            </ul>
        </nav>
    </div>

</div>
</body>