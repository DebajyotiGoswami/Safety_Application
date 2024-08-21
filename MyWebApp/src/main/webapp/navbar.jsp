<!-- Navigation Bar -->
	<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
		<div class="container-fluid">
			<!-- Left side: Welcome message -->
			<%
            // Retrieve user details from session
            String empDtlsJson = (String) session.getAttribute("empDtls");
            String username = "Guest"; // Default value if user details are not found
            String erpId = ""; // Default value if ERP ID is not found
            String designation= "";

            if (empDtlsJson != null) {
                org.json.JSONObject empDtls = new org.json.JSONObject(empDtlsJson);
                username = empDtls.optString("name", "Guest"); // Get name or default to 'Guest'
                erpId = empDtls.optString("erpId", "N/A"); // Get ERP ID or default to 'N/A'
                designation = empDtls.optString("designation", "N/A");
            }
        %>
			<span class="navbar-text">Welcome, <%= username %> (ERP ID: <%= erpId %>
				, <%= designation %>)
			</span>

			<!-- Right side: Navigation links -->
			<button class="navbar-toggler" type="button" data-toggle="collapse"
				data-target="#navbarNav" aria-controls="navbarNav"
				aria-expanded="false" aria-label="Toggle navigation">
				<span class="navbar-toggler-icon"></span>
			</button>
			<div class="collapse navbar-collapse justify-content-end"
				id="navbarNav">
				<ul class="navbar-nav">
					<li class="nav-item"><a class="nav-link" href="dashboard.jsp">Home</a>
					</li>
					<li class="nav-item"><a class="nav-link" href="contacts.html">Contact</a>
					</li>
					<li class="nav-item">
						<!-- Logout form -->
						<form action="LogoutServlet" method="POST"
							style="display: inline;">
							<button type="submit" class="btn btn-outline-light ml-2">Logout</button>
						</form>
					</li>
				</ul>
			</div>
		</div>
	</nav>