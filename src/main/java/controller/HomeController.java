package controller;

import java.io.IOException;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.ProductModel;
import model.NewModel;
import service.IProductService;
import service.INewService;
import service.impl.ProductServiceImpl; 
import service.impl.NewServiceImpl;

@WebServlet(urlPatterns = {"/home", "/index", "/about", "/contact", "/profile"})
public class HomeController extends HttpServlet {
private static final long serialVersionUID = 1L;
private IProductService productService = new ProductServiceImpl();
private INewService newService = new NewServiceImpl();
@Override
protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
    resp.setContentType("text/html");
    String path = req.getServletPath();
    switch (path) {
        case "/about":
            // hide slidebar on about page
            req.setAttribute("hideSlidebar", true);
            req.getRequestDispatcher("/views/client/about.jsp").forward(req, resp);
            break;
        case "/contact":
            // hide slidebar on contact page
            req.setAttribute("hideSlidebar", true);
            req.getRequestDispatcher("/views/client/contact.jsp").forward(req, resp);
            break;
        case "/profile":
            req.getRequestDispatcher("/views/client/user-profile.jsp").forward(req, resp);
            break;
//        case "/home":
//        case "/index":
        default:
            try {
                // Fetch a few products to show on homepage (limit 4 to fill a 4-col row; controller can limit to 3 if desired)
                List<ProductModel> products = productService.findAllPaged(0, 4);
                // Fetch top 3 news items
                List<NewModel> topNews = newService.findTopViewed(3);

                req.setAttribute("products", products);
                req.setAttribute("newsList", topNews);
            } catch (Exception e) {
                // ignore service errors; page will show empty sections
                e.printStackTrace();
            }
            req.getRequestDispatcher("home.jsp").forward(req, resp);
            break;
    }
}
@Override
protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
    doGet(req, resp);
}
}