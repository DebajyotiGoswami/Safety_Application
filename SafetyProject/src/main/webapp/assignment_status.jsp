<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Search Assigned Inspection</title>

<script src="assets/js/jquery.min.js"></script>
<script src="assets/js/bootstrap.min.js"></script>
<script src="assets/js/BigInteger.js"></script>

<!-- Link to Bootstrap CSS -->
<link rel="stylesheet" href="assets/css/bootstrap.min.css">
<link rel="stylesheet" href="assets/css/inspection_navigation.css">

<link rel="stylesheet" href="assets/fontAwesome/css/all.min.css">

<!-- jQuery -->
<script src="assets/js/jquery.min.js"></script>
</head>
<body>
	<!-- Navigation Bar -->
	<%-- <nav>
		<%@ include file="navbar.jsp"%>
	</nav> --%>
	<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
		<div class="container-fluid">
			<!-- Left side: Welcome message -->
			<div id="cookieDisplay"></div>
			<%-- <span class="navbar-text"><%= username %> (ERP ID: <%= erpId %>, <%= designation %>)
			</span> --%>
			<span class="navbar-text"><div id="cookieDisplay"></div> </span>
			<!-- Right side: Navigation links -->
			<button class="navbar-toggler" type="button" data-toggle="collapse"
				data-target="#navbarNav" aria-controls="navbarNav"
				aria-expanded="false" aria-label="Toggle navigation">
				<span class="navbar-toggler-icon"></span>
			</button>
			<div class="collapse navbar-collapse justify-content-end"
				id="navbarNav">
				<ul class="navbar-nav">
					<li class="nav-item"><a class="nav-link" href="dashboard.jsp">Home</a>
					</li>
					<li class="nav-item"><a class="nav-link" href="contacts.html">Contact</a>
					</li>
					<li class="nav-item">
						<!-- Logout form -->
						<form action="LogoutServlet" method="POST"
							onsubmit="clearLocalStorage()" style="display: inline;">
							<button type="submit" id="logOutSubmit" name="logOutSubmit"
								class="btn btn-outline-light ml-2">Logout</button>
						</form>
					</li>
				</ul>
			</div>
		</div>
		<script src="assets/js/navbar.js"></script>
	</nav>

	<!-- Main Content -->
	<div class="container">
		<div class="card" id="resultsContainer" style="display: block;">
			<div class="card-header text-center custom-header">Inspection
				Assigned By You</div>
			<div class="card-body">

				<div id="noDataAlert" class="alert alert-info text-center"
					role="alert" style="display: none;">No assignment data
					available to show.</div>

				<div id="tableContainer" class="table-responsive"
					style="overflow-y: auto;">
					<table
						class="table table-striped table-hover table-sm small-font-table">
						<thead>
							<tr>
								<th>Sl No.</th>
								<th>Inspection ID</th>
								<th>Assigned On</th>
								<th>Assigned To</th>
								<th>Office Name</th>
								<th>From Date</th>
								<th>To Date</th>
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
			<div class="mb-4 row filterSection" id="filterSection">
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
					<label for="assignedTo" class="form-label">Assigned To</label> <input
						type="text" class="form-control" id="assignedTo" name="assignedTo"
						placeholder="Enter Name">
				</div>
				<div class="col-sm-3 form-group">
					<label for="assignedOffice" class="form-label">Assigned
						Office</label> <input type="text" class="form-control" id="assignedOffice"
						name="assignedOffice" placeholder="Enter Office Name">
				</div>
			</div>

			<!-- Modal -->
			<div class="modal fade" id="confirmationModal" tabindex="-1"
				aria-labelledby="exampleModalLabel" aria-hidden="true">
				<div class="modal-dialog">
					<div class="modal-content">
						<div class="modal-header">
							<h5 class="modal-title" id="exampleModalLabel">Assignment
								Deletion</h5>
							<button type="button" class="btn-close" aria-label="Close"></button>
						</div>
						<div class="modal-body">
							<p>Provide the reason for assignment deletion</p>
							<textarea id="commentField" placeholder="Within 20 characters"
								class="form-control" maxlength="20"></textarea>
						</div>
						<div class="modal-footer">
							<button type="button" class="btn btn-secondary" id="noBtn">NO</button>
							<button type="button" class="btn btn-primary" id="yesBtn">YES</button>
						</div>
					</div>
				</div>
			</div>


		</div>
	</div>

	<!-- Footer -->
	<footer class="text-center mt-auto">
		<div class="text-center p-3">© 2024 IT&C Cell, WBSEDCL</div>
	</footer>

	<!-- JavaScript to handle the form submission and display results -->
	<script src="assets/js/assignment_status.js"></script>
</body>
</html>
