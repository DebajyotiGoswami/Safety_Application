package com.service;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import org.json.JSONObject;

import com.envProp.envVar;

public class dbUpdate {
	
	public Connection dbCon() {
		Connection con= null;
		envVar envvar= new envVar();

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
		
		PreparedStatement ps= null;
		int index= 0;
		Connection con= null;
		envVar envar= new envVar();
		try {
			con= dbCon();
			ps= con.prepareStatement(envar.getSql(201));
			ps.setString(1, jsonObj.getString("user"));
			ps.setString(2, jsonObj.getString("ipAddr"));
			ps.setString(3, jsonObj.getString("userAgent"));
			index= ps.executeUpdate();
			if(index> 0) {
				jsonObj.put("msg", "otpSent");
			}
		}catch (Exception e){
			System.err.println("Connection failed.");
            e.printStackTrace();
		}finally {
			if(con!= null) {
				con.close();
			}
		}
		
		
		return jsonObj;
	}
	
}
