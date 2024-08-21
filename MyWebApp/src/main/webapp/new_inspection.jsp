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
    <script src="assets/js/entry_inspection.js"></script>
    <style>
        .form-container {
            margin-top: 30px;
        }
        .form-row {
            align-items: center;
        }
        .form-row label {
            margin-bottom: 0;
        }
        .form-row .form-control {
            margin-bottom: 15px;
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
            margin-bottom: 30px;
        }
    </style>
</head>
<body>
    <!-- Navigation Bar -->
<%--     <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
        <div class="container-fluid">
            <span class="navbar-text">Welcome, <strong><%=session.getAttribute("username")%></strong></span>
            <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse justify-content-end" id="navbarNav">
                <ul class="navbar-nav">
                    <li class="nav-item"><a class="nav-link" href="dashboard.html">Home</a></li>
                    <li class="nav-item"><a class="nav-link" href="contacts.html">Contact</a></li>
                    <li class="nav-item">
                        <form action="LogoutServlet" method="POST" style="display:inline;">
                            <button type="submit" class="btn btn-outline-light ml-2">Logout</button>
                        </form>
                    </li>
                </ul>
            </div>
        </div>
    </nav> --%>
    <nav>
		<jsp:include page="navbar.jsp" />
	</nav>

    <!-- Main Content -->
    <div class="container mt-5">
        <div class="form-container">
            <div class="heading-container">
                <h2>Entry New Inspection</h2>
            </div>
            <form id="inspectionForm">
                <div class="row form-row">
                    <div class="col-sm-6 form-group">
                        <label for="inspection_id" class="form-label">Inspection ID</label>
                        <input type="text" class="form-control" id="inspection_id" name="inspection_id" required>
                    </div>
                    <div class="col-sm-6 form-group">
                        <label for="inspection_date" class="form-label">Inspection Date</label>
                        <input type="date" class="form-control" id="inspection_date" name="inspection_date" required>
                    </div>
                </div>
                <div class="row form-row">
                    <div class="col-sm-6 form-group">
                        <label for="problem_code" class="form-label">Problem Code</label>
                        <input type="text" class="form-control" id="problem_code" name="problem_code" required>
                    </div>
                    <div class="col-sm-6 form-group">
                        <label for="location" class="form-label">Location</label>
                        <input type="text" class="form-control" id="location" name="location" required>
                    </div>
                </div>
                <div class="row form-row">
                    <div class="col-sm-12 form-group">
                        <label for="problem_details" class="form-label">Problem Details</label>
                        <textarea class="form-control" id="problem_details" name="problem_details" rows="3" required></textarea>
                    </div>
                </div>
                <div class="row form-row">
                    <div class="col-sm-6 form-group">
                        <label for="office_name" class="form-label">Office Name</label>
                        <input type="text" class="form-control" id="office_name" name="office_name" required>
                    </div>
                </div>
                <div class="row">
                    <div class="col-sm-12 btn-center">
                        <button type="button" class="btn btn-primary" id="submitBtn">Submit</button>
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
    <script src="assets/js/new_inspection.js"></script>
</body>
</html>
