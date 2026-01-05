package controller;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.Map;
import java.net.URLEncoder;
import com.google.gson.Gson;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.CartItemModel;
import model.CartModel; 
import model.ProductModel;
import service.IProductService;
import service.impl.ProductServiceImpl;

@WebServlet(urlPatterns = { "/cart", "/cart/add", "/cart/remove", "/cart/clear", "/cart/update" })
public class CartController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private IProductService productService = new ProductServiceImpl();
    private Gson gson = new Gson();

    private boolean isAjax(HttpServletRequest req) {
        String xhr = req.getHeader("X-Requested-With");
        return "XMLHttpRequest".equalsIgnoreCase(xhr);
    }
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String path = req.getServletPath();
        try {
            HttpSession session = req.getSession(true);
            CartModel cart = (CartModel) session.getAttribute("cart");
            if (cart == null) {
                cart = new CartModel();
                session.setAttribute("cart", cart);
            }
            switch (path) {
            case "/cart/add":
                addToCart(req, resp, cart);
                return;
            case "/cart/remove":
                removeFromCart(req, resp, cart);
                return;
            case "/cart/clear":
                cart.clear();
                if (isAjax(req)) {
                    writeCartJson(resp, cart);
                } else {
                    resp.sendRedirect(req.getContextPath() + "/cart");
                }
                return;
            case "/cart/update":
                updateCartQuantity(req, resp, cart);
                return;
            default: // "/cart"
                req.getRequestDispatcher("/views/client/cart.jsp").forward(req, resp);
            }
        } catch (Exception e) {
            e.printStackTrace();
            resp.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        }
    }
    private void writeJson(HttpServletResponse resp, Object obj) throws IOException {
        resp.setContentType("application/json;charset=UTF-8");
        try (PrintWriter out = resp.getWriter()) {
            out.print(gson.toJson(obj));
        }
    }
    private void writeCartJson(HttpServletResponse resp, CartModel cart) throws IOException {
        Map<String, Object> data = new HashMap<>();
        data.put("totalQuantity", cart.getTotalQuantity());
        data.put("totalPrice", cart.getTotalPrice());
        // include per-item info
        Map<String, Object> itemsMap = new HashMap<>();
        for (CartItemModel it : cart.getItems()) {
            Map<String, Object> itmap = new HashMap<>();
            itmap.put("quantity", it.getQuantity());
            itmap.put("subtotal", it.getSubtotal());
            itemsMap.put(String.valueOf(it.getProductId()), itmap);
        }
        data.put("items", itemsMap);
        writeJson(resp, data);
    }
    private void addToCart(HttpServletRequest req, HttpServletResponse resp, CartModel cart) throws Exception {
        // require login: user object stored in session under "user"
        HttpSession sessionCheck = req.getSession(false);
        Object userObj = (sessionCheck != null) ? sessionCheck.getAttribute("user") : null;
        if (userObj == null) {
            if (isAjax(req)) {
                resp.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
                Map<String, Object> err = new HashMap<>();
                err.put("error", "Vui lòng đăng nhập để sử dụng chức năng giỏ hàng.");
                // construct login URL with next param (current full request)
                String current = req.getRequestURI();
                String qs = req.getQueryString();
                String full = current + (qs != null && !qs.isEmpty() ? "?" + qs : "");
                String next = URLEncoder.encode(full, "UTF-8");
                String loginUrl = req.getContextPath() + "/login?next=" + next;
                err.put("loginUrl", loginUrl);
                writeJson(resp, err);
            } else {
                // redirect to login page with next param
                String current = req.getRequestURI();
                String qs = req.getQueryString();
                String full = current + (qs != null && !qs.isEmpty() ? "?" + qs : "");
                String next = URLEncoder.encode(full, "UTF-8");
                String loginUrl = req.getContextPath() + "/login?next=" + next;
                resp.sendRedirect(loginUrl);
            }
            return;
        }
        String idStr = req.getParameter("id");
        String qtyStr = req.getParameter("qty");
        if (idStr == null || idStr.isEmpty()) {
            if (isAjax(req)) {
                resp.sendError(HttpServletResponse.SC_BAD_REQUEST);
            } else {
                resp.sendError(HttpServletResponse.SC_BAD_REQUEST);
            }
            return;
        }
        int id = Integer.parseInt(idStr);
        int qty = 1;
        try {
            if (qtyStr != null) qty = Math.max(1, Integer.parseInt(qtyStr));
        } catch (NumberFormatException e) {
            qty = 1;
        }
        ProductModel p = productService.findById(id);
        if (p == null) {
            if (isAjax(req)) {
                resp.sendError(HttpServletResponse.SC_NOT_FOUND);
            } else {
                resp.sendError(HttpServletResponse.SC_NOT_FOUND);
            }
            return;
        }
        // stock check
        int available = p.getQuantity();
        int existingQty = 0;
        for (CartItemModel it : cart.getItems()) {
            if (it.getProductId() == id) {
                existingQty = it.getQuantity();
                break;
            }
        }
        if (existingQty + qty > available) {
            if (isAjax(req)) {
                Map<String, Object> err = new HashMap<>();
                err.put("error", "Số lượng vượt quá tồn kho. Còn " + available + " sản phẩm.");
                writeJson(resp, err);
            } else {
                req.setAttribute("error", "Số lượng vượt quá tồn kho. Còn " + available + " sản phẩm.");
                resp.sendRedirect(req.getHeader("Referer") != null ? req.getHeader("Referer") : req.getContextPath() + "/cart");
            }
            return;
        }

        CartItemModel item = new CartItemModel(p.getId(), p.getName(), p.getPrice(), qty);
        cart.addItem(item);

        if (isAjax(req)) {
            writeCartJson(resp, cart);
        } else {
            String referer = req.getHeader("Referer");
            if (referer != null && !referer.contains("/cart/add")) {
                resp.sendRedirect(referer);
            } else {
                resp.sendRedirect(req.getContextPath() + "/cart");
            }
        }
    }

    private void removeFromCart(HttpServletRequest req, HttpServletResponse resp, CartModel cart) throws IOException {
        String idStr = req.getParameter("id");
        if (idStr != null && !idStr.isEmpty()) {
            try {
                int id = Integer.parseInt(idStr);
                cart.removeItem(id);
            } catch (NumberFormatException e) {
                // ignore
            }
        }
        if (isAjax(req)) {
            writeCartJson(resp, cart);
        } else {
            resp.sendRedirect(req.getContextPath() + "/cart");
        }
    }
    private void updateCartQuantity(HttpServletRequest req, HttpServletResponse resp, CartModel cart) throws IOException {
        String idStr = req.getParameter("id");
        String qtyStr = req.getParameter("qty");
        if (idStr == null || idStr.isEmpty()) {
            if (isAjax(req)) {
                resp.sendError(HttpServletResponse.SC_BAD_REQUEST);
            } else {
                resp.sendRedirect(req.getContextPath() + "/cart");
            }
            return;
        }
        try {
            int id = Integer.parseInt(idStr);
            int qty = 1;
            try {
                if (qtyStr != null) qty = Math.max(1, Integer.parseInt(qtyStr));
            } catch (NumberFormatException e) {
                qty = 1;
            }
            for (CartItemModel it : cart.getItems()) {
                if (it.getProductId() == id) {
                    it.setQuantity(qty);
                    break;
                }
            }
        } catch (NumberFormatException e) {
            // ignore bad id
        }
        if (isAjax(req)) {
            writeCartJson(resp, cart);
        } else {
            resp.sendRedirect(req.getContextPath() + "/cart");
        }
    }
}