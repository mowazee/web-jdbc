package utils;
import java.sql.Connection;
import java.sql.DriverManager;
import java.io.File;
import java.io.FileWriter;
import java.io.PrintWriter;

public class DBConnect {
    private final String serverName = "LUCIFER\\SQLEXPRESS";
    private final String dbName = "WebProject";
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
        //System.out.println("[DBConnect] Attempting DB connection with URL: " + url);
        Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
        // Set a reasonable login timeout to avoid long blocking under Tomcat
        try {
            DriverManager.setLoginTimeout(10); // seconds
        } catch (Exception e) {
            //System.err.println("[DBConnect] Failed to set login timeout: " + e.getMessage());
        }
        try {
            Connection conn = DriverManager.getConnection(url);
            //System.out.println("[DBConnect] Connection established successfully");
            return conn;
        } catch (Exception ex) {
            //System.err.println("[DBConnect] Integrated security connection failed: " + ex.getMessage());
            // write to a local log file for easier inspection from Tomcat process
            try {
                File logDir = new File(Constant.DIR);
                if (!logDir.exists()) logDir.mkdirs();
                File logFile = new File(logDir, "web-jdbc-db-error.log");
                try (PrintWriter pw = new PrintWriter(new FileWriter(logFile, true))) {
                    pw.println("--- " + java.time.ZonedDateTime.now() + " ---");
                    ex.printStackTrace(pw);
                    pw.println();
                }
                //System.err.println("[DBConnect] Wrote DB connect error to " + logFile.getAbsolutePath());
            } catch (Exception e2) {
                //System.err.println("[DBConnect] Failed to write DB connect error log: " + e2.getMessage());
            }
            String dbUser = System.getenv("DB_USER");
            String dbPass = System.getenv("DB_PASS");
            if (dbUser != null && dbPass != null) {
                String url2 = "jdbc:sqlserver://" + serverName + ":" + portNumber + ";encrypt=true;trustServerCertificate=true;databaseName=" + dbName;
                //System.out.println("[DBConnect] Trying SQL auth fallback with URL: " + url2 + " user=" + dbUser);
                try {
                    Connection conn2 = DriverManager.getConnection(url2, dbUser, dbPass);
                    //System.out.println("[DBConnect] Connection established with SQL auth fallback");
                    return conn2;
                } catch (Exception ex2) {
                    //System.err.println("[DBConnect] SQL auth fallback failed: " + ex2.getMessage());
                    try {
                        File logDir = new File(Constant.DIR);
                        if (!logDir.exists()) logDir.mkdirs();
                        File logFile = new File(logDir, "web-jdbc-db-error.log");
                        try (PrintWriter pw = new PrintWriter(new FileWriter(logFile, true))) {
                            pw.println("--- " + java.time.ZonedDateTime.now() + " ---");
                            ex2.printStackTrace(pw);
                            pw.println();
                        }
                        //System.err.println("[DBConnect] Wrote DB fallback error to " + logFile.getAbsolutePath());
                    } catch (Exception e3) {
                        //System.err.println("[DBConnect] Failed to write DB fallback error log: " + e3.getMessage());
                    }
                    throw ex2;
                }
            }
            throw ex;
        }
    }
	//  public static void main(String[] args) {
	//	try {
	//	System.out.println(new DBConnect().getConnection());
	//	} catch (Exception e) {
	//	e.printStackTrace();
	//	}
	//}

}