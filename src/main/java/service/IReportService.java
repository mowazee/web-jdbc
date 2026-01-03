package service;

import java.util.Map;
import java.util.List;

public interface IReportService {
    Map<String, double[]> getProductRevenueByYear(int year, int topN) throws Exception;
    List<java.util.Map<String,Object>> getTopNewsPerMonth(int year) throws Exception;
}
