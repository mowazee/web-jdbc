package controller;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/logout")
public class LogoutController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		// 1. Xóa session
		HttpSession session = request.getSession(false); // không tạo mới nếu chưa có
		if (session != null) {
			session.invalidate();
		}

		// 2. Xóa cookie (ví dụ cookie lưu login)
		Cookie[] cookies = request.getCookies();
		if (cookies != null) {
			for (Cookie cookie : cookies) {
				if ("username".equals(cookie.getName()) || "password".equals(cookie.getName())) {
					cookie.setValue(""); // xóa giá trị
					cookie.setPath("/"); // cần set path
					cookie.setMaxAge(0); // xóa cookie
					response.addCookie(cookie);
				}
			}
		}

		// Redirect to login servlet
		response.sendRedirect(request.getContextPath() + "/home");
	}

	// Optional: nếu dùng POST
	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request, response);
	}

}