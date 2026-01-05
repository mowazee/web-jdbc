package controller;
import java.io.IOException;
import java.util.UUID;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse; 
import service.IUserService;
import utils.MailUtil;
@WebServlet(urlPatterns = "/forgotpassword")
public class ForgotPasswordController extends HttpServlet {
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
            IUserService userService = new service.impl.UserServiceImpl();
            // generate token and expiry
            String token = UUID.randomUUID().toString();
            long expiryMillis = System.currentTimeMillis() + (60L * 60L * 1000L); // 1 hour
            // set token if email exists (silent if not)
            boolean updated = userService.setResetTokenByEmail(email.trim(), token, expiryMillis);
            // build reset link
            String resetLink = req.getScheme() + "://" + req.getServerName()
                    + ( req.getServerPort() == 80 || req.getServerPort() == 443 ? "" : (":" + req.getServerPort()) )
                    + req.getContextPath() + "/resetpassword?token=" + token;

            if (updated) {
                // send email
                try {
                    String subject = "Đặt lại mật khẩu - " + req.getServerName();
                    String html = "<p>Xin chào,</p>"
                            + "<p>Yêu cầu đặt lại mật khẩu đã được gửi cho tài khoản này. Nếu bạn yêu cầu, vui lòng click liên kết bên dưới để đặt mật khẩu mới. Liên kết có hiệu lực 1 giờ.</p>"
                            + "<p><a href=\"" + resetLink + "\">Đặt lại mật khẩu</a></p>"
                            + "<p>Nếu bạn không yêu cầu, hãy bỏ qua email này.</p>";
                    MailUtil.sendActivationEmail(email.trim(), subject, html);
                } catch (Exception mailEx) {
                    mailEx.printStackTrace();
                    // Do not reveal to user; log only.
                }
            } else {
                // email not found or update failed: we still pretend success
            }
            message = "Đã gửi liên kết đặt lại mật khẩu (vui lòng kiểm tra hộp thư đến và spam).";
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