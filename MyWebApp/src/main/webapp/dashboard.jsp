<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<title>Safety Dashboard</title>

<!-- Link to Bootstrap CSS -->
<link rel="stylesheet" href="assets/css/bootstrap.min.css">
<link rel="stylesheet" href="assets/css/dashboard_navigation.css">
</head>

<body>
	<!-- Navigation Bar -->
<%-- 	<%@ include file="navbar.jsp" % --%>
	<nav>
		<jsp:include page="navbar.jsp" />
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
							<a href="assign_inspection.jsp"
								class="btn btn-primary btn-equal">New Assignment</a> 
							<a href="assignment_status.jsp" class="btn btn-primary btn-equal">View 
							All Assignments</a>
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
							inspections. Also find a comprehensive inspection history for
							reference and reporting.</p>
						<div class="btn-container">
							<a href="new_inspection.jsp" class="btn btn-primary btn-equal">Entry New
								Inspection</a> 
						<a href="pending_inspection.jsp" class="btn btn-primary btn-equal">View
								All Inspections</a>
						</div>
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
							<a href="#" class="btn btn-primary btn-equal">Pending
								Rectification</a> <a href="#" class="btn btn-primary btn-equal">View
								All Rectifications</a>
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
							<a href="#" class="btn btn-primary btn-equal">Generate
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

	<!-- Link to Bootstrap JS -->
	<!-- <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script> -->
</body>
</html>