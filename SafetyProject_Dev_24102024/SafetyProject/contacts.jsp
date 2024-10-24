<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Contacts</title>
<link rel="stylesheet" href="assets/css/bootstrap.min.css">
<link rel="stylesheet" href="assets/css/dashboard_navigation.css">
<link rel="stylesheet" href="assets/fontAwesome/css/all.min.css">
<style>
h2 {
	color: #007bff;
	font-size: 2rem;
	margin-bottom: 20px;
}

.table-responsive {
	margin-bottom: 20px;
}

th {
	background-color: #e3f2fd;
	font-weight: bold;
}

tr:hover {
	background-color: #dfe6f0;
	cursor: pointer;
}

footer {
	padding: 5px;
	font-size: 14px;
	background-color: #012466;
	color: white;
	position: fixed;
	width: 100%;
	bottom: 0;
}
</style>

<script
	src="https://cdn.datatables.net/1.10.21/js/jquery.dataTables.min.js"></script>
	<script src="assets/js/config.js"></script>

<link rel="stylesheet"
	href="https://cdn.datatables.net/1.10.21/css/jquery.dataTables.min.css">
</head>

<body>
	<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
		<div class="container-fluid">
			<!-- Left side: Welcome message -->
			<div id="cookieDisplay"></div>
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

	<div class="container">
		<h2 align="center">Contacts</h2>
		<table class="table table-striped table-hover">
			<thead>
				<tr>
					<th>Name</th>
					<th>Designation</th>
					<th>Office</th>
					<th>Mobile No</th>
					<th>Email ID</th>
					<th>Problem Area</th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td>Tuhin Sovan Koley</td>
					<td>SE(IT&C)</td>
					<td>IT&C Cell</td>
					<td>9474813396</td>
					<td>TuhinS.Koley@wbsedcl.in</td>
					<td>Authorization</td>
				</tr>
				<tr>
					<td>Debajyoti Goswami</td>
					<td>DE(IT&C)</td>
					<td>IT&C Cell</td>
					<td>9432177024</td>
					<td>Debajyoti.Goswami@wbsedcl.in</td>
					<td>Data Entry and View (Web)</td>
				</tr>
				<tr>
					<td>Tamal Biswas</td>
					<td>DE(IT&C)</td>
					<td>IT&C Cell</td>
					<td>6291411244</td>
					<td>Tamal.Biswas@wbsedcl.in</td>
					<td>Data Entry and View (App)</td>
				</tr>
				<tr>
					<td>Jewel Daw</td>
					<td>DE(IT&C)</td>
					<td>IT&C Cell</td>
					<td>8981111873</td>
					<td>Jewel.Daw@wbsedcl.in</td>
					<td>Reports (Web & App)</td>
				</tr>
				<!-- Add more contacts as needed -->
			</tbody>
		</table>
	</div>
	<!-- Footer -->
	<footer class="text-center mt-auto">
		<div class="text-center p-3">© 2024 IT&C Cell, WBSEDCL</div>
	</footer>

</body>
</html>
