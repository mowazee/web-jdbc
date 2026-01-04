package controller.admin;
import java.io.File;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.StandardCopyOption;
import java.util.List;
import java.util.UUID;
import java.nio.charset.StandardCharsets;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.apache.commons.fileupload2.core.FileItem;
import org.apache.commons.fileupload2.core.DiskFileItemFactory;
import org.apache.commons.fileupload2.jakarta.JakartaServletFileUpload;
import model.CategoryModel;
import service.ICategoryService;
import service.impl.CategoryServiceImpl;
import utils.Constant;

@WebServlet(urlPatterns = {"/admin/categories","/admin/category"})
public class CategoryAdminController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private ICategoryService categoryService = new CategoryServiceImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, java.io.IOException {
        try {
            String action = req.getParameter("action");
            if (action == null || action.isEmpty()) {
                // list with pagination
                List<CategoryModel> list = categoryService.findAll();
                // pagination params
                String pageParam = req.getParameter("page");
                int page = 1;
                int pageSize = 10; // default 10 per page
                try { if (pageParam != null) page = Math.max(1, Integer.parseInt(pageParam)); } catch (NumberFormatException ex) { page = 1; }

                int totalItems = list == null ? 0 : list.size();
                int totalPages = totalItems == 0 ? 1 : (int) Math.ceil((double) totalItems / pageSize);
                if (page > totalPages) page = totalPages;
                int fromIndex = (page - 1) * pageSize;
                int toIndex = Math.min(fromIndex + pageSize, totalItems);
                List<CategoryModel> pageList = (list == null || list.isEmpty()) ? java.util.Collections.emptyList() : list.subList(fromIndex, toIndex);

                req.setAttribute("categories", pageList);
                req.setAttribute("currentPage", page);
                req.setAttribute("totalPages", totalPages);
                req.setAttribute("pageSize", pageSize);
                req.setAttribute("totalItems", totalItems);
                req.getRequestDispatcher("/views/admin/category/list-category.jsp").forward(req, resp);
                return;
            }
            switch (action) {
                case "create":
                    req.setAttribute("category", new CategoryModel());
                    req.getRequestDispatcher("/views/admin/category/form-category.jsp").forward(req, resp);
                    break;
                case "edit":
                    int id = Integer.parseInt(req.getParameter("id"));
                    CategoryModel cat = categoryService.findById(id);
                    req.setAttribute("category", cat);
                    req.getRequestDispatcher("/views/admin/category/form-category.jsp").forward(req, resp);
                    break;
                default:
                    resp.sendError(HttpServletResponse.SC_NOT_FOUND);
            }
        } catch (Exception e) {
            e.printStackTrace();
            resp.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        }
    }

    @SuppressWarnings({ "unchecked", "rawtypes" })
	@Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, java.io.IOException {
        req.setCharacterEncoding("UTF-8");
        try {
            // Quick non-multipart delete handling: check request parameter directly before multipart parsing.
            String quickAction = req.getParameter("action");
            if ("delete".equals(quickAction)) {
                System.out.println("[CategoryAdminController] quick delete detected via request param");
                String idParam = req.getParameter("id");
                if (idParam == null || idParam.trim().isEmpty()) {
                    resp.sendError(HttpServletResponse.SC_BAD_REQUEST);
                    return;
                }
                try {
                    int id = Integer.parseInt(idParam);
                    String uploadDirPath = Constant.DIR;
                    File uploadDir = new File(uploadDirPath);
                    String deployedImageRealPath = req.getServletContext().getRealPath("/image");
                    File deployedImageDir = null;
                    if (deployedImageRealPath != null && !deployedImageRealPath.trim().isEmpty()) {
                        deployedImageDir = new File(deployedImageRealPath);
                    }
                    CategoryModel existing = categoryService.findById(id);
                    if (existing != null && existing.getIcon() != null && !existing.getIcon().trim().isEmpty()) {
                        File f = new File(uploadDir, existing.getIcon());
                        try { if (f.exists() && f.isFile()) f.delete(); } catch (Exception ex) { ex.printStackTrace(); }
                        if (deployedImageDir != null) {
                            File df = new File(deployedImageDir, existing.getIcon());
                            try { if (df.exists() && df.isFile()) df.delete(); } catch (Exception ex) { ex.printStackTrace(); }
                        }
                    }
                    categoryService.delete(id);
                    resp.sendRedirect(req.getContextPath() + "/admin/category");
                    return;
                } catch (NumberFormatException nfe) {
                    resp.sendError(HttpServletResponse.SC_BAD_REQUEST);
                    return;
                } catch (Exception ex) {
                    ex.printStackTrace();
                    resp.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
                    return;
                }
            }

            boolean isMultipart = JakartaServletFileUpload.isMultipartContent(req);
            String uploadDirPath = Constant.DIR;
            File uploadDir = new File(uploadDirPath);
            if (!uploadDir.exists()) uploadDir.mkdirs();
            String deployedImageRealPath = req.getServletContext().getRealPath("/image");
            File deployedImageDir = null;
            if (deployedImageRealPath != null && !deployedImageRealPath.trim().isEmpty()) {
                deployedImageDir = new File(deployedImageRealPath);
                if (!deployedImageDir.exists()) deployedImageDir.mkdirs();
            }

            // read common fields
            String action = null; // expected: 'create' or 'update' or 'delete'
            String idStr = null;
            String name = null;
            String iconParam = null;
            String uploadedFileName = null;
            String description = null;

            List<FileItem> fileItems = null;
            if (isMultipart) {
                DiskFileItemFactory factory = DiskFileItemFactory.builder().get();
                JakartaServletFileUpload upload = new JakartaServletFileUpload(factory);
                List<FileItem> items = upload.parseRequest(req);
                fileItems = items;
                for (FileItem item : items) {
                    if (item.isFormField()) {
                        String fieldName = item.getFieldName();
                        String value = item.getString(StandardCharsets.UTF_8);
                        if ("action".equals(fieldName)) action = value;
                        else if ("id".equals(fieldName)) idStr = value;
                        else if ("catename".equals(fieldName)) name = value;
                        else if ("icon".equals(fieldName)) iconParam = value;
                        else if ("description".equals(fieldName)) description = value;
                    }
                }
            } else {
                action = req.getParameter("action");
                idStr = req.getParameter("id");
                name = req.getParameter("catename");
                iconParam = req.getParameter("icon");
                description = req.getParameter("description");
            }

            if ("delete".equals(action)) {
                //System.out.println("[CategoryAdminController] multipart delete detected (action from parsed fields)");
                if (idStr == null || idStr.trim().isEmpty()) {
                    resp.sendError(HttpServletResponse.SC_BAD_REQUEST);
                    return;
                }
                try {
                    int id = Integer.parseInt(idStr);
                    CategoryModel existing = categoryService.findById(id);
                    if (existing != null && existing.getIcon() != null && !existing.getIcon().trim().isEmpty()) {
                        File f = new File(uploadDir, existing.getIcon());
                        try { if (f.exists() && f.isFile()) f.delete(); } catch (Exception ex) { ex.printStackTrace(); }
                        if (deployedImageDir != null) {
                            File df = new File(deployedImageDir, existing.getIcon());
                            try { if (df.exists() && df.isFile()) df.delete(); } catch (Exception ex) { ex.printStackTrace(); }
                        }
                    }
                    categoryService.delete(id);
                    resp.sendRedirect(req.getContextPath() + "/admin/category");
                    return;
                } catch (NumberFormatException nfe) {
                    resp.sendError(HttpServletResponse.SC_BAD_REQUEST);
                    return;
                } catch (Exception ex) {
                    ex.printStackTrace();
                    resp.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
                    return;
                }
            }

            // handle file upload if any
            if (fileItems != null) {
                for (FileItem item : fileItems) {
                    if (!item.isFormField()) {
                        String submittedName = item.getName();
                        if (submittedName != null && !submittedName.isEmpty()) {
                            String ext = "";
                            int dot = submittedName.lastIndexOf('.');
                            if (dot >= 0) ext = submittedName.substring(dot);
                            String filename = UUID.randomUUID().toString() + ext;
                            File dest = new File(uploadDir, filename);
                            try (InputStream is = item.getInputStream()) {
                                Files.copy(is, dest.toPath(), StandardCopyOption.REPLACE_EXISTING);
                            }
                            uploadedFileName = filename;
                            // copy to deployed image dir
                            if (deployedImageDir != null && !uploadDir.getAbsolutePath().equalsIgnoreCase(deployedImageDir.getAbsolutePath())) {
                                try { Files.copy(dest.toPath(), new File(deployedImageDir, filename).toPath(), StandardCopyOption.REPLACE_EXISTING); } catch (Exception ex) { ex.printStackTrace(); }
                            }
                        }
                    }
                }
            }

            // basic validation
            if (name == null || name.trim().isEmpty()) {
                req.setAttribute("error", "Tên danh mục không được để trống");
                CategoryModel cat = new CategoryModel();
                if (idStr != null && !idStr.isEmpty()) cat.setCateid(Integer.parseInt(idStr));
                cat.setCatename(name);
                if (uploadedFileName != null) cat.setIcon(uploadedFileName); else cat.setIcon(iconParam);
                cat.setDescription(description);
                req.setAttribute("category", cat);
                req.getRequestDispatcher("/views/admin/category/form-category.jsp").forward(req, resp);
                return;
            }

            CategoryModel model = new CategoryModel();
            model.setCatename(name.trim());
            model.setDescription(description);
            if (uploadedFileName != null) model.setIcon(uploadedFileName); else model.setIcon(iconParam);

            if ("create".equals(action)) {
                try {
                    int newId = categoryService.save(model);
                    if (newId > 0) {
                        resp.sendRedirect(req.getContextPath() + "/admin/category");
                        return;
                    } else {
                        req.setAttribute("error", "Không thể tạo danh mục (insert returned " + newId + ")");
                        req.setAttribute("category", model);
                        req.getRequestDispatcher("/views/admin/category/form-category.jsp").forward(req, resp);
                        return;
                    }
                } catch (Exception ex) {
                    ex.printStackTrace();
                    req.setAttribute("error", "Lỗi khi tạo danh mục: " + ex.getMessage());
                    req.setAttribute("category", model);
                    req.getRequestDispatcher("/views/admin/category/form-category.jsp").forward(req, resp);
                    return;
                }
            } else if ("update".equals(action)) {
                try {
                    int id = Integer.parseInt(idStr);
                    model.setCateid(id);
                    // if user didn't upload new file, keep existing icon
                    if (uploadedFileName == null) {
                        CategoryModel existing = categoryService.findById(id);
                        if (existing != null) model.setIcon(existing.getIcon());
                    } else {
                        // delete old file if present
                        CategoryModel existing = categoryService.findById(id);
                        if (existing != null && existing.getIcon() != null && !existing.getIcon().trim().isEmpty()) {
                            File oldFile = new File(uploadDir, existing.getIcon());
                            try { if (oldFile.exists()) oldFile.delete(); } catch (Exception ex) { ex.printStackTrace(); }
                        }
                    }
                    boolean ok = categoryService.update(model);
                    if (ok) {
                        resp.sendRedirect(req.getContextPath() + "/admin/category");
                        return;
                    } else {
                        req.setAttribute("error", "Không thể cập nhật danh mục");
                        req.setAttribute("category", model);
                        req.getRequestDispatcher("/views/admin/category/form-category.jsp").forward(req, resp);
                        return;
                    }
                } catch (Exception ex) {
                    ex.printStackTrace();
                    req.setAttribute("error", "Lỗi khi cập nhật danh mục: " + ex.getMessage());
                    req.setAttribute("category", model);
                    req.getRequestDispatcher("/views/admin/category/form-category.jsp").forward(req, resp);
                    return;
                }
            } else {
                resp.sendError(HttpServletResponse.SC_BAD_REQUEST);
                return;
            }

        } catch (Exception e) {
            e.printStackTrace();
            resp.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        }
    }
}
