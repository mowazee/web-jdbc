package controller;

import java.io.IOException;
import java.sql.Date;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.CartItemModel;
import model.CartModel;
import model.OrderItemModel;
import model.OrderModel;
import model.ProductModel;
import model.UserModel;
import service.IOrderService;
import service.IProductService;
import service.impl.OrderServiceImpl;
import service.impl.ProductServiceImpl;

@WebServlet(urlPatterns = {"/checkout"})
public class CheckoutController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private IOrderService orderService = new OrderServiceImpl();
    private IProductService productService = new ProductServiceImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("/views/client/checkout.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        if (session == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }
        CartModel cart = (CartModel) session.getAttribute("cart");
        if (cart == null || cart.getItems().isEmpty()) {
            req.setAttribute("error", "Giỏ hàng trống");
            req.getRequestDispatcher("/views/client/checkout.jsp").forward(req, resp);
            return;
        }

        // server-side validation for recipient info
        String recipientName = req.getParameter("recipientName");
        String recipientPhone = req.getParameter("recipientPhone");
        String recipientAddress = req.getParameter("recipientAddress");
        if (recipientName == null || recipientName.trim().isEmpty() || recipientPhone == null || recipientPhone.trim().isEmpty() || recipientAddress == null || recipientAddress.trim().isEmpty()) {
            req.setAttribute("error", "Vui lòng điền đầy đủ thông tin người nhận.");
            req.getRequestDispatcher("/views/client/checkout.jsp").forward(req, resp);
            return;
        }

        UserModel user = (UserModel) session.getAttribute("user");
        int userId = user != null ? user.getId() : 0; // guest user id 0

        try {
            OrderModel order = new OrderModel();
            order.setUserid(userId);
            order.setOrderdate(new Date(System.currentTimeMillis()));
            order.setTotal(cart.getTotalPrice());
            order.setRecipientName(recipientName.trim());
            order.setRecipientPhone(recipientPhone.trim());
            order.setRecipientAddress(recipientAddress.trim());
            // copy items
            for (CartItemModel it : cart.getItems()) {
                OrderItemModel oit = new OrderItemModel();
                oit.setProductId(it.getProductId());
                oit.setProductName(it.getProductName());
                oit.setPrice(it.getPrice());
                oit.setQuantity(it.getQuantity());
                order.addItem(oit);
            }

            int orderId = orderService.save(order);
            if (orderId > 0) {
                // decrement product stock
                for (OrderItemModel oit : order.getItems()) {
                    ProductModel p = productService.findById(oit.getProductId());
                    if (p != null) {
                        int newQty = Math.max(0, p.getQuantity() - oit.getQuantity());
                        p.setQuantity(newQty);
                        productService.update(p);
                    }
                }
                // clear cart
                cart.clear();
                session.setAttribute("cart", cart);
                resp.sendRedirect(req.getContextPath() + "/views/client/oder-succes.jsp");
                return;
            } else {
                req.setAttribute("error", "Không thể lưu đơn hàng");
                req.getRequestDispatcher("/views/client/checkout.jsp").forward(req, resp);
            }
        } catch (Exception e) {
            e.printStackTrace();
            resp.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        }
    }
}