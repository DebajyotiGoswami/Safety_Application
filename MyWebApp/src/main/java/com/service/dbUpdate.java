package com.service;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
/*import java.sql.Date;*/

import org.json.JSONArray;
import org.json.JSONObject;

import com.envProp.envVar;

public class dbUpdate {

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
			rs = ps.executeQuery(); // this will create multiple rows of results from query

			while (rs.next()) {
				JSONObject rowObject = new JSONObject();
				rowObject.put("problem_id", rs.getString("problem_id"));
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

	public JSONObject getOffices(JSONObject jsonObj) throws SQLException {
		PreparedStatement ps = null;
		Connection con = null;
		ResultSet rs = null;
		JSONArray resultArray = new JSONArray();
		try {
			con = dbCon();
			String sql = "SELECT office_code AS code, office_name AS name FROM safety_schema.office";
			ps = con.prepareStatement(sql);
			rs = ps.executeQuery();

			while (rs.next()) {
				JSONObject rowObject = new JSONObject();
				rowObject.put("code", rs.getString("code"));
				rowObject.put("name", rs.getString("name"));
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

	public JSONObject updateVulnerabilities(JSONObject jsonObj) throws SQLException {
		PreparedStatement ps = null;
		Connection con = null;
		try {
			con = dbCon();
			String sql = "INSERT INTO safety_schema.vulnerabilities (inspection_id, inspection_date, problem_code, location, problem_details, office_name) VALUES (?, ?, ?, ?, ?, ?)";
			ps = con.prepareStatement(sql);
			ps.setString(1, jsonObj.getString("inspection_id"));
			ps.setDate(2, java.sql.Date.valueOf(jsonObj.getString("inspection_date")));
			ps.setString(3, jsonObj.getString("problem_code"));
			ps.setString(4, jsonObj.getString("location"));
			ps.setString(5, jsonObj.getString("problem_details"));
			ps.setString(6, jsonObj.getString("office_name"));

			int index = ps.executeUpdate();
			if (index > 0) {
				jsonObj.put("msg", "vulnerabilities updated");
			} else {
				jsonObj.put("msg", "update failed");
			}

		} catch (Exception e) {
			jsonObj.put("msg", "update failure");
			System.err.println("Error updating vulnerabilities.");
			e.printStackTrace();
		} finally {
			if (ps != null)
				ps.close();
			if (con != null)
				con.close();
		}
		return jsonObj;
	}

	public JSONObject getInspectionProc(JSONObject jsonObj) throws SQLException {
		PreparedStatement ps = null;
		Connection con = null;
		envVar envar = new envVar();
		ResultSet rs = null;
		JSONArray resultArray = new JSONArray();
		try {
			con = dbCon();
			String sqlStatement = envar.getSql(501);
			ps = con.prepareStatement(sqlStatement);
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
		System.out.println("dbupdate: " + jsonObj);
		return jsonObj;
	}
}
