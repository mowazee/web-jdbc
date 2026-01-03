package dao.impl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Map;
import java.util.HashMap;
import java.util.ArrayList;
import java.util.List;

import dao.IReportDAO;
import utils.DBConnect;

public class ReportDAOImpl implements IReportDAO {

    @Override
    public Map<String, double[]> getProductRevenueByYear(int year, int topN) throws Exception {
        // Query: sum of (quantity * unit_price) grouped by product and month
        String sqlBase = "SELECT p.product_name, MONTH(o.order_date) as m, SUM(od.quantity * od.unit_price) as rev "
                   + "FROM ORDERS o "
                   + "JOIN ORDER_DETAIL od ON o.order_id = od.order_id "
                   + "JOIN PRODUCT p ON od.product_id = p.product_id "
                   + "WHERE YEAR(o.order_date) = ? ";
        String sqlWithStatus = sqlBase + "AND o.status = 3 "
                   + "GROUP BY p.product_name, MONTH(o.order_date) "
                   + "ORDER BY p.product_name, m";
        String sqlNoStatus = sqlBase
                   + "GROUP BY p.product_name, MONTH(o.order_date) "
                   + "ORDER BY p.product_name, m";

        Map<String, double[]> map = new HashMap<>();
        // try with status filter first
        try (Connection conn = new DBConnect().getConnection(); PreparedStatement ps = conn.prepareStatement(sqlWithStatus)) {
            ps.setInt(1, year);
            try (ResultSet rs = ps.executeQuery()) {
//                int rowCount = 0;
                while (rs.next()) {
//                    rowCount++;
                    String name = rs.getString("product_name");
                    int m = rs.getInt("m");
                    double rev = rs.getDouble("rev");
                    double[] arr = map.get(name);
                    if (arr == null) { arr = new double[12]; map.put(name, arr); }
                    if (m >=1 && m <=12) arr[m-1] += rev;
                }
//                System.out.println("[ReportDAOImpl] SQL(with status)=" + sqlWithStatus);
//                System.out.println("[ReportDAOImpl] getProductRevenueByYear year=" + year + " rows=" + rowCount + " rawProducts=" + map.size());
//                for (Map.Entry<String,double[]> e : map.entrySet()) {
//                    System.out.println("[ReportDAOImpl] product='" + e.getKey() + "' total=" + sum(e.getValue()));
//                }
            }
        }

        // if no data found, try again without status filter to detect if status condition is filtering everything out
        if (map.isEmpty()) {
//            System.out.println("[ReportDAOImpl] No data with status=1 filter; retrying without status filter for year=" + year);
            try (Connection conn = new DBConnect().getConnection(); PreparedStatement ps = conn.prepareStatement(sqlNoStatus)) {
                ps.setInt(1, year);
                try (ResultSet rs = ps.executeQuery()) {
 //                   int rowCount = 0;
                    while (rs.next()) {
 //                       rowCount++;
                        String name = rs.getString("product_name");
                        int m = rs.getInt("m");
                        double rev = rs.getDouble("rev");
                        double[] arr = map.get(name);
                        if (arr == null) { arr = new double[12]; map.put(name, arr); }
                        if (m >=1 && m <=12) arr[m-1] += rev;
                    }
//                    System.out.println("[ReportDAOImpl] SQL(no status)=" + sqlNoStatus);
//                    System.out.println("[ReportDAOImpl] Retry getProductRevenueByYear year=" + year + " rows=" + rowCount + " rawProducts=" + map.size());
//                    for (Map.Entry<String,double[]> e : map.entrySet()) {
//                        System.out.println("[ReportDAOImpl] product='" + e.getKey() + "' total=" + sum(e.getValue()));
//                    }
                }
            }
        }

        // Optionally reduce to topN products by total revenue
        if (topN > 0 && map.size() > topN) {
            List<Map.Entry<String,double[]>> entries = new ArrayList<>(map.entrySet());
            entries.sort((a,b) -> Double.compare(sum(b.getValue()), sum(a.getValue())));
            Map<String,double[]> top = new HashMap<>();
            for (int i=0;i<Math.min(topN, entries.size());i++) { top.put(entries.get(i).getKey(), entries.get(i).getValue()); }
//            System.out.println("[ReportDAOImpl] returning top " + top.size() + " products for year=" + year);
            return top;
        }
//        System.out.println("[ReportDAOImpl] returning " + map.size() + " products for year=" + year);
        return map;
    }

    @Override
    public List<Map<String, Object>> getTopNewsPerMonth(int year) throws Exception {
        // For each month, get the news title with max view_count in that month (based on publish_date month)
        String sql = "SELECT MONTH(publish_date) as m, title, view_count FROM NEWS WHERE YEAR(publish_date) = ? ORDER BY MONTH(publish_date), view_count DESC";
        List<Map<String,Object>> out = new ArrayList<>();
        try (Connection conn = new DBConnect().getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, year);
            try (ResultSet rs = ps.executeQuery()) {
 //               int rowCount = 0;
                int currentMonth = -1;
                while (rs.next()) {
 //                   rowCount++;
                    int m = rs.getInt("m");
                    String title = rs.getString("title");
                    int views = rs.getInt("view_count");
                    if (m != currentMonth) {
                        Map<String,Object> rec = new HashMap<>();
                        rec.put("month", m);
                        rec.put("title", title);
                        rec.put("views", views);
                        out.add(rec);
                        currentMonth = m;
                    }
                }
//                System.out.println("[ReportDAOImpl] getTopNewsPerMonth year=" + year + " dbRows=" + rowCount + " topNewsCount=" + out.size());
//                for (Map<String,Object> r : out) {
//                    System.out.println("[ReportDAOImpl] month=" + r.get("month") + " title='" + r.get("title") + "' views=" + r.get("views"));
//                }
            }
        }
        return out;
    }

    private static double sum(double[] arr) { double s=0; for(double v:arr) s+=v; return s; }
}