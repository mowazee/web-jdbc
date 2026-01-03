package service.impl;

import java.util.Map;
import java.util.List;

import dao.IReportDAO;
import dao.impl.ReportDAOImpl;
import service.IReportService;

public class ReportServiceImpl implements IReportService {
    private IReportDAO dao = new ReportDAOImpl();

    @Override
    public Map<String, double[]> getProductRevenueByYear(int year, int topN) throws Exception {
        return dao.getProductRevenueByYear(year, topN);
    }

    @Override
    public List<java.util.Map<String,Object>> getTopNewsPerMonth(int year) throws Exception {
        return dao.getTopNewsPerMonth(year);
    }
}
