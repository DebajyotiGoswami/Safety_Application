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
<link rel="stylesheet" href="assets/css/inspection_navigation.css">
<!-- jQuery -->
<script src="assets/js/jquery.min.js"></script>
<script src="assets/js/config.js"></script>
<!-- Custom JavaScript -->
<!-- <script src="assets/js/new_inspection.js"></script> -->
<style>
.additional-section {
	display: none;
}
</style>
<%@page import="org.json.*"%>
</head>
<body>
	<!-- Navigation Bar -->
	<nav>
		<%@ include file="navbar.jsp"%>
	</nav>

	<!-- Main Content -->
	<div class="container mt-5">
		<div class="form-container">
			<div class="heading-container">
				<h2>Entry New Inspection</h2>
			</div>
			<form id="inspectionForm" enctype="multipart/form-data">

				<!-- Initial visible sections -->
				<div id="initialSection" class="initial-section">
					<div class="row form-row">
						<div class="col-sm-6 form-group">
							<label for="inspection_id" class="form-label required-label">Assigned
								Inspections</label> <select id="inspectionList" class="form-control">
								<!-- Added class "form-control" -->
								<option selected="true" disabled>Loading...</option>
							</select>
						</div>
						<div class="col-sm-6 form-group">
							<label for="inspection_date" class="form-label required-label">Inspection
								Date</label> <input type="date" class="form-control"
								id="inspection_date" name="inspection_date" required>
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

				<!-- Hidden sections initially -->
				<div id="additionalSection" class="additional-section">
					<div class="row form-row">
						<div class="col-sm-6 form-group">
							<label for="problem_code" class="form-label required-label">Problem
								Code</label> <select class="form-control" id="problem_list"
								name="problem_list" required>
								<option value="Select Asset Type"></option>
								<option value="Select Asset Typed">lsdsl</option>
							</select>
						</div>
						<div class="col-sm-6 form-group">
							<label for="location" class="form-label required-label">Location
								Details</label> <input type="text" class="form-control" id="location"
								name="location" required>
						</div>
					</div>
					<div class="row form-row">
						<div class="col-sm-12 form-group">
							<label for="problem_details" class="form-label required-label">Problem
								Details</label>
							<textarea class="form-control" id="problem_details"
								name="problem_details" rows="3" required></textarea>
						</div>
					</div>
					<div class="row form-row">
						<div class="col-sm-12 form-group image-upload-section">
							<label for="imageInput" class="form-label">Upload Image 1</label>
							<input type="file" id="imageInput" name="imageInput"
								accept=".jpg, .jpeg, .png" onchange="uploadImage()" /> <input
								type="text" id="base64Output" name="base64Output"
								style="display: none" readonly />
						</div>
					</div>
					<div class="row form-row">
						<div class="col-sm-6 form-group">
							<label for="office_name" class="form-label required-label">Concerned
								Office Name</label> <input type="text" class="form-control"
								id="office_name" name="office_name" required>
						</div>
					</div>
				</div>
				<div class="row">
					<div class="col-sm-12 btn-center">
						<button type="button" class="btn btn-primary" id="submitBtn">NEXT</button>
						<!-- <button type="button" class="btn btn-secondary" id="resetBtn">RESET</button>
-->
					</div>
				</div>
				<!-- <div class="row form-row">
					<div class="col-sm-6 form-group">
						<label for="inspection_id" class="form-label required-label">Inspection
							ID</label> <input type="text" class="form-control" id="inspection_id"
							name="inspection_id" required>
					</div>
					<div class="col-sm-6 form-group">
						<label for="inspection_date" class="form-label required-label">Inspection
							Date</label> <input type="date" class="form-control" id="inspection_date"
							name="inspection_date" required>
					</div>
				</div>
				<div class="row form-row">
					<div class="col-sm-6 form-group">
						<label for="problem_code" class="form-label required-label">Problem
							Code</label> <input type="text" class="form-control" id="problem_code"
							name="problem_code" required>
					</div>
					<div class="col-sm-6 form-group">
						<label for="location" class="form-label required-label">Location
							Details</label> <input type="text" class="form-control" id="location"
							name="location" required>
					</div>
				</div>
				<div class="row form-row">
					<div class="col-sm-12 form-group">
						<label for="problem_details" class="form-label required-label">Problem
							Details</label>
						<textarea class="form-control" id="problem_details"
							name="problem_details" rows="3" required></textarea>
					</div>
				</div>
				Image Upload Sections


				<div class="row form-row">
					<div class="col-sm-12 form-group image-upload-section">
						<label for="image1" class="form-label">Upload Image: </label> <input
							type="file" class="form-control" id="image1" name="image1"
							required>
					</div>
				</div>


				<div class="row form-row">
					<div class="col-sm-6 form-group">
						<label for="office_name" class="form-label required-label">ConcernedOffice
							Name</label> <input type="text" class="form-control" id="office_name"
							name="office_name" required>
					</div>
				</div>
				<div class="row">
					<div class="col-sm-12 btn-center">
						<button type="button" class="btn btn-primary" id="submitBtn">Submit</button>
					</div>
				</div>
 -->
			</form>
		</div>
	</div>

	<!-- Footer -->
	<footer class="text-center mt-5 bg-dark text-light p-3"> ©
		2024 IT&C Cell, WBSEDCL </footer>

	<!-- JavaScript to handle LDAP authentication and OTP submission -->
	<script src="assets/js/entry_inspection.js"></script>
</body>
</html>
