package com.example;

import java.io.IOException;
import javax.servlet.ServletException;
//import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.json.JSONObject;

public class GetIpServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String ipAddr = request.getRemoteAddr(); // Get client IP address
        System.out.println("ip address: "+ ipAddr);

        // Create a JSON object to return IP address
        JSONObject jsonResponse = new JSONObject();
        jsonResponse.put("ipAddr", ipAddr);
        System.out.println("json: "+jsonResponse);
        response.setContentType("application/json");
        response.getWriter().print(jsonResponse.toString());
    }
}
