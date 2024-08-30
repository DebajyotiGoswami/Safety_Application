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
	  		+ "inspection_to_date<= ? and emp_assigned_by=?";
	  
	  private String getProblemQry= "select problem_id, description from safety_schema.problems where asset_type_id in "
	  		+ "(select asset_type_id from safety_schema.asset_type where network_type=?"
	  		+ "and asset_name=?)";
	  
	  private String getInspectionQry= "select * "
	  		+  "from safety_schema.inspectdtls where "
	  		+ "(inspection_date between ? and ?) and inspection_by= ?";
	  
	  private String insertInspectionQry= "insert into safety_schema.vulnerabilities"
		  		+ "(site_id, inspection_id, inspection_by, problem_id, location_remarks,"
		  		+ "problem_remarks, assigned_office_code, present_status, inspection_date,"
		  		+ "pre_image, post_image)values"
		  		+ "((CONCAT(?,'_', nextval('safety_schema.vulnerabilities_site_id_serial_seq'))),"
		  		+ "?, 90012775, (select problem_id from safety_schema.problems"
		  		+ "where description=?), ?, ?, ?, 'INSPECTED', ?,?, 'test.jpg')";
	  
	  
	  private String fetchOfficesQry= "SELECT office_code, office_name, office_type FROM safety_schema.office "
	  		+ "where active='A'";
	  
	  private String fetchInspectionForEntryQuery="select inspection_id, emp_assigned_by, emp_assigned_to,"
		  		+ "office_code_to_inspect, inspection_from_date, inspection_to_date, status "
		  		+ "from safety_schema.team_assignment where inspection_from_date < now()::Date and emp_assigned_to=?";
	  
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
			 System.out.println(query);
		 }else if(i== 401){
			 System.out.println("data fetched from problems table");
			 query= getProblemQry;
		 }else if(i== 501){
			 System.out.println("data fetched from inspection table");
			 query= getInspectionQry;
		 }else if(i== 601){
			 System.out.println("data inserted into inspection table");
			 query= insertInspectionQry;
			 System.out.println("envVar query is: "+ query);
		 }else if(i== 701) {
			 query= fetchOfficesQry;
		 }else if(i== 801){
			 query=  fetchInspectionForEntryQuery;
		 }
		 else {
			 query="";
		 }
		 return query;
	 }
}
