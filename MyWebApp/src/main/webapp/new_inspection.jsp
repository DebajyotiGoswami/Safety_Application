<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
    <!-- Custom JavaScript -->
    <script src="assets/js/new_inspection.js"></script>
    <style>
        .form-container {
            margin-top: 5px;
        }
        .form-row {
            align-items: center;
        }
        .form-row label {
            margin-bottom: 0;
        }
        .form-row .form-control {
            margin-bottom: 5px;
        }
        .form-row .form-group {
            margin-bottom: 0;
        }
        .btn-center {
            display: flex;
            justify-content: center;
        }
        .heading-container {
            text-align: center;
            margin-bottom: 5px;
        }
        .required-label::after {
            content: '*';
            color: red;
            margin-left: 5px;
        }
    </style>
</head>
<body>
    <!-- Navigation Bar -->
    <nav>
		<jsp:include page="navbar.jsp" />
	</nav>

    <!-- Main Content -->
    <div class="container mt-5">
        <div class="form-container">
            <div class="heading-container">
                <h2>Entry New Inspection</h2>
            </div>
            <form id="inspectionForm" enctype="multipart/form-data">
                <div class="row form-row">
                    <div class="col-sm-6 form-group">
                        <label for="inspection_id" class="form-label required-label">Inspection ID</label>
                        <input type="text" class="form-control" id="inspection_id" name="inspection_id" required>
                    </div>
                    <div class="col-sm-6 form-group">
                        <label for="inspection_date" class="form-label required-label">Inspection Date</label>
                        <input type="date" class="form-control" id="inspection_date" name="inspection_date" required>
                    </div>
                </div>
                <div class="row form-row">
                    <div class="col-sm-6 form-group">
                        <label for="problem_code" class="form-label required-label">Problem Code</label>
                        <input type="text" class="form-control" id="problem_code" name="problem_code" required>
                    </div>
                    <div class="col-sm-6 form-group">
                        <label for="location" class="form-label required-label">Location Details</label>
                        <input type="text" class="form-control" id="location" name="location" required>
                    </div>
                </div>
                <div class="row form-row">
                    <div class="col-sm-12 form-group">
                        <label for="problem_details" class="form-label required-label">Problem Details</label>
                        <textarea class="form-control" id="problem_details" name="problem_details" rows="3" required></textarea>
                    </div>
                </div>
                <!-- Image Upload Sections -->
                <div class="row form-row">
                    <div class="col-sm-12 form-group image-upload-section">
                        <label for="image1" class="form-label">Upload Image 1</label>
                        <input type="file" class="form-control" id="image1" name="image1">
                    </div>
                </div>
<!--                 <div class="row form-row">
                    <div class="col-sm-12 form-group image-upload-section">
                        <label for="image2" class="form-label">Upload Image 2</label>
                        <input type="file" class="form-control" id="image2" name="image2">
                    </div>
                </div> -->
                <div class="row form-row">
                    <div class="col-sm-6 form-group">
                        <label for="office_name" class="form-label required-label">Concerned Office Name</label>
                        <input type="text" class="form-control" id="office_name" name="office_name" required>
                    </div>
                </div>
                <div class="row">
                    <div class="col-sm-12 btn-center">
                        <button type="button" class="btn btn-primary" id="submitBtn" >Submit</button>
                    </div>
                </div>
            </form>
        </div>
    </div>

    <!-- Footer -->
    <footer class="text-center mt-5 bg-dark text-light p-3">
        © 2024 IT&C Cell, WBSEDCL
    </footer>
    
    <!-- JavaScript to handle LDAP authentication and OTP submission -->
    <script src="assets/js/entry_inspection.js"></script>
</body>
</html>
