<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="sitemesh" uri="http://www.opensymphony.net/sitemesh/decorator" %>
<!DOCTYPE html>
<html lang="vi">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title><sitemesh:write property="title"/> - My Site</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" />

<style>
html, body { height: 100%; margin: 0; }
.wrapper { display: flex; flex-direction: column; min-height: 100vh; }
main { flex: 1 0 auto; }
</style>

<sitemesh:write property="head"/>
</head>
<body>
<div class="wrapper">

  <!-- Header / Navbar -->
  <header>
    <%@ include file="/common/client/header.jsp" %>
    <%@ include file="/common/client/navbar.jsp" %>
  </header>

  <!-- Main content -->
  <main class="container py-4">
    <div class="row">
      <!-- Optional sidebar for larger screens -->
      <aside class="col-12 col-lg-3 mb-3 d-none d-lg-block">
        <%@ include file="/common/client/slidebar.jsp" %>
      </aside>

      <section class="col-12 col-lg-9">
        <sitemesh:write property="body"/>
      </section>
    </div>
  </main>

  <!-- Footer -->
  <footer class="mt-auto">
    <%@ include file="/common/client/footer.jsp" %>
  </footer>

</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>