package controller;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
//import models.UserModel;

@SuppressWarnings("serial")
@WebServlet(urlPatterns = "/waiting")
public class WaitingController extends HttpServlet {
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		HttpSession session = req.getSession();
		if (session != null && session.getAttribute("username") != null) {
			//UserModel user = (UserModel) session.getAttribute("username");
			//req.setAttribute("username", user);
//			if (user.getRoleid() == 1) {
//				resp.sendRedirect(req.getContextPath() + "/admin/home");
//			} else if (user.getRoleid() == 2) {
//				resp.sendRedirect(req.getContextPath() + "/home");
//			} else {
//				resp.sendRedirect(req.getContextPath() + "/home");
//			}
//		} else {
//			resp.sendRedirect(req.getContextPath() + "/login");
		}
	}
}