
package com.example;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


public class LoginServlet extends HttpServlet {
    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String userId = request.getParameter("userId");
        String password = request.getParameter("password");

        // Implement your authentication logic here
        if ("user".equals(userId) && "user".equals(password)) {
//        	response.getWriter().println("Hello World");
        	response.sendRedirect("dashboard.html"); // Redirect to a protected page
        } else {
        	response.getWriter().println("ERROR");
            //response.sendRedirect("login.jsp?error=invalid"); // Redirect back to login page with error
        }
    }
}

