<!-- Navigation Bar -->
<%@page import="org.json.*"%>
<link rel="icon" href="assets/images/favicon.ico" type="image/x-icon">
<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
	<div class="container-fluid">
		<!-- Left side: Welcome message -->
		<div id="cookieDisplay"></div>
		<%-- <span class="navbar-text"><%= username %> (ERP ID: <%= erpId %>, <%= designation %>)
			</span> --%>
		<span class="navbar-text"><div id="cookieDisplay"></div> </span>
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
				<li class="nav-item"><a class="nav-link" href="contacts.jsp">Contact</a>
				</li>
				<li class="nav-item">
					<!-- Logout form -->
					<!-- <form action="LogoutServlet" method="POST"
						onsubmit="clearLocalStorage()" style="display: inline;">
						<button type="submit" id="logOutSubmit" name="logOutSubmit"
							class="btn btn-outline-light ml-2">Logout</button>
					</form> -->
					
					<form style="display: inline;">
						<button type="submit" id="logOutSubmit" name="logOutSubmit"
							onsubmit="clearLocalStorage()" 
							class="btn btn-outline-light ml-2">Logout</button>
					</form>
					
				</li>
			</ul>
		</div>
	</div>
	<script src="assets/js/config.js"></script>
	<script src="assets/js/navbar.js"></script>
</nav>

