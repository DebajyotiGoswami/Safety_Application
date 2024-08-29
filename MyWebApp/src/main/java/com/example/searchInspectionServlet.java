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

		StringBuilder jsonBuilder = new StringBuilder();
		try (BufferedReader reader = request.getReader()) {
			String line;
			while ((line = reader.readLine()) != null) {
				jsonBuilder.append(line);
			}
			
		}

		// Convert StringBuilder to JSON object
		if (jsonBuilder.toString() != null && !jsonBuilder.toString().equals("")) {
			JSONObject jsonObjInput = new JSONObject(jsonBuilder.toString());
			System.out.println("jsonObjInput : " + jsonObjInput);
			if(jsonObjInput.has("pageLoadFlag")
					&&
					jsonObjInput.getString("pageLoadFlag").equals("pageLoad")
					&&
					jsonObjInput.has("erpId")
					&&
					!jsonObjInput.getString("erpId").equals("")
					) {
				dbUpdate dbUpd = new dbUpdate();
				try {
					jsonObjInput=dbUpd.getInspectionEntryProc(jsonObjInput);
					PrintWriter out = response.getWriter();
					out.print(jsonObjInput);
					out.flush();
				} catch (Exception e) {
					System.err.println(e.getMessage());
				}
			}else {
				response.sendRedirect("dashboard.jsp");
			}
		} else {
			dbUpdate dbUpd = new dbUpdate();
			JSONObject jsonObj = new JSONObject();

			try {
				String fromDate = request.getParameter("fromDate");
				String toDate = request.getParameter("toDate");
				String erpId = (String) request.getSession().getAttribute("erpId");
				System.out.println(fromDate + toDate + erpId);
				jsonObj.put("fromDate", fromDate);
				jsonObj.put("toDate", toDate);
				jsonObj.put("erpId", erpId);
				System.out.println("searchInspectionServlet: " + jsonObj);
				jsonObj = dbUpd.getInspectionProc(jsonObj);
			} catch (SQLException e) {
				e.printStackTrace();
			}
			System.out.println("just before request.getSession(): " + jsonObj);
			request.getSession().setAttribute("assignmentObject", jsonObj);

			if (jsonObj.getString("msg").equals("assignment data fetched")) {
				request.getSession().setAttribute("datafetchflag", "true");
				jsonObj.put("msg", "true");
			}
			System.out.println("searchInspectionServlet getSession: " + jsonObj);
			response.sendRedirect("pending_inspection.jsp");

			PrintWriter out = response.getWriter();
			out.print(jsonObj);
			out.flush();
		}
	}
}
