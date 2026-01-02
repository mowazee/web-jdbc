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
                List<NewModel> list = newService.findAll();
                req.setAttribute("newsList", list);
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
        String uploadDir = req.getServletContext().getRealPath("/image/news");
        File uploadDirFile = new File(uploadDir);
        if (!uploadDirFile.exists()) uploadDirFile.mkdirs();
        File file = new File(uploadDirFile, fileName);
        try (InputStream in = filePart.getInputStream()) {
            Files.copy(in, file.toPath(), StandardCopyOption.REPLACE_EXISTING);
        }
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