<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>

<head>
    <meta charset="UTF-8">
    <title>Đăng nhập</title>
    <style>
        /* Bỏ style cho body cũ, thay bằng lớp bao quanh nội dung */
		.login-container {
		    min-height: calc(100vh - 150px); /* Trừ đi chiều cao ước tính của Header/Footer */
		    display: flex;
		    justify-content: center;
		    align-items: center;
		    /* Đưa background vào đây thay vì body để không đè lên Header */
		    background: url('https://images.unsplash.com/photo-1615715874955-59fca38a3515?q=80&w=1170&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D') no-repeat center center;
		    background-size: cover;
		    padding: 50px 0;
		}
		
		.login-card {
		    margin: 0 auto;
		    background: rgba(255, 255, 255, 0.85);
		    backdrop-filter: blur(10px); /* Giữ hiệu ứng kính mờ cho đẹp */
		    -webkit-backdrop-filter: blur(10px);
		    padding: 40px 30px;
		    border-radius: 20px;
		    box-shadow: 0 15px 50px rgba(0,0,0,0.1);
		    width: 400px;
		}
        .login-card h2 {
            text-align: center;
            margin-bottom: 25px;
            font-weight: bold;
            color: #333;
        }
        .alert {
            text-align: center;
            margin-bottom: 15px;
        }
        .form-control {
            border-radius: 10px;
            height: 48px;
        }
        .btn-login {
            width: 100%;
            padding: 12px;
            border-radius: 10px;
            border: none;
            background: linear-gradient(90deg,#a55eea,#ff79c6);
            color: #fff;
            font-weight: bold;
        }
        .btn-login:hover {
            background: linear-gradient(90deg,#ff79c6,#a55eea);
        }
    </style>
</head>
<body>
    <div class="login-card">
        <h2>Đăng nhập</h2>

        <c:if test="${not empty success}">
            <div class="alert alert-success">${success}</div>
        </c:if>
        
        <c:if test="${not empty alert}">
            <div class="alert alert-danger">${alert}</div>
        </c:if>

        <form action="${pageContext.request.contextPath}/login" method="post">
            <c:if test="${not empty next}">
                <input type="hidden" name="next" value="${next}" />
            </c:if>
            <div class="mb-3 input-group">
                <span class="input-group-text"><i class="fa-solid fa-user"></i></span>
                <input type="text" class="form-control" name="username" placeholder="Tên đăng nhập" required>
            </div>

            <div class="mb-3 input-group">
                <span class="input-group-text"><i class="fa-solid fa-lock"></i></span>
                <input type="password" class="form-control" name="password" id="passwordInput" placeholder="Mật khẩu" required>
                <span class="input-group-text" id="togglePassword" style="cursor:pointer;">
                    <i class="fa-solid fa-eye"></i>
                </span>
            </div>

            <div class="mb-3 d-flex justify-content-between align-items-center">
                <div class="form-check">
                    <input type="checkbox" class="form-check-input" id="rememberMe" name="remember">
                    <label class="form-check-label" for="rememberMe">Ghi nhớ đăng nhập</label>
                </div>
                <a href="${pageContext.request.contextPath}/forgotpassword" class="text-decoration-none text-primary">Quên mật khẩu?</a>
            </div>

            <button type="submit" class="btn btn-login">Đăng nhập</button>
        </form>

        <div class="text-center mt-3">
            <span>Chưa có tài khoản? </span>
            <a href="${pageContext.request.contextPath}/register" class="text-primary">Đăng ký</a> hoặc 
            <a href="${pageContext.request.contextPath}/home" class="text-primary">Về trang chủ</a>
        </div>
    </div>

    <script>
        const togglePassword = document.getElementById('togglePassword');
        const passwordInput = document.getElementById('passwordInput');
        togglePassword.addEventListener('click', function () {
            const type = passwordInput.type === 'password' ? 'text' : 'password';
            passwordInput.type = type;
            this.querySelector('i').classList.toggle('fa-eye-slash');
        });
    </script>
</body>