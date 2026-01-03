package controller;
import java.io.IOException;
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
import org.mindrot.jbcrypt.BCrypt;

@WebServlet(urlPatterns = {"/login"})
public class LoginController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		HttpSession session = req.getSession(false);
		if (session != null && session.getAttribute("username") != null) {
			resp.sendRedirect(req.getContextPath() + "/waiting");
			return;
		}
		Cookie[] cookies = req.getCookies();
		if (cookies != null) {
			for (Cookie cookie : cookies) {
				if (cookie.getName().equals("username")) {
					session = req.getSession(true);
					session.setAttribute("username", cookie.getValue());
					// Load full UserModel into session when cookie is present so role checks work
					try {
						IUserService userService = new UserServiceImpl();
						UserModel user = userService.findByUsername(cookie.getValue());
						if (user != null) {
							session.setAttribute("user", user);
						}
					} catch (Exception e) {
						// swallow but log; keep cookie-based username so user can still be redirected to waiting
						e.printStackTrace();
					}
					resp.sendRedirect(req.getContextPath() + "/waiting");
					return;
				}
			}
		}
		// pass through any next param to the login view so it can be preserved
		String next = req.getParameter("next");
		if (next != null) req.setAttribute("next", next);
		req.getRequestDispatcher("/views/auth/login.jsp").forward(req, resp);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		resp.setContentType("text/html");
		resp.setCharacterEncoding("UTF-8");
		req.setCharacterEncoding("UTF-8");
		String username = req.getParameter("username");
		String password = req.getParameter("password");
		String remember = req.getParameter("remember");
		String next = req.getParameter("next");
		String alertMsg = "";
		if (username == null || username.isEmpty() || password == null || password.isEmpty()) {
			alertMsg = "Tài khoản hoặc mật khẩu không được rỗng";
			req.setAttribute("alert", alertMsg);
			if (next != null) req.setAttribute("next", next);
			req.getRequestDispatcher("/views/auth/login.jsp").forward(req, resp);
			return;
		}

		IUserService userService = new UserServiceImpl();
		try {
			UserModel user = userService.findByUsername(username);
			if (user != null && user.getPassword() != null && BCrypt.checkpw(password, user.getPassword())) {
				HttpSession session = req.getSession(true);
				// store both username string for legacy checks and full user object
				session.setAttribute("username", user.getUsername());
				session.setAttribute("user", user);

				// handle remember me
				if ("on".equals(remember)) {
					Cookie cookie = new Cookie("username", user.getUsername());
					cookie.setPath(req.getContextPath().isEmpty() ? "/" : req.getContextPath());
					cookie.setMaxAge(7 * 24 * 60 * 60); // 7 days
					resp.addCookie(cookie);
				}

				// if next param provided, validate and redirect to it; otherwise go to waiting
				if (next != null && !next.isEmpty()) {
					// basic safety check: disallow external URLs
					if (!next.startsWith("http://") && !next.startsWith("https://")) {
						// allow absolute path starting with context path or root-relative
						String ctx = req.getContextPath();
						if (next.startsWith(ctx) || next.startsWith("/")) {
							resp.sendRedirect(next);
							return;
						}
					}
				}
				resp.sendRedirect(req.getContextPath() + "/waiting");
				return;
			} else {
				alertMsg = "Tài khoản hoặc mật khẩu không đúng";
				req.setAttribute("alert", alertMsg);
				if (next != null) req.setAttribute("next", next);
				req.getRequestDispatcher("/views/auth/login.jsp").forward(req, resp);
				return;
			}
		} catch (Exception e) {
			// log exception (could be enhanced to use a logger)
			e.printStackTrace();
			alertMsg = "Có lỗi trong quá trình đăng nhập";
			req.setAttribute("alert", alertMsg);
			if (next != null) req.setAttribute("next", next);
			req.getRequestDispatcher("/views/auth/login.jsp").forward(req, resp);
		}
	}
}