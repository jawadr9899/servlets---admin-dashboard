package org.main;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.Statement;

public class DBConnection {
    private static final String URL = "jdbc:sqlite:./dev.db";

    static {
        try {
            // Load the driver
            Class.forName("org.sqlite.JDBC");

            // Create tables immediately if they don't exist
            initializeDatabase();
        } catch (Exception e) {
            System.err.println("Critical Error: Could not initialize SQLite.");
            e.printStackTrace();
        }
    }

    private static void initializeDatabase() {
        String createUserTable = "CREATE TABLE IF NOT EXISTS users (" +
                "id INTEGER PRIMARY KEY AUTOINCREMENT, " +
                "name TEXT NOT NULL, " +
                "email TEXT NOT NULL UNIQUE, " + // Added UNIQUE for better data integrity
                "password TEXT NOT NULL);";

        String createProductTable = "CREATE TABLE IF NOT EXISTS products (" +
                "productId INTEGER PRIMARY KEY AUTOINCREMENT, " +
                "name TEXT NOT NULL, " +
                "category TEXT, " +
                "price REAL NOT NULL," +
                "description TEXT NOT NULL," +
                "imgURL TEXT NOT NULL," +
                "quantity INTEGER NOT NULL DEFAULT 0);";

        try (Connection conn = getConnection();
             Statement stmt = conn.createStatement()) {

            // Execute both table creations
            stmt.execute(createUserTable);
            stmt.execute(createProductTable);

            System.out.println("SQLite Database & Tables verified/created at: " + URL);
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public static Connection getConnection() throws SQLException {
        return DriverManager.getConnection(URL);
    }
}
