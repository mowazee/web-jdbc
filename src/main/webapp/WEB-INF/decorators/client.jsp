<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="Client Dashboard - Web Bán Gạo"/>
    <meta name="author" content="Han Trinh"/>

    <title><sitemesh:write property="title"/> - My Rice Store</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" />

    <style>
        :root {
            --primary-color: #2c3e50;
            --secondary-color: #f8f9fa;
        }
        
        html, body { height: 100%; margin: 0; background-color: #f4f7f6; font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; }
        .wrapper { display: flex; flex-direction: column; min-height: 100vh; }
        
        /* Sticky Header */
        header { position: sticky; top: 0; z-index: 1020; box-shadow: 0 2px 10px rgba(0,0,0,0.1); }
        
        main { flex: 1 0 auto; }
        
        /* Sidebar Styling */
        .sidebar-wrapper {
            background: white;
            border-radius: 10px;
            padding: 1.5rem;
            box-shadow: 0 4px 15px rgba(0,0,0,0.05);
            border: 1px solid #eef0f2;
        }
        /* Hiệu ứng cho các mục trong Sidebar */
		.sidebar-wrapper ul {
		    list-style: none;
		    padding: 0;
		}
		
		.sidebar-wrapper li a {
		    display: block;
		    padding: 10px 15px;
		    color: #444;
		    text-decoration: none;
		    border-radius: 8px;
		    transition: all 0.3s ease; /* Tạo hiệu ứng mượt mà */
		    margin-bottom: 5px;
		}
		
		/* Khi di chuột qua mục danh mục */
		.sidebar-wrapper li a:hover {
		    background-color: #e8f5e9; /* Màu nền xanh lá nhẹ (hợp với web bán gạo) */
		    color: #2e7d32;           /* Chữ xanh đậm hơn */
		    padding-left: 25px;       /* Hiệu ứng đẩy chữ sang phải */
		    box-shadow: inset 4px 0 0 #2e7d32; /* Thanh kẻ dọc bên trái */
		}
		
		/* Hiệu ứng cho các nút bấm (Buttons) */
		.btn {
		    transition: transform 0.2s ease, box-shadow 0.2s ease;
		}
		
		.btn:hover {
		    transform: translateY(-2px); /* Nút bay lên nhẹ */
		    box-shadow: 0 5px 15px rgba(0,0,0,0.1);
		}
		
		/* Hiệu ứng cho khung nội dung chính */
		.content-card {
		    transition: transform 0.3s ease;
		}
		
		/* Tỉ lệ ảnh cố định cho Category và Product [cite: 18-21, 117-122] */
		.img-hover-zoom {
		    overflow: hidden; /* Giấu phần ảnh thừa khi phóng to */
		    border-radius: 8px;
		}
		
		.img-hover-zoom img {
		    transition: transform 0.5s ease;
		    width: 100%;
		    height: 200px;
		    object-fit: cover;
		}
		
		.img-hover-zoom:hover img {
		    transform: scale(1.1); /* Phóng to ảnh khi di chuột vào */
		}
		
		        /* Content Area Styling */
		        .content-card {
		            background: white;
		            border-radius: 10px;
		            padding: 2rem;
		            box-shadow: 0 4px 15px rgba(0,0,0,0.05);
		            min-height: 60vh;
		        }
		
		        /* Category Image fix */
		        .category-img {
		            width: 100%;
		            height: 200px; /* Có thể đổi thành 600x400 tùy nhu cầu */
		            object-fit: cover;
		            border-radius: 8px;
		            }

        footer { border-top: 1px solid #dee2e6; }
        
    </style>

    <sitemesh:write property="head"/>
</head>
<body>
<div class="wrapper">

    <header class="bg-white">
        <%-- Top Header (Logo, Search, Account) --%>
        <div class="header-top border-bottom py-2">
            <%@ include file="/common/client/header.jsp" %>
        </div>
        <%-- Main Navigation Bar --%>
        <div class="navbar-container">
            <%@ include file="/common/client/navbar.jsp" %>
        </div>
    </header>

    <main class="container py-5">
        <div class="row g-4"> <aside class="col-lg-3 d-none d-lg-block">
                <div class="sidebar-wrapper">
                    <h5 class="border-bottom pb-2 mb-3 fw-bold text-uppercase" style="font-size: 0.9rem; color: #666;">
                        <i class="fa-solid fa-bars me-2"></i>Danh mục sản phẩm
                    </h5>
                    <%@ include file="/common/client/slidebar.jsp" %>
                </div>
            </aside>

            <section class="col-12 col-lg-9">
                <div class="content-card">
                    <sitemesh:write property="body"/>
                </div>
            </section>
            
        </div>
    </main>

    <footer class="mt-auto bg-dark text-white py-4">
        <div class="container text-center">
            <%@ include file="/common/client/footer.jsp" %>
            <p class="mt-3 mb-0 text-muted small">&copy; 2025 Web Bán Gạo - All Rights Reserved.</p>
        </div>
    </footer>

</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>