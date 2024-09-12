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
	<nav>
		<%@ include file="navbar.jsp"%>
	</nav>

	<!-- Main Content -->
	<div class="container">
		<div class="form-container">
			<h2 class="text-center mb-4">Assign Inspection</h2>
			<form>
				<!-- 				<div class="mb-3 row">
					<label class="col-sm-3 col-form-label">Hello, <strong>username</strong>
						(Office Code)
					</label>
					<div class="col-sm-9">
						<p class="form-control-static"></p>
					</div>
				</div> -->
				<!-- <div class="mb-3 row">
                    <label for="officeCode" class="col-sm-3 col-form-label">Your Office Code</label>
                    <div class="col-sm-9">
                        <input type="text" class="form-control" id="officeCode" placeholder="Enter Office Code" required>
                    </div>
                </div> -->
				<div class="mb-3 row">
					<label for="teamMembers" class="col-sm-3 col-form-label">Number
						of Team Members<span class="text-danger">*</span></label>
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
				<!-- <div class="mb-3 row">
					<label for="empDetails" class="col-sm-3 col-form-label">Employee Details
					<span class="text-danger">*</span></label>
					<div class="col-sm-9">
						<select class="form-control" id="empDetails" name="empDetails"
							required>
							<option value="">Select Employee Name</option>
							Add options here dynamically or hardcode them
						</select>
					</div>
				</div> -->
				<div id="erpIdContainer"></div>
				<div class="mb-3 row">
					<label class="col-sm-3 col-form-label">Inspection Date<span class="text-danger">*</span></label>
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
				<p id="dateError" class="error text-danger" aria-live="assertive"></p>
				<!-- Error message container with red text -->
				<div class="mb-3 row">
					<label for="officeName" class="col-sm-3 col-form-label">Office
						Name<span class="text-danger">*</span></label>
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
						<textarea class="form-control" id="remarks" rows="3"
							placeholder="Enter remarks"></textarea>
					</div>
				</div>
				<div class="mb-3 row">
					<div class="col-sm-12 text-center">
						<button type="button" class="btn btn-primary" id="assgnSubmitbtn" disabled>Assign
							Inspection</button>
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