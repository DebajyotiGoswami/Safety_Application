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
<!-- jQuery -->
<script src="assets/js/jquery.min.js"></script>
<script src="assets/js/bootstrap.min.js"></script>
<script src="assets/js/BigInteger.js"></script>
<script src="assets/js/popper.min.js"></script>
<script src="assets/js/config.js"></script>
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

	<!-- <div class="card" id="resultsContainer" style="display: none;">
		<div class="card-header text-center custom-header">Inspection
			Assigned To You</div>
		<div class="card-body">
			Alert message for no data, initially hidden
			<div id="noDataAlert" class="alert alert-info text-center"
				role="alert" style="display: none;">No inspection task pending
				at you to show.</div>

			Table for displaying inspection data
			<div class="table-responsive" id="tableContainer"
				style="overflow-y: auto;">
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
						Rows will be populated via JavaScript
					</tbody>
				</table>
			</div>
		</div>
	</div> -->




	<div class="container mt-5">
		<!-- Heading for the form -->
		<h2 class="text-center">Inspection Entry</h2>
		<!-- You can use any heading level like h2, h3 etc. -->

		<div class="form-container">
			<form id="inspectionForm" enctype="multipart/form-data">
				<!-- Initial visible sections -->
				<div id="additionalSection1" class="additional-section1">
					<div class="row form-row">
						<div class="col-sm-6 form-group">
							<label for="inspection_id" class="form-label required-label">Selected
								Inspection ID</label> <input type="text" id="inspection_id"
								name="inspection_id" class="form-control" readonly>
						</div>
						<div class="col-sm-6 form-group">
							<label for="inspection_date" class="form-label required-label">Inspection
								Date</label> <select id="dateDropdown" class="form-control"></select>
							<!-- Add class "form-control" here -->
						</div>
						<div class="row form-row">
							<div class="col-sm-6 form-group">
								<label for="location" class="form-label required-label">Location
									Details</label> <input type="text" class="form-control" id="location"
									name="location" placeholder="Type location details" required>
							</div>

							<div class="col-sm-6 form-group image-upload-section">
								<label for="imageInput" class="form-label">Upload Image</label>
								<input type="file" id="imageInput" name="imageInput"
									accept=".jpg, .jpeg, .png" /> <input type="text"
									id="base64Output" name="base64Output" style="display: none"
									readonly />
							</div>
						</div>
					</div>

					<div class="row form-row">
						<div class="col-sm-6 form-group">
							<label for="network_type" class="form-label required-label">Network
								Type</label> <select class="form-control" id="network_type"
								name="network_type" required>
								<option value="">Select Network Type</option>
								<option value="HT">HT Network</option>
								<option value="LT">LT Network</option>
							</select>
						</div>
						<div class="col-sm-6 form-group">
							<label for="asset_type" class="form-label required-label">Asset
								Type</label> <select class="form-control" id="asset_type"
								name="asset_type" required>
								<option value="">Select Asset Type</option>
								<option value="4P STRUCTURE">4P STRUCTURE</option>
								<option value="AB CABLE">AB CABLE</option>
								<option value="ACCESSORIES OF AB CABLE ">ACCESSORIES OF
									AB CABLE</option>
								<option value="BARE CONDUCTOR">BARE CONDUCTOR</option>
								<option value="CABLE RISER">CABLE RISER</option>
								<option value="CRADLE GUARD">CRADLE GUARD</option>
								<option value="DP STRUCTURE">DP STRUCTURE</option>
								<option value="DTR">DTR</option>
								<option value="DTR KIOSK">DTR KIOSK</option>
								<option value="EARTHING">EARTHING</option>
								<option value="INFRASTRUCTURE">INFRASTRUCTURE</option>
								<option value="INSULATOR (PIN, DISC, POST)">INSULATOR
									(PIN, DISC, POST)</option>
								<option value="INSULATOR (PIN, DISC,POST)">INSULATOR
									(PIN, DISC,POST)</option>
								<option value="INSULATOR (SACKLE, PIN)">INSULATOR
									(SACKLE, PIN)</option>
								<option value="IRON FITTINGS OF BARE CONDUCTOR ">IRON
									FITTINGS OF BARE CONDUCTOR</option>
								<option
									value="IRON FITTINGS OF BARE CONDUCTOR (V BRACKET, TOP ADAPTOR, CROSS ARM ETC.)">IRON
									FITTINGS OF BARE CONDUCTOR (V BRACKET, TOP ADAPTOR, CROSS ARM
									ETC.)</option>
								<option value="ISOLATOR">ISOLATOR</option>
								<option value="JUMPER">JUMPER</option>
								<option value="LIGHTNING ARRESTOR">LIGHTNING ARRESTOR</option>
								<option value="OTHERS">OTHERS</option>
								<option value="POLE">POLE</option>
								<option value="SERVICE CONNECTION INSTALLATION">SERVICE
									CONNECTION INSTALLATION</option>
								<option value="SPACER">SPACER</option>
								<option value="STAY SET">STAY SET</option>
							</select>
						</div>
					</div>
				</div>
				<p id="errorMessage"></p>

				<!-- Hidden sections initially -->
				<div id="additionalSection2" class="additional-section2">
					<div class="row form-row">

						<div id="problem_list_container" class="form-group">
							<!-- <label for="problem_list">Problem List</label> -->
							<div id="problem_list"></div>
						</div>

					</div>
					<!-- <div class="row form-row">
						<div class="col-sm-12 form-group">
							<label for="problem_details" class="form-label required-label">Problem
								Details</label>
							<textarea class="form-control" id="problem_details"
								name="problem_details" rows="3" required></textarea>
						</div>
					</div> -->
					<div class="mb-3 row">
						<label for="difficulty" class="form-label required-label">Severity
							Level</label>
						<div class="col-sm-9">
							<!-- <div class="form-check form-check-inline">
								<input class="form-check-input" type="radio" id="lowOption"
									name="difficulty" value="none" checked> <label
									class="form-check-label" for="noneOption">No Option</label>
							</div> -->
							<div class="form-check form-check-inline">
								<input class="form-check-input" type="radio" id="lowOption"
									name="difficulty" value="low"> <label
									class="form-check-label" for="lowOption">Low</label>
							</div>
							<div class="form-check form-check-inline">
								<input class="form-check-input" type="radio" id="mediumOption"
									name="difficulty" value="medium"> <label
									class="form-check-label" for="mediumOption">Medium</label>
							</div>
							<div class="form-check form-check-inline">
								<input class="form-check-input" type="radio" id="highOption"
									name="difficulty" value="high"> <label
									class="form-check-label" for="highOption">High</label>
							</div>
						</div>
					</div>
					<!-- <div class="row form-row">
						<div class="col-sm-12 form-group image-upload-section">
							<label for="imageInput" class="form-label">Upload Image</label> <input
								type="file" id="imageInput" name="imageInput"
								accept=".jpg, .jpeg, .png" onchange="uploadImage()" /> <input
								type="text" id="base64Output" name="base64Output"
								style="display: none" readonly />
						</div>
					</div> -->
					<div class="row form-row">
						<div class="col-sm-6 form-group">
							<!-- <label for="office_name" class="form-label required-label">Concerned
								Office Name</label> <input type="text" class="form-control"
								id="office_name" name="office_name" required> -->

							<label for="office_name" class="form-label required-label">Concerned
								Office Name</label> <select class="form-control" id="office_name"
								name="office_name" required>
								<option value="Select Office"></option>
							</select>
						</div>
					</div>
				</div>

				<!-- Bootstrap Modal -->
				<div class="modal fade" id="confirmationModal" tabindex="-1"
					aria-labelledby="confirmationModalLabel" aria-hidden="true">
					<div class="modal-dialog modal-lg">
						<div class="modal-content">
							<div class="modal-header">
								<h5 class="modal-title" id="confirmationModalLabel"
									align="center">Check and confirm the submission</h5>
								<button type="button" class="btn-close" id="btn-close"
									data-bs-dismiss="modal" aria-label="Close"></button>
							</div>
							<div class="modal-body">
								<!-- Dynamic content will be populated here with JavaScript -->
								<p>
									<strong>Inspection ID:</strong> <span id="confirmInspectionId"></span>
								</p>
								<p>
									<strong>Assigned Office:</strong> <span
										id="confirmAssignedOffice"></span>
								</p>
								<p>
									<strong>Location Remarks:</strong> <span
										id="confirmLocationRemarks"></span>
								</p>
								<p>
									<strong>Inspection Date:</strong> <span
										id="confirmInspectionDate"></span>
								</p>
								<p>
									<strong>Problem Details:</strong> <span
										id="confirmProblemDetails"></span>
								</p>
								<p>
									<strong>Severity Level:</strong> <span
										id="confirmSeverityLevel"></span>
								</p>
							</div>
							<div class="modal-footer">
								<button type="button" class="btn btn-primary" id="resetInspBtn"
									data-bs-dismiss="modal">Cancel</button>
								<button type="button" class="btn btn-primary"
									id="finalSubmitBtn">Submit</button>
								<!-- <button type="button" class="btn" id="resetInspBtn"
									data-bs-dismiss="modal"
									style="background-color: #ff6b6b; color: white;">Cancel</button>
								<button type="button" class="btn btn-primary"
									id="finalSubmitBtn">Submit</button> -->
								<!-- <button type="button" class="btn btn-secondary"
									id="resetInspBtn" data-bs-dismiss="modal"
									style="background-color: #ff6b6b; color: white; width: 150px;">Cancel</button>
								<button type="button" class="btn btn-primary"
									id="finalSubmitBtn" style="width: 150px;">Submit</button> -->

							</div>
						</div>
					</div>
				</div>

				<div class="row justify-content-center">
					<div class="col-auto">
						<!-- <button type="button" class="btn btn-primary" id="inspSubmitBtn">NEXT</button> -->
						<button type="button" class="btn btn-primary" id="inspSubmitBtn"
							disabled>NEXT</button>
					</div>
				</div>

			</form>
		</div>
	</div>


	<!-- Footer -->
	<footer class="text-center mt-5 bg-dark text-light p-3"> ©
		2024 IT&C Cell, WBSEDCL </footer>

	<!-- JavaScript to handle LDAP authentication and OTP submission -->
	<script src="assets/js/entry_inspection_own.js"></script>
	<!-- <script src="assets/js/login.js"></script> -->
</body>