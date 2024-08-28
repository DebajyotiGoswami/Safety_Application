package com.service;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
/*import java.sql.Date;*/
import java.util.ArrayList;

import org.json.JSONArray;
import org.json.JSONObject;

import com.envProp.envVar;

public class dbUpdate {
	
	envVar envar = new envVar();

	public Connection dbCon() {
		Connection con = null;
		envVar envvar = new envVar();

		try {
			// Load the PostgreSQL JDBC driver
			Class.forName("org.postgresql.Driver");
			// Establish the connection
			con = DriverManager.getConnection(envvar.getConnUrl(), envvar.getDbUser(), envvar.getDbPwd());
			System.out.println("Connection established successfully.");
		} catch (ClassNotFoundException e) {
			System.err.println("PostgreSQL JDBC Driver not found.");
			e.printStackTrace();
		} catch (SQLException e) {
			System.err.println("Connection failed.");
			e.printStackTrace();
		}
		return con;
	}

	//entry login details to login table ( code 201 )
	public JSONObject dbUpdateProc(JSONObject jsonObj) throws SQLException {
		PreparedStatement ps = null;
		int index = 0;
		Connection con = null;
		envVar envar = new envVar();
		try {
			con = dbCon();
			ps = con.prepareStatement(envar.getSql(201));
			ps.setString(1, jsonObj.getString("user"));
			ps.setString(2, jsonObj.getString("ipAddr"));
			ps.setString(3, jsonObj.getString("userAgent"));
			index = ps.executeUpdate();
			if (index > 0) {
				jsonObj.put("msg", "otpSent");
			}
		} catch (Exception e) {
			System.err.println("Connection failed.");
			e.printStackTrace();
		} finally {
			if (con != null) {
				con.close();
			}
		}

		return jsonObj;
	}

	//get assignment details from team_assignment table ( code 301 )
	public JSONObject getAssignmentProc(JSONObject jsonObj) throws SQLException {
		PreparedStatement ps = null;
		Connection con = null;
		envVar envar = new envVar();
		ResultSet rs = null;
		JSONArray resultArray = new JSONArray();
		try {
			con = dbCon();
			String sqlStatement = envar.getSql(301);
			ps = con.prepareStatement(sqlStatement);
			java.sql.Date from_date= java.sql.Date.valueOf(jsonObj.getString("from_date"));
			java.sql.Date to_date= java.sql.Date.valueOf(jsonObj.getString("to_date"));
			ps.setDate(1, from_date);
			ps.setDate(2, to_date);
			try{
				rs = ps.executeQuery();
			}catch(SQLException e) {
				e.printStackTrace();
			}

			while (rs.next()) {
				// Create a JSON object for each row
				JSONObject rowObject = new JSONObject();
				rowObject.put("inspection_id", rs.getString("inspection_id"));
				rowObject.put("emp_assigned_by", rs.getString("emp_assigned_by"));
				rowObject.put("emp_assigned_to", rs.getString("emp_assigned_to"));
				rowObject.put("office_code_to_inspect", rs.getString("office_code_to_inspect"));
				rowObject.put("inspection_from_date", rs.getDate("inspection_from_date").toString()); // Convert Date to
																										// String
				rowObject.put("inspection_to_date", rs.getDate("inspection_to_date").toString()); // Convert Date to
																									// String
				rowObject.put("status", rs.getString("status"));

				// Add the JSON object to the JSON array
				resultArray.put(rowObject);
			}
			// Add the JSON array to the final JSON object
			jsonObj.put("assignments", resultArray);
			jsonObj.put("msg", "success");

		} catch (Exception e) {
			jsonObj.put("msg", "failure");
			System.err.println("Connection failed.....");
			e.printStackTrace();
		} finally {
			if (rs != null) {
				rs.close();
			}
			if (ps != null) {
				ps.close();
			}
			if (con != null) {
				con.close();
			}
		}
		return jsonObj;
	}

	//get list of problems from problem+asset_type table ( code 401 )
	public JSONObject getProblems(JSONObject jsonObj) throws SQLException {
		PreparedStatement ps = null;
		Connection con = null;
		ResultSet rs = null;
		JSONArray resultArray = new JSONArray();
		envVar envar = new envVar();
		try {
			System.out.println("jsonObj at first: " + jsonObj);
			con = dbCon();
			String sql = envar.getSql(401); // fetch the select * query string
			ps = con.prepareStatement(sql);
			System.out.println("ps before: "+ ps);
			ps.setString(1, jsonObj.getString("network_type"));
			ps.setString(2, jsonObj.getString("asset_name"));
			System.out.println("ps after: "+ ps);
			rs = ps.executeQuery(); // this will create multiple rows of results from query
			System.out.println(rs);
			
			while (rs.next()) {
				JSONObject rowObject = new JSONObject();
				//rowObject.put("problem_id", rs.getString("problem_id"));
				rowObject.put("description", rs.getString("description"));
				System.out.println("rowObject: " + rowObject);
				resultArray.put(rowObject);
			}
			jsonObj.put("problems", resultArray);
			jsonObj.put("msg", "problems data fetched");
			System.out.println("jsonObj at last: " + jsonObj);

		} catch (Exception e) {
			jsonObj.put("msg", "problems data fetch failure");
			System.err.println("Error fetching problems data.");
			e.printStackTrace();
		} finally {
			if (rs != null)
				rs.close();
			if (ps != null)
				ps.close();
			if (con != null)
				con.close();
		}
		return jsonObj;
	}

