<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Assign Inspection</title>

<!-- <link rel="icon" href="assets/images/favicon.ico" type="image/x-icon"> -->


<!-- Link to Bootstrap CSS -->
<link rel="stylesheet" href="assets/css/bootstrap.min.css">
<link rel="stylesheet" href="assets/css/inspection_navigation.css">
<script src="assets/js/jquery.min.js"></script>
<script src="assets/js/bootstrap.min.js"></script>
<script src="assets/js/BigInteger.js"></script>
<script src="assets/js/BigInteger.min.js"></script>

<%@page import="org.json.*,java.time.*,java.time.format.*"%>
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
						<!-- Logout form --> <!-- <form action="LogoutServlet" method="POST"
						onsubmit="clearLocalStorage()" style="display: inline;">
						<button type="submit" id="logOutSubmit" name="logOutSubmit"
							class="btn btn-outline-light ml-2">Logout</button>
					</form> -->

						<form style="display: inline;">
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
		<div class="form-container">
			<h2 class="text-center mb-4">Assign Inspection</h2>
			<form>
				<div class="mb-3 row">
					<label for="teamMembers" class="col-sm-3 col-form-label">Number
						of Team Members<span class="text-danger">*</span>
					</label>
					<div class="col-sm-9">
						<select class="form-control team-selection" id="teamMembers"
							onchange="updateERPFields()">
							<option disabled selected hidden=>Select Team Members</option>
							<option value="1">1</option>
							<option value="2">2</option>
							<option value="3">3</option>
						</select>
					</div>
				</div>
				<div id="erpIdContainer"></div>
				<div class="mb-3 row">
					<label class="col-sm-3 col-form-label">Inspection Date<span
						class="text-danger">*</span></label>
					<div class="col-sm-4">
						<input type="date" class="form-control" id="inspectionDateStart"
							required>
					</div>
					<div class="col-sm-1 text-center">to</div>
					<div class="col-sm-4">
						<input type="date" class="form-control" id="inspectionDateEnd"
							required>
					</div>
				</div>
				<!-- <p id="dateError" class="error text-danger" aria-live="assertive"></p> -->
				<div id="dateError" class="error-message"></div>
				<!-- Error message container with red text -->
				<div class="mb-3 row">
					<label for="officeName" class="col-sm-3 col-form-label">Office
						Name<span class="text-danger">*</span>
					</label>
					<div class="col-sm-9">
						<select class="form-control" id="officeName" name="officeName"
							required>
							<option value="">Select Office Name</option>
							<!-- Add options here dynamically or hardcode them -->
						</select>
					</div>
				</div>
				<div class="mb-3 row">
					<label for="remarks" class="col-sm-3 col-form-label">Remarks</label>
					<div class="col-sm-9">
						<textarea class="form-control" id="remarks" rows="3" maxlength="100"
							placeholder="Enter remarks(Max 100 characters)"></textarea>
					</div>
				</div>
				<div class="mb-3 row">
					<div class="col-sm-12 text-center">
						<button type="button" class="btn btn-primary" id="assgnSubmitbtn"
							disabled>Assign Inspection</button>
					</div>
				</div>
			</form>
		</div>
	</div>

	<!-- Footer -->
	<footer class="text-center mt-auto">
		<div class="text-center p-3">© 2024 IT&C Cell, WBSEDCL</div>
	</footer>

	<script src="assets/js/new_assignment.js"></script>
	<!-- <script src="assets/js/login.js"></script> -->
</body>
</html>