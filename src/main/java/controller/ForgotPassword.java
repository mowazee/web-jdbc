package controller;

import java.io.IOException;
import java.util.UUID;

import dao.IUserDAO;
import dao.impl.UserDAOImpl;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.UserModel;

@WebServlet(urlPatterns = "/forgotpassword")
public class ForgotPassword extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("/views/auth/forgotpassword.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");

        String email = req.getParameter("email");
        String message = null;
        String error = null;

        if (email == null || email.trim().isEmpty()) {
            error = "Vui lòng nhập địa chỉ email.";
            req.setAttribute("error", error);
            req.getRequestDispatcher("/views/auth/forgotpassword.jsp").forward(req, resp);
            return;
        }

        try {
            IUserDAO userDao = new UserDAOImpl();
            UserModel user = userDao.findByEmail(email.trim());
            // Generate token regardless; do not reveal whether email exists
            String token = UUID.randomUUID().toString();
            // In a real app: persist the token with expiry and send email with reset link containing token.
            if (user != null) {
                // Here we simply log the token for testing.
                System.out.println("[ForgotPassword] Reset token for user '" + user.getUsername() + "' (email=" + email + "): " + token);
            } else {
                // Log attempt for non-existing email as well (no info leak to user)
                System.out.println("[ForgotPassword] Requested reset for non-registered email: " + email + "; generated token: " + token);
            }
            message = "Nếu email tồn tại trong hệ thống, chúng tôi đã gửi liên kết đặt lại mật khẩu (vui lòng kiểm tra hộp thư đến và spam).";
            req.setAttribute("message", message);
            req.getRequestDispatcher("/views/auth/forgotpassword.jsp").forward(req, resp);

        } catch (Exception e) {
            e.printStackTrace();
            error = "Có lỗi hệ thống. Vui lòng thử lại sau.";
            req.setAttribute("error", error);
            req.getRequestDispatcher("/views/auth/forgotpassword.jsp").forward(req, resp);
        }
    }
}