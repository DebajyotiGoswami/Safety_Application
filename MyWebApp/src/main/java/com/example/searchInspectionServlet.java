package com.example;

import java.io.BufferedReader;
/*import java.io.BufferedReader;*/
import java.io.IOException;
import java.io.PrintStream;
import java.io.PrintWriter;
import java.sql.SQLException;

import javax.servlet.ServletException;
/*import javax.servlet.annotation.WebServlet;*/
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONObject;

import com.service.dbUpdate;

public class searchInspectionServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public searchInspectionServlet() {
		super();
		// TODO Auto-generated constructor stub
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		// response.getWriter().append("Served at: ").append(request.getContextPath());
		
		 StringBuilder jsonBuffer = new StringBuilder();
	        String line;
	        try (BufferedReader reader = request.getReader()) {
	            while ((line = reader.readLine()) != null) {
	                jsonBuffer.append(line);
	            }
	        }

	        // Parse JSON data
	        JSONObject jsonObject = new JSONObject(jsonBuffer.toString());
		System.out.println("jsonObject: "+jsonObject);
		String user= jsonObject.getString("erpId");
		dbUpdate dbUpd = new dbUpdate();
		JSONObject jsonObj = new JSONObject();
//		jsonObj.put("from_date", request.getParameter("from_date"));
//		jsonObj.put("to_date", request.getParameter("to_date"));
		jsonObj.put("user", user );

		try {
			jsonObj = dbUpd.getInspectionProc(jsonObj);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		System.out.println("just before request.getSession(): "+ jsonObj);
		request.getSession().setAttribute("assignmentObject", jsonObj); 

		if (jsonObj.getString("msg").equals("assignment data fetched")) {
			request.getSession().setAttribute("datafetchflag", "true");
		}
		System.out.println("searchAssignmentServlet getSession: " + jsonObj);
		PrintWriter out= response.getWriter();
		/* response.sendRedirect("assignment_status.jsp"); */
		 out.print(jsonObj);
	}
}
