package com.envProp;

public class envVar {

	private String connUrl = "jdbc:postgresql://10.251.37.170:5432/mobapp_safety_db";
	  
	  private String dbUser = "dbadmin";
	  
	  private String dbPwd = "dbadmin@06022018";
	  
	  private String insertLoginDtlQry= "insert into safety_schema.login (erp_id, "
			  + "ip_address, user_agent, login_timestamp) values (?,?,?,now())";
	  
	  private String getAssignmentQry= "select inspection_id, emp_assigned_by, emp_assigned_to,"
	  		+ "office_code_to_inspect, inspection_from_date, inspection_to_date, status "
	  		+ "from safety_schema.team_assignment";

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
			 System.out.println("login table updated");
			 query= insertLoginDtlQry;
		 }else if(i== 301) {
			 System.out.println("data fetched from assignment table");
			 query= getAssignmentQry;
		 }else {
			 query="";
		 }
		 return query;
	 }
}
