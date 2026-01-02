package controller;
import java.io.IOException;
import java.sql.Date;
import java.util.UUID;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.UserModel;
import service.IUserService;
import service.impl.UserServiceImpl;
import utils.MailUtil;

@WebServlet(urlPatterns ="/register")
public class RegisterController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	// simple email regex: allow common email formats
	private static final Pattern EMAIL_PATTERN = Pattern.compile("^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}$");

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		HttpSession session = req.getSession(false);// request
		if (session != null && session.getAttribute("username") != null) {
			resp.sendRedirect(req.getContextPath() + "/admin");
			return;
		}
		Cookie[] cookies = req.getCookies();
		if (cookies != null) {
			for (Cookie cookie : cookies) {
				if (cookie.getName().equals("username")) {
					session = req.getSession(true);
					session.setAttribute("username", cookie.getValue());
					resp.sendRedirect(req.getContextPath() + "/admin");
					return;
				}
			}
		}
		req.getRequestDispatcher("/views/auth/register.jsp").forward(req, resp);
	}
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		resp.setCharacterEncoding("UTF-8");
		req.setCharacterEncoding("UTF-8");
		String username = req.getParameter("username");
		String password = req.getParameter("password");
		String confirmPassword = req.getParameter("confirmPassword");
		String email = req.getParameter("email");
		String fullname = req.getParameter("fullname");
		String phone = req.getParameter("phone");
		String address = req.getParameter("address");

		String alertMsg = null;
		// basic server-side validation
		if (username == null || username.trim().isEmpty() || password == null || password.trim().isEmpty() ||
			email == null || email.trim().isEmpty() || fullname == null || fullname.trim().isEmpty()) {
			alertMsg = "Vui lòng điền đầy đủ thông tin bắt buộc: username, email, họ tên, mật khẩu.";
			req.setAttribute("alert", alertMsg);
			req.getRequestDispatcher("/views/auth/register.jsp").forward(req, resp);
			return;
		}

		// normalize email
		email = email.trim().toLowerCase();

		// validate email format
		Matcher m = EMAIL_PATTERN.matcher(email);
		if (!m.matches()) {
			alertMsg = "Email không hợp lệ. Vui lòng nhập email theo dạng example@domain.com";
			req.setAttribute("alert", alertMsg);
			req.getRequestDispatcher("/views/auth/register.jsp").forward(req, resp);
			return;
		}
		if (password.length() < 6) {
			alertMsg = "Mật khẩu phải có ít nhất 6 ký tự";
			req.setAttribute("alert", alertMsg);
			req.getRequestDispatcher("/views/auth/register.jsp").forward(req, resp);
			return;
		}
		if (!password.equals(confirmPassword)) {
			alertMsg = "Mật khẩu và nhập lại mật khẩu không khớp";
			req.setAttribute("alert", alertMsg);
			req.getRequestDispatcher("/views/auth/register.jsp").forward(req, resp);
			return;
		}

		IUserService userService = new UserServiceImpl();
		try {
			if (userService.checkExistEmail(email)) {
				alertMsg = "Email đã tồn tại. Nếu bạn quên mật khẩu, hãy thử chức năng quên mật khẩu.";
				req.setAttribute("alert", alertMsg);
				req.getRequestDispatcher("/views/auth/register.jsp").forward(req, resp);
				return;
			}
			if (userService.checkExistUsername(username)) {
				alertMsg = "Tên đăng nhập đã tồn tại. Vui lòng chọn tên khác.";
				req.setAttribute("alert", alertMsg);
				req.getRequestDispatcher("/views/auth/register.jsp").forward(req, resp);
				return;
			}
			if (phone != null && !phone.trim().isEmpty() && userService.checkExistPhone(phone)) {
				alertMsg = "Số điện thoại đã được sử dụng";
				req.setAttribute("alert", alertMsg);
				req.getRequestDispatcher("/views/auth/register.jsp").forward(req, resp);
				return;
			}

			int roleid = 2; // default regular user
			Date createdate = new Date(System.currentTimeMillis());
			// create activation token
			String token = UUID.randomUUID().toString();
			UserModel u = new UserModel(email, username, fullname, password, null, roleid, phone, address, createdate);
			// set activation token and isActive=0
			u.setActivationToken(token);
			u.setIsActive(0);
			int newId = userService.save(u);
			if (newId > 0) {
				// build activation link
				String activationLink = req.getScheme() + "://" + req.getServerName() + 
					( req.getServerPort() == 80 || req.getServerPort() == 443 ? "" : (":" + req.getServerPort()) )
					+ req.getContextPath() + "/activate?token=" + token;
				// send email (may throw)
				try {
					String subject = "Kích hoạt tài khoản - " + req.getServerName();
					String html = "<p>Xin chào " + fullname + ",</p>"
						+ "<p>Cảm ơn bạn đã đăng ký. Vui lòng click vào liên kết bên dưới để kích hoạt tài khoản:</p>"
						+ "<p><a href=\"" + activationLink + "\">Kích hoạt tài khoản</a></p>"
						+ "<p>Nếu bạn không yêu cầu đăng ký, hãy bỏ qua email này.</p>";
					MailUtil.sendActivationEmail(email, subject, html);
					// success -> redirect to login with success message
					req.setAttribute("success", "Đăng ký thành công! Vui lòng kiểm tra email để kích hoạt tài khoản.");
					// forward to login page showing success
					req.getRequestDispatcher("/views/auth/login.jsp").forward(req, resp);
					return;
				} catch (Exception mailEx) {
					mailEx.printStackTrace();
					// email failed, but user is created; inform user
					alertMsg = "Đăng ký thành công nhưng không thể gửi email kích hoạt. Vui lòng liên hệ quản trị.";
					req.setAttribute("alert", alertMsg);
					req.getRequestDispatcher("/views/auth/register.jsp").forward(req, resp);
					return;
				}
			} else {
				alertMsg = "Đăng ký thất bại, vui lòng thử lại sau";
				req.setAttribute("alert", alertMsg);
				req.getRequestDispatcher("/views/auth/register.jsp").forward(req, resp);
				return;
			}
		} catch (Exception e) {
			e.printStackTrace();
			alertMsg = "Lỗi hệ thống: " + e.getMessage();
			req.setAttribute("alert", alertMsg);
			req.getRequestDispatcher("/views/auth/register.jsp").forward(req, resp);
			return;
		}

	}

}