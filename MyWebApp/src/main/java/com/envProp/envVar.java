package com.envProp;

public class envVar {

	private String connUrl = "jdbc:postgresql://10.251.37.170:5432/mobapp_safety_db";
	  
	  private String dbUser = "dbadmin";
	  
	  private String dbPwd = "dbadmin@06022018";
	  
	  private String insertLoginDtlQry= "insert into safety_schema.login (erp_id, "
			  + "ip_address, user_agent, login_timestamp) values (?,?,?,now())";
	  
	  private String getAssignmentQry= "select inspection_id, emp_assigned_by, emp_assigned_to,"
	  		+ "office_code_to_inspect, inspection_from_date, inspection_to_date, status "
	  		+ "from safety_schema.team_assignment where inspection_from_date>= ? and "
	  		+ "inspection_to_date<= ?";
	  
	  private String getProblemQry= "select problem_id, description from safety_schema.problems";
	  
	  private String getInspectionQry= "select inspection_id, emp_assigned_by, emp_assigned_to,"
		  		+ "office_code_to_inspect, inspection_from_date, inspection_to_date, status "
		  		+ "from safety_schema.team_assignment";
	  
	  private String insertInspectionQry= "insert into safety_schema.vulnerabilities "
	  		+ "(site_id, inspection_id, inspection_by, problem_id, location_remarks,"
	  		+ "problem_remarks, assigned_office_code, present_status, inspection_date, "
	  		+ "pre_image, post_image)"
	  		+ "values (5, ?, 90012775, 1, ?, ?, ?, 'INSPECTED', ?,'test.jpg', 'test.jpg')";
	  
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
		 }else if(i== 401){
			 System.out.println("data fetched from problems table");
			 query= getProblemQry;
		 }else if(i== 501){
			 System.out.println("data fetched from inspection table");
			 query= getInspectionQry;
		 }else if(i== 601){
			 System.out.println("data inserted into inspection table");
			 query= insertInspectionQry;
		 }else {
			 query="";
		 }
		 return query;
	 }
}
