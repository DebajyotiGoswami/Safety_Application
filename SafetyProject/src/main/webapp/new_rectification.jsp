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
<script src="assets/js/BigInteger.js"></script>
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
		<%@ include file="navbar.jsp"%>
	</nav>
	<!-- Main Content -->

	<div class="card" id="resultsContainer" style="display: none;">
		<div class="card-header text-center custom-header">Rectification
			Pending At Your End</div>
		<div class="card-body">
			<div class="table-responsive"
				style="height: 180px; overflow-y: auto;">
				<!-- <div class="table-responsive" style="max-height: 400px; overflow-y: auto;"> -->
				<table class="table table-striped table-hover">
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
	</div>

	<!-- keep this part hidden at start. It will be populated after clicking button from #resultTableBody -->
	<div class="container mt-5" id="formContainer" style="display: none;">
		<div class="row">
			<!-- Left Section (Form Fields) -->
			<div class="col-md-6 form-container">
				<form id="rectificationForm">
					<div class="initial_section">
						<!-- Inspection ID Text Field -->
						<div class="form-row">
							<label for="inspection_id" class="form-label">Inspection
								ID</label> <input type="text" class="form-control" id="inspection_id"
								name="inspection_id" placeholder="Enter Inspection ID">
						</div>

						<!-- Site ID Text Field -->
						<div class="form-row">
							<label for="site_id" class="form-label">Site ID</label> <input
								type="text" class="form-control" id="site_id" name="site_id"
								placeholder="Enter Site ID">
						</div>

					</div>
					<div class="additional_section">
						<!-- Inspection Date -->
						<div class="form-row">
							<label for="inspection_date" class="form-label">Inspection
								Date</label> <input type="text" class="form-control"
								id="inspection_date" name="inspection_date" readonly>
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
						<!-- <div class="form-row">
							<label for="rectification_date" class="form-label">Rectification
								Date</label> <input type="date" class="form-control"
								id="rectification_date" name="rectification_date" required>
						</div>

						Rectification Remarks
						<div class="form-row">
							<label for="rectification_remarks" class="form-label">Rectification
								Remarks</label>
							<textarea class="form-control" id="rectification_remarks"
								name="rectification_remarks" rows="3" required></textarea>
						</div>

						Upload Rectified Image
						<div class="form-row mt-3">
							<div class="col-sm-12">
								<label for="rectificationImage" class="form-label">Upload
									Rectification Image</label> <input type="file" class="form-control"
									id="rectificationImage" name="rectificationImage"
									accept=".jpg, .jpeg, .png">
							</div>
						</div>

						Submit Button
						<div class="form-row text-center">
							<div class="col-sm-12">
								<button type="submit" class="btn btn-primary">Submit
									Rectification</button>
							</div>
						</div> -->
					</div>
				</form>
			</div>

			<!-- Right Section (Image) -->
			<div class="col-md-6">
				<div class="image-container">
					<img src="assets/images/placeholder.png" alt="Placeholder Image"
						style="width: 100%; height: auto;">
				</div>
			</div>
		</div>
		<!-- Submit Button -->

		<!-- Rectification Date -->
		<div class="form-row">
			<label for="rectification_date" class="form-label">Rectification
				Date</label> <input type="date" class="form-control" id="rectification_date"
				name="rectification_date" required>
		</div>

		<!-- Rectification Remarks -->
		<div class="form-row">
			<label for="rectification_remarks" class="form-label">Rectification
				Remarks</label>
			<textarea class="form-control" id="rectification_remarks"
				name="rectification_remarks" rows="3" required></textarea>
		</div>

		<!-- Upload Rectified Image -->
		<div class="form-row mt-3">
			<div class="col-sm-12">
				<label for="rectificationImage" class="form-label">Upload
					Rectification Image</label> <input type="file" class="form-control"
					id="rectificationImage" name="rectificationImage"
					accept=".jpg, .jpeg, .png">
			</div>
		</div>
		<div class="form-row text-center">
			<div class="col-sm-12">
				<button type="submit" class="btn btn-primary">Submit
					Rectification</button>
			</div>
		</div>
	</div>


	<script src="assets/js/entry_rectification.js"></script>
</body>
</html>
