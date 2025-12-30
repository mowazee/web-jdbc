<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="Client Dashboard"/>
    <meta name="author" content="Han Trinh"/>

    <title><sitemesh:write property="title"/> - My Site</title>

    <!-- CSS Dependencies -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" />

    <style>
        html, body { height: 100%; margin: 0; }
        .wrapper { display: flex; flex-direction: column; min-height: 100vh; }
        main { flex: 1 0 auto; }
        /* Custom sidebar styles */
        aside { padding: 1rem; background-color: #f8f9fa; border-radius: 5px; }
        @media (max-width: 991.98px) {
            aside { display: none; } /* Hide sidebar for smaller screens */
        }
    </style>

    <!-- Allows child pages to add content in <head> -->
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
            <aside class="col-lg-3 mb-3 d-none d-lg-block">
                <%@ include file="/common/client/slidebar.jsp" %>
            </aside>

            <!-- Primary content area -->
            <section class="col-12 col-lg-9">
                <sitemesh:write property="body"/>
            </section>
        </div>
    </main>

    <!-- Footer -->
    <footer class="mt-auto bg-light text-center py-3">
        <%@ include file="/common/client/footer.jsp" %>
    </footer>

</div>

<!-- JS Dependencies -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>