package filters;

import java.io.IOException;

import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.FilterConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import model.UserModel;

@WebFilter(urlPatterns = {"/admin/*"})
public class AdminFilter implements Filter {

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        // no-op
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse resp = (HttpServletResponse) response;

        HttpSession session = req.getSession(false);
        UserModel user = null;
        if (session != null) {
            Object uObj = session.getAttribute("user");
            if (uObj instanceof UserModel) {
                user = (UserModel) uObj;
            }
        }

        // allow only users with roleid == 1 (admin)
        if (user != null && user.getRoleid() == 1) {
            chain.doFilter(request, response);
        } else {
            // redirect to a public URL so SiteMesh applies client decorator
            String context = req.getContextPath();
            resp.sendRedirect(context + "/web404");
        }
    }

    @Override
    public void destroy() {
        // no-op
    }
}