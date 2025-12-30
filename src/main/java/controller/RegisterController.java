package controller;
import java.io.IOException;
//import java.sql.Date;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
//import services.UserService;
//import services.impl.UserServiceImpl;

@WebServlet(urlPatterns ="/register")
public class RegisterController extends HttpServlet {
	private static final long serialVersionUID = 1L;

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
//		String username = req.getParameter("username");
//		String password = req.getParameter("password");
//		String email = req.getParameter("email");
//		String fullname = req.getParameter("fullname");
//		String avatar = req.getParameter("avatar");
//		String phone = req.getParameter("phone");
//		int roleid = Integer.parseInt(req.getParameter("roleid"));
//        Date createdate = new java.sql.Date(System.currentTimeMillis());
		//UserService service = new UserServiceImpl();
//		String alertMsg = "";
//		if (service.checkExistEmail(email)) {
//			alertMsg = "Email đã tồn tại!";
//			req.setAttribute("alert", alertMsg);
//			req.getRequestDispatcher("views/register.jsp").forward(req, resp);
//			return;
//		}
//		if (service.checkExistUsername(username)) {
//			alertMsg = "Tài khoản đã tồn tại!";
//			req.setAttribute("alert", alertMsg);
//			req.getRequestDispatcher("views/register.jsp").forward(req, resp);
//		} else {
//			boolean isSuccess = service.register(email,  username,  fullname,  password,  avatar,  roleid, phone, createdate);
//			if (isSuccess) {
//				// Nếu muốn gửi mail thì mở lại phần này
//				// SendMail sm = new SendMail();
//				// sm.sendMail(email, "Shopping.iotstar.vn",
//				// "Welcome to Shopping. Please login to use service. Thanks!");
//				alertMsg = "Đăng ký thành công! Vui lòng đăng nhập.";
//				req.setAttribute("alert", alertMsg);
//				resp.sendRedirect(req.getContextPath() +"/login");
//			} else {
//				alertMsg = "System error!";
//				req.setAttribute("alert", alertMsg);
//				req.getRequestDispatcher("views/register.jsp").forward(req, resp);
//			}
//		}

	}

}
