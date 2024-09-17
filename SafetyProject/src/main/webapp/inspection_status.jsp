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
<script src="assets/js/jquery.min.js"></script>
<script src="assets/js/bootstrap.min.js"></script>
<script src="assets/js/BigInteger.js"></script>

<!-- jQuery -->
<script src="assets/js/jquery.min.js"></script>
</head>
<body>
	<!-- Navigation Bar -->
	<nav>
		<%@ include file="navbar.jsp"%>
	</nav>

	<!-- Main Content -->
	<div class="container">
		<div class="form-container">
			<h2 class="text-center mb-4">Search All Your Inspection</h2>
			<form id="searchForm">
				<!-- Search and All Assigned By Me Buttons -->
				<div class="mb-3 row">
					<div class="col-sm-12 text-center">
						<button type="button" class="btn btn-primary" id="searchBtn">Fetch
							All Inspection</button>
					</div>
					<!-- <div class="col-sm-12 text-center">
						<button type="button" class="btn btn-primary ml-2"
							id="allAssignedByMeBtn">Search All Assignment</button>
					</div> -->
				</div>
				<!-- From Date, To Date, Assigned To Fields Side by Side -->
				<div class="mb-4 row">
					<!-- From Date -->
					<div class="col-sm-3 form-group">
						<label for="fromDate" class="form-label">Inspection From</label> <input
							type="date" class="form-control" id="fromDate" name="fromDate"
							required>
					</div>
					<!-- To Date -->
					<div class="col-sm-3 form-group">
						<label for="toDate" class="form-label">Inspection To</label> <input
							type="date" class="form-control" id="toDate" name="toDate"
							required>
					</div>
					<!-- Assigned To -->
					<div class="col-sm-3 form-group">
						<label for="assignedTo" class="form-label">Problem Name</label> <input
							type="text" class="form-control" id="probName"
							name="probName" placeholder="Enter Name">
					</div>
					<!-- Assigned Office -->
					<div class="col-sm-3 form-group">
						<label for="officeName" class="form-label">Assigned Office</label>
						<input type="text" class="form-control" id="officeName"
							name="officeName" placeholder="Office Name">
					</div>
				</div>


				<!-- Only Pending Assignments Checkbox -->
				<!-- <div class="mb-3 row">
					<div class="col-sm-9 offset-sm-3">
						<div class="form-check">
							<input class="form-check-input" type="checkbox"
								id="pendingAssignments" name="pendingAssignments"> <label
								class="form-check-label" for="pendingAssignments"> Only
								Pending Assignments </label>
						</div>
					</div>
				</div> -->


			</form>
		</div>

		<div class="card" id="resultsContainer" style="display: none; height:600px">
			<div class="card-header text-center custom-header">Inspection
				Assigned By You</div>
			<div class="card-body">
				<div class="table-responsive"
					style="height: 600px; overflow-y: auto;">
					<!-- <div class="table-responsive" style="max-height: 400px; overflow-y: auto;"> -->
					<table class="table table-striped table-hover table-sm small-font-table">
						<thead>
							<tr>
								<th>Sl No.</th>
								<th>Inspection ID</th>
								<th>Office Name</th>
								<th>Location</th>
								<th>Problem Name</th>
								<th>Problem Details</th>
								<th>Inspected On</th>
								<th>Status</th>
								<th>Action</th>
							</tr>
						</thead>
						<tbody id="resultsTableBody">
							<!-- Rows will be populated via JavaScript -->
						</tbody>
					</table>
				</div>
			</div>
		</div>

	</div>

	<!-- Footer -->
	<footer class="text-center mt-auto">
		<div class="text-center p-3">© 2024 IT&C Cell, WBSEDCL</div>
	</footer>

	<!-- JavaScript to handle the form submission and display results -->
	<script src="assets/js/inspection_status.js"></script>
</body>
</html>
