<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Đăng Ký Tài Khoản - HT Store</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
    <style>
        body {
            min-height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            /* Sử dụng cùng ảnh nền với trang Login */
            background: url('https://images.unsplash.com/photo-1615715874955-59fca38a3515?q=80&w=1170&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D') no-repeat center center fixed;
            background-size: cover;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            padding: 20px;
        }

        .register-card {
            /* Hiệu ứng kính mờ (Glassmorphism) đồng bộ trang login */
            background: rgba(255, 255, 255, 0.85);
            backdrop-filter: blur(10px);
            -webkit-backdrop-filter: blur(10px);
            padding: 40px 30px;
            border-radius: 20px;
            box-shadow: 0 15px 50px rgba(0,0,0,0.2);
            width: 100%;
            max-width: 650px; /* Độ rộng tối ưu cho form 2 cột */
            border: 1px solid rgba(255, 255, 255, 0.3);
        }

        .register-card h2 {
            text-align: center;
            margin-bottom: 25px;
            font-weight: bold;
            color: #333;
        }

        .form-label {
            font-weight: 600;
            color: #444;
            margin-bottom: 8px;
        }

        .form-control {
            border-radius: 10px;
            height: 45px;
            border: 1px solid rgba(0,0,0,0.1);
        }

        .form-control:focus {
            box-shadow: 0 0 0 0.25rem rgba(165, 94, 234, 0.15);
            border-color: #a55eea;
        }

        .btn-register {
            width: 100%;
            padding: 12px;
            border-radius: 10px;
            border: none;
            /* Sử dụng cùng màu Gradient với nút Login */
            background: linear-gradient(90deg, #a55eea, #ff79c6);
            color: #fff;
            font-weight: bold;
            font-size: 1.1rem;
            transition: all 0.3s ease;
        }

        .btn-register:hover {
            background: linear-gradient(90deg, #ff79c6, #a55eea);
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(165, 94, 234, 0.3);
            color: white;
        }

        .login-link {
            text-decoration: none;
            color: #a55eea;
            font-weight: bold;
        }

        .login-link:hover {
            color: #ff79c6;
        }

        /* Responsive cho mobile */
        @media (max-width: 576px) {
            .register-card {
                padding: 25px 20px;
            }
        }
    </style>
</head>
<body>

    <div class="register-card shadow-lg">
        <h2><i class="fas fa-user-plus me-2"></i>Đăng ký tài khoản</h2>

        <%-- Hiển thị thông báo LỖI --%>
        <c:if test="${not empty alert}">
            <div class="alert alert-danger alert-dismissible fade show" role="alert">
                <i class="fas fa-exclamation-circle me-2"></i>${alert}
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
        </c:if>

        <form id="registerForm" action="<c:url value='/register'/>" method="post">
            <div class="row">
                <div class="col-md-6">
                    <div class="mb-3">
                        <label for="username" class="form-label">Tên đăng nhập</label>
                        <input type="text" class="form-control" id="username" name="username" 
                               placeholder="Nhập username" required value="${param.username}">
                    </div>
                    <div class="mb-3">
                        <label for="fullname" class="form-label">Họ và Tên</label>
                        <input type="text" class="form-control" id="fullname" name="fullname" 
                               placeholder="Nhập họ tên" required value="${param.fullname}">
                    </div>
                    <div class="mb-3">
                        <label for="password" class="form-label">Mật khẩu</label>
                        <input type="password" class="form-control" id="password" name="password" 
                               placeholder="********" required>
                    </div>
                    <div class="mb-3">
                        <label for="confirmPassword" class="form-label">Nhập lại mật khẩu</label>
                        <input type="password" class="form-control" id="confirmPassword" name="confirmPassword" 
                               placeholder="Nhập lại mật khẩu" required>
                    </div>
                </div>

                <div class="col-md-6">
                    <div class="mb-3">
                        <label for="email" class="form-label">Email</label>
                        <input type="email" class="form-control" id="email" name="email" 
                               placeholder="vi-du@gmail.com" required value="${param.email}">
                    </div>
                    <div class="mb-3">
                        <label for="phone" class="form-label">Số điện thoại</label>
                        <input type="tel" class="form-control" id="phone" name="phone" 
                               placeholder="09xx..." value="${param.phone}">
                    </div>
                    <div class="mb-3">
                        <label for="address" class="form-label">Địa chỉ</label>
                        <input type="text" class="form-control" id="address" name="address" 
                               placeholder="Nhập địa chỉ" value="${param.address}">
                    </div>
                </div>
            </div>

            <div class="mt-4">
                <button type="submit" class="btn btn-register">
                    <i class="fas fa-paper-plane me-2"></i>Hoàn tất Đăng ký
                </button>
            </div>

            <div class="text-center mt-3">
                <span class="text-muted">Đã có tài khoản? </span>
                <a href="<c:url value='/login'/>" class="login-link">Đăng nhập ngay</a>
            </div>
        </form>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Client-side validation: ensure required fields and password match
        document.getElementById('registerForm').addEventListener('submit', function (e) {
            var pw = document.getElementById('password').value;
            var cpw = document.getElementById('confirmPassword').value;
            if (pw !== cpw) {
                e.preventDefault();
                alert('Mật khẩu và nhập lại mật khẩu phải giống nhau');
                return false;
            }
            // minimal password length check
            if (pw.length < 6) {
                e.preventDefault();
                alert('Mật khẩu phải có ít nhất 6 ký tự');
                return false;
            }
            return true;
        });
    </script>
</body>
</html>