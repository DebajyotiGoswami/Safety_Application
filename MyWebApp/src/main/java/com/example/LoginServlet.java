package com.example;

//import jakarta.servlet.ServletException;
//import jakarta.servlet.http.HttpServlet;
//import jakarta.servlet.http.HttpServletRequest;
//import jakarta.servlet.http.HttpServletResponse;
//import jakarta.servlet.http.HttpSession;
//import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

public class LoginServlet extends HttpServlet {

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	    // Retrieve form data
	    String userId = request.getParameter("userId");
	    String password = request.getParameter("password");

	    // Simulate user validation - replace with actual validation logic
	    boolean isValidUser = validateUser(userId, password);

	    if (isValidUser) {
	        // Generate OTP and send it to user's mobile
	        String otp = generateOtp();
	        HttpSession session = request.getSession();
	        session.setAttribute("generatedOtp", otp);
	        System.out.println(otp);
	        // Set message to show that OTP is sent
	        request.setAttribute("otpSentMessage", "A one-time password has been sent to your registered mobile number *********");
	        request.setAttribute("generatedOtp", otp); // Include OTP in the request for testing
	    } else {
	        // Set error message
	        request.setAttribute("loginError", "Invalid User ID or Password. Please try again.");
	    }

	    // Forward back to the login page
	    request.getRequestDispatcher("index.jsp").forward(request, response);
	}


    private boolean validateUser(String userId, String password) {
        // Placeholder for real user validation logic
        return "user".equals(userId) && "user".equals(password);
    }

    private String generateOtp() {
        // Generate a random 6-digit OTP
        int otp = 100000 + (int)(Math.random() * 900000);
        System.out.println(otp); // Consider removing or logging to a file in production
        return String.valueOf(otp);
    }
}