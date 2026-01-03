<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>


<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    
    <title>Liên hệ với chúng tôi</title>
    
    <style>
        /* Compact CSS for contact form */
        .contact-container {
            padding: 24px 0; /* reduced from 50px */
            font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, "Helvetica Neue", Arial, sans-serif;
        }

        .contact-title {
            color: #333;
            font-weight: bold;
            margin-bottom: 0.6rem; /* tighter spacing */
            font-size: 1.4rem;
        }

        .contact-description {
            color: #666;
            margin-bottom: 1.2rem; /* reduce spacing */
            font-size: 0.95rem;
        }

        .company-name {
            font-weight: bold;
            font-size: 1rem;
            margin-bottom: 0.8rem;
        }

        .contact-info-item {
            display: flex;
            align-items: flex-start;
            margin-bottom: 0.9rem;
        }

        .contact-info-icon {
            color: #1976D2;
            font-size: 1.05rem;
            margin-right: 12px;
            margin-top: 2px;
        }

        .contact-info-text {
            color: #333;
            line-height: 1.4;
            font-size: 0.95rem;
        }

        /* Compact card */
        .contact-form-card {
            background: #fff;
            border: 1px solid #e0e0e0;
            border-radius: 12px;
            padding: 20px; /* reduced from 40px */
            box-shadow: 0 4px 12px rgba(0,0,0,0.06);
        }

        .form-title {
            text-align: center;
            color: #F9A825;
            font-weight: 700;
            margin-bottom: 1.2rem;
            font-size: 1.25rem;
        }

        .form-group {
            margin-bottom: 0.9rem;
            position: relative;
        }

        .form-control {
            border-radius: 6px;
            border: 1px solid #ced4da;
            padding: 8px 12px; /* reduced from 12/15 */
            padding-right: 38px; /* space for icon */
            font-size: 0.95rem;
            height: auto; /* allow smaller inputs */
        }

        /* Icon position */
        .form-icon {
            position: absolute;
            right: 12px;
            top: 50%;
            transform: translateY(-50%);
            color: #aaa;
            font-size: 0.95rem;
        }
        
        .form-icon-textarea {
             position: absolute;
             right: 12px;
             top: 12px;
             color: #aaa;
        }

        .btn-submit {
            background-color: #37474F;
            color: white;
            font-weight: 600;
            padding: 10px 22px; /* slightly smaller */
            border-radius: 8px;
            border: none;
            width: 100%;
            transition: all 0.18s ease;
            font-size: 0.95rem;
        }

        .btn-submit:hover {
            background-color: #263238;
            transform: translateY(-1px);
        }

        /* Responsive tweaks for small screens */
        @media (max-width: 576px) {
            .contact-container { padding: 16px 0; }
            .contact-form-card { padding: 16px; }
            .contact-title { font-size: 1.2rem; }
        }
        /* Container cho mỗi dòng thông tin */
		.contact-info-item {
		    display: flex;
		    align-items: flex-start; /* Giữ icon thẳng hàng với dòng văn bản đầu tiên */
		    margin-bottom: 1.2rem;
		    transition: all 0.3s ease;
		}
		
		/* Vùng chứa Icon - Cực kỳ quan trọng để văn bản thẳng hàng */
		.contact-info-icon {
		    color: #1976D2;
		    font-size: 1.1rem;
		    width: 30px;      /* Cố định độ rộng để văn bản bên phải luôn thẳng hàng dọc */
		    min-width: 30px;  /* Ngăn icon bị bóp méo trên màn hình nhỏ */
		    display: flex;
		    justify-content: center; /* Căn giữa icon trong vùng 30px */
		    margin-top: 3px;  /* Căn chỉnh chính xác để icon ngang tâm dòng chữ đầu tiên */
		}
		
		.contact-info-text {
		    color: #444;
		    line-height: 1.6; /* Tăng khoảng cách dòng để dễ đọc và sang trọng hơn */
		    font-size: 0.95rem;
		    flex: 1;          /* Để văn bản chiếm hết phần còn lại */
		}
		
		/* Hiệu ứng sang trọng khi hover */
		.contact-info-item:hover .contact-info-icon {
		    transform: scale(1.2);
		    color: #F9A825;
		}
		.form-group {
		    margin-bottom: 1rem;
		    position: relative;
		}
		
		.form-control {
		    border: 1.5px solid #eee; /* Viền mảnh và nhạt hơn cho sang trọng */
		    border-radius: 8px;
		    padding: 10px 15px;
		    padding-right: 40px; 
		    font-size: 0.9rem;
		    transition: border-color 0.3s ease;
		}
		
		.form-control:focus {
		    border-color: #1976D2;
		    box-shadow: none; /* Bỏ viền xanh mặc định của Bootstrap */
		}
		
		/* Căn giữa icon trong input theo chiều dọc tuyệt đối */
		.form-icon {
		    position: absolute;
		    right: 15px;
		    top: 50%;
		    transform: translateY(-50%);
		    color: #bdc3c7; /* Màu xám nhẹ tinh tế */
		    font-size: 0.9rem;
		    pointer-events: none; /* Tránh cản trở việc click vào input */
		}
		
		.form-icon-textarea {
		    position: absolute;
		    right: 15px;
		    top: 15px;
		    color: #bdc3c7;
		    font-size: 0.9rem;
		}
    </style>
