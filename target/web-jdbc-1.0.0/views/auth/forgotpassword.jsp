<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Quên Mật Khẩu</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
    <style>
        html, body { height: 100%; }
        body {
            background-color: #eef2f7;
            font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, 'Helvetica Neue', Arial;
            -webkit-font-smoothing: antialiased;
            -moz-osx-font-smoothing: grayscale;
            margin: 0;
            padding: 0;
        }
        .fp-wrapper {
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 30px 15px;
        }
        .fp-card { border-radius: 12px; max-width: 520px; }
        .form-control:focus { box-shadow: 0 0 0 0.2rem rgba(13,110,253,.12); }
    </style>
</head>
<body>

<div class="fp-wrapper">
    <div class="container-fluid">
        <div class="d-flex justify-content-center w-100">
            <div class="w-100" style="max-width:520px;">
                <div class="card fp-card shadow-sm">
                    <div class="card-header bg-primary text-white text-center py-3">
                        <h5 class="mb-0"><i class="fas fa-key me-2"></i> Quên Mật Khẩu</h5>
                    </div>
                    <div class="card-body p-4">

                        <%-- show success or error messages --%>
                        <c:if test="${not empty requestScope.error}">
                            <div class="alert alert-danger" role="alert">${requestScope.error}</div>
                        </c:if>
                        <c:if test="${not empty requestScope.message}">
                            <div class="alert alert-success" role="alert">${requestScope.message}</div>
                        </c:if>

                        <p class="text-muted">Nhập địa chỉ email của bạn. Chúng tôi sẽ gửi một liên kết để đặt lại mật khẩu.</p>

                        <form action="<c:url value='/forgotpassword'/>" method="post">
                            <div class="mb-3">
                                <label for="email" class="form-label">Email đăng ký</label>
                                <input type="email" class="form-control" id="email" name="email" placeholder="nhập email của bạn" required value="${param.email}">
                            </div>

                            <div class="d-grid gap-2">
                                <button type="submit" class="btn btn-primary btn-lg">Gửi liên kết đặt lại</button>
                                <a href="<c:url value='/login'/>" class="btn btn-outline-secondary">Quay lại Đăng nhập</a>
                            </div>
                        </form>

                        <hr class="my-3">
                        <p class="small text-center text-muted mb-0">Nếu bạn không nhận được email, kiểm tra hộp thư rác hoặc thử lại sau vài phút.</p>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>