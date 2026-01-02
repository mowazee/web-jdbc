package filters;

import java.io.IOException;
import java.util.List;

import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.FilterConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.annotation.WebFilter;

import model.CategoryModel;
import service.ICategoryService;
import service.impl.CategoryServiceImpl;

@WebFilter(urlPatterns = {"/*"})
public class CategoryFilter implements Filter {
    private ICategoryService categoryService = new CategoryServiceImpl();

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        // no-op
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        try {
            List<CategoryModel> categories = categoryService.findAll();
            request.setAttribute("categories", categories);
        } catch (Exception e) {
            // ignore; ensure request proceeds even if categories fail
        }
        chain.doFilter(request, response);
    }

    @Override
    public void destroy() {
        // no-op
    }
}
