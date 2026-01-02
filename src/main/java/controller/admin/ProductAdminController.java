package controller.admin;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.StandardCopyOption;
import java.sql.Date;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import model.ProductModel;
import service.ICategoryService;
import service.IProductService;
import service.impl.CategoryServiceImpl;
import service.impl.ProductServiceImpl;

@MultipartConfig(fileSizeThreshold = 1024 * 1024, // 1MB
        maxFileSize = 5 * 1024 * 1024, // 5MB
        maxRequestSize = 10 * 1024 * 1024)
@WebServlet(urlPatterns = { "/admin/products","/admin/product" })
public class ProductAdminController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private IProductService productService = new ProductServiceImpl();
    private ICategoryService categoryService = new CategoryServiceImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            String action = req.getParameter("action");
            if (action == null || action.isEmpty()) {
                List<ProductModel> products = productService.findAll();
                req.setAttribute("products", products);
                // provide categories so list view can display category names (not just IDs)
                req.setAttribute("categories", categoryService.findAll());
                // flash message support: move from session to request
                Object msg = req.getSession().getAttribute("message");
                if (msg != null) {
                    req.setAttribute("message", msg);
                    req.getSession().removeAttribute("message");
                }
                req.getRequestDispatcher("/views/admin/product/list-product.jsp").forward(req, resp);
                return;
            }
            switch (action) {
            case "create":
                req.setAttribute("product", new ProductModel());
                req.setAttribute("categories", categoryService.findAll());
                req.getRequestDispatcher("/views/admin/product/form-product.jsp").forward(req, resp);
                break;
            case "edit":
                int id = Integer.parseInt(req.getParameter("id"));
                ProductModel p = productService.findById(id);
                req.setAttribute("product", p);
                req.setAttribute("categories", categoryService.findAll());
                req.getRequestDispatcher("/views/admin/product/form-product.jsp").forward(req, resp);
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

        // Quick non-multipart delete handling
        String quickAction = req.getParameter("action");
        if ("delete".equals(quickAction)) {
            try {
                String idStr = req.getParameter("id");
                if (idStr != null && !idStr.isEmpty()) {
                    int id = Integer.parseInt(idStr);
                    productService.delete(id);
                    req.getSession().setAttribute("message", "Xóa thành công");
                }
                resp.sendRedirect(req.getContextPath() + "/admin/product");
                return;
            } catch (Exception ex) {
                ex.printStackTrace();
                resp.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
                return;
            }
        }

        try {
            String action = req.getParameter("action");
            // common params
            String idStr = req.getParameter("id");
            String name = req.getParameter("name");
            String description = req.getParameter("description");
            String priceStr = req.getParameter("price");
            String quantityStr = req.getParameter("quantity");
            String cateidStr = req.getParameter("cateid");

            double price = 0;
            int quantity = 0;
            int cateid = 0;
            try {
                price = Double.parseDouble(priceStr == null || priceStr.isEmpty() ? "0" : priceStr);
            } catch (NumberFormatException ex) {
                price = 0;
            }
            try {
                quantity = Integer.parseInt(quantityStr == null || quantityStr.isEmpty() ? "0" : quantityStr);
            } catch (NumberFormatException ex) {
                quantity = 0;
            }
            try {
                cateid = Integer.parseInt(cateidStr == null || cateidStr.isEmpty() ? "0" : cateidStr);
            } catch (NumberFormatException ex) {
                cateid = 0;
            }

            ProductModel product = new ProductModel();
            product.setName(name);
            product.setDescription(description);
            product.setPrice(price);
            product.setQuantity(quantity);
            product.setCateid(cateid);
            product.setCreatedate(new Date(System.currentTimeMillis()));

            // handle file upload via Part
            Part filePart = null;
            try {
                filePart = req.getPart("image");
            } catch (IllegalStateException ise) {
                filePart = null;
            }

            if ("create".equals(action) || "save".equals(action)) {
                // create new product
                if (filePart != null && filePart.getSize() > 0) {
                    String imagePath = saveUploadedFile(filePart, req);
                    product.setImage(imagePath);
                }
                int newId = productService.save(product);
                if (newId > 0) {
                    req.getSession().setAttribute("message", "Thêm mới phẩm thành công");
                    resp.sendRedirect(req.getContextPath() + "/admin/product");
                    return;
                } else {
                    req.setAttribute("error", "Không thể tạo sản phẩm");
                }
            } else if ("update".equals(action)) {
                // update existing product
                if (idStr == null || idStr.isEmpty()) {
                    resp.sendError(HttpServletResponse.SC_BAD_REQUEST);
                    return;
                }
                int id = Integer.parseInt(idStr);
                product.setId(id);
                if (filePart != null && filePart.getSize() > 0) {
                    String imagePath = saveUploadedFile(filePart, req);
                    product.setImage(imagePath);
                } else {
                    ProductModel existing = productService.findById(id);
                    if (existing != null) product.setImage(existing.getImage());
                }
                boolean ok = productService.update(product);
                if (ok) {
                    req.getSession().setAttribute("message", "Cập nhật sản phẩm thành công");
                    resp.sendRedirect(req.getContextPath() + "/admin/product");
                    return;
                } else {
                    req.setAttribute("error", "Không thể cập nhật sản phẩm");
                }
            } else {
                // unsupported action
                resp.sendError(HttpServletResponse.SC_BAD_REQUEST);
                return;
            }

            // on error re-show form
            req.setAttribute("product", product);
            req.setAttribute("categories", categoryService.findAll());
            req.getRequestDispatcher("/views/admin/product/form-product.jsp").forward(req, resp);
            return;

        } catch (Exception e) {
            e.printStackTrace();
            resp.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        }
    }

    private String saveUploadedFile(Part filePart, HttpServletRequest req) throws IOException {
        String submitted = getFileName(filePart);
        if (submitted == null || submitted.isEmpty()) return null;
        String ext = "";
        int idx = submitted.lastIndexOf('.');
        if (idx > 0) ext = submitted.substring(idx);
        String fileName = System.currentTimeMillis() + ext;
        String uploadDir = req.getServletContext().getRealPath("/image/products");
        File uploadDirFile = new File(uploadDir);
        if (!uploadDirFile.exists()) uploadDirFile.mkdirs();
        File file = new File(uploadDirFile, fileName);
        try (InputStream in = filePart.getInputStream()) {
            Files.copy(in, file.toPath(), StandardCopyOption.REPLACE_EXISTING);
        }
        // return web path relative to context
        return "image/products/" + fileName;
    }

    private String getFileName(Part part) {
        String header = part.getHeader("content-disposition");
        if (header == null) return null;
        for (String cd : header.split(";")) {
            if (cd.trim().startsWith("filename")) {
                String fileName = cd.substring(cd.indexOf('=') + 1).trim().replace("\"", "");
                return fileName.substring(fileName.lastIndexOf(File.separator) + 1);
            }
        }
        return null;
    }
}