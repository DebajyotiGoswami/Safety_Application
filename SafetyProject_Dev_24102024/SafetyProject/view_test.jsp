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
<script src="assets/js/config.js"></script>

<style>
/* Styling for Image Section */
.image-section {
    display: flex;
    justify-content: center; /* Center the images horizontally */
    margin-bottom: 10px;
    position: relative;
    gap: 300px; /* Add some space between the images */
}

.image-section img {
    width: 20%;  /* Make the images smaller initially */
    height: auto;
    transition: transform 0.3s ease, z-index 0.3s ease;  /* Smooth transition */
}

.image-section img:hover {
    transform: scale(2.5);  /* Enlarge the image more on hover */
    z-index: 10;  /* Bring the image to the front */
    position: relative;
}

/* Styling for Details Section */
.details-section {
    margin-top: 10px;
    padding: 10px;
    border: 1px solid #dee2e6;
}

.form-row {
    display: flex;
    justify-content: left-aligned;
    align-items: center;
    margin-bottom: 10px;
}

.form-row label {
    width: 15%;
    font-size: 14px;
    text-align: right;
    margin-right: 5px;
    font-weight: bold;
}

.details-section p {
    margin: 0;
    padding: 5px 0;
    font-size: 14px;
    width: 35%;
    font-weight: bold;
    border-bottom: 1px solid #dee2e6;
}

/* Green Styling for Rectification Fields */
.green-text {
    color: green;
}

.green-border {
    border-bottom: 1px solid green;
}

/* Red Styling for all other labels and p */
.red-text {
    color: red;
}

.red-border {
    border-bottom: 1px solid red;
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

    <div class="container mt-4">
        <!-- Image Section -->
        <div class="image-section">
            <img id="inspImage" src="" alt="Inspection Image"> 
            <img id="rectImage" src="assets/images/not_rectified_yet.jpg" alt="NOT RECTIFIED YET">
        </div>

        <!-- Details Section -->
        <div class="details-section">
            <!-- First Line -->
            <div class="form-row">
                <p id="inspectionId"></p>
                <label for="siteId"></label> 
                <p id="siteId"></p>
            </div>
            <!-- Second Line -->
            <div class="form-row">
                <p id="inspectionDate" class="red-text red-border"></p> 
                <label for="rectificationDate" class="green-text"></label> 
                <p id="rectificationDate" class="green-text green-border"></p>
            </div>
            <!-- Third Line -->
            <div class="form-row">
                <p id="problemDetails" class="red-text red-border"></p> 
                <label for="rectificationDetails" class="green-text"></label> 
                <p id="rectificationDetails" class="green-text green-border"></p>
            </div>
            <!-- Fourth Line -->
            <div class="form-row">
                <p id="location" class="red-text red-border"></p>
                <label for="gps" class="red-text"></label> 
                <p id="gps" class="red-text red-border"></p>
            </div>
            <!-- Fifth Line -->
            <div class="form-row">
                <p id="inspectionBy" class="red-text red-border"></p>
                <label for="rectificationBy" class="green-text"></label> 
                <p id="rectificationBy" class="green-text green-border"></p>
            </div>
        </div>
    </div>

    <!-- Footer -->
    <footer class="text-center mt-4 bg-dark text-light p-3">© 2024 IT&C Cell, WBSEDCL</footer>

    <!-- JavaScript to handle AJAX call for updating fields -->
    <script>
        $(document).ready(function() {
            // Retrieve the stored data from localStorage
            var currProbData = JSON.parse(localStorage.getItem("currProb"));

            if (currProbData) {
		if(!currProbData.rectification_date) currProbData.rectification_date= "";
		if(!currProbData.rectification_remarks) currProbData.rectification_remarks= "";
		if(!currProbData.rectified_by) currProbData.rectified_by= "";

                // Populate the fields with data
                $('#inspectionId').text("Inspection ID: " + currProbData.inspection_id);
                $('#siteId').text("Site ID: " + currProbData.site_id);
                
                $('#inspectionDate').text("Inspection Date: " + currProbData.inspection_date);
                $('#rectificationDate').text("Rectification Date: " + currProbData.rectification_date);
                
                $('#problemDetails').text("Problem Details: " + currProbData.problem_id + " - " + currProbData.problem_remarks);
                $('#rectificationDetails').text("Rectification Details: " + currProbData.rectification_remarks);
                
                $('#location').text("Location: " + currProbData.location_remarks);
                $('#gps').text("Geo Location: " + currProbData.latitude + " , " + currProbData.longitude);
                
                $('#inspectionBy').text("Inspected By: " + currProbData.inspection_by);
                $('#rectificationBy').text("Rectified By: " + currProbData.rectified_by);

                // Display the image by converting the base64 string
                var base64ImageString = currProbData.pre_image;
                if (base64ImageString) {
                    $('#inspImage').attr('src', 'data:image/jpeg;base64,' + base64ImageString);
                }
                
                base64ImageString = currProbData.post_image;
                if (base64ImageString) {
                    $('#rectImage').attr('src', 'data:image/jpeg;base64,' + base64ImageString);
                }
            } else {
                console.log("No data found in localStorage.");
            }
        });
    </script>
</body>
</html>
