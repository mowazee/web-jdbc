package controller;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse; 
import jakarta.servlet.http.HttpSession;
import utils.MailUtil;

@WebServlet(urlPatterns = {"/request-support", "/purchase-register"})
public class ContactController extends HttpServlet {
private static final long serialVersionUID = 1L;
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// For simple GETs, redirect to contact page
        resp.sendRedirect(req.getContextPath() + "/contact");
	}
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
	    req.setCharacterEncoding("UTF-8");
	    String path = req.getServletPath();
	    HttpSession session = req.getSession(true);
	    try {
	        if ("/request-support".equals(path)) {
	            // collect fields from contact form
	            String fullName = trim(req.getParameter("fullName"));
	            String phone = trim(req.getParameter("phone"));
	            String email = trim(req.getParameter("email"));
	            String address = trim(req.getParameter("address"));
	            String message = trim(req.getParameter("message"));

	            if ((fullName == null || fullName.isEmpty()) || (phone == null || phone.isEmpty()) || (message == null || message.isEmpty())) {
	                session.setAttribute("contactError", "Vui lòng điền đầy đủ thông tin bắt buộc (Họ tên, SĐT, Nội dung).");
	                resp.sendRedirect(req.getContextPath() + "/contact");
	                return;
	            }

	            String subject = "Yêu cầu tư vấn / Liên hệ từ " + fullName;
	            StringBuilder sb = new StringBuilder();
	            sb.append("<h3>Yêu cầu tư vấn / liên hệ mới</h3>");
	            sb.append("<p><strong>Họ tên:</strong> " + escapeHtml(fullName) + "</p>");
	            sb.append("<p><strong>Số điện thoại:</strong> " + escapeHtml(phone) + "</p>");
	            sb.append("<p><strong>Email:</strong> " + (email==null?"-":escapeHtml(email)) + "</p>");
	            sb.append("<p><strong>Địa chỉ:</strong> " + (address==null?"-":escapeHtml(address)) + "</p>");
	            sb.append("<p><strong>Nội dung:</strong><br/>" + (message==null?"-":escapeHtml(message)) + "</p>");

	            // send email to site owner
	            MailUtil.sendActivationEmail("hantrinh1509s@gmail.com", subject, sb.toString());

	            // set a unified purchase/register notification and redirect to notification page
	            session.setAttribute("purchaseRegisterMessage", "Cám ơn bạn đã gửi yêu cầu. Chúng tôi sẽ liên hệ lại sớm.");
	            session.setAttribute("purchaseRegisterSuccess", Boolean.TRUE);
	            resp.sendRedirect(req.getContextPath() + "/views/client/purchaseregister.jsp");
	            return;
	        } else if ("/purchase-register".equals(path)) {
	            // purchase registration from floating form
	            String customerName = trim(req.getParameter("customerName"));
	            String customerPhone = trim(req.getParameter("customerPhone"));
	            String productInterest = trim(req.getParameter("productInterest"));
	            String address = trim(req.getParameter("address"));

	            if ((customerName == null || customerName.isEmpty()) || (customerPhone == null || customerPhone.isEmpty()) || (productInterest == null || productInterest.isEmpty())) {
	                session.setAttribute("purchaseError", "Vui lòng điền đầy đủ thông tin (Họ tên, SĐT, Sản phẩm quan tâm). ");
	                String referer = req.getHeader("Referer");
	                resp.sendRedirect(referer != null ? referer : req.getContextPath() + "/home");
	                return;
	            }

	            String subject = "Đăng ký mua hàng từ " + customerName;
	            StringBuilder sb = new StringBuilder();
	            sb.append("<h3>Đăng ký mua hàng mới</h3>");
	            sb.append("<p><strong>Họ tên:</strong> " + escapeHtml(customerName) + "</p>");
	            sb.append("<p><strong>Số điện thoại:</strong> " + escapeHtml(customerPhone) + "</p>");
	            sb.append("<p><strong>Sản phẩm quan tâm:</strong> " + escapeHtml(productInterest) + "</p>");
	            sb.append("<p><strong>Địa chỉ:</strong> " + (address==null?"-":escapeHtml(address)) + "</p>");

	            MailUtil.sendActivationEmail("hantrinh1509s@gmail.com", subject, sb.toString());

	            // redirect to unified notification page
	            session.setAttribute("purchaseRegisterMessage", "Cảm ơn! Yêu cầu mua hàng đã được gửi. Chúng tôi sẽ liên hệ sớm.");
	            session.setAttribute("purchaseRegisterSuccess", Boolean.TRUE);
	            resp.sendRedirect(req.getContextPath() + "/views/client/purchaseregister.jsp");
	            return;
	        } else {
	            resp.sendError(HttpServletResponse.SC_NOT_FOUND);
	            return;
	        }
	    } catch (Exception e) {
	        e.printStackTrace();
	        // set failure message on notification page
	        session.setAttribute("purchaseRegisterMessage", "Đã xảy ra lỗi khi gửi thông tin: " + e.getMessage());
	        session.setAttribute("purchaseRegisterSuccess", Boolean.FALSE);
	        resp.sendRedirect(req.getContextPath() + "/views/client/purchaseregister.jsp");
             return;
        }
	}

	private String trim(String v) { return v == null ? null : v.trim(); }
	private String escapeHtml(String s) { if (s == null) return null; return s.replaceAll("&","&amp;").replaceAll("<","&lt;").replaceAll(">","&gt;").replaceAll("\"","&quot;").replaceAll("'","&#x27;"); }
}