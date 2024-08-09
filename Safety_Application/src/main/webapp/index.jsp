<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
    <link rel="stylesheet" href="assets/css/styles.css">
    
	<script></script>
</head>
<body>
	<!-- Welcome Content -->
	<div>
		<!-- Navigation panel in login/welcome page -->
	</div>
	<div class="container login-container">
		<div class="text-center header-title">
			<h2>Safety Inspection Portal</h2>
			<!-- Following form will take userid and password -->
			<form action="LoginServlet" method="POST">
				<!-- User Id section -->
				<div class="form-group">
					<label for="userId">User ID</label>
					<input type="text" class="form-control" id="userId" name="userId" placeholder="Enter your ERP ID" required>
				</div>
				
				<!-- Password section -->
				<div class="form-group">
					<label for="password">Password</label>
					<input type="text" class="form-control" id="password" name="password" placeholder="Enter your password" required>	
				</div>
				
				<!-- Submit Button -->
				<div class="d-flex justify-content-center">
					<button type="submit" class="btn btn-primary mt-3" style="width:150px">Login</button>
				</div>
			</form>
		</div>
	</div>"
		
</body>
</html>