package com.example;

import java.io.IOException;
import javax.servlet.ServletException;
/*import javax.servlet.annotation.WebServlet;*/
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.json.JSONObject;
import java.io.BufferedReader;

//@WebServlet("/StoreUserDetailsServlet")
public class StoreUserDetailsServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Read the JSON data from the request
        StringBuilder sb = new StringBuilder();
        BufferedReader reader = request.getReader();
        String line;
        while ((line = reader.readLine()) != null) {
            sb.append(line);
        }
        JSONObject empDtls = new JSONObject(sb.toString());
        //String erpId= "";
        System.out.println("empDtls: "+ empDtls);

        // Store the JSON object in the session
        HttpSession session = request.getSession();
        session.setAttribute("empDtls", empDtls);
        //session.setAttribute("erpId",  empDtls.erpId.toString());

        // Send a response back to the client
		/* response.setContentType("text/plain"); */
        response.setContentType("application/json");
        response.getWriter().write("User details stored in session.");
    }
}
