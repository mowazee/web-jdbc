package utils;
import java.sql.Connection;
import java.sql.DriverManager;

public class DBConnect {
    private final String serverName = "LUCIFER\\SQLEXPRESS";
    private final String dbName = "VNPTHT";
    private final String portNumber = "1433";
    private final String instance = "";            // ví dụ: "SQLEXPRESS", hoặc để rỗng
    //private final String userID = "sa";            // thay bằng user thật
    //private final String password = "123456";      // thay bằng pass thật

    public Connection getConnection() throws Exception {
		String url = "jdbc:sqlserver://" + serverName + ":" + portNumber + "\\" + instance
				+ ";encrypt=true;trustServerCertificate=true;integratedSecurity=true;databaseName=" + dbName;
		if (instance == null || instance.trim().isEmpty()) {
			url = "jdbc:sqlserver://" + serverName + ":" + portNumber + ";encrypt=true;trustServerCertificate=true;integratedSecurity=true;databaseName="
					+ dbName;
		}
		Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
		return DriverManager.getConnection(url);
	}
//    public static void main(String[] args) {
//    	try {
//    	System.out.println(new DBConnect().getConnection());
//    	} catch (Exception e) {
//    	e.printStackTrace();
//    	}
//    }
}