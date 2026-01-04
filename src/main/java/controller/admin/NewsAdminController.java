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
import model.NewModel;
import service.INewService;
import service.impl.NewServiceImpl;
import utils.Constant;

@MultipartConfig(fileSizeThreshold = 1024 * 1024, maxFileSize = 3 * 1024 * 1024, maxRequestSize = 6 * 1024 * 1024)
@WebServlet(urlPatterns = { "/admin/news" })
public class NewsAdminController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private INewService newService = new NewServiceImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            String action = req.getParameter("action");
            if (action == null || action.isEmpty()) {
                // list with pagination (mirror CategoryAdminController)
                List<NewModel> list = newService.findAll();
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
                List<NewModel> pageList = (list == null || list.isEmpty()) ? java.util.Collections.emptyList() : list.subList(fromIndex, toIndex);

                req.setAttribute("newsList", pageList);
                req.setAttribute("currentPage", page);
                req.setAttribute("totalPages", totalPages);
                req.setAttribute("pageSize", pageSize);
                req.setAttribute("totalItems", totalItems);

                req.getRequestDispatcher("/views/admin/news/list-news.jsp").forward(req, resp);
                return;
            }
            switch (action) {
            case "create":
                req.setAttribute("news", new NewModel());
                req.getRequestDispatcher("/views/admin/news/form-news.jsp").forward(req, resp);
                break;
            case "edit":
                int id = Integer.parseInt(req.getParameter("id"));
                NewModel n = newService.findById(id);
                req.setAttribute("news", n);
                req.getRequestDispatcher("/views/admin/news/form-news.jsp").forward(req, resp);
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
                String title = req.getParameter("title");
                String summary = req.getParameter("summary");
                String content = req.getParameter("content");
                String authorStr = req.getParameter("authorid");
                int authorid = 0;
                try { authorid = Integer.parseInt(authorStr == null || authorStr.isEmpty() ? "0" : authorStr); } catch (NumberFormatException ex) { authorid = 0; }

                NewModel news = new NewModel();
                news.setTitle(title);
                news.setPreview(summary);
                news.setContent(content);
                news.setAuthorid(authorid);
                // do not set createdate here; set it only when creating new record

                Part filePart = null;
                Part imagePart = null;
                try { filePart = req.getPart("thumbnail"); } catch (IllegalStateException ise) { filePart = null; }
                try { imagePart = req.getPart("image"); } catch (IllegalStateException ise) { imagePart = null; }

                // parse id safely and treat id <= 0 as create
                int id = 0;
                try { if (idStr != null && !idStr.isEmpty()) id = Integer.parseInt(idStr); } catch (NumberFormatException nfe) { id = 0; }

                if (id <= 0) {
                    // create
                    news.setCreatedate(new Date(System.currentTimeMillis()));
                    if (filePart != null && filePart.getSize() > 0) {
                        String thumb = saveUploadedFile(filePart, req);
                        news.setThumbnail(thumb);
                    }
                    if (imagePart != null && imagePart.getSize() > 0) {
                        String img = saveUploadedFile(imagePart, req);
                        news.setImage(img);
                    }
                    int newId = newService.save(news);
                    if (newId > 0) { resp.sendRedirect(req.getContextPath() + "/admin/news"); return; }
                    else req.setAttribute("error","Không thể tạo tin");
                } else {
                    // update
                    news.setId(id);
                    // load existing once
                    NewModel ex = newService.findById(id);
                    if (ex != null) {
                        // preserve original createdate when updating
                        news.setCreatedate(ex.getCreatedate());
                    }
                    if (filePart != null && filePart.getSize() > 0) {
                        String thumb = saveUploadedFile(filePart, req);
                        news.setThumbnail(thumb);
                    } else {
                        if (ex != null) news.setThumbnail(ex.getThumbnail());
                    }
                    if (imagePart != null && imagePart.getSize() > 0) {
                        String img = saveUploadedFile(imagePart, req);
                        news.setImage(img);
                        // delete old image file when replacing
                        if (ex != null && ex.getImage() != null && !ex.getImage().trim().isEmpty()) {
                            try {
                                String old = ex.getImage();
                                String oldName = old.contains("/") ? old.substring(old.lastIndexOf('/') + 1) : old;
                                File oldFile = new File(Constant.DIR + File.separator + "news", oldName);
                                try { if (oldFile.exists() && oldFile.isFile()) oldFile.delete(); } catch (Exception exx) { exx.printStackTrace(); }
                                String deployedImageRealPath = req.getServletContext().getRealPath("/image/news");
                                if (deployedImageRealPath != null && !deployedImageRealPath.trim().isEmpty()) {
                                    File df = new File(deployedImageRealPath, oldName);
                                    try { if (df.exists() && df.isFile()) df.delete(); } catch (Exception exx) { exx.printStackTrace(); }
                                }
                            } catch (Exception exx) { exx.printStackTrace(); }
                        }
                    } else {
                        if (ex != null) news.setImage(ex.getImage());
                    }
                    boolean ok = newService.update(news);
                    if (ok) { resp.sendRedirect(req.getContextPath() + "/admin/news"); return; }
                    else req.setAttribute("error","Không thể cập nhật tin");
                }
                req.setAttribute("news", news);
                req.getRequestDispatcher("/views/admin/news/form-news.jsp").forward(req, resp);
                return;
            } else if ("delete".equals(action)) {
                String idStr = req.getParameter("id");
                if (idStr != null && !idStr.isEmpty()) {
                    int id = Integer.parseInt(idStr);
                    // remove physical files (thumbnail/image) if present
                    try {
                        NewModel existing = newService.findById(id);
                        if (existing != null) {
                            String uploadDirPath = Constant.DIR + File.separator + "news";
                            File uploadDir = new File(uploadDirPath);
                            String deployedImageRealPath = req.getServletContext().getRealPath("/image/news");
                            File deployedImageDir = (deployedImageRealPath != null && !deployedImageRealPath.trim().isEmpty()) ? new File(deployedImageRealPath) : null;
                            if (existing.getThumbnail() != null && !existing.getThumbnail().trim().isEmpty()) {
                                String thumbName = existing.getThumbnail();
                                if (thumbName.contains("/")) thumbName = thumbName.substring(thumbName.lastIndexOf('/') + 1);
                                File f = new File(uploadDir, thumbName);
                                try { if (f.exists() && f.isFile()) f.delete(); } catch (Exception exx) { exx.printStackTrace(); }
                                if (deployedImageDir != null) {
                                    File df = new File(deployedImageDir, thumbName);
                                    try { if (df.exists() && df.isFile()) df.delete(); } catch (Exception exx) { exx.printStackTrace(); }
                                }
                            }
                            if (existing.getImage() != null && !existing.getImage().trim().isEmpty()) {
                                String imgName = existing.getImage();
                                if (imgName.contains("/")) imgName = imgName.substring(imgName.lastIndexOf('/') + 1);
                                File f2 = new File(uploadDir, imgName);
                                try { if (f2.exists() && f2.isFile()) f2.delete(); } catch (Exception exx) { exx.printStackTrace(); }
                                if (deployedImageDir != null) {
                                    File df2 = new File(deployedImageDir, imgName);
                                    try { if (df2.exists() && df2.isFile()) df2.delete(); } catch (Exception exx) { exx.printStackTrace(); }
                                }
                            }
                        }
                    } catch (Exception deleteEx) { deleteEx.printStackTrace(); }
                    newService.delete(id);
                }
                resp.sendRedirect(req.getContextPath() + "/admin/news");
                return;
            } else {
                resp.sendError(HttpServletResponse.SC_NOT_FOUND);
            }
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
        String uploadDir = Constant.DIR + File.separator + "news";
        File uploadDirFile = new File(uploadDir);
        if (!uploadDirFile.exists()) uploadDirFile.mkdirs();
        File file = new File(uploadDirFile, fileName);
        try (InputStream in = filePart.getInputStream()) {
            Files.copy(in, file.toPath(), StandardCopyOption.REPLACE_EXISTING);
        }
        // Also ensure copied to deployed webapp image folder for immediate serving
        String deployedImageRealPath = req.getServletContext().getRealPath("/image/news");
        if (deployedImageRealPath != null && !deployedImageRealPath.trim().isEmpty()) {
            File deployedImageDir = new File(deployedImageRealPath);
            if (!deployedImageDir.exists()) deployedImageDir.mkdirs();
            try {
                Files.copy(file.toPath(), new File(deployedImageDir, fileName).toPath(), StandardCopyOption.REPLACE_EXISTING);
            } catch (Exception ex) { ex.printStackTrace(); }
        }
        // return relative path used by views
        return "image/news/" + fileName;
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
