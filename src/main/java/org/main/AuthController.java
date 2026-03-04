package org.main;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class AuthController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req,
                         HttpServletResponse res)
            throws ServletException, IOException {

        req.setAttribute("pageTitle","Authentication");
        req.setAttribute("contentPage", "/WEB-INF/auth.jsp");
        req.getRequestDispatcher("/WEB-INF/layout.jsp").forward(req, res);

    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {

        String action = req.getParameter("action");
        if ("login".equalsIgnoreCase(action)) {
            handleLogin(req, res);
        } else if ("signup".equalsIgnoreCase(action)) {
            handleSignup(req, res);
        } else {
            res.sendRedirect("/error");
        }

    }

    private void handleLogin(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
        String email = req.getParameter("email");
        String password = req.getParameter("password");

        System.out.println("User Login Info {");
        System.out.println(" email: "+email);
        System.out.println(" password: "+password);
        System.out.println("}");

        String sql = "SELECT * FROM users WHERE email = ? AND password = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            // 1. Bind the email to the first ?
            pstmt.setString(1, email);
            pstmt.setString(2,password);

            // 2. Use executeQuery() for SELECT statements
            try (ResultSet rs = pstmt.executeQuery()) {

                // 3. Check if a record was found
                if (rs.next()) {
                    // User exists! Extract data by column name
                    String dbEmail = rs.getString("email");
                    String dbPassword = rs.getString("password"); // Be careful with plain text!
                    String userName = rs.getString("name");

                    // Example: Store user in session and redirect to dashboard
                    req.getSession().setAttribute("user", userName);
                    res.sendRedirect("/dashboard");

                } else {
                    // No user found with that email
                    System.out.println("No user found!");
                    req.setAttribute("alertMessage", "No account found with that email.");
                   res.sendRedirect("/");
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
            res.sendRedirect("/error");
        }

    }


    private void handleSignup(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
        String name = req.getParameter("name");
        String email = req.getParameter("email");
        String password = req.getParameter("password");

        System.out.println("User Signup Info {");
        System.out.println(" name: "+name);
        System.out.println(" email: "+email);
        System.out.println(" password: "+password);
        System.out.println("}");

        String sql = "INSERT INTO users (name,email,password) VALUES (?,?,?);";
//
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            // 4. Bind the values to the ? placeholders
            pstmt.setString(1,name);
            pstmt.setString(2, email);
            pstmt.setString(3, password);

            // 5. Execute the update
            int rowsInserted = pstmt.executeUpdate();

            if (rowsInserted > 0) {
                // Success! Redirect or show message
                res.getWriter().println("<h1>User " + email + " registered successfully!</h1>");
                res.getWriter().println("<a href='/'>Go Back</a>");
            }

        } catch (SQLException e) {
            // Handle database errors
            e.printStackTrace();
            res.getWriter().println("Error saving user: " + e.getMessage());
            res.sendRedirect("/error");
        }

    }

}