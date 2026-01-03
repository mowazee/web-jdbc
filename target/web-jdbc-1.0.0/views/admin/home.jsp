<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>

<head>
<title>Trang chủ - Dashboard</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<div class="container py-4">
    <div class="d-flex justify-content-between align-items-center mb-4">
        <h3>Báo cáo & Thống kê</h3>
        <form method="get" class="d-flex align-items-center">
            Năm:&nbsp;
            <input type="number" name="year" value="${reportYear}" class="form-control form-control-sm me-2" style="width:100px;" />
            <button class="btn btn-sm btn-primary">Xem</button>
        </form>
    </div>

    <c:if test="${not empty reportError}">
        <div class="alert alert-danger">${reportError}</div>
    </c:if>

    <div class="row">
        <div class="col-lg-8 mb-4">
            <div class="card p-3">
                <div class="d-flex justify-content-between align-items-center mb-2">
                    <h5 class="mb-0">Doanh thu sản phẩm theo tháng (Top)</h5>
                    <div>
                        <button id="exportRevenueBtn" class="btn btn-sm btn-outline-secondary">Export CSV</button>
                    </div>
                </div>
                <canvas id="revenueChart" width="800" height="320"></canvas>
            </div>
        </div>
        <div class="col-lg-4 mb-4">
            <div class="card p-3">
                <div class="d-flex justify-content-between align-items-center mb-2">
                    <h5 class="mb-0">Tin tức xem nhiều theo tháng</h5>
                    <div>
                        <button id="exportNewsBtn" class="btn btn-sm btn-outline-secondary">Export CSV</button>
                    </div>
                </div>
                <canvas id="newsChart" width="400" height="300"></canvas>
                <div id="newsList" class="mt-3"></div>
            </div>
        </div>
    </div>
</div>

<!-- embed JSON safely into the page for client-side parsing -->
<script id="productRevenueData" type="application/json"><c:out value="${productRevenueJson == null ? '{}' : productRevenueJson}" escapeXml="false"/></script>
<script id="topNewsData" type="application/json"><c:out value="${topNewsJson == null ? '[]' : topNewsJson}" escapeXml="false"/></script>

<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<script>
(function(){
-    const productRevenue = ${productRevenueJson == null ? '{}': productRevenueJson};
-    const topNews = ${topNewsJson == null ? '[]' : topNewsJson};
+    // parse embedded JSON safely
+    let productRevenue = {};
+    let topNews = [];
+    try {
+        const prText = document.getElementById('productRevenueData').textContent || '{}';
+        productRevenue = JSON.parse(prText);
+    } catch(e){ console.error('Failed to parse productRevenueJson', e); productRevenue = {}; }
+    try {
+        const tnText = document.getElementById('topNewsData').textContent || '[]';
+        topNews = JSON.parse(tnText);
+    } catch(e){ console.error('Failed to parse topNewsJson', e); topNews = []; }

    // prepare labels
    const months = ['Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'];

    // currency formatter for VNĐ
    function formatVND(value){
        if (value == null) return '0 VNĐ';
        try{
            return new Intl.NumberFormat('vi-VN').format(Math.round(value)) + ' VNĐ';
        }catch(e){
            return value + ' VNĐ';
        }
    }

    // revenue chart
    const ctx = document.getElementById('revenueChart').getContext('2d');
    const datasets = [];
-    Object.keys(productRevenue).forEach((prod, idx) => {
-        const data = productRevenue[prod];
-        datasets.push({
-            label: prod,
-            data: data,
-            fill: false,
-            borderWidth: 2,
-            tension: 0.2,
-        });
-    });
+    // Ensure each product series has 12 numeric points (one per month)
+    const productKeys = Object.keys(productRevenue || {});
+    productKeys.forEach((prod, idx) => {
+        let data = productRevenue[prod] || [];
+        // coerce to numbers and ensure length 12
+        const normalized = new Array(12).fill(0).map((_,i) => {
+            const v = data[i];
+            const n = Number(v);
+            return isNaN(n) ? 0 : n;
+        });
+        datasets.push({ label: prod, data: normalized, fill: false, borderWidth: 2, tension: 0.2 });
+    });
+    // If no data at all, add a placeholder dataset so chart renders cleanly
+    if (datasets.length === 0) {
+        datasets.push({ label: 'No data', data: new Array(12).fill(0), borderWidth: 1, borderColor: 'rgba(200,200,200,0.6)', backgroundColor: 'rgba(200,200,200,0.2)' });
+    }
    const revenueChart = new Chart(ctx, {
        type: 'line',
        data: { labels: months, datasets: datasets },
        options: {
            responsive: true,
            maintainAspectRatio: false,
            interaction: { mode: 'index', intersect: false },
            plugins: {
                tooltip: {
                    callbacks: {
                        label: function(context){
                            const y = context.parsed.y;
                            return context.dataset.label + ': ' + formatVND(y);
                        }
                    }
                },
                legend: { position: 'bottom', labels: { boxWidth: 12 } }
            },
            scales: {
                y: {
                    ticks: {
                        callback: function(value){ return formatVND(value); }
                    }
                }
            }
        }
    });

    // news chart
    const ctx2 = document.getElementById('newsChart').getContext('2d');
    const newsMonths = [];
    const newsViews = [];
    const newsListDiv = document.getElementById('newsList');
    newsListDiv.innerHTML = '';
    if (Array.isArray(topNews) && topNews.length > 0) {
        topNews.forEach(item => {
            const m = item.month || item['month'];
            const monthLabel = m ? ('M' + m) : '';
            newsMonths.push(monthLabel);
            newsViews.push(Number(item.views) || 0);
            const el = document.createElement('div');
            el.innerHTML = `<strong>Tháng ${item.month}:</strong> ${item.title} (${item.views} lượt)`;
            newsListDiv.appendChild(el);
        });
        const newsChart = new Chart(ctx2, {
            type: 'bar',
            data: { labels: newsMonths, datasets: [{ label: 'Lượt xem', data: newsViews, backgroundColor: 'rgba(54,162,235,0.6)' }] },
            options: { responsive: true, maintainAspectRatio: false }
        });
    } else {
        // no data -> show placeholder message instead of chart
        newsListDiv.innerHTML = '<div class="text-muted">Không có dữ liệu tin tức cho năm này.</div>';
        // draw an empty chart to preserve layout
        const newsChart = new Chart(ctx2, {
            type: 'bar',
            data: { labels: ['N/A'], datasets: [{ label: 'Lượt xem', data: [0], backgroundColor: 'rgba(200,200,200,0.4)' }] },
            options: { responsive: true, maintainAspectRatio: false }
        });
    }

    // CSV export helpers
    function downloadCSV(filename, csvContent){
        const blob = new Blob([csvContent], { type: 'text/csv;charset=utf-8;' });
        const url = URL.createObjectURL(blob);
        const a = document.createElement('a');
        a.href = url;
        a.setAttribute('download', filename);
        document.body.appendChild(a);
        a.click();
        document.body.removeChild(a);
        URL.revokeObjectURL(url);
    }

    function exportRevenueCSV(){
        // header
        const header = ['Product','Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'];
        const rows = [header];
        Object.keys(productRevenue).forEach(prod => {
            const arr = productRevenue[prod] || [];
            const row = [prod];
            for(let i=0;i<12;i++) row.push(arr[i] == null ? 0 : Math.round(arr[i]));
            rows.push(row);
        });
        // build CSV
        const csv = rows.map(r => r.map(cell => '"'+String(cell).replace(/"/g,'""')+'"').join(',')).join('\n');
        downloadCSV('product_revenue_${reportYear}.csv', csv);
    }

    function exportNewsCSV(){
        const header = ['Month','Title','Views'];
        const rows = [header];
        if (Array.isArray(topNews)){
            topNews.forEach(item => {
                rows.push([item.month, item.title, item.views]);
            });
        }
        const csv = rows.map(r => r.map(cell => '"'+String(cell).replace(/"/g,'""')+'"').join(',')).join('\n');
        downloadCSV('top_news_${reportYear}.csv', csv);
    }

    document.getElementById('exportRevenueBtn').addEventListener('click', function(e){ e.preventDefault(); exportRevenueCSV(); });
    document.getElementById('exportNewsBtn').addEventListener('click', function(e){ e.preventDefault(); exportNewsCSV(); });

})();
</script>
</body>