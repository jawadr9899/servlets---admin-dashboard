package org.main;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

public class ErrorController extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        req.setAttribute("pageTitle","Error");
        req.setAttribute("contentPage", "/WEB-INF/error.jsp");
        req.getRequestDispatcher("/WEB-INF/layout.jsp").forward(req, res);


    }
}
