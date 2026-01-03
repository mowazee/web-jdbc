<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Tin tức</title>

    <style>
        .news-card { position: relative; border-radius:12px; overflow:hidden; box-shadow:0 8px 20px rgba(0,0,0,0.06); }
        .news-thumb { width:100%; height:220px; object-fit:cover; }
        .date-badge { position:absolute; left:12px; top:12px; background:rgba(0,0,0,0.6); color:#fff; padding:6px 10px; border-radius:6px; font-size:12px; }
        .news-preview { max-height:84px; overflow:hidden; }
        .sidebar-item { display:flex; gap:12px; margin-bottom:16px; }
        .sidebar-thumb { width:120px; height:80px; object-fit:cover; border-radius:8px; }
    </style>
</head>

<body>
<div class="container py-4">
    <div class="row">
        <div class="col-12 mb-3 d-flex justify-content-between align-items-center">
            <h3 class="mb-0">Tin tức</h3>
            <div>Trang ${currentPage} / ${totalPages}</div>
        </div>
    </div>

    <div class="row g-4">
        <div class="col-lg-8">
            <c:if test="${empty newsList}">
                <div class="alert alert-info">Chưa có tin nào.</div>
            </c:if>
            <c:forEach var="n" items="${newsList}">
                <div class="news-card mb-4">
                    <c:if test="${not empty n.createdate}">
                        <div class="date-badge" style="left:12px;top:12px;z-index:10;">
                            <fmt:formatDate value="${n.createdate}" pattern="dd/MM/yyyy"/>
                        </div>
                    </c:if>
                    <div class="row g-0">
                        <div class="col-12 col-md-4">
                            <a href="${pageContext.request.contextPath}/news/${n.id}" class="d-block">
                                <c:choose>
                                    <c:when test="${not empty n.image}">
                                        <img src="${pageContext.request.contextPath}/${n.image}" class="img-fluid w-100" alt="${n.title}" loading="lazy" decoding="async" style="height:180px; object-fit:cover;" />
                                    </c:when>
                                    <c:when test="${not empty n.thumbnail}">
                                        <img src="${pageContext.request.contextPath}/${n.thumbnail}" class="img-fluid w-100" alt="${n.title}" loading="lazy" decoding="async" style="height:180px; object-fit:cover;" />
                                    </c:when>
                                    <c:otherwise>
                                        <img src="https://via.placeholder.com/800x400?text=News" class="img-fluid w-100" alt="${n.title}" loading="lazy" decoding="async" style="height:180px; object-fit:cover;" />
                                    </c:otherwise>
                                </c:choose>
                            </a>
                        </div>
                        <div class="col-12 col-md-8">
                            <div class="p-3">
                                <h5 class="mb-2"><a href="${pageContext.request.contextPath}/news/${n.id}" class="text-decoration-none text-dark d-block">${n.title}</a></h5>
                                <p class="news-preview text-muted mb-0">${n.preview}</p>
                            </div>
                        </div>
                    </div>
                </div>
            </c:forEach>

            <!-- pagination -->
            <nav>
                <ul class="pagination">
                    <c:forEach var="i" begin="1" end="${totalPages}">
                        <li class="page-item ${i == currentPage ? 'active' : ''}"><a class="page-link" href="${pageContext.request.contextPath}/news?page=${i}&size=${pageSize}">${i}</a></li>
                    </c:forEach>
                </ul>
            </nav>
        </div>

        <div class="col-lg-4">
            <div class="mb-3">
                <h5>Nổi bật (Xem nhiều)</h5>
            </div>
            <c:forEach var="t" items="${topViewed}">
                <div class="sidebar-item">
                    <a href="${pageContext.request.contextPath}/news/${t.id}">
                        <c:choose>
                            <c:when test="${not empty t.image}">
                                <img src="${pageContext.request.contextPath}/${t.image}" class="sidebar-thumb" alt="${t.title}" loading="lazy" decoding="async" width="120" height="80" />
                            </c:when>
                            <c:when test="${not empty t.thumbnail}">
                                <img src="${pageContext.request.contextPath}/${t.thumbnail}" class="sidebar-thumb" alt="${t.title}" loading="lazy" decoding="async" width="120" height="80" />
                            </c:when>
                            <c:otherwise>
                                <img src="https://via.placeholder.com/300x200?text=News" class="sidebar-thumb" alt="${t.title}" loading="lazy" decoding="async" width="120" height="80" />
                            </c:otherwise>
                        </c:choose>
                    </a>
                    <div>
                        <a href="${pageContext.request.contextPath}/news/${t.id}" class="text-decoration-none text-dark"><strong>${t.title}</strong></a>
                        <c:if test="${not empty t.createdate}"><div class="text-muted small"><fmt:formatDate value="${t.createdate}" pattern="dd/MM/yyyy"/></div></c:if>
                        <div class="text-muted small mt-1">${t.viewCount} lượt xem</div>
                    </div>
                </div>
            </c:forEach>
        </div>
    </div>
</div>

</body>