<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="sitemesh" uri="http://www.opensymphony.net/sitemesh/decorator" %>
<!doctype html>
<html lang="vi">
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title><sitemesh:write property="title"/>Admin</title>

    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

    <style>
      /* Full-height wrapper to keep footer at bottom */
      html, body { height: 100%; margin: 0; }
      .wrapper { display: flex; flex-direction: column; min-height: 100vh; }
      .main { flex: 1 0 auto; }

      /* Sidebar styles */
      .sidebar { background: #343a40; color: #fff; min-height: 100vh; padding-top: 1rem; }
      .sidebar .nav-link { color: rgba(255,255,255,0.9); }
      .sidebar .nav-link:hover { color: #fff; background: rgba(255,255,255,0.03); }

      /* Content area */
      .content-area { padding: 1.5rem; background: #f8f9fa; min-height: 100vh; }

      @media (max-width: 767.98px) {
        .sidebar { min-height: auto; }
        .content-area { min-height: auto; }
      }
    </style>

    <!-- Allow pages to add extra head content -->
    <sitemesh:write property="head"/>
  </head>
  <body>
    <div class="wrapper">

      <!-- Header (common) -->
      <header>
        <%@ include file="/common/admin/header.jsp" %>
      </header>

      <!-- Main area -->
      <main class="main">
        <div class="container-fluid">
          <div class="row g-0">

            <!-- Sidebar -->
            <aside class="col-12 col-md-3 col-lg-2 sidebar">
              <%@ include file="/common/admin/left.jsp" %>
            </aside>

            <!-- Content -->
            <section class="col-12 col-md-9 col-lg-10 content-area">
              <div class="container-fluid">
                <sitemesh:write property="body"/>
              </div>
            </section>

          </div>
        </div>
      </main>

      <!-- Footer (common) -->
      <footer class="mt-auto">
        <%@ include file="/common/admin/footer.jsp" %>
      </footer>

    </div>

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
  </body>
</html>