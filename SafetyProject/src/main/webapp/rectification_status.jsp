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
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">

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
		<div class="card" id="resultsContainer" style="display: block;">
			<div class="card-header text-center custom-header">Rectification
				Entered By You</div>
			<div class="card-body">
				<div class="table-responsive" style="overflow-y: auto;">
					<table
						class="table table-striped table-hover table-sm small-font-table">
						<thead>
							<tr>
								<th>Sl No.</th>
								<th>Inspection ID</th>
								<th>Inspection Date</th>
								<th>Inspected By</th>
								<th>Problem Name</th>
								<th>Problem Details</th>
								<th>Location</th>
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
			<div class="mb-4 row filterSection">
				<!-- From Date -->
				<div class="col-sm-3 form-group">
					<label for="fromDate" class="form-label">Inspection From
						Date</label> <input type="date" class="form-control" id="fromDate"
						name="fromDate" required>
				</div>
				<!-- To Date -->
				<div class="col-sm-3 form-group">
					<label for="toDate" class="form-label">Inspection To Date</label> <input
						type="date" class="form-control" id="toDate" name="toDate"
						required>
				</div>
				<!-- Assigned To -->
				<div class="col-sm-3 form-group">
					<label for="problemName" class="form-label">Problem Name</label> <input
						type="text" class="form-control" id="problemName" name="problemName"
						placeholder="Enter Problem">
				</div>
				<div class="col-sm-3 form-group">
					<label for="locationName" class="form-label">Location
						Name</label> <input type="text" class="form-control" id="locationName"
						name="locationName" placeholder="Enter Location">
				</div>
			</div>
		</div>

	</div>

	<!-- Footer -->
	<footer class="text-center mt-auto">
		<div class="text-center p-3">© 2024 IT&C Cell, WBSEDCL</div>
	</footer>

	<!-- JavaScript to handle the form submission and display results -->
	<script src="assets/js/rectification_status.js"></script>
</body>
</html>