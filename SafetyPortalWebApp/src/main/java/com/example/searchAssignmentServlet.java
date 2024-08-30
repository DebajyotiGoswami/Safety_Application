package com.example;

/*import java.io.BufferedReader;*/
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;

import javax.servlet.ServletException;
/*import javax.servlet.annotation.WebServlet;*/
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONObject;

import com.service.dbUpdate;


public class searchAssignmentServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public searchAssignmentServlet() {
		super();
		// TODO Auto-generated constructor stub
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		// response.getWriter().append("Served at: ").append(request.getContextPath());
		dbUpdate dbUpd = new dbUpdate();
		JSONObject jsonObj = new JSONObject();
		jsonObj.put("from_date", request.getParameter("fromDate"));
		jsonObj.put("to_date", request.getParameter("toDate"));
		jsonObj.put("erpId", request.getParameter("erpId"));
		try {
			jsonObj = dbUpd.getAssignmentProc(jsonObj);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		//request.getSession().setAttribute("assignmentObject", jsonObj); 

//		if (jsonObj.getString("msg").equals("success")) {
//			request.getSession().setAttribute("datafetchflag", "true");
//		}
//		response.sendRedirect("assignment_status.jsp");
		
		System.out.println("jsonObj: "+jsonObj);
		
		PrintWriter out = response.getWriter();
        out.print(jsonObj);
        out.flush();
	}
}
