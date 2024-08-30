package com.example;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONObject;

import com.service.dbUpdate;

/**
 * Servlet implementation class searchInspectionServletNew
 */
//@WebServlet("/searchInspectionServletNew")
public class searchInspectionServletNew extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public searchInspectionServletNew() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
				dbUpdate dbUpd = new dbUpdate();
				response.getWriter().println("searchInspectionServletNew");
			System.out.println("searchInspectionServletNew");
		JSONObject jsonObj=new JSONObject();
		
		try {
			String fromDate=request.getParameter("fromDate");
			String toDate=request.getParameter("toDate");
			//String erpId=(String) request.getSession().getAttribute("erpId");
			jsonObj.put("fromDate", fromDate);
			jsonObj.put("toDate", toDate);
			jsonObj.put("erpId", "90012775");
			System.out.println("searchInspectionServlet: "+jsonObj);
			jsonObj = dbUpd.getInspectionProc(jsonObj);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		System.out.println("just before request.getSession(): "+ jsonObj);
		request.getSession().setAttribute("assignmentObject", jsonObj); 

		if (jsonObj.getString("msg").equals("assignment data fetched")) {
			request.getSession().setAttribute("datafetchflag", "true");
		}
		System.out.println("searchInspectionServlet getSession: " + jsonObj);
		response.sendRedirect("pending_inspection.jsp");
	}

}
