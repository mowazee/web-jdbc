<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!doctype html>
<html lang="vi">
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="Admin Dashboard"/>
    <meta name="author" content="Han Trinh"/>
    
    <title><sitemesh:write property="title"/> - Admin</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

    <style>
      /* Full-height wrapper để đẩy footer xuống đáy trang */
      html, body { height: 100%; margin: 0; }
      .wrapper { display: flex; flex-direction: column; min-height: 100vh; }
      .main { flex: 1 0 auto; }

      /* Cấu trúc vùng nội dung chính */
      .content-area { 
        padding: 2rem; 
        background: #f8f9fa; 
        min-height: 80vh; /* Đảm bảo vùng body đủ lớn */
      }
      /* Sidebar Container */
		.admin-sidebar {
		    background: white;
		    padding: 20px;
		    border-radius: 16px;
		    box-shadow: 0 4px 15px rgba(0,0,0,0.05);
		    min-height: 80vh;
		}
		
		/* Tùy chỉnh các liên kết Menu */
		.admin-nav .nav-link {
		    color: #4b5563;
		    font-weight: 500;
		    padding: 12px 15px;
		    border-radius: 10px;
		    margin-bottom: 5px;
		    transition: all 0.3s ease;
		    display: flex;
		    align-items: center;
		}
		
		.admin-nav .nav-link i {
		    width: 25px;
		    font-size: 1.1rem;
		    margin-right: 10px;
		}
		
		/* Trạng thái Hover */
		.admin-nav .nav-link:hover {
		    background-color: #f3f4f6;
		    color: #2563eb;
		    transform: translateX(5px);
		}
		
		/* Trạng thái Active (Đang được chọn) */
		.admin-nav .nav-link.active {
		    background: linear-gradient(90deg, #2563eb 0%, #3b82f6 100%);
		    color: white !important;
		    box-shadow: 0 4px 12px rgba(37, 99, 235, 0.2);
		}
		
		.sidebar-header hr {
		    opacity: 0.1;
		}
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

      /* Admin layout: left sidebar and right content iframe */
      .admin-row { gap: 1rem; }
      .admin-iframe { width: 100%; height: calc(100vh - 220px); border: none; background: #fff; }

      @media (max-width: 767px) {
        .admin-iframe { height: 60vh; }
      }
    </style>

    <sitemesh:write property="head"/>
  </head>
  <body>
    <div class="wrapper">
      <header>
       <%@ include file="/common/admin/header.jsp" %>
      </header>
      <main class="container py-4">
	    <div class="row">
	        <aside class="col-lg-3">
	            <%@ include file="/common/admin/left.jsp" %>
	        </aside>
	
	        <section class="col-lg-9">
	            <div class="content-card">
	                <sitemesh:write property="body"/>
	            </div>
	        </section>
	    </div>
	</main>

      <footer class="mt-auto">
        <%@ include file="/common/admin/footer.jsp" %>
      </footer>
    </div>
    <div class="footer-bottom text-center">
            <div class="container">
                <p class="mb-0 text-dark">&copy; 2026 HT Store - Bản quyền thuộc về Web Bán Hàng!</p>
            </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
  </body>
</html>