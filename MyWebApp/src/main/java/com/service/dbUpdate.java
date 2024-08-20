package com.service;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

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
		//int index = 0;
		Connection con = null;
		envVar envar = new envVar();
		ResultSet rs = null;
		JSONArray resultArray = new JSONArray();
		try {
			con = dbCon();
			String sqlStatement = envar.getSql(301);
			ps = con.prepareStatement(sqlStatement);
			rs = ps.executeQuery(); // error started from this line
			/*
			 * if (index > 0) { jsonObj.put("msg", "assignment data fetched");
			 * System.out.println("inside if: index is "+ Integer.toString(index)); }
			 */
			//System.out.println("just before while loop");
			while (rs.next()) {
                // Create a JSON object for each row
                JSONObject rowObject = new JSONObject();
                //System.out.println("after rowObject intialization");
                rowObject.put("inspection_id", rs.getString("inspection_id"));
                //System.out.println("may be error in here");
                rowObject.put("assigned_by", rs.getString("emp_assigned_by"));
                rowObject.put("assigned_to", rs.getString("emp_assigned_to"));
                rowObject.put("office_name", rs.getString("office_code_to_inspect"));
                rowObject.put("from_date", rs.getDate("inspection_from_date").toString()); // Convert Date to String
                rowObject.put("to_date", rs.getDate("inspection_to_date").toString()); // Convert Date to String
                rowObject.put("status", rs.getString("status"));
                //System.out.println("end of while loop");

                // Add the JSON object to the JSON array
                resultArray.put(rowObject);
            }
			// Add the JSON array to the final JSON object
            jsonObj.put("assignments", resultArray);
            jsonObj.put("msg", "assignment data fetched");
			/*
			 * if (rs.next()) { // Check if there's at least one result jsonObj.put("msg",
			 * "assignment data fetched"); System.out.println("check line"); // working ok
			 * // You can process the result set here and populate jsonObj with the data }
			 * else { jsonObj.put("msg", "no assignment data found"); }
			 */
		} catch (Exception e) {
			jsonObj.put("msg", "assignment data fetch failure");
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
		System.out.println("dbupdate: "+ jsonObj);
		return jsonObj;
	}

}
