<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Entry New Rectification</title>
<!-- Link to Bootstrap CSS -->
<link rel="stylesheet" href="assets/css/bootstrap.min.css">
<link rel="stylesheet" href="assets/css/inspection_navigation.css">
<!-- jQuery -->
<script src="assets/js/jquery.min.js"></script>
<script src="assets/js/bootstrap.bundle.min.js"></script>
<!-- Custom JavaScript -->
<style>
.form-container {
	margin-top: 30px;
}

.form-row {
	margin-bottom: 15px;
	display: flex;
	align-items: center;
}

.form-label {
	font-weight: bold;
	width: 25%; /* Adjust label width */
	margin-right: 15px;
}

.form-control {
	flex: 1; /* Make the input field take up the remaining space */
}
</style>
</head>
<body>
	<!-- Navigation Bar -->
	<nav>
		<jsp:include page="navbar.jsp" />
	</nav>
	<!-- Main Content -->
	<div class="container">
		<div class="form-container">
			<h2 class="text-center mb-4">Entry New Rectification</h2>
			<form id="rectificationForm">
				<div class="initial_section">
					<!-- Inspection ID Dropdown -->
					<div class="form-row">
						<label for="inspection_id" class="form-label">Inspection
							ID</label> <select class="form-control" id="inspection_id"
							name="inspection_id">
							<option value="">Select Inspection ID</option>
							<!-- Add options dynamically -->
						</select>
					</div>

					<!-- Site ID Dropdown -->
					<div class="form-row">
						<label for="site_id" class="form-label">Site ID</label> <select
							class="form-control" id="site_id" name="site_id">
							<option value="">Select Site ID</option>
							<!-- Add options dynamically -->
						</select>
					</div>
				</div>
				<div class="additional_section">
					<!-- Inspection Date -->
					<div class="form-row">
						<label for="inspection_date" class="form-label">Inspection
							Date</label> <input type="text" class="form-control" id="inspection_date"
							name="inspection_date" readonly>
					</div>

					<!-- Problem Name -->
					<div class="form-row">
						<label for="problem_name" class="form-label">Problem Name</label>
						<input type="text" class="form-control" id="problem_name"
							name="problem_name" readonly>
					</div>

					<!-- Problem Details -->
					<div class="form-row">
						<label for="problem_details" class="form-label">Problem
							Details</label>
						<textarea class="form-control" id="problem_details"
							name="problem_details" rows="3" readonly></textarea>
					</div>

					<!-- Location -->
					<div class="form-row">
						<label for="location" class="form-label">Location</label> <input
							type="text" class="form-control" id="location" name="location"
							readonly>
					</div>

					<!-- Inspection By -->
					<div class="form-row">
						<label for="inspection_by" class="form-label">Inspection
							By</label> <input type="text" class="form-control" id="inspection_by"
							name="inspection_by" readonly>
					</div>

					<!-- Rectification Date -->
					<div class="form-row">
						<label for="rectification_date" class="form-label">Rectification
							Date</label> <input type="date" class="form-control"
							id="rectification_date" name="rectification_date" required>
					</div>

					<!-- Rectification Remarks -->
					<div class="form-row">
						<label for="rectification_remarks" class="form-label">Rectification
							Remarks</label>
						<textarea class="form-control" id="rectification_remarks"
							name="rectification_remarks" rows="3" required></textarea>
					</div>

					<!-- Submit Button -->
					<div class="form-row text-center">
						<div class="col-sm-12">
							<button type="submit" class="btn btn-primary">Submit
								Rectification</button>
						</div>
					</div>
				</div>
			</form>
		</div>
	</div>
</body>
</html>
