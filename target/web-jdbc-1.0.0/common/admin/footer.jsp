<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>  

<footer class="bg-transparent text-dark py-4"> 
    <div class="container">
        <div class="row">

            <div class="col-md-4 mb-3"> <h5 class="text-uppercase fw-bold mb-3"> <i class="fas fa-store me-2"></i> Web Bán Hàng
                </h5>
                <p class="small text-dark">
                    Chuyên cung cấp các sản phẩm đặc sản địa phương chất lượng, uy tín.
                    Luôn cam kết mang lại trải nghiệm mua sắm tốt nhất cho khách hàng.
                </p>
            </div>

            <div class="col-md-2 mb-3"> <h5 class="text-uppercase fw-bold mb-3">Danh Mục</h5> <ul class="list-unstyled">
                    <li><a href="<c:url value='/products/category?id=1'/>" class="text-dark text-decoration-none small">Gạo thơm</a></li>
                    <li><a href="<c:url value='/products/category?id=2'/>" class="text-dark text-decoration-none small">Gạo đặc sản</a></li>
                    <li><a href="<c:url value='/products/category?id=3'/>" class="text-dark text-decoration-none small">Gạo nếp</a></li>
                    <li><a href="<c:url value='news'/>" class="text-dark text-decoration-none small">Tin Tức và Blog</a></li>
                </ul>
            </div>

            <div class="col-md-2 mb-3"> <h5 class="text-uppercase fw-bold mb-3">Hỗ Trợ</h5> <ul class="list-unstyled">
                    <li><a href="#" class="text-dark text-decoration-none small">Chính sách đổi trả</a></li>
                    <li><a href="#" class="text-dark text-decoration-none small">Hướng dẫn mua hàng</a></li>
                    <li><a href="#" class="text-dark text-decoration-none small">Điều khoản dịch vụ</a></li>
                    <li><a href="#" class="text-dark text-decoration-none small">FAQ</a></li>
                </ul>
            </div>

            <div class="col-md-4 mb-3"> <h5 class="text-uppercase fw-bold mb-3">Liên Hệ</h5> <p class="small text-dark"><i class="fas fa-home me-3"></i> Võ Văn Ngân, Phường Thủ Đức, TP. Hồ Chí Minh</p>
                <p class="small text-dark"><i class="fas fa-envelope me-3"></i> support@wpstore.vn</p>
                <p class="small text-dark"><i class="fas fa-phone me-3"></i> + 84 9123 45..</p>
                
                <div class="mt-2"> <a href="#" class="btn btn-outline-dark btn-sm me-2"><i class="fab fa-facebook-f"></i></a>
                    <a href="#" class="btn btn-outline-dark btn-sm me-2"><i class="fab fa-twitter"></i></a>
                    <a href="#" class="btn btn-outline-dark btn-sm"><i class="fab fa-instagram"></i></a>
                </div>
            </div>

        </div>
    </div>
</footer>