<!-- Navigation Bar -->
<%@page import="org.json.*"%>
	<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
		<div class="container-fluid">
			<!-- Left side: Welcome message -->
			<%
            // Retrieve user details from session
            JSONObject empDtlsJson = (JSONObject) request.getSession().getAttribute("empDtls");
            String username = empDtlsJson.getString("name"); // Default value if user details are not found
            String erpId = empDtlsJson.getString("erpId"); // Default value if ERP ID is not found
            String designation=  empDtlsJson.getString("designation");
			String office= empDtlsJson.getString("office");
		//	String role= empDtlsJson.getString("role");
		//	String xUid= empDtlsJson.getString("xUid");
		//	String tkn= empDtlsJson.getString("tkn");
            request.getSession().setAttribute("empDtls", empDtlsJson);
            request.getSession().setAttribute("erpId", erpId);
        %>
        <input type="text" id="erpId" name="erpId" style="display: none" value="<%=erpId%>"/>
        <input type="text" id="username" name="username" style="display: none" value="<%=username%>"/>
        <input type="text" id="designation" name="designation" style="display: none" value="<%=designation%>"/>
        <input type="text" id="office" name="office" style="display: none" value="<%=office%>"/>
<%--         <input type="text" id="role" name="role" style="display: none" value="<%=role%>"/> --%>
<%--         <input type="text" id="xUid" name="xUid" style="display: none" value="<%=xUid%>"/> --%>
<%--         <input type="text" id="tkn" name="tkn" style="display: none" value="<%=tkn%>"/> --%>
			<span class="navbar-text"><%= username %> (ERP ID: <%= erpId %>
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
	<script>
        // Function to prevent back navigation
        function preventBack() {
            history.pushState(null, null, location.href);
            window.onpopstate = function () {
                history.go(1);
            };
        }

        // Call the function on page load
        window.onload = preventBack;
    </script>