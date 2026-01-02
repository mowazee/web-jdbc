<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Quên Mật Khẩu - HT Store</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
    <style>
        body {
            min-height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            /* Đồng bộ ảnh nền với trang Login/Register */
            background: url('https://images.unsplash.com/photo-1615715874955-59fca38a3515?q=80&w=1170&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D') no-repeat center center fixed;
            background-size: cover;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            padding: 20px;
        }

        .fp-card {
            /* Hiệu ứng kính mờ Glassmorphism */
            background: rgba(255, 255, 255, 0.85);
            backdrop-filter: blur(10px);
            -webkit-backdrop-filter: blur(10px);
            padding: 40px 30px;
            border-radius: 20px;
            box-shadow: 0 15px 50px rgba(0,0,0,0.2);
            width: 100%;
            max-width: 450px;
            border: 1px solid rgba(255, 255, 255, 0.3);
        }

        .fp-card h2 {
            text-align: center;
            margin-bottom: 20px;
            font-weight: bold;
            color: #333;
        }

        .form-label {
            font-weight: 600;
            color: #444;
        }

        .form-control {
            border-radius: 10px;
            height: 48px;
            border: 1px solid rgba(0,0,0,0.1);
        }

        .form-control:focus {
            box-shadow: 0 0 0 0.25rem rgba(165, 94, 234, 0.15);
            border-color: #a55eea;
        }

        .btn-submit {
            padding: 12px;
            border-radius: 10px;
            border: none;
            /* Gradient đồng bộ trang Login */
            background: linear-gradient(90deg, #a55eea, #ff79c6);
            color: #fff;
            font-weight: bold;
            transition: all 0.3s ease;
        }

        .btn-submit:hover {
            background: linear-gradient(90deg, #ff79c6, #a55eea);
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(165, 94, 234, 0.3);
            color: white;
        }

        .btn-back {
            border-radius: 10px;
            padding: 10px;
            font-weight: 600;
        }

        .instruction-text {
            font-size: 0.9rem;
            line-height: 1.5;
            color: #666;
            margin-bottom: 25px;
            text-align: center;
        }
    </style>
</head>
<body>

<div class="fp-card shadow-lg">
    <h2><i class="fas fa-key me-2 text-primary"></i>Quên mật khẩu</h2>

    <%-- Hiển thị thông báo --%>
    <c:if test="${not empty requestScope.error}">
        <div class="alert alert-danger alert-dismissible fade show" role="alert">
            <i class="fas fa-exclamation-triangle me-2"></i>${requestScope.error}
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
    </c:if>
    <c:if test="${not empty requestScope.message}">
        <div class="alert alert-success alert-dismissible fade show" role="alert">
            <i class="fas fa-check-circle me-2"></i>${requestScope.message}
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
    </c:if>

    <p class="instruction-text">
        Nhập địa chỉ email đăng ký của bạn. Chúng tôi sẽ gửi một liên kết để bạn có thể đặt lại mật khẩu mới.
    </p>

    <form action="<c:url value='/forgotpassword'/>" method="post">
        <div class="mb-4">
            <label for="email" class="form-label">Email đăng ký</label>
            <div class="input-group">
                <span class="input-group-text bg-white border-end-0" style="border-radius: 10px 0 0 10px;">
                    <i class="fas fa-envelope text-muted"></i>
                </span>
                <input type="email" class="form-control border-start-0" id="email" name="email" 
                       style="border-radius: 0 10px 10px 0;"
                       placeholder="vi-du@gmail.com" required value="${param.email}">
            </div>
        </div>

        <div class="d-grid gap-3">
            <button type="submit" class="btn btn-submit shadow">
                <i class="fas fa-paper-plane me-2"></i>Gửi liên kết đặt lại
            </button>
            <a href="<c:url value='/login'/>" class="btn btn-outline-secondary btn-back">
                <i class="fas fa-arrow-left me-2"></i>Quay lại Đăng nhập
            </a>
        </div>
    </form>

    <div class="mt-4 pt-3 border-top text-center">
        <p class="small text-muted mb-0">
            Kiểm tra hộp thư rác (Spam) nếu bạn không thấy email trong hộp thư đến.
        </p>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>