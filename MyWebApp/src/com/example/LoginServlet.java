package com.example;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


public class LoginServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String userId = request.getParameter("userId");
        String password = request.getParameter("password");

        // Implement your authentication logic here
        if ("user".equals(userId) && "user".equals(password)) {
            response.sendRedirect("E:\\Project\\Safety_Application\\MyWebApp\\WebContent\\next_page.html"); // Redirect to a dashboard page
        } else {
            response.sendRedirect("login.jsp?error=invalid"); // Redirect back to login page with error
        }
    }
}

