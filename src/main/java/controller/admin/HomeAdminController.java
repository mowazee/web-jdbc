package controller.admin;
import java.io.IOException;
import java.time.Year;
import java.util.Map;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import service.IReportService;
import service.impl.ReportServiceImpl;
import com.google.gson.Gson;

@WebServlet(urlPatterns = {"/admin/home"})
public class HomeAdminController extends HttpServlet {
private static final long serialVersionUID = 1L;
private IReportService reportService = new ReportServiceImpl();
private Gson gson = new Gson();
@Override
protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
    int year = Year.now().getValue();
    String yearParam = req.getParameter("year");
    if (yearParam != null) {
        try { year = Integer.parseInt(yearParam); } catch (NumberFormatException ex) { year = Year.now().getValue(); }
    }
    try {
        Map<String,double[]> productRevenue = reportService.getProductRevenueByYear(year, 6); // top 6 products
        List<java.util.Map<String,Object>> topNews = reportService.getTopNewsPerMonth(year);
        req.setAttribute("productRevenueJson", gson.toJson(productRevenue));
        req.setAttribute("topNewsJson", gson.toJson(topNews));
        req.setAttribute("reportYear", year);
    } catch (Exception ex) {
        ex.printStackTrace();
        req.setAttribute("reportError", "Không thể tải dữ liệu báo cáo: " + ex.getMessage());
    }
	req.getRequestDispatcher("/views/admin/home.jsp").forward(req, resp);
    return;
}
@Override
protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
    doGet(req, resp);
}
}