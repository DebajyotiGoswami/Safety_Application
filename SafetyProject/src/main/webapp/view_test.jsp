<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>View Problem</title>

<!-- Link to Bootstrap CSS -->
<link rel="stylesheet" href="assets/css/bootstrap.min.css">
<link rel="stylesheet" href="assets/css/inspection_entry.css">

<!-- jQuery -->
<script src="assets/js/jquery.min.js"></script>
<script src="assets/js/bootstrap.min.js"></script>
<script src="assets/js/BigInteger.js"></script>

<style>
.image-section {
	display: flex;
	justify-content: space-between;
}

.image-section img {
	width: 48%;
	height: auto;
}

.details-section {
	margin-top: 20px;
	padding: 20px;
	border: 1px solid #dee2e6;
}

.form-row {
	display: flex;
	justify-content: space-between;
	align-items: center;
	margin-bottom: 15px;
}

.form-row label {
	width: 20%;
	text-align: right;
	margin-right: 10px;
}

.form-row input {
	width: 30%;
}
</style>
</head>
<body>
	<!-- Navigation Bar -->
	<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
		<div class="container-fluid">
			<div id="cookieDisplay"></div>
			<span class="navbar-text"><span id="cookieDisplay"></span> </span>
			<button class="navbar-toggler" type="button" data-toggle="collapse"
				data-target="#navbarNav" aria-controls="navbarNav"
				aria-expanded="false" aria-label="Toggle navigation">
				<span class="navbar-toggler-icon"></span>
			</button>
			<div class="collapse navbar-collapse justify-content-end"
				id="navbarNav">
				<ul class="navbar-nav">
					<li class="nav-item"><a class="nav-link" href="dashboard.jsp">Home</a></li>
					<li class="nav-item"><a class="nav-link" href="contacts.jsp">Contact</a></li>
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

	<div class="container mt-5">
		<!-- Image Section -->
		<div class="image-section">
			<img id="problemImage1" src="image1.jpg" alt="Inspection Image 1"> 
			<img id="problemImage2" src="image2.jpg" alt="Inspection Image 2">
		</div>

		<!-- Details Section -->
		<div class="details-section">
			<!-- First Line -->
			<div class="form-row">
				<label for="inspectionId">Inspection ID:</label> <input type="text"
					class="form-control" id="inspectionId" name="inspectionId" readonly>
				<label for="siteId">Site ID:</label> <input type="text"
					class="form-control" id="siteId" name="siteId" readonly>
			</div>
			<!-- Second Line -->
			<div class="form-row">
				<label for="inspectionDate">Inspection Date:</label> <input
					type="text" class="form-control" id="inspectionDate"
					name="inspectionDate" readonly> <label
					for="rectificationDate">Rectification Date:</label> <input
					type="text" class="form-control" id="rectificationDate"
					name="rectificationDate" readonly>
			</div>
			<!-- Third Line -->
			<div class="form-row">
				<label for="problemDetails">Problem Details:</label> <input
					type="text" class="form-control" id="problemDetails"
					name="problemDetails" readonly> <label
					for="rectificationDetails">Rectification Details:</label> <input
					type="text" class="form-control" id="rectificationDetails"
					name="rectificationDetails" readonly>
			</div>
			<!-- Fourth Line -->
			<div class="form-row">
				<label for="location">Location:</label> <input type="text"
					class="form-control" id="location" name="location" readonly>
				<label for="gps">GPS:</label> <input type="text"
					class="form-control" id="gps" name="gps" readonly>
			</div>
			<!-- Fifth Line -->
			<div class="form-row">
				<label for="inspectionBy">Inspection By:</label> <input type="text"
					class="form-control" id="inspectionBy" name="inspectionBy" readonly>
				<label for="rectificationBy">Rectification By:</label> <input
					type="text" class="form-control" id="rectificationBy"
					name="rectificationBy" readonly>
			</div>
		</div>
	</div>

	<!-- Footer -->
	<footer class="text-center mt-5 bg-dark text-light p-3">© 2024
		IT&C Cell, WBSEDCL</footer>

	<!-- JavaScript to handle AJAX call for updating fields -->
	<!-- JavaScript to populate fields and convert base64 image -->
	<script>
        $(document).ready(function() {
            // Retrieve the stored data from localStorage
            var currProbData = JSON.parse(localStorage.getItem("currProb"));

            if (currProbData) {
                // Populate the fields with data
                $('#inspectionId').val(currProbData.inspection_id);
                $('#siteId').val(currProbData.site_id);
                
                $('#inspectionDate').val(currProbData.inspection_date);
                $('#rectificationDate').val(currProbData.rectification_date);
                
                $('#problemDetails').val(currProbData.problem_id+ " - "+ currProbData.problem_remarks);
                $('#rectificationDetails').val(currProbData.rectification_details);
                
                $('#location').val(currProbData.location_remarks);
                $('#gps').val(currProbData.latitude+ " , "+ currProbData.longitude);
                
                $('#inspectionBy').val(currProbData.inspection_by);
                $('#rectificationBy').val(currProbData.rectification_by);

                // Display the image by converting the base64 string
                var base64ImageString = currProbData.pre_image;  // Assuming the field is named "problem_image"
                if (base64ImageString) {
                    $('#problemImage1').attr('src', 'data:image/jpeg;base64,' + base64ImageString);
                }
                
                var base64ImageString = currProbData.pre_image;  // Assuming the field is named "problem_image"
                if (base64ImageString) {
                    $('#problemImage2').attr('src', 'data:image/jpeg;base64,' + base64ImageString);
                }
            } else {
                console.log("No data found in localStorage.");
            }
        });
    </script>
</body>
</html>
