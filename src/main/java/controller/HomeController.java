package controller;

import java.io.IOException;
//import java.io.PrintWriter;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(urlPatterns = {"/home", "/index", "/about", "/contact"})
public class HomeController extends HttpServlet {
private static final long serialVersionUID = 1L;
@Override
protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
    resp.setContentType("text/html");
    String path = req.getServletPath();
    switch (path) {
        case "/about":
            req.getRequestDispatcher("/views/client/about.jsp").forward(req, resp);
            break;
        case "/contact":
            req.getRequestDispatcher("/views/client/contact.jsp").forward(req, resp);
            break;
        case "/home":
        case "/index":
        default:
            req.getRequestDispatcher("home.jsp").forward(req, resp);
            break;
    }
}
@Override
protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
    doGet(req, resp);
}
}