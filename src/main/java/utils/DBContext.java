package utils;

import java.sql.Connection;
import java.sql.DriverManager;

public class DBContext {

    private static final String URL =
        "jdbc:sqlserver://localhost:1433;databaseName=SuMonDB;encrypt=false";

    private static final String USER = "sa";
    private static final String PASS = System.getenv().getOrDefault("SUMON_DB_PASSWORD", "");

    public static Connection getConnection() {

        try {

            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
            
            System.out.println("=== DBContext đang chạy ===");
            System.out.println(URL);

            return DriverManager.getConnection(URL, USER, PASS);

        } catch (Exception e) {
            e.printStackTrace();
        }

        return null;
    }
}