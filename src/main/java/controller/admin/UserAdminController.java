package controller.admin;

import java.io.IOException;
import java.sql.Date;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.UserModel;
import service.IUserService;
import service.impl.UserServiceImpl;

@WebServlet(urlPatterns = {"/admin/user"})
public class UserAdminController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private IUserService userService = new UserServiceImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            String action = req.getParameter("action");
            if (action == null || action.isEmpty()) {
                List<UserModel> users = userService.findAll();
                req.setAttribute("users", users);
                req.getRequestDispatcher("/views/admin/user/list-user.jsp").forward(req, resp);
                return;
            }
            switch (action) {
                case "create":
                    req.setAttribute("user", new UserModel());
                    req.getRequestDispatcher("/views/admin/user/form-user.jsp").forward(req, resp);
                    break;
                case "edit":
                    int id = Integer.parseInt(req.getParameter("id"));
                    UserModel u = userService.findById(id);
                    req.setAttribute("user", u);
                    req.getRequestDispatcher("/views/admin/user/form-user.jsp").forward(req, resp);
                    break;
                default:
                    resp.sendError(HttpServletResponse.SC_NOT_FOUND);
            }
        } catch (Exception e) {
            e.printStackTrace();
            resp.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        String action = req.getParameter("action");
        try {
            if ("save".equals(action)) {
                String idStr = req.getParameter("id");
                String email = req.getParameter("email");
                String username = req.getParameter("username");
                String fullname = req.getParameter("fullname");
                String password = req.getParameter("password");
                String avatar = req.getParameter("avatar");
                String phone = req.getParameter("phone");
                int roleid = Integer.parseInt(req.getParameter("roleid") == null || req.getParameter("roleid").isEmpty() ? "3" : req.getParameter("roleid"));
                Date createdate = new Date(System.currentTimeMillis());

                if (email == null || email.trim().isEmpty() || username == null || username.trim().isEmpty()) {
                    req.setAttribute("error", "Email và Username là bắt buộc");
                    UserModel u = new UserModel();
                    if (idStr != null && !idStr.isEmpty()) u.setId(Integer.parseInt(idStr));
                    u.setEmail(email);
                    u.setUsername(username);
                    u.setFullname(fullname);
                    u.setPhone(phone);
                    u.setAvatar(avatar);
                    u.setRoleid(roleid);
                    req.setAttribute("user", u);
                    req.getRequestDispatcher("/views/admin/user/form-user.jsp").forward(req, resp);
                    return;
                }

                UserModel user = new UserModel(email, username, fullname, password, avatar, roleid, phone, createdate);
                if (idStr == null || idStr.isEmpty()) {
                    int newId = userService.save(user);
                    if (newId > 0) {
                        resp.sendRedirect(req.getContextPath() + "/admin/user");
                        return;
                    } else {
                        req.setAttribute("error", "Không thể tạo user");
                    }
                } else {
                    user.setId(Integer.parseInt(idStr));
                    boolean ok = userService.update(user);
                    if (ok) {
                        resp.sendRedirect(req.getContextPath() + "/admin/user");
                        return;
                    } else {
                        req.setAttribute("error", "Không thể cập nhật user");
                    }
                }
                req.setAttribute("user", user);
                req.getRequestDispatcher("/views/admin/user/form-user.jsp").forward(req, resp);
                return;
            } else if ("delete".equals(action)) {
                String idStr = req.getParameter("id");
                if (idStr != null && !idStr.isEmpty()) {
                    int id = Integer.parseInt(idStr);
                    userService.delete(id);
                }
                resp.sendRedirect(req.getContextPath() + "/admin/user");
                return;
            } else {
                resp.sendError(HttpServletResponse.SC_NOT_FOUND);
            }
        } catch (Exception e) {
            e.printStackTrace();
            resp.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        }
    }
}