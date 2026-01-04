package controller;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import service.IUserService;
import service.impl.UserServiceImpl;

@WebServlet(urlPatterns = "/activate") 
public class ActivateController extends HttpServlet  {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String token = req.getParameter("token");
        if (token == null || token.isEmpty()) {
            req.setAttribute("alert", "Token không hợp lệ");
            req.getRequestDispatcher("/views/client/register-succes.jsp").forward(req, resp);
            return;
        }
        IUserService userService = new UserServiceImpl();
        try {
            boolean ok = userService.activate(token);
            if (ok) {
                req.setAttribute("success", "Kích hoạt tài khoản thành công. Vui lòng đăng nhập.");
                req.getRequestDispatcher("/views/client/register-succes.jsp").forward(req, resp);
                return;
            } else {
                req.setAttribute("alert", "Token không hợp lệ hoặc đã được sử dụng.");
                req.getRequestDispatcher("/views/client/register-succes.jsp").forward(req, resp);
                return;
            }
        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("alert", "Có lỗi trong quá trình kích hoạt: " + e.getMessage());
            req.getRequestDispatcher("/views/client/register-succes.jsp").forward(req, resp);
            return;
        }
    }
}
