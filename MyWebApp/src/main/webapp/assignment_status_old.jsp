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
    <link rel="stylesheet" href="assets/css/inspection_status.css">
</head>
<body>
    <!-- Navigation Bar -->
    <nav class="navbar navbar-expand-lg navbar-dark">
        <div class="container-fluid">
            <span class="navbar-text">Welcome, <strong><%= request.getParameter("username") %></strong></span>
            <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse justify-content-end" id="navbarNav">
                <ul class="navbar-nav">
                    <li class="nav-item">
                        <a class="nav-link" href="dashboard.html">Home</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="contacts.html">Contact</a>
                    </li>
                    <li class="nav-item">
                        <form action="LogoutServlet" method="POST" style="display:inline;">
                            <button type="submit" class="btn btn-outline-light ml-2">Logout</button>
                        </form>
                    </li>
                </ul>
            </div>
        </div>
    </nav>

    <!-- Main Content -->
    <div class="container">
        <div class="form-container">
            <h2 class="text-center mb-4">Status of Assigned Inspection by <strong><%= request.getParameter("assigned_by_name") %></strong> (<%= request.getParameter("erp_id") %>)</h2>
            <table class="table">
                <thead>
                    <tr>
                        <th>Inspection ID</th>
                        <th>Assigned By</th>
                        <th>Assigned To</th>
                        <th>Office Name</th>
                        <th>From Date</th>
                        <th>To Date</th>
                        <th>Status</th>
                    </tr>
                </thead>
                <tbody id="inspectionData">
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

    <script>
        const erpId = "<%= request.getParameter("erp_id") %>";

        fetch(`/viewInspection?erpId=${erpId}`)
            .then(response => response.json())
            .then(data => {
                const tbody = document.getElementById('inspectionData');
                data.forEach(inspection => {
                    const row = document.createElement('tr');
                    row.innerHTML = `
                        <td>${inspection.inspection_id}</td>
                        <td>${inspection.assigned_by}</td>
                        <td>${inspection.assigned_to}</td>
                        <td>${inspection.office_name}</td>
                        <td>${inspection.from_date}</td>
                        <td>${inspection.to_date}</td>
                        <td>${inspection.status}</td>
                    `;
                    tbody.appendChild(row);
                });
            })
            .catch(error => console.error('Error:', error));
    </script>
</body>
</html>
