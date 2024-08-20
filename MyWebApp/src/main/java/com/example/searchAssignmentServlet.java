package com.example;

import java.io.BufferedReader;
import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONObject;

import com.service.dbUpdate;

/**
 * Servlet implementation class searchAssignmentServlet
 */
@WebServlet("/searchAssignmentServlet")
public class searchAssignmentServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public searchAssignmentServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		//response.getWriter().append("Served at: ").append(request.getContextPath());
		dbUpdate dbUpd= new dbUpdate();
		BufferedReader reader = request.getReader();
		String line;
		StringBuffer sB = new StringBuffer();
		while ((line = reader.readLine()) != null)
			sB.append(line);
		System.out.println(sB.toString());
		JSONObject reqJsonHpl = new JSONObject(sB.toString());
		JSONObject jsonObj = new JSONObject();
		jsonObj.put("from_date", reqJsonHpl.getString("from_date"));
		jsonObj.put("to_date", reqJsonHpl.getString("to_date"));
		try {
			jsonObj = dbUpd.getAssignmentProc(jsonObj);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		System.out.println("servlet: "+ jsonObj); // found ok
		//System.out.println("first"+ jsonObj.getString("msg")); // found ok
		response.getWriter().println(jsonObj.getString("msg")); //error found here
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	/*
	 * protected void doPost(HttpServletRequest request, HttpServletResponse
	 * response) throws ServletException, IOException { // TODO Auto-generated
	 * method stub doGet(request, response); }
	 */

}
