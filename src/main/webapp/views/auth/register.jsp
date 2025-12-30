<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Đăng Ký Tài Khoản Mới</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
    <style>
        /* CSS TÙY CHỈNH: Áp dụng style cho container để căn giữa màn hình */
        .register-page-wrapper {
            /* Đảm bảo container này chiếm ít nhất toàn bộ chiều cao của viewport */
            min-height: 100vh;
            /* Căn giữa form */
            display: flex;
            justify-content: center;
            align-items: center;
            /* Màu nền nhẹ cho trang */
            background-color: #f0f2f5;
            padding: 30px 0;
        }

        .register-card {
            border-radius: 10px;
            max-width: 550px; /* Tăng kích thước để chứa nhiều trường hơn */
        }

        .card-header {
            border-top-left-radius: 10px !important;
            border-top-right-radius: 10px !important;
        }

        /* Small tweaks for inputs and buttons */
        .form-control:focus {
            box-shadow: 0 0 0 0.2rem rgba(25,135,84,.12);
        }
    </style>
</head>
<body>
<div class="register-page-wrapper">
    <!-- Use container-fluid and a single flex wrapper so the card centers reliably -->
    <div class="container-fluid">
        <div class="d-flex justify-content-center w-100">
            <!-- constrained-width wrapper centers card and prevents left-alignment -->
            <div class="w-100" style="max-width: 560px;">

                <div class="card shadow-lg border-0 register-card w-100">
                    <div class="card-header bg-success text-white text-center py-3">
                        <h4 class="mb-0">
                            <i class="fas fa-user-plus me-2"></i> Tạo Tài Khoản Mới
                        </h4>
                    </div>

                    <div class="card-body p-4">

                        <%-- Hiển thị thông báo LỖI --%>
                        <c:if test="${alert != null}">
                            <div class="alert alert-danger" role="alert"><strong>Thông báo:</strong> ${alert}</div>
                        </c:if>

                        <%-- Form Đăng Ký --%>
                        <form action="<c:url value='/register'/>" method="post" enctype="multipart/form-data">

                            <div class="row">
                                <div class="col-md-6">
                                    <div class="mb-3">
                                        <label for="username" class="form-label fw-bold">Tên đăng nhập:</label>
                                        <input type="text" class="form-control" id="username" name="username"
                                               required value="${param.username}">
                                    </div>

                                    <div class="mb-3">
                                        <label for="fullname" class="form-label fw-bold">Họ và Tên:</label>
                                        <input type="text" class="form-control" id="fullname" name="fullname"
                                               required value="${param.fullname}">
                                    </div>

                                    <div class="mb-3">
                                        <label for="email" class="form-label fw-bold">Email:</label>
                                        <input type="email" class="form-control" id="email" name="email"
                                               required value="${param.email}">
                                    </div>

                                    <div class="mb-3">
                                        <label for="password" class="form-label fw-bold">Mật khẩu:</label>
                                        <input type="password" class="form-control" id="password" name="password" required>
                                    </div>
                                </div>

                                <div class="col-md-6">
                                    <div class="mb-3">
                                        <label for="phone" class="form-label fw-bold">Số điện thoại:</label>
                                        <input type="tel" class="form-control" id="phone" name="phone"
                                               value="${param.phone}">
                                    </div>

                                    <div class="mb-3">
                                        <label for="avatar" class="form-label fw-bold">Upload Avatar:</label>
                                        <input type="file" class="form-control" id="avatar" name="avatar" accept="image/*">
                                    </div>
                                </div>
                            </div>

                            <hr>
                            <div class="d-grid gap-2">
                                <button type="submit" class="btn btn-success btn-lg shadow">
                                    <i class="fas fa-paper-plane me-2"></i> Hoàn tất Đăng Ký
                                </button>
                            </div>

                            <div class="text-center mt-3">
                                <a href="<c:url value='/login'/>" class="text-decoration-none">
                                    Đã có tài khoản? Đăng nhập ngay!
                                </a>
                            </div>

                        </form>
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