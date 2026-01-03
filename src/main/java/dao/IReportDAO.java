package dao;

import java.util.Map;
import java.util.List;

public interface IReportDAO {
    // returns product -> monthly revenues (index 0 = Jan .. 11 = Dec)
    Map<String, double[]> getProductRevenueByYear(int year, int topN) throws Exception;

    // returns list of TopNewsPerMonth objects serialized elsewhere; here return as List of Map with keys: month(int), title(String), views(long)
    List<java.util.Map<String, Object>> getTopNewsPerMonth(int year) throws Exception;
}
