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
				<li class="nav-item"><a class="nav-link" href="contacts.html">Contact</a>
				</li>
				<li class="nav-item">
					<!-- Logout form -->
					<form action="LogoutServlet" method="POST" style="display: inline;">
						<button type="submit" class="btn btn-outline-light ml-2">Logout</button>
					</form>
				</li>
			</ul>
		</div>
	</div>
	<script>
		function getCookie(name) {
			const nameEQ = name + "=";
			const ca = document.cookie.split(';');
			for (let i = 0; i < ca.length; i++) {
				let c = ca[i];
				while (c.charAt(0) === ' ')
					c = c.substring(1, c.length);
				if (c.indexOf(nameEQ) === 0)
					return c.substring(nameEQ.length, c.length);
			}
			return null;
		}

		const cookieData = JSON.parse(getCookie('empDtls'));
		const name = cookieData.empDtls.EMNAMCL;
		const erp_id = cookieData.xUid.slice(0, 8);
		const designation = cookieData.empDtls.STEXTCL;
	
		document.getElementById("cookieDisplay").innerText = cookieData ? name
				+ ", " + designation + " (ERP ID: " + erp_id + ") "
				: "Cookie not found.";
	</script>
</nav>
