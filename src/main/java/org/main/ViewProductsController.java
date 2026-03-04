package org.main;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
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

@WebServlet("/products")
public class ViewProductsController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        List<DashboardController.Product> productList = new ArrayList<>();

        // Query to fetch all products for the gallery
        String sql = "SELECT * FROM products ORDER BY name ASC";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql);
             ResultSet rs = pstmt.executeQuery()) {

            while (rs.next()) {
                productList.add(new DashboardController.Product(
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
            // Optional: Redirect to an error page or set an error message
        }

        // Set attributes for the JSP
        req.setAttribute("productList", productList);
        req.setAttribute("pageTitle", "Our Collection");

        // This assumes you are using a layout.jsp as a wrapper
        req.setAttribute("contentPage", "/WEB-INF/products.jsp");
        req.getRequestDispatcher("/WEB-INF/layout.jsp").forward(req, res);
    }
}