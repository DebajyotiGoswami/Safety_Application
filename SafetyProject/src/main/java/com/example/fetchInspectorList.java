package com.example;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONArray;
import org.json.JSONObject;

/**
 * Servlet implementation class fetchInspectorList
 */
/* @WebServlet("/fetchInspectorList") */
public class fetchInspectorList extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public fetchInspectorList() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		JSONArray emplist = new JSONArray();
		JSONObject emplistjson = new JSONObject();
		
		emplist.put("Jewel Daw (90017401)");
		emplist.put("Debajyoti Goswami (90012775)");
		emplist.put("Tuhin Sovan Koley (90010101)");
		emplistjson.put("emplist", emplist);
		
		PrintWriter out = response.getWriter();
		response.setContentType("application/json");
		response.setCharacterEncoding("UTF-8");
		out.print(emplistjson.toString());
		out.flush();
	}

}
