<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<head>
    <title>Đăng Nhập Hệ Thống</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" /> 
    <style>
        /* CSS tùy chỉnh cho trang login (vẫn cần 100vh) */
        body {
            /* Vấn đề: body này chỉ áp dụng cho nội dung được chèn */
            background-color: #e9ecef; 
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
            padding: 0; /* Thêm padding: 0 */
        }
        .card {
            border-radius: 15px;
        }
    </style>
</head>

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
                    <form action="<c:url value="/login"/>" method="post">
                        
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
                                <a href="#">Quên mật khẩu?</a>
                            </div>
                        </div>
                        
                        <div class="mb-4 form-check">
                            <input type="checkbox" class="form-check-input" id="rememberMe" name="rememberMe" value="on">
                            <label class="form-check-label" for="rememberMe">Ghi nhớ đăng nhập</label>
                        </div>
                        
                        <div class="d-grid gap-2">
                            <button type="submit" class="btn btn-success btn-lg">Đăng Nhập</button>
                            <hr class="my-3">
                            <a href="<c:url value="/register"/>" class="btn btn-outline-primary">Đăng Ký Tài Khoản Mới</a>
                        </div>
                        
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>