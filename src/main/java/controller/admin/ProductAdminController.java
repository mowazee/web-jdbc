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
import utils.Constant; // added import

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
                // pagination params
                String pageParam = req.getParameter("page");
                int page = 1;
                int pageSize = 10;
                try { if (pageParam != null) page = Math.max(1, Integer.parseInt(pageParam)); } catch (NumberFormatException ex) { page = 1; }
                int totalItems = products == null ? 0 : products.size();
                int totalPages = totalItems == 0 ? 1 : (int) Math.ceil((double) totalItems / pageSize);
                if (page > totalPages) page = totalPages;
                int fromIndex = (page - 1) * pageSize;
                int toIndex = Math.min(fromIndex + pageSize, totalItems);
                List<ProductModel> pageList = (products == null || products.isEmpty()) ? java.util.Collections.emptyList() : products.subList(fromIndex, toIndex);
                req.setAttribute("products", pageList);
                req.setAttribute("currentPage", page);
                req.setAttribute("totalPages", totalPages);
                req.setAttribute("pageSize", pageSize);
                req.setAttribute("totalItems", totalItems);
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

        // Quick non-multipart delete handling - now also remove physical files
        String quickAction = req.getParameter("action");
        if ("delete".equals(quickAction)) {
            try {
                String idStr = req.getParameter("id");
                if (idStr != null && !idStr.isEmpty()) {
                    int id = Integer.parseInt(idStr);
                    ProductModel existing = productService.findById(id);
                    if (existing != null) {
                        // delete physical files from configured DIR and deployed webapp image folder
                        try {
                            String uploadDirPath = Constant.DIR + File.separator + "products";
                            File uploadDir = new File(uploadDirPath);
                            String deployedImageRealPath = req.getServletContext().getRealPath("/image/products");
                            File deployedImageDir = (deployedImageRealPath != null && !deployedImageRealPath.trim().isEmpty()) ? new File(deployedImageRealPath) : null;
                            if (existing.getImage() != null && !existing.getImage().trim().isEmpty()) {
                                String imgName = existing.getImage();
                                if (imgName.contains("/")) imgName = imgName.substring(imgName.lastIndexOf('/') + 1);
                                File f = new File(uploadDir, imgName);
                                try { if (f.exists() && f.isFile()) f.delete(); } catch (Exception exx) { exx.printStackTrace(); }
                                if (deployedImageDir != null) {
                                    File df = new File(deployedImageDir, imgName);
                                    try { if (df.exists() && df.isFile()) df.delete(); } catch (Exception exx) { exx.printStackTrace(); }
                                }
                            }
                        } catch (Exception deleteEx) { deleteEx.printStackTrace(); }
                    }
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
                    // save new file
                    String imagePath = saveUploadedFile(filePart, req);
                    product.setImage(imagePath);
                    // delete old file
                    ProductModel existing = productService.findById(id);
                    if (existing != null && existing.getImage() != null && !existing.getImage().trim().isEmpty()) {
                        try {
                            String old = existing.getImage();
                            String oldName = old.contains("/") ? old.substring(old.lastIndexOf('/') + 1) : old;
                            File oldFile = new File(Constant.DIR + File.separator + "products", oldName);
                            try { if (oldFile.exists() && oldFile.isFile()) oldFile.delete(); } catch (Exception exx) { exx.printStackTrace(); }
                            String deployedImageRealPath = req.getServletContext().getRealPath("/image/products");
                            if (deployedImageRealPath != null && !deployedImageRealPath.trim().isEmpty()) {
                                File df = new File(deployedImageRealPath, oldName);
                                try { if (df.exists() && df.isFile()) df.delete(); } catch (Exception exx) { exx.printStackTrace(); }
                            }
                        } catch (Exception exx) { exx.printStackTrace(); }
                    }
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
        // Save to project images dir (Constant.DIR) so files persist between redeploys
        String uploadDir = Constant.DIR + File.separator + "products";
        File uploadDirFile = new File(uploadDir);
        if (!uploadDirFile.exists()) uploadDirFile.mkdirs();
        File file = new File(uploadDirFile, fileName);
        try (InputStream in = filePart.getInputStream()) {
            Files.copy(in, file.toPath(), StandardCopyOption.REPLACE_EXISTING);
        }
        // Also ensure copied to deployed webapp image folder for immediate serving
        String deployedImageRealPath = req.getServletContext().getRealPath("/image/products");
        if (deployedImageRealPath != null && !deployedImageRealPath.trim().isEmpty()) {
            File deployedImageDir = new File(deployedImageRealPath);
            if (!deployedImageDir.exists()) deployedImageDir.mkdirs();
            try {
                Files.copy(file.toPath(), new File(deployedImageDir, fileName).toPath(), StandardCopyOption.REPLACE_EXISTING);
            } catch (Exception ex) { ex.printStackTrace(); }
        }
        // return relative path used by views
        return "image/products/" + fileName;
    }

    private String getFileName(Part part) {
        String header = part.getHeader("content-disposition");
        if (header == null) return null;
        for (String cd : header.split(";")) {
            if (cd.trim().startsWith("filename")) {
                String fileName = cd.substring(cd.indexOf('=') + 1).trim().replace("\"", "");
                // some browsers (IE) send the full path, normalize separators and take last segment
                fileName = fileName.replace('\\', '/');
                int idx = fileName.lastIndexOf('/');
                if (idx >= 0) fileName = fileName.substring(idx + 1);
                return fileName;
            }
        }
        return null;
    }
}
