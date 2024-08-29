<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>View Inspections</title>
    
    <!-- Link to Bootstrap CSS -->
    <link rel="stylesheet" href="assets/css/bootstrap.min.css">
    <link rel="stylesheet" href="assets/css/inspection_navigation.css">
</head>
<body>
	<!-- Navigation Bar -->
	<nav>
			<jsp:include page="navbar.jsp" />
	</nav>

	<!-- Main Content -->
    <div class="container">
    
    	<div class="form-container">
			<h2 class="text-center mb-4">Search Assigned Inspection</h2>
			<form id="searchForm" action="searchAssignmentServlet" method="post">
				<div class="mb-3 row">
					<label for="fromDate" class="col-sm-3 col-form-label">From
						Date</label>
					<div class="col-sm-9">
						<input type="date" class="form-control" id="fromDate"
							name="fromDate" required>
					</div>
				</div>
				<div class="mb-3 row">
					<label for="toDate" class="col-sm-3 col-form-label">To Date</label>
					<div class="col-sm-9">
						<input type="date" class="form-control" id="toDate" name="toDate"
							required>
					</div>
				</div>
				<div class="mb-3 row">
					<div class="col-sm-12 text-center">
						<button type="button" class="btn btn-primary" id="searchBtn" 
						onclick="submitThisForm()">Search</button>
					</div>
				</div>
			</form>
		</div>
		
		
        <div class="result-container">
            <h2 class="text-center mb-4">Status of Assigned Inspection by <strong><%= request.getParameter("assigned_by_name") %></strong> (<%= request.getParameter("erp_id") %>)</h2>
            <table class="table">
                <thead>
                    <tr>
						<th>#</th>
						<th>Inspection ID</th>
						<th>Assigned By</th>
						<th>Assigned To</th>
						<th>Office Name</th>
						<th>From Date</th>
						<th>To Date</th>
						<th>Status</th>
                    </tr>
                </thead>
                <tbody id="resultsTableBody">
                    <!-- Data will be populated here by JavaScript -->
                </tbody>
            </table>
        </div>
    </div>

    <!-- Footer -->
    <footer class="text-center mt-auto">
        <div class="text-center p-3">
            © 2024 IT&C Cell, WBSEDCL
        </div>
    </footer>
	<script src="assets/js/search_inspection.js"></script>
</body>
</html>
