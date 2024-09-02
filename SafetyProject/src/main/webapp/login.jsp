<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Safety Application</title>

<!-- Link to Bootstrap CSS -->
<link rel="stylesheet" href="assets/css/bootstrap.min.css">

<!-- Link to custom CSS -->
<link rel="stylesheet" href="assets/css/before_login.css">

<!-- jQuery -->
<script src="assets/js/jquery.min.js"></script>

<script src="assets/js/BigInteger.js"></script>
<script src="assets/js/BigInteger.min.js"></script>


<!-- JavaScript to handle LDAP authentication and OTP submission -->
<script src="assets/js/login.js"></script>

<!-- <script src="https://peterolson.github.io/BigInteger.js/BigInteger.min.js"></script> -->

</head>

<body>
	<!-- Header -->
	<nav class="navbar navbar-expand-lg navbar-dark">
		<a class="navbar-brand" href="#"> <img
			src="assets/images/logo.png" alt="Logo">
		</a> <span class="navbar-brand">West Bengal State Electricity
			Distribution Company Limited</span>
	</nav>

	<!-- Welcome Content -->
	<div class="container login-container mt-5">
		<div class="text-center header-title mb-4">
			<h2>Safety Inspection Portal</h2>
		</div>

		<!-- Login form -->
		<div class="form-row">
			<div class="form-group col-md-12">
				<label for="userId" class="mr-2">User ID</label> <input type="text"
					class="form-control" id="userId" name="userId"
					placeholder="Enter your ERP ID" required>
					
			</div>
		</div>

		<!-- Password section -->
		<div class="form-row">
			<div class="form-group col-md-12">
				<label for="password" class="mr-2">Password</label> <input
					type="password" class="form-control" id="password" name="password"
					placeholder="Enter your password" required>
					 
			</div>
		</div>
		<p id="loginError" class="error"></p>
		<!-- Login Button -->
		<div class="form-row">
			<div class="form-group col-md-12 d-flex justify-content-center">
				<button type="button" class="btn btn-primary" id="loginbttn"
					style="width: 50%;">Login</button>
			</div>
		</div>

		<!-- OTP Sent Message -->
		<div class="form-row" id="otpMessage" style="display: none;">
			<div class="form-group col-md-12 text-center">
				<p class="text-info">A one-time password has been sent to your
					registered mobile number.</p>
			</div>
		</div>

		<!-- OTP Section -->
		<form id="otpForm" style="display: none;">
			<div class="form-row">
				<div class="form-group col-md-12">
					<label for="otp" class="mr-2">OTP</label> <input type="text"
						class="form-control" id="otp" name="otp" placeholder="Enter OTP"
						required disabled>
				</div>
				<div class="form-group col-md-12 d-flex justify-content-center">
					<button type="button" class="btn btn-primary" id="submitOtpBtn"
						style="width: 50%;" disabled>Submit
						OTP</button>&nbsp;
						<button type="button" class="btn btn-primary" id="resendOtpBtn"
						style="width: 50%;" disabled>
						</button>
				</div>
				<p id="otpError" class="error"></p>
<!-- 				<div id="otpError" class="alert alert-danger" role="alert"
					style="display: none;"></div> -->
			</div>
		</form>
	</div>

	<!-- Footer -->
	<div class="footer">© 2024 WBSEDCL</div>


</body>
</html>
