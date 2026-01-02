package controller;

import java.io.IOException;
import java.sql.Timestamp;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.UserModel;
import service.IUserService;
import service.impl.UserServiceImpl;

@WebServlet(urlPatterns = "/resetpassword")
public class ResetPasswordController extends HttpServlet {
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
            UserModel u = userService.findByResetToken(token);
            if (u == null) {
                req.setAttribute("alert", "Token không hợp lệ hoặc đã hết hạn");
                req.getRequestDispatcher("/views/client/register-succes.jsp").forward(req, resp);
                return;
            }
            // check expiry
            Timestamp expiry = u.getResetTokenExpiry();
            if (expiry == null || expiry.getTime() < System.currentTimeMillis()) {
                req.setAttribute("alert", "Token đã hết hạn. Vui lòng yêu cầu đặt lại mật khẩu lại.");
                req.getRequestDispatcher("/views/client/register-succes.jsp").forward(req, resp);
                return;
            }
            req.setAttribute("token", token);
            // show reset form located under views/client/resetpassword.jsp
            req.getRequestDispatcher("/views/client/resetpassword.jsp").forward(req, resp);
        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("alert", "Có lỗi hệ thống");
            req.getRequestDispatcher("/views/client/register-succes.jsp").forward(req, resp);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");
        String token = req.getParameter("token");
        String password = req.getParameter("password");
        String confirm = req.getParameter("confirmPassword");
        if (token == null || token.isEmpty()) {
            req.setAttribute("alert", "Token không hợp lệ");
            req.getRequestDispatcher("/views/client/register-succes.jsp").forward(req, resp);
            return;
        }
        if (password == null || password.length() < 6) {
            req.setAttribute("alert", "Mật khẩu phải có ít nhất 6 ký tự");
            req.setAttribute("token", token);
            req.getRequestDispatcher("/views/client/resetpassword.jsp").forward(req, resp);
            return;
        }
        if (!password.equals(confirm)) {
            req.setAttribute("alert", "Mật khẩu và xác nhận không khớp");
            req.setAttribute("token", token);
            req.getRequestDispatcher("/views/client/resetpassword.jsp").forward(req, resp);
            return;
        }
        IUserService userService = new UserServiceImpl();
        try {
            // verify token and expiry
            UserModel u = userService.findByResetToken(token);
            if (u == null) {
                req.setAttribute("alert", "Token không hợp lệ hoặc đã hết hạn");
                req.getRequestDispatcher("/views/client/register-succes.jsp").forward(req, resp);
                return;
            }
            Timestamp expiry = u.getResetTokenExpiry();
            if (expiry == null || expiry.getTime() < System.currentTimeMillis()) {
                req.setAttribute("alert", "Token đã hết hạn. Vui lòng yêu cầu đặt lại mật khẩu lại.");
                req.getRequestDispatcher("/views/client/register-succes.jsp").forward(req, resp);
                return;
            }
            boolean ok = userService.updatePasswordByResetToken(token, password);
            if (ok) {
                req.setAttribute("success", "Đặt lại mật khẩu thành công. Vui lòng đăng nhập.");
                req.getRequestDispatcher("/views/client/register-succes.jsp").forward(req, resp);
                return;
            } else {
                req.setAttribute("alert", "Không thể cập nhật mật khẩu. Vui lòng thử lại.");
                req.setAttribute("token", token);
                req.getRequestDispatcher("/views/client/resetpassword.jsp").forward(req, resp);
                return;
            }
        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("alert", "Có lỗi hệ thống");
            req.getRequestDispatcher("/views/client/register-succes.jsp").forward(req, resp);
            return;
        }
    }
}