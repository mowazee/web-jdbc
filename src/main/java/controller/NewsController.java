package controller;

import java.io.IOException;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.NewModel;
import service.INewService;
import service.impl.NewServiceImpl;
@WebServlet(urlPatterns = {"/news", "/news/*"})
public class NewsController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private INewService newService = new NewServiceImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("text/html");
        // determine if request is for list or detail
        String pathInfo = req.getPathInfo(); // returns /{id} when accessed like /news/123
        try {
            if (pathInfo == null || pathInfo.equals("/") || pathInfo.isEmpty()) {
                // list with pagination
                List<NewModel> list = newService.findAll();
                // pagination params
                String pageParam = req.getParameter("page");
                String sizeParam = req.getParameter("size");
                int page = 1;
                int size = 6; // default page size
                try {
                    if (pageParam != null) page = Math.max(1, Integer.parseInt(pageParam));
                } catch (NumberFormatException ex) { page = 1; }
                try {
                    if (sizeParam != null) size = Math.max(1, Integer.parseInt(sizeParam));
                } catch (NumberFormatException ex) { size = 6; }

                int totalItems = list == null ? 0 : list.size();
                int totalPages = totalItems == 0 ? 1 : (int) Math.ceil((double) totalItems / size);
                if (page > totalPages) page = totalPages;
                int fromIndex = (page - 1) * size;
                int toIndex = Math.min(fromIndex + size, totalItems);
                List<NewModel> pageList = (list == null || list.isEmpty()) ? java.util.Collections.emptyList() : list.subList(fromIndex, toIndex);

                List<NewModel> topViewed = newService.findTopViewed(5);

                req.setAttribute("newsList", pageList);
                req.setAttribute("topViewed", topViewed);
                req.setAttribute("currentPage", page);
                req.setAttribute("totalPages", totalPages);
                req.setAttribute("pageSize", size);
                req.setAttribute("totalItems", totalItems);
                req.getRequestDispatcher("/views/client/news/news-list.jsp").forward(req, resp);
            } else {
                // detail - pathInfo like /123
                String raw = pathInfo.startsWith("/") ? pathInfo.substring(1) : pathInfo;
                // support possible trailing slash
                if (raw.endsWith("/")) raw = raw.substring(0, raw.length() - 1);
                int id = Integer.parseInt(raw);
                NewModel news = newService.findById(id);
                if (news == null) {
                    resp.sendRedirect(req.getContextPath() + "/web404");
                    return;
                }
                req.setAttribute("news", news);
                req.getRequestDispatcher("/views/client/news/news-detail.jsp").forward(req, resp);
            }
        } catch (NumberFormatException ex) {
            // invalid id
            resp.sendRedirect(req.getContextPath() + "/web404");
        } catch (Exception e) {
            e.printStackTrace();
            // on service errors, show 404 page
            resp.sendRedirect(req.getContextPath() + "/web404");
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doGet(req, resp);
    }
}