package com.example;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import org.json.JSONArray;
import org.json.JSONObject;

import com.service.dbUpdate;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/*import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;*/

public class fetchProblemCodes extends HttpServlet {

	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("entered the fetchProblem servlet");
		BufferedReader reader = request.getReader();
		String line;
		StringBuffer sB = new StringBuffer();
		while((line= reader.readLine())!= null) {
			sB.append(line);
		}

		dbUpdate dbUpd= new dbUpdate();
		JSONObject jsonObj= new JSONObject();
		JSONObject jsonInput= new JSONObject(sB.toString());
		
		jsonObj.put("network_type",  jsonInput.getString("network_type"));
		jsonObj.put("asset_name",  jsonInput.getString("asset_name"));
		
		System.out.println("sb toString: "+ sB.toString());
		System.out.println("json object: "+ jsonObj);
		
		try {
			jsonObj= dbUpd.getProblems(jsonObj);
			System.out.println("try section completed");
		}catch(SQLException e) {
			System.out.println("catch section entered");
			e.printStackTrace();
		}
		
		System.out.println("jsonObject at last in fetch servlet: "+ jsonObj);
		PrintWriter out = response.getWriter();
		response.setContentType("application/json");
		response.setCharacterEncoding("UTF-8");
		out.print(jsonObj.toString());
		
        out.flush();
        System.out.println(jsonObj.toString());
        System.out.println("Response: " + jsonObj.toString());
        System.out.println("servlet fetch Problem ends");
	}
}