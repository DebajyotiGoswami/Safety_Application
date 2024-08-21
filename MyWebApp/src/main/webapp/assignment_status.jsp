<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Search Assigned Inspection</title>

<!-- Link to Bootstrap CSS -->
<link rel="stylesheet" href="assets/css/bootstrap.min.css">
<link rel="stylesheet" href="assets/css/inspection_navigation.css">
<link rel="stylesheet" href="assets/css/assignment_status.css">

<!-- jQuery -->
<script src="assets/js/jquery.min.js"></script>
<%@page import="org.json.*"%>
</head>
<body>
	<!-- Navigation Bar -->
<!-- 	<nav class="navbar navbar-expand-lg navbar-dark">
		<div class="container-fluid">
			<span class="navbar-text">Welcome, <strong>username</strong></span>
			<button class="navbar-toggler" type="button" data-toggle="collapse"
				data-target="#navbarNav" aria-controls="navbarNav"
				aria-expanded="false" aria-label="Toggle navigation">
				<span class="navbar-toggler-icon"></span>
			</button>
			<div class="collapse navbar-collapse justify-content-end"
				id="navbarNav">
				<ul class="navbar-nav">
					<li class="nav-item"><a class="nav-link" href="dashboard.html">Home</a>
					</li>
					<li class="nav-item"><a class="nav-link" href="contacts.html">Contact</a>
					</li>
					<li class="nav-item">
						<form action="LogoutServlet" method="POST"
							style="display: inline;">
							<button type="submit" class="btn btn-outline-light ml-2">Logout</button>
						</form>
					</li>
				</ul>
			</div>
		</div>
	</nav> -->
	<nav>
		<jsp:include page="navbar.jsp" />
	</nav>

	<!-- Main Content -->
	<div class="container">
		<%
		String dataFetchFlag = (String)request.getSession().getAttribute("datafetchflag");
		//String assignmentObjStr = request.getSession().getAttribute("assignmentObject").toString();
		%>
		
	
		<%
		if (dataFetchFlag == null) {
		%>
		<div class="form-container">
			<h2 class="text-center mb-4">Search Assigned Inspection</h2>
			<form id="searchForm" action="searchAssignmentServlet" method="post">
				<div class="mb-3 row">
					<label for="fromDate" class="col-sm-3 col-form-label">From
						Date</label>
					<div class="col-sm-9">
						<input type="date" class="form-control" id="fromDate"
							name="fromDate" required>
					</div>
				</div>
				<div class="mb-3 row">
					<label for="toDate" class="col-sm-3 col-form-label">To Date</label>
					<div class="col-sm-9">
						<input type="date" class="form-control" id="toDate" name="toDate"
							required>
					</div>
				</div>
				<div class="mb-3 row">
					<div class="col-sm-12 text-center">
						<button type="button" class="btn btn-primary" id="searchBtn" 
						onclick="submitThisForm()">Search</button>
					</div>
				</div>
			</form>
		</div>
		<%
		}
		
		else if (dataFetchFlag != null && dataFetchFlag.equals("true")) {
		JSONObject assignmentObj = (JSONObject) request.getSession().getAttribute("assignmentObject");
		
		%>
	
		<div class="results-container" id="resultsContainer">
			<h3 class="text-center mb-4">Inspection Results</h3>
			<table class="table table-striped">
				<thead>
					<tr>
						<th>#</th>
						<th>Inspection ID</th>
						<th>Assigned By</th>
						<th>Assigned To</th>
						<th>Office Name</th>
						<th>From Date</th>
						<th>To Date</th>
						<th>Status</th>
					</tr>
				</thead>
				<tbody id="resultsTableBody">

					<%
					if (assignmentObj.has("msg") && assignmentObj.getString("msg").equals("assignment data fetched")) {
						JSONArray jsonArray = assignmentObj.getJSONArray("assignments");
					for (int i = 0; i < jsonArray.length(); i++) {
						JSONObject buffObj = jsonArray.getJSONObject(i);
					%>
					<tr>
						<td><%=(i + 1)%></td>
						<td><%=buffObj.getString("inspection_id")%></td>
						<td><%=buffObj.getString("emp_assigned_by")%></td>
						<td><%=buffObj.getString("emp_assigned_to")%></td>
						<td><%=buffObj.getString("office_code_to_inspect")%></td>
						<td><%=buffObj.getString("inspection_from_date")%></td>
						<td><%=buffObj.getString("inspection_to_date")%></td>
						<td><%=buffObj.getString("status")%></td>
					</tr>
					<%
					}
					%>
				</tbody>
			</table>
		</div>
		<%
		}
		}
		%> 
	
	</div>

	<!-- Footer -->
	<footer class="text-center mt-auto">
		<div class="text-center p-3">© 2024 IT&C Cell, WBSEDCL</div>
	</footer>

	<!-- JavaScript to handle the form submission and display results -->
	<script src="assets/js/search_inspection.js"></script>
</body>
</html>

