package controller.admin;
import java.io.IOException;
import java.util.Map;
import java.util.List;

import com.google.gson.Gson;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import service.IReportService;
import service.impl.ReportServiceImpl;

@WebServlet(urlPatterns = { "/admin/report-debug" })
public class ReportDebugController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private IReportService reportService = new ReportServiceImpl();
    private Gson gson = new Gson();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("application/json;charset=UTF-8");
        int year = java.time.Year.now().getValue();
        String y = req.getParameter("year");
        if (y != null) {
            try { year = Integer.parseInt(y); } catch (NumberFormatException ex) { }
        }
        try {
            Map<String,double[]> productRevenue = reportService.getProductRevenueByYear(year, 0);
            List<java.util.Map<String,Object>> topNews = reportService.getTopNewsPerMonth(year);
            java.util.Map<String,Object> out = new java.util.HashMap<>();
            out.put("year", year);
            out.put("productRevenue", productRevenue);
            out.put("topNews", topNews);
            resp.getWriter().write(gson.toJson(out));
        } catch (Exception ex) {
            resp.setStatus(500);
            resp.getWriter().write(gson.toJson(java.util.Map.of("error", ex.getMessage())));
        }
    }
}
