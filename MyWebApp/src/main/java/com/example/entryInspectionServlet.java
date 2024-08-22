package com.example;

/*import java.io.BufferedReader;*/
import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
/*import javax.servlet.annotation.WebServlet;*/
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONObject;

import com.service.dbUpdate;


public class entryInspectionServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public entryInspectionServlet() {
		super();
		// TODO Auto-generated constructor stub
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		// response.getWriter().append("Served at: ").append(request.getContextPath());
		dbUpdate dbUpd = new dbUpdate();
		JSONObject jsonObj = new JSONObject();
		jsonObj.put("inspection_id", request.getParameter("inspection_id"));
		jsonObj.put("inspection_date", request.getParameter("inspection_date"));
		jsonObj.put("problem_code", request.getParameter("problem_code"));
		jsonObj.put("location", request.getParameter("location"));
		jsonObj.put("problem_details", request.getParameter("problem_details"));
		jsonObj.put("image1", request.getParameter("image1"));
		jsonObj.put("inspection_date", request.getParameter("inspection_date"));
		
		try {
			jsonObj = dbUpd.getAssignmentProc(jsonObj);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		request.getSession().setAttribute("assignmentObject", jsonObj); 

		if (jsonObj.getString("msg").equals("success")) {
			request.getSession().setAttribute("datafetchflag", "true");
		}
		response.sendRedirect("assignment_status.jsp");
	}
}
