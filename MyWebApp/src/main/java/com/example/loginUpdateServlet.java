package com.example;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.PrintStream;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONObject;

import com.service.dbUpdate;

/**
 * Servlet implementation class loginUpdateServlet
 */
//@WebServlet("/loginUpdateServlet")
public class loginUpdateServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public loginUpdateServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// Get the client's IP address from the X-Forwarded-For header
        
        dbUpdate dbUpd= new dbUpdate();
        String ipAddress = request.getHeader("X-Forwarded-For");
        if (ipAddress == null || ipAddress.isEmpty()) {
            // Fallback to request.getRemoteAddr() if X-Forwarded-For is not present
            ipAddress = request.getRemoteAddr();
        }

        // Get the User-Agent header
        String userAgent = request.getHeader("User-Agent");
        
//        String erpId= request.getParameter("user");
        BufferedReader reader = request.getReader();
        String line;
        StringBuffer sB = new StringBuffer();
		while ((line = reader.readLine()) != null)
          sB.append(line); 
        System.out.println(sB.toString());
        JSONObject reqJsonHpl = new JSONObject(sB.toString());
        
        JSONObject jsonObj= new JSONObject();
        jsonObj.put("user", reqJsonHpl.getString("User"));
        jsonObj.put("ipAddr", ipAddress);
        jsonObj.put("userAgent", userAgent);
        System.out.println(jsonObj);
        try {
			jsonObj= dbUpd.dbUpdateProc(jsonObj);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
        System.out.println(jsonObj.getString("msg"));
        response.getWriter().println(jsonObj.getString("msg"));
	}

}
