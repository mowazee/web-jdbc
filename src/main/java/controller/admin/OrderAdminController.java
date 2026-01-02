package controller.admin;

import java.io.IOException;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.OrderModel;
import service.IOrderService;
import service.impl.OrderServiceImpl;

@WebServlet(urlPatterns = {"/admin/orders", "/admin/order"})
public class OrderAdminController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private IOrderService orderService = new OrderServiceImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            String action = req.getParameter("action");
            if (action == null || action.isEmpty()) {
                List<OrderModel> orders = orderService.findAll();
                req.setAttribute("orders", orders);
                req.getRequestDispatcher("/views/admin/order/list-order.jsp").forward(req, resp);
                return;
            }
            switch (action) {
                case "detail":
                    int id = Integer.parseInt(req.getParameter("id"));
                    OrderModel order = orderService.findById(id);
                    req.setAttribute("order", order);
                    req.getRequestDispatcher("/views/admin/order/order-detail.jsp").forward(req, resp);
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
            if ("updateStatus".equals(action)) {
                int id = Integer.parseInt(req.getParameter("id"));
                int status = Integer.parseInt(req.getParameter("status"));
                OrderModel order = orderService.findById(id);
                if (order != null) {
                    order.setStatus(status);
                    orderService.update(order);
                }
                // normalize redirect to the plural /admin/orders (matches sidebar link)
                resp.sendRedirect(req.getContextPath() + "/admin/orders");
                return;
            } else if ("delete".equals(action)) {
                int id = Integer.parseInt(req.getParameter("id"));
                orderService.delete(id);
                resp.sendRedirect(req.getContextPath() + "/admin/orders");
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