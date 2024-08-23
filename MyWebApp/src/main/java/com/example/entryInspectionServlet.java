package com.example;

/*import java.io.BufferedReader;*/
import java.io.IOException;
import java.io.BufferedReader;
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

		// Read JSON data from the request body
		StringBuilder jsonBuilder = new StringBuilder();
		try (BufferedReader reader = request.getReader()) {
			String line;
			while ((line = reader.readLine()) != null) {
				jsonBuilder.append(line);
			}
			System.out.println("line is : " + line);
		}

		// Convert StringBuilder to JSON object
		JSONObject jsonObjInput = new JSONObject(jsonBuilder.toString());
		System.out.println("created json is : " + jsonObjInput);

		String exampleField = jsonObjInput.getString("inspection_id");
		System.out.println("data out of json: " + exampleField);

		System.out.println("Inside entry inspection servlet.");

		dbUpdate dbUpd = new dbUpdate();
		JSONObject jsonObjOutput = new JSONObject();
		jsonObjOutput.put("inspection_id", jsonObjInput.getString("inspection_id"));
		System.out.println(1);
		jsonObjOutput.put("location_remarks", jsonObjInput.getString("location_remarks"));
		System.out.println(2);
		jsonObjOutput.put("problem_remarks", jsonObjInput.getString("problem_details"));
		System.out.println(3);
		jsonObjOutput.put("assigned_office_code", jsonObjInput.getString("assigned_office_code"));
		System.out.println(4);
		jsonObjOutput.put("inspection_date", jsonObjInput.getString("inspection_date"));
		System.out.println(5);

		System.out.println("Output json to dbupdate is : " + jsonObjOutput);
		// jsonObj.put("image1", request.getParameter("image1"));

		try {
			jsonObjOutput = dbUpd.updateVulnerabilities(jsonObjOutput);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		request.getSession().setAttribute("assignmentObject", jsonObjOutput);

		if (jsonObjOutput.getString("msg").equals("success")) {
			request.getSession().setAttribute("datafetchflag", "true");
		}
		// response.sendRedirect("assignment_status.jsp");

	}
}
