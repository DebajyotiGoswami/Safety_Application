<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<title>Safety Dashboard</title>

<!-- <link rel="icon" href="assets/images/favicon.ico" type="image/x-icon"> -->

<!-- Link to Bootstrap CSS -->
<link rel="stylesheet" href="assets/css/bootstrap.min.css">
<link rel="stylesheet" href="assets/css/dashboard_navigation.css">
<link rel="stylesheet" href="assets/fontAwesome/css/all.min.css">
<script src="assets/js/jquery.min.js"></script>
<!-- <script src="assets/js/login.js"></script> -->
<script src="assets/js/dashboard.js"></script>
<script src="assets/js/config.js"></script>

<%@page import="org.json.*"%>
</head>

<body>
	<!-- Navigation Bar -->
	<%-- 	<%@ include file="navbar.jsp" % --%>
	<%-- <nav>
			<%@ include file="navbar.jsp"%>
	</nav> --%>
	<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
		<div class="container-fluid">
			<!-- Left side: Welcome message -->
			<div id="cookieDisplay"></div>
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
					<li class="nav-item"><a class="nav-link" href="contacts.jsp">Contact</a>
					</li>
					<li class="nav-item">
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

	<!-- Dashboard Content -->
	<div class="container mt-5">
		<h2 class="text-center mb-4">Safety Inspection and Rectification
			Dashboard</h2>
		<div class="row">
			<!-- Inspection Assignment section -->
			<div class="col-md-6 mb-4">
				<div class="card">
					<div class="card-body">
						<h5 class="card-title">Inspection Assignment</h5>
						<p class="card-text">Manage inspection tasks by assigning
							responsibilities to your team and track assignment progress.</p>
						<div class="btn-container">
							<a href="new_assignment.jsp" class="btn btn-primary btn-equal">Create
								New Assignment</a> <a href="assignment_status.jsp"
								class="btn btn-primary btn-equal">Inspection Assigned By You</a>
						</div>
					</div>
				</div>
			</div>

			<!-- Inspection Entry section -->

			<div class="col-md-6 mb-4">
				<div class="card">
					<div class="card-body">
						<h5 class="card-title">Inspection Entry</h5>
						<p class="card-text">Enter the data collected during
							inspections and view history</p>
						<div class="btn-container">
							<a href="new_inspection_test.jsp"
								class="btn btn-primary btn-equal">Pending Works</a> <a
								href="inspection_status.jsp" class="btn btn-primary btn-equal">
								All Inspections</a>
						</div>

						<!-- <a href="new_inspection_test.jsp?type=suo_moto" class="btn btn-primary btn-block-wide mt-3">Inspection without Assignment</a> -->
						<a href="new_inspection_own.jsp"
							class="btn btn-primary btn-block-wide mt-3">Inspection
							without Assignment</a>
					</div>
				</div>
			</div>


			<!-- Enter Rectification Data section -->
			<div class="col-md-6 mb-4">
				<div class="card">
					<div class="card-body">
						<h5 class="card-title">Rectification Entry</h5>
						<p class="card-text">Enter the detailed information of
							corrective actions which was taken after inspections.</p>
						<div class="btn-container">
							<a href="new_rectification_test.jsp"
								class="btn btn-primary btn-equal">Your Pending Rectification</a>
							<a href="rectification_status.jsp"
								class="btn btn-primary btn-equal">View All Rectifications</a>
						</div>
					</div>
				</div>
			</div>

			<!-- Reports section -->
			<div class="col-md-6 mb-4">
				<div class="card">
					<div class="card-body">
						<h5 class="card-title">Reports</h5>
						<p class="card-text">Generate detailed reports based on
							inspection and rectification data. Analyze trends, identify
							recurring issues.</p>
						<div class="btn-container">
							<a class="btn btn-primary btn-equal" onclick="portalAllView()">Generate
								Reports</a>
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

</body>
</html>