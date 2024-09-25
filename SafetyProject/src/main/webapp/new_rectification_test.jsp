<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Entry New Inspection</title>
<!-- Link to Bootstrap CSS -->
<link rel="stylesheet" href="assets/css/bootstrap.min.css">
<link rel="stylesheet" href="assets/css/inspection_entry.css">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
<!-- jQuery -->
<script src="assets/js/jquery.min.js"></script>
<script src="assets/js/bootstrap.min.js"></script>
<script src="assets/js/BigInteger.js"></script>
<!-- Custom JavaScript -->
<!-- <script src="assets/js/new_inspection.js"></script> -->
<style>
.additional-section1 {
	display: none;
}

.additional-section2 {
	display: none;
}

#inspSubmitBtn {
	display: none;
}

#dateDropdown {
	width: 100%; /* Ensures the dropdown takes the full width */
}
</style>
<%@page import="org.json.*"%>
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


	<div class="card" id="resultsContainer" style="display: none;">
		<div class="card-header text-center custom-header">Rectification
			Pending At You</div>
		<div class="card-body">
			<div class="table-responsive" style="overflow-y: auto;">
				<table class="table table-striped table-hover">
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
	</div>

	<div class="container mt-5" id="formContainer" style="display: none;">
		<div class="row justify-content-center">
			<div class="col-md-8">
				<div class="row">
					<!-- Left Section (Form Fields) -->
					<div class="col-md-6 form-container">
						<form id="rectificationForm">
							<div class="initial_section" id="initial_section"
								name="initial_section">
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

								<!-- Inspection Date -->
								<div class="form-row">
									<label for="inspection_date" class="form-label">Inspection
										Date</label> <input type="text" class="form-control"
										id="inspection_date" name="inspection_date" readonly>
								</div>

								<!-- Problem Name -->
								<div class="form-row">
									<label for="problem_name" class="form-label">Problem
										Name</label> <input type="text" class="form-control" id="problem_name"
										name="problem_name" readonly>
								</div>

								<!-- Problem Details -->
								<div class="form-row">
									<label for="problem_details" class="form-label">Problem
										Details</label>
									<textarea class="form-control" id="problem_details"
										name="problem_details" rows="2" readonly></textarea>
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
							</div>
						</form>
					</div>

					<!-- Right Section (Image) -->
					<div class="col-md-6">
						<div class="image-container">
							<img id="imagePreview" alt="Image_Before_Rectification"
								style="width: 100%; height: auto;">
						</div>
					</div>
				</div>

				<!-- WIP Checkbox and Rectification Date -->
				<div class="row form-row">
					<!-- Checkbox for WIP -->
					<div class="col-md-6 form-group">
						<input type="checkbox" id="wipCheckbox" name="wipStatus"
							class="form-check-input" value="WIP"> <label
							for="wipCheckbox" class="form-label">Click to make this
							problem WIP</label>
					</div>

					<!-- Rectification Date -->
					<div class="col-md-6 form-group">
						<label for="rectification_date" class="form-label">Rectification
							Date</label> <input type="date" class="form-control"
							id="rectification_date" name="rectification_date" required>
					</div>
				</div>

				<!-- Rectification Remarks and Image Upload -->
				<div class="row form-row">
					<!-- Rectification Remarks -->
					<div class="col-md-6 form-group">
						<label for="rectification_remarks" class="form-label">Rectification
							Remarks</label>
						<textarea class="form-control" id="rectification_remarks"
							name="rectification_remarks" rows="2" required></textarea>
					</div>

					<!-- Upload Rectified Image -->
					<div class="col-md-6 form-group image-upload-section">
						<label for="rectificationImage" class="form-label">Upload
							Rectification Image</label> <input type="file" class="form-control"
							id="rectificationImage" name="rectificationImage"
							accept=".jpg, .jpeg, .png" onchange="uploadImage()" /> <input
							type="text" id="base64Output" name="base64Output"
							style="display: none" readonly />
					</div>
				</div>

				<!-- Submit Button -->
				<div class="form-row text-center">
					<div class="col-sm-12">
						<button type="submit" class="btn btn-primary"
							id="rectifySubmitBtn">Submit Rectification</button>
					</div>
				</div>
			</div>
		</div>
	</div>

	<!-- <div class="container mt-5" id="formContainer" style="display: none;">
		<div class="row">
			Left Section (Form Fields)
			<div class="col-md-6 form-container">
				<form id="rectificationForm">
					<div class="initial_section" id="initial_section"
						name="initial_section">
						Inspection ID Text Field
						<div class="form-row">
							<label for="inspection_id" class="form-label">Inspection
								ID</label> <input type="text" class="form-control" id="inspection_id"
								name="inspection_id" placeholder="Enter Inspection ID">
						</div>

						Site ID Text Field
						<div class="form-row">
							<label for="site_id" class="form-label">Site ID</label> <input
								type="text" class="form-control" id="site_id" name="site_id"
								placeholder="Enter Site ID">
						</div>

						</div>
						<div class="additional_section">
						Inspection Date
						<div class="form-row">
							<label for="inspection_date" class="form-label">Inspection
								Date</label> <input type="text" class="form-control"
								id="inspection_date" name="inspection_date" readonly>
						</div>

						Problem Name
						<div class="form-row">
							<label for="problem_name" class="form-label">Problem Name</label>
							<input type="text" class="form-control" id="problem_name"
								name="problem_name" readonly>
						</div>

						Problem Details
						<div class="form-row">
							<label for="problem_details" class="form-label">Problem
								Details</label>
							<textarea class="form-control" id="problem_details"
								name="problem_details" rows="2" readonly></textarea>
						</div>

						Location
						<div class="form-row">
							<label for="location" class="form-label">Location</label> <input
								type="text" class="form-control" id="location" name="location"
								readonly>
						</div>

						Inspection By
						<div class="form-row">
							<label for="inspection_by" class="form-label">Inspection
								By</label> <input type="text" class="form-control" id="inspection_by"
								name="inspection_by" readonly>
						</div>
					</div>
				</form>
			</div>

			Right Section (Image)
			<div class="col-md-6">
				<div class="image-container">
					<img id="imagePreview" alt="Image_Before_Rectification"
						style="width: 100%; height: auto;">
				</div>
			</div>
		</div>
		
		Checkbox to identify this as WORK IN PROGRESS
		<div class="form-group">
			<input type="checkbox" id="wipCheckbox" name="wipStatus"
				class="form-check-input" value="WIP"> <label
				for="wipCheckbox" class="form-label">Click to make this
				problem WIP</label>
		</div>

		Rectification Date
		<div class="form-row">
			<label for="rectification_date" class="form-label">Rectification
				Date</label> <input type="date" class="form-control" id="rectification_date"
				name="rectification_date" required>
		</div>

		Rectification Remarks
		<div class="form-row">
			<label for="rectification_remarks" class="form-label">Rectification
				Remarks</label>
			<textarea class="form-control" id="rectification_remarks"
				name="rectification_remarks" rows="2" required></textarea>
		</div>

		Upload Rectified Image
		<div class="form-row mt-3">
			<div class="col-sm-12 form-group image-upload-section">
				<label for="rectificationImage" class="form-label">Upload
					Rectification Image</label> <input type="file" class="form-control"
					id="rectificationImage" name="rectificationImage"
					accept=".jpg, .jpeg, .png" onchange="uploadImage()" /><input
					type="text" id="base64Output" name="base64Output"
					style="display: none" readonly />
			</div>
		</div>


		<div class="form-row">
			Checkbox for WIP
			<div class="col-md-6 form-group">
				<input type="checkbox" id="wipCheckbox" name="wipStatus"
					class="form-check-input" value="WIP"> <label
					for="wipCheckbox" class="form-label">Click to make this
					problem WIP</label>
			</div>

			Rectification Date
			<div class="col-md-6 form-group">
				<label for="rectification_date" class="form-label">Rectification
					Date</label> <input type="date" class="form-control"
					id="rectification_date" name="rectification_date" required>
			</div>
		</div>

		<div class="form-row">
			Rectification Remarks
			<div class="col-md-6 form-group">
				<label for="rectification_remarks" class="form-label">Rectification
					Remarks</label>
				<textarea class="form-control" id="rectification_remarks"
					name="rectification_remarks" rows="2" required></textarea>
			</div>

			Upload Rectified Image
			<div class="col-md-6 form-group image-upload-section">
				<label for="rectificationImage" class="form-label">Upload
					Rectification Image</label> <input type="file" class="form-control"
					id="rectificationImage" name="rectificationImage"
					accept=".jpg, .jpeg, .png" onchange="uploadImage()" /> <input
					type="text" id="base64Output" name="base64Output"
					style="display: none" readonly />
			</div>
		</div>


		<div class="form-row text-center">
			<div class="col-sm-12">
				<button type="submit" class="btn btn-primary" id="rectifySubmitBtn">Submit
					Rectification</button>
			</div>
		</div>
	</div> -->

	<!-- Footer -->
	<footer class="text-center mt-5 bg-dark text-light p-3"> ©
		2024 IT&C Cell, WBSEDCL </footer>

	<!-- JavaScript to handle LDAP authentication and OTP submission -->
	<script src="assets/js/entry_rectification_test.js"></script>
	<!-- <script src="assets/js/login.js"></script> -->
</body>