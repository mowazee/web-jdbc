package controller;
import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.CategoryModel;
import model.ProductModel;
import service.IProductService;
import service.impl.ProductServiceImpl;
@WebServlet(urlPatterns = { "/categories", "/category", "/products/category" })
public class CategoryClientController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private IProductService productService = new ProductServiceImpl();
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            req.setCharacterEncoding("UTF-8");  
            resp.setCharacterEncoding("UTF-8");

            String cateidParam = req.getParameter("cateid");
            int cateid = 0;
            if (cateidParam != null && !cateidParam.trim().isEmpty()) {
                try {
                    cateid = Integer.parseInt(cateidParam);
                } catch (NumberFormatException e) {
                    cateid = 0;
                }
            }
            // pagination params
            String pageStr = req.getParameter("page");
            String pageSizeStr = req.getParameter("pageSize");
            int page = 1;
            int pageSize = 12; // default
            try { if (pageStr != null) page = Math.max(1, Integer.parseInt(pageStr)); } catch (NumberFormatException ex) { page = 1; }
            try {
                if (pageSizeStr != null) {
                    int ps = Integer.parseInt(pageSizeStr);
                    if (ps == 6 || ps == 12 || ps == 24 || ps == 48) pageSize = ps;
                }
            } catch (NumberFormatException ex) { pageSize = 12; }
            int offset = (page - 1) * pageSize;

            // If no cateid provided, try to use first category from request attribute (CategoryFilter provides it)
            if (cateid <= 0) {
                Object catsObj = req.getAttribute("categories");
                if (catsObj instanceof List) {
                    @SuppressWarnings("unchecked")
                    List<CategoryModel> cats = (List<CategoryModel>) catsObj;
                    if (cats != null && !cats.isEmpty()) {
                        cateid = cats.get(0).getCateid();
                    }
                }
            }
            List<ProductModel> products;
            int totalResults = 0;
            if (cateid > 0) {
                products = productService.findByCategoryPaged(cateid, offset, pageSize);
                totalResults = productService.countByCategory(cateid);
            } else {
                products = java.util.Collections.emptyList();
            }
            int totalPages = (int) Math.ceil((double) totalResults / pageSize);
            if (totalPages == 0) totalPages = 1;
            req.setAttribute("products", products);
            req.setAttribute("currentCategoryId", cateid);
            req.setAttribute("currentPage", page);
            req.setAttribute("pageSize", pageSize);
            req.setAttribute("totalPages", totalPages);
            req.setAttribute("totalResults", totalResults);
            req.getRequestDispatcher("/views/client/list-category.jsp").forward(req, resp);
        } catch (Exception e) {
            e.printStackTrace();
            resp.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        }
    }
}