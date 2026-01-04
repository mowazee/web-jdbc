package controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.ProductModel;
import model.CategoryModel;
import service.ICategoryService;
import service.IProductService;
import service.impl.CategoryServiceImpl;
import service.impl.ProductServiceImpl;

@WebServlet(urlPatterns = { "/products", "/product", "/products/special" })
public class ProductController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private IProductService productService = new ProductServiceImpl();
    private ICategoryService categoryService = new CategoryServiceImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            req.setCharacterEncoding("UTF-8");
            resp.setCharacterEncoding("UTF-8");

            String q = req.getParameter("q");
            String cateIdStr = req.getParameter("id");
            String pageStr = req.getParameter("page");
            String pageSizeStr = req.getParameter("pageSize");

            int page = 1;
            int pageSize = 12; // default items per page
            try {
                if (pageStr != null)
                    page = Math.max(1, Integer.parseInt(pageStr));
            } catch (NumberFormatException ex) {
                page = 1;
            }

            // validate pageSize (allow common sizes)
            try {
                if (pageSizeStr != null) {
                    int ps = Integer.parseInt(pageSizeStr);
                    if (ps == 6 || ps == 12 || ps == 24 || ps == 48) pageSize = ps;
                }
            } catch (NumberFormatException ex) {
                pageSize = 12;
            }

            int offset = (page - 1) * pageSize;

            List<ProductModel> products;
            int totalResults = 0;
            if (q != null && !q.trim().isEmpty()) {
                String keyword = q.trim();
                products = productService.searchByNamePaged(keyword, offset, pageSize);
                totalResults = productService.countBySearch(keyword);
                req.setAttribute("searchQuery", keyword);
            } else if (cateIdStr != null && !cateIdStr.isEmpty()) {
                try {
                    int cateid = Integer.parseInt(cateIdStr);
                    products = productService.findByCategoryPaged(cateid, offset, pageSize);
                    totalResults = productService.countByCategory(cateid);
                    req.setAttribute("currentCategoryId", cateid);
                } catch (NumberFormatException e) {
                    products = productService.findAllPaged(offset, pageSize);
                    totalResults = productService.countAll();
                }
            } else {
                products = productService.findAllPaged(offset, pageSize);
                totalResults = productService.countAll();
            }

            // Build category map for displayed products to show category name in the view
            Map<Integer, String> categoryMap = new HashMap<>();
            for (ProductModel p : products) {
                int cid = p.getCateid();
                if (!categoryMap.containsKey(cid)) {
                    try {
                        CategoryModel c = categoryService.findById(cid);
                        categoryMap.put(cid, c != null ? c.getCatename() : "Không xác định");
                    } catch (Exception ex) {
                        categoryMap.put(cid, "Không xác định");
                    }
                }
            }

            int totalPages = (int) Math.ceil((double) totalResults / pageSize);
            if (totalPages == 0)
                totalPages = 1;

            req.setAttribute("products", products);
            req.setAttribute("categoryMap", categoryMap);
            req.setAttribute("currentPage", page);
            req.setAttribute("totalPages", totalPages);
            req.setAttribute("totalResults", totalResults);
            req.setAttribute("pageSize", pageSize);

            req.getRequestDispatcher("/views/client/product-list.jsp").forward(req, resp);
        } catch (Exception e) {
            e.printStackTrace();
            resp.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        }
    }
}