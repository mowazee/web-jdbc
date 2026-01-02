<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="HT Store - Hệ thống bán lẻ gạo sạch"/>
    <meta name="author" content="Han Trinh"/>

    <title><sitemesh:write property="title"/> - HT Store</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" />

    <style>
        :root {
            --primary-green: #2e7d32;
            --accent-yellow: #ffc107;
            --bg-light: #f4f7f6;
        }
        
        html, body { height: 100%; margin: 0; background-color: var(--bg-light); font-family: 'Segoe UI', Roboto, sans-serif; }
        .wrapper { display: flex; flex-direction: column; min-height: 100vh; }
        
        /* === 1. HEADER & NAVBAR === */
        header { 
            position: sticky; 
            top: 0; 
            z-index: 1020;
            background: white;
            box-shadow: 0 1px 15px rgba(0,0,0,0.08); 
        }

        /* === 2. MAIN BODY AREA === */
        main { flex: 1 0 auto; }
        
        .content-card {
            background: white;
            border-radius:16px;
            padding: 2.5rem;
            box-shadow: 0 4px 20px rgba(0,0,0,0.04);
            border: 1px solid rgba(0,0,0,0.02);
            min-height: 70vh;
        }

        /* Hiệu ứng ảnh sản phẩm/danh mục dùng chung cho toàn web */
        .img-hover-zoom {
            overflow: hidden;
            border-radius: 12px;
            position: relative;
        }
        
        .img-hover-zoom img {
            transition: transform 0.6s cubic-bezier(0.25, 0.45, 0.45, 0.95);
            width: 100%;
            height: 250px; /* Tối ưu cho khung 600x400 khi hiển thị card */
            object-fit: cover;
        }
        
        .img-hover-zoom:hover img {
            transform: scale(1.08);
        }

        /* Hiệu ứng Button */
        .btn-custom {
            border-radius: 999px;
            padding: 10px 25px;
            font-weight: 600;
            transition: all 0.3s ease;
        }
        
        .btn-custom:hover {
            transform: translateY(-3px);
            box-shadow: 0 8px 15px rgba(0,0,0,0.1);
        }

        /* === 3. FOOTER === */
        footer { 
            background:#dae0df;
            color:000000;
        }
        
        .footer-bottom {
            background: rgba(0,0,0,0.1);
            padding: 3px 0;
            font-size: 0.85rem;
            color:#ffffff;
        }

        /* Responsive adjustments */
        @media (max-width: 768px) {
            .content-card { padding: 1.5rem; }
        }
        /* === NAVBAR CUSTOM STYLES === */
        .navbar-container { background: transparent; }
        .navbar-container .container { padding: 0; }

        /* Wrapper for the nav to create pill-like bar */
        .navbar-bar {
            background: rgba(255, 255, 255, 0.2); /* Độ trong suốt 60% */
		    backdrop-filter: blur(12px); /* Hiệu ứng làm mờ hậu cảnh quan trọng nhất */
		    -webkit-backdrop-filter: blur(12px); 
		    border-radius: 12px; /* Chuyển hẳn sang dạng viên thuốc (pill) */
		    padding: 6px;
		    box-shadow: 0 4px 20px rgba(0, 0, 0, 0.04);
		    border: 1px solid rgba(255, 255, 255, 0.5); /* Viền trắng mảnh giúp nổi khối */
		    margin-bottom: 1rem;
		    margin-top: 1rem;
		    transition: all 0.3s ease;
        }

        /* Use flex nav and make it horizontally scrollable on small screens */
        .navbar-bar .nav {
            display: flex;
            gap: 8px;
            align-items: center;
            justify-content: center;
            overflow-x: auto;
            -webkit-overflow-scrolling: touch;
            padding: 6px;
        }

        /* Hide default scrollbars for a cleaner look (WebKit) */
        .navbar-bar .nav::-webkit-scrollbar { height: 6px; }
        .navbar-bar .nav::-webkit-scrollbar-thumb { background: rgba(0,0,0,0.08); border-radius: 6px; }

        /* Nav links styling */
        .navbar-bar .nav-link {
            color: #374151; /* gray-700 */
            background: transparent;
            padding: 10px 14px;
            border-radius: 9999px;
            font-weight: 600;
            letter-spacing: 0.1px;
            transition: all .18s ease-in-out;
            border: 1px solid transparent;
        }

        .navbar-bar .nav-link:hover {
            background: linear-gradient(180deg, rgba(88, 101, 242, 0.06), rgba(88,101,242,0.02));
            color: #2446d8;
            transform: translateY(-2px);
            box-shadow: 0 6px 12px rgba(37, 99, 235, 0.06);
            border-color: rgba(37,99,235,0.08);
        }

        /* Active pill */
        .navbar-bar .nav-link.active, .navbar-bar .nav-link:active {
            background: linear-gradient(90deg, #eeeee4 0%, #a7a7a0 100%);
            color: #fff !important;
            box-shadow: 0 8px 20px rgba(79,70,229,0.18);
            border-color: rgba(255,255,255,0.06);
        }

        /* Small screens: allow scroll and slight padding */
        @media (max-width: 768px) {
            .navbar-bar { padding: 6px 4px; }
            .navbar-bar .nav-link { padding: 8px 12px; font-size: 14px; }
            .navbar-bar .nav { justify-content: flex-start; }
        }

        /* Large screens: left align nav and reduce max width */
        @media (min-width: 992px) {
            .navbar-bar { max-width: 1100px; margin-left: auto; margin-right: auto; }
            .navbar-bar .nav { justify-content: flex-start; }
        }

        /* Utility: visually hide focus outline but keep accessible focus ring */
        .navbar-bar .nav-link:focus {
            outline: none;
            box-shadow: 0 0 0 4px rgba(37,99,235,0.08);
        }

        /* === NAVBAR SEARCH STYLES === */
        .navbar-search { min-width: 220px; }
        .navbar-search .navbar-search-input {
            border-radius: 999px;
            padding: 6px 10px;
            border: 1px solid rgba(16,24,40,0.06);
            background: rgba(255,255,255,0.95);
            min-width: 180px;
            transition: box-shadow .12s ease, transform .12s ease;
        }
        .navbar-search .navbar-search-input:focus {
            box-shadow: 0 6px 18px rgba(37,99,235,0.08);
            transform: translateY(-1px);
            outline: none;
        }
        .navbar-search .navbar-search-btn {
            border-radius: 999px;
            padding: 6px 10px;
            display: inline-flex;
            align-items: center;
            justify-content: center;
        }
        /* Smaller on mobile stacked search */
        .d-lg-none .navbar-search-input { min-width: 0; }
        .d-lg-none .navbar-search-btn { padding: 6px 10px; }
    </style>

    <sitemesh:write property="head"/>
</head>
<body>
<div class="wrapper">

    <header>
        <div class="header-main border-bottom py-0">
            <%@ include file="/common/client/header.jsp" %>
        </div>
        <div class="navbar-bar navbar-expand-lg navbar-container mx-auto px-3 px-lg-2">
            <%@ include file="/common/client/navbar.jsp" %>
        </div>
    </header>

    <main class="container py-1">
        <div class="row justify-content-center">
            <div class="content-card">
                    <sitemesh:write property="body"/>
            </div>
        </div>
    </main>

    <footer class="mt-auto">
        <div class="container py-1">
            <%@ include file="/common/client/footer.jsp" %>
        </div>
        <div class="footer-bottom text-center">
            <div class="container">
                <p class="mb-0 text-dark">&copy; 2026 HT Store - Bản quyền thuộc về Web Bán Hàng!</p>
            </div>
        </div>
    </footer>

</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>