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
    </style>

    <sitemesh:write property="head"/>
  </head>
  <body>
    <div class="wrapper">
      <header>
        <%@ include file="/common/admin/header.jsp" %>
      </header>

      <main class="main">
        <div class="container-fluid">
          <div class="row">
            <section class="col-12 content-area">
                <sitemesh:write property="body"/>
            </section>
          </div>
        </div>
      </main>

      <footer class="mt-auto">
        <%@ include file="/common/admin/footer.jsp" %>
      </footer>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
  </body>
</html>