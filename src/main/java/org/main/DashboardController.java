package org.main;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;


public class DashboardController extends HttpServlet {

    // --- Product Inner Class ---
    public static class Product {
        private final int productId;
        private final String name;
        private final String category;
        private final double price;
        private final String description;
        private final int quantity;
        private final String imgURL;

        public Product(int productId, String name, String category, String description, double price, int quantity , String imgURL){
            this.productId = productId;
            this.name = name;
            this.category = category;
            this.price = price;
            this.description = description;
            this.imgURL = imgURL;
            this.quantity = quantity;
        }

        public int getId() { return productId; }
        public String getName() { return name; }
        public String getCategory() { return category; }
        public String getDescription() { return description; }
        public double getPrice() { return price; }
        public int getQuantity() { return quantity; }

        public String getImgURL() {
            return imgURL;
        }
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
        List<Product> productList = new ArrayList<>();
        String sql = "SELECT * FROM products ORDER BY productId DESC";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql);
             ResultSet rs = pstmt.executeQuery()) {

            while (rs.next()) {
                productList.add(new Product(
                        rs.getInt("productId"),
                        rs.getString("name"),
                        rs.getString("category"),
                        rs.getString("description"),
                        rs.getDouble("price"),
                        rs.getInt("quantity"),
                        rs.getString("imgURL")
                ));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        req.setAttribute("productList", productList);
        req.setAttribute("contentPage", "/WEB-INF/dashboard.jsp");
        req.getRequestDispatcher("/WEB-INF/layout.jsp").forward(req, res);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        try {
            String action = req.getParameter("action");

            if ("add".equals(action)) {
                addProduct(req);
            } else if ("delete".equals(action)) {
                deleteProduct(req);
            }

            res.sendRedirect(req.getContextPath() + "/dashboard");
        } catch (Exception e) {
            e.printStackTrace();
            res.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error: " + e.getMessage());
        }
    }

    private void addProduct(HttpServletRequest req) throws ServletException, IOException {
        String name = req.getParameter("name");
        String category = req.getParameter("category");
        String description = req.getParameter("description");
        double price = Double.parseDouble(req.getParameter("price"));
        int quantity = Integer.parseInt(req.getParameter("quantity"));
        String imgURL = req.getParameter("image");

        String sql = "INSERT INTO products (name, category, description, price, quantity, imgURL) VALUES (?, ?, ?, ?, ?,?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, name);
            pstmt.setString(2, category);
            pstmt.setString(3, description);
            pstmt.setDouble(4, price);
            pstmt.setInt(5, quantity);
            pstmt.setString(6,imgURL);
            pstmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }



    private void deleteProduct(HttpServletRequest req) {
        String idStr = req.getParameter("productId");
        if (idStr != null) {
            int id = Integer.parseInt(idStr);
            String sql = "DELETE FROM products WHERE productId = ?";
            try (Connection conn = DBConnection.getConnection();
                 PreparedStatement pstmt = conn.prepareStatement(sql)) {
                pstmt.setInt(1, id);
                pstmt.executeUpdate();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}