<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Đăng Nhập Hệ Thống</title>
    <!-- Bootstrap CSS (v5) -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" />
    <style>
        /* Keep your custom styles here. These ensure full-height centering and polish. */
        html, body {
            height: 100%;
        }
        body {
            background-color: #e9ecef;
            margin: 0;
            padding: 0;
            -webkit-font-smoothing: antialiased;
            -moz-osx-font-smoothing: grayscale;
            font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, 'Helvetica Neue', Arial;
        }
        /* Make the card a bit larger on small screens and add subtle rounding */
        .card {
            border-radius: 12px;
        }
        .card-header {
            border-top-left-radius: 12px;
            border-top-right-radius: 12px;
        }
        /* Improve spacing for form controls */
        .form-control:focus {
            box-shadow: 0 0 0 0.2rem rgba(13,110,253,.15);
        }
        /* Smaller text for the "forgot password" link */
        .form-text a {
            text-decoration: none;
        }
        /* Ensure buttons are full width on mobile */
        @media (max-width: 576px) {
            .col-md-6.col-lg-4 {
                max-width: 420px;
                margin: 0 auto;
            }
        }
    </style>
</head>
<body>

<div class="container d-flex justify-content-center align-items-center" style="min-height: 100vh;">
    <div class="row justify-content-center w-100">
        <div class="col-md-6 col-lg-4">
            <div class="card shadow-lg border-0">
                <div class="card-header bg-primary text-white text-center rounded-top-3">
                    <h5 class="my-1">
                        <i class="fas fa-lock"></i> Đăng Nhập Hệ Thống
                    </h5>
                </div>
                <div class="card-body p-4">
                    
                    <%-- Hiển thị thông báo LỖI --%>
                    <c:if test="${not empty requestScope.error}">
                        <div class="alert alert-danger">${requestScope.error}</div>
                    </c:if>
                    
                    <%-- Form Đăng Nhập --%>
                    <form action="<c:url value='/login'/>" method="post">
                        
                        <div class="mb-3">
                            <label for="username" class="form-label">Tên đăng nhập:</label>
                            <input type="text" 
                                   class="form-control" 
                                   id="username" 
                                   name="username" 
                                   value="${requestScope.username}" 
                                   required>
                        </div>
                        
                        <div class="mb-3">
                            <label for="password" class="form-label">Mật khẩu:</label>
                            <input type="password" class="form-control" id="password" name="password" required>
                            <div class="form-text text-end">
                                <a href="<c:url value='forgotpassword'/>" class="btn btn-outline-primary">Quên mật khẩu?</a>
                            </div>
                        </div>
                        
                        <div class="mb-4 form-check">
                            <input type="checkbox" class="form-check-input" id="rememberMe" name="rememberMe" value="on">
                            <label class="form-check-label" for="rememberMe">Ghi nhớ đăng nhập</label>
                        </div>
                        
                        <div class="d-grid gap-2">
                            <button type="submit" class="btn btn-success btn-lg">Đăng Nhập</button>
                            <hr class="my-3">
                            <a href="<c:url value='/register'/>" class="btn btn-outline-primary">Đăng Ký Tài Khoản Mới</a>
                        </div>
                        
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Bootstrap JS (includes Popper) -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>