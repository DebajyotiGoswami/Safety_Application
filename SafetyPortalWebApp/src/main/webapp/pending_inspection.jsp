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
	
	<nav>
			<%@ include file="navbar.jsp"%>
	</nav>

	<!-- Main Content -->
	<div class="container">
		
		<div class="form-container">
			<h2 class="text-center mb-4">Search Assigned Inspection</h2>
			<form id="searchForm" action="searchInspectionServletNew" method="post">
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
						<button type="button" class="btn btn-primary" id="searchBtn" name="searchBtn"
						>Search</button>
					</div>
				</div>
				<table id="inspectionListTable" name="inspectionListTable" class="display table table-responsive" style="width:100%">
        <thead>
						<tr>
							<th>site_id</th>
							<th>inspection_id</th>
							<th>inspection_by</th>
							<th>problem_id</th>
							<th>location_remarks</th>
							<th>problem_remarks</th>
							<th>latitude</th>
							<th>longitude</th>
							<th>gis_id</th>
							<th>assigned_office_code</th>
							<th>present_status</th>
							<th>solution_id</th>
							<th>rectification_date</th>
							<th>rectified_by</th>
							<th>rectification_remarks</th>
							<th>inspection_date</th>
							<th>pre_image</th>
							<th>post_image</th>
							<th>site_id_serial</th>
						</tr>
					</thead>
    </table>
			</form>
		</div>
		</div>

	<!-- Footer -->
	<footer class="text-center mt-auto">
		<div class="text-center p-3">© 2024 IT&C Cell, WBSEDCL</div>
	</footer>

	<!-- JavaScript to handle the form submission and display results -->
	<script src="assets/js/search_inspection.js"></script>
</body>
</html>

