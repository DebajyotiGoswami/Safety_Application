package com.envProp;

public class envVar {

	private String connUrl = "jdbc:postgresql://10.251.37.170:5432/mobapp_safety_db";
	  
	  private String dbUser = "dbadmin";
	  
	  private String dbPwd = "dbadmin@06022018";
	  
	  private String insertLoginDtlQry= "insert into safety_schema.login (erp_id, "
	  		+ "ip_address, user_agent, login_timestamp) values (?,?,?,now())";

	public String getConnUrl() {
		return connUrl;
	}

	public String getDbUser() {
		return dbUser;
	}

	public String getDbPwd() {
		return dbPwd;
	}
	  
	  
	 public String getSql(int i) {
		 String query= "";
		 
		 if(i==201) {
			 query= insertLoginDtlQry;
		 }
		 
		 return query;
	 }
	
	
}