	//get list of offices from office table ( code *** ) 
	public JSONObject getOffices(JSONObject jsonObj) throws SQLException {
		PreparedStatement ps = null;
		Connection con = null;
		ResultSet rs = null;
		JSONArray resultArray = new JSONArray();
		
		try {
			con = dbCon();
			String sql = envar.getSql(701);
			ps = con.prepareStatement(sql);
			rs = ps.executeQuery();

			while (rs.next()) {
				JSONObject rowObject = new JSONObject();
				rowObject.put("office_code", rs.getString("office_code"));
				rowObject.put("office_name", rs.getString("office_name"));
				rowObject.put("office_type", rs.getString("office_type"));
				resultArray.put(rowObject);
			}
			jsonObj.put("offices", resultArray);
			jsonObj.put("msg", "offices data fetched");

		} catch (Exception e) {
			jsonObj.put("msg", "offices data fetch failure");
			System.err.println("Error fetching offices data.");
			e.printStackTrace();
		} finally {
			if (rs != null)
				rs.close();
			if (ps != null)
				ps.close();
			if (con != null)
				con.close();
		}
		return jsonObj;
	}

	//insert new inspection data into vulnerabilities table ( code 601)
	public JSONObject updateVulnerabilities(JSONObject jsonObj) throws SQLException {
		System.out.println("Inside updateVuln method");
		PreparedStatement ps = null;
		int index = 0;
		Connection con = null;
		envVar envar = new envVar();
		try {
			con = dbCon();
			System.out.println("Inside updateVuln try section");
			ps = con.prepareStatement(envar.getSql(601));
			System.out.println("ps: "+ ps);
			System.out.println("data to be shown: "+ jsonObj.getString("assigned_office_code"));
			ps.setString(1, jsonObj.getString("assigned_office_code"));
			System.out.println("1");
			ps.setString(2, jsonObj.getString("inspection_id"));
			ps.setString(3, jsonObj.getString("problem_"));
			ps.setString(4, jsonObj.getString("location_remarks"));
			ps.setString(5, jsonObj.getString("problem_remarks"));
			ps.setString(6, jsonObj.getString("assigned_office_code"));
			System.out.println("data to be shown: "+ jsonObj.getString("inspection_date"));
			java.sql.Date insp_date= java.sql.Date.valueOf(jsonObj.getString("inspection_date"));
			ps.setDate(7, insp_date);
			ps.setString(8, jsonObj.getString("image1"));
			System.out.println("Inside updateVuln : setstring successfull");
			System.out.println("ps: "+ ps);
			index = ps.executeUpdate();
			System.out.println("index: "+ index);
			if (index > 0) {
				jsonObj.put("msg", "vulnerabilities updated");
			}

		} catch (Exception e) {
			System.err.println("Connection failed.");
			e.printStackTrace();
		} finally {
			if (con != null) {
				con.close();
			}
		}

		return jsonObj;
	}

	//get pending inspection from team_assignment table ( code 501 )
	public JSONObject getInspectionProc(JSONObject jsonObj) throws SQLException {
		PreparedStatement ps = null;
		Connection con = null;
		envVar envar = new envVar();
		ResultSet rs = null;
		JSONArray resultArray = new JSONArray();
		JSONArray inspectionIdList= new JSONArray();
		try {
			
			
			
			con = dbCon();
			String sqlStatement = envar.getSql(501);
			System.out.println(sqlStatement);
			System.out.println( jsonObj.getString("user"));
			ps = con.prepareStatement(sqlStatement);
			
			/*
			 * java.sql.Date from_date=
			 * java.sql.Date.valueOf(jsonObj.getString("from_date")); ps.setDate(1,
			 * from_date);
			 * 
			 * java.sql.Date to_date= java.sql.Date.valueOf(jsonObj.getString("to_date"));
			 * ps.setDate(2, to_date);
			 */

			
			ps.setString(1, jsonObj.getString("user") );
			rs = ps.executeQuery();

			while (rs.next()) {
				// Create a JSON object for each row
				JSONObject rowObject = new JSONObject();
				rowObject.put("inspection_id", rs.getString("inspection_id"));
				rowObject.put("emp_assigned_by", rs.getString("emp_assigned_by"));
				rowObject.put("emp_assigned_to", rs.getString("emp_assigned_to"));
				rowObject.put("office_code_to_inspect", rs.getString("office_code_to_inspect"));
				rowObject.put("inspection_from_date", rs.getDate("inspection_from_date").toString()); // Convert Date to
																										// String
				rowObject.put("inspection_to_date", rs.getDate("inspection_to_date").toString()); // Convert Date to
																									// String
				rowObject.put("status", rs.getString("status"));

				// Add the JSON object to the JSON array
				resultArray.put(rowObject);
				
				inspectionIdList.put(rs.getString("inspection_id"));
				
			}
			// Add the JSON array to the final JSON object
			jsonObj.put("assignments", resultArray);
			jsonObj.put("msg", "success");
			jsonObj.put("inspectionIdList", inspectionIdList);

		} catch (Exception e) {
			jsonObj.put("msg", "failure");
			System.err.println("Connection failed.....");
			e.printStackTrace();
		} finally {
			if (rs != null) {
				rs.close();
			}
			if (ps != null) {
				ps.close();
			}
			if (con != null) {
				con.close();
			}
		}
		System.out.println("dbupdate: " + jsonObj);
		return jsonObj;
	}
}