</head>
<body>

<div class="container contact-container">
    <!-- flash messages -->
    <c:if test="${not empty sessionScope.contactSuccess}">
        <div class="alert alert-success">${sessionScope.contactSuccess}</div>
        <c:remove var="contactSuccess" scope="session" />
    </c:if>
    <c:if test="${not empty sessionScope.contactError}">
        <div class="alert alert-danger">${sessionScope.contactError}</div>
        <c:remove var="contactError" scope="session" />
    </c:if>

    <div class="row align-items-start">
        <div class="col-lg-5 pe-lg-5 mb-5 mb-lg-0">
            <h2 class="contact-title">Liên hệ với chúng tôi</h2>
            <p class="contact-description">
                Chúng tôi luôn sẵn sàng trả lời bất kỳ câu hỏi nào của bạn, cung cấp các bản demo sản phẩm và tìm ra gói sản phẩm hoàn hảo cho bạn.
            </p>

            <h5 class="company-name">WP Store</h5>

            <div class="contact-info-item">
                <div class="contact-info-icon"><i class="fas fa-map-marker-alt"></i></div>
                <div class="contact-info-text">HCMUTE, Thành phố Hồ Chí Minh, Việt Nam</div>
            </div>

            <div class="contact-info-item">
                <div class="contact-info-icon"><i class="fas fa-phone-alt"></i></div>
                <div class="contact-info-text"><strong>0989899xxx</strong></div>
            </div>

            <div class="contact-info-item">
                <div class="contact-info-icon"><i class="fas fa-headset"></i></div>
                <div class="contact-info-text">1900 100 có</div>
            </div>

            <div class="contact-info-item">
                <div class="contact-info-icon"><i class="fas fa-envelope"></i></div>
                <div class="contact-info-text">contact@wpstore.vn</div>
            </div>

            <div class="contact-info-item">
                <div class="contact-info-icon"><i class="fas fa-university"></i></div>
                <div class="contact-info-text"><strong>999.999.999</strong> – Ngân hàng TNHH Một Mình Tui</div>
            </div>
        </div>

        <div class="col-lg-7">
            <div class="contact-form-card">
                <h3 class="form-title">Yêu cầu tư vấn ngay</h3>
                
                <form action="${pageContext.request.contextPath}/request-support" method="post">
                    <div class="form-group">
                        <input type="text" class="form-control" id="fullName" name="fullName" placeholder="Họ tên *" required>
                        <i class="fas fa-user form-icon"></i>
                    </div>

                    <div class="form-group">
                        <input type="tel" class="form-control" id="phone" name="phone" placeholder="Số điện thoại *" required>
                        <i class="fas fa-phone form-icon"></i>
                    </div>

                    <div class="form-group">
                        <input type="email" class="form-control" id="email" name="email" placeholder="Email">
                        <i class="fas fa-envelope form-icon"></i>
                    </div>

                    <div class="form-group">
                        <input type="text" class="form-control" id="address" name="address" placeholder="Địa chỉ">
                        <i class="fas fa-pen form-icon"></i>
                    </div>

                    <div class="form-group">
                        <textarea class="form-control" id="message" name="message" rows="4" placeholder="Nội dung cần tư vấn/ hỗ trợ *" required></textarea>
                        <i class="far fa-comment-dots form-icon-textarea"></i>
                    </div>

                    <div class="text-center mt-4">
                        <button type="submit" class="btn-submit">GỬI THÔNG TIN</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

</body>