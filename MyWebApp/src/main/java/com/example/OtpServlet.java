package com.example;

//import jakarta.servlet.ServletException;
//import jakarta.servlet.http.HttpServlet;
//import jakarta.servlet.http.HttpServletRequest;
//import jakarta.servlet.http.HttpServletResponse;
//import jakarta.servlet.http.HttpSession;
//import java.io.IOException;
//import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;

public class OtpServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("application/json");
        PrintWriter out = response.getWriter();
        HttpSession session = request.getSession();
        String generatedOtp = (String) session.getAttribute("generatedOtp");
        String enteredOtp = request.getParameter("otp");

        if (generatedOtp != null && generatedOtp.equals(enteredOtp)) {
            out.println("{\"valid\": true}");
        } else {
            out.println("{\"valid\": false}");
        }
    }
}