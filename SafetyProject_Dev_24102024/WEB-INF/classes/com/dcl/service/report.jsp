<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Reporting Dashboard</title>
<style>
html, body {
	overflow-x: hidden;
	overflow-y: auto;
}

a {
	cursor: pointer; /* Changes cursor to hand icon */
}

.sidebar {
	width: 150px;
	/* background-color: #FF5733;*/
	color: white;
	padding: 7px;
	height: 100vh;
	position: fixed;
	left: 0;
	top: 0;
	transition: transform 0.3s ease;
	transform: translateX(-100%);
}

.sidebar.active {
	transform: translateX(0);
}

.expand-btn {
	position: fixed;
	left: 10px;
	top: 10px;
	background-color: #007bff;
	color: white;
	border: none;
	padding: 10px;
	cursor: pointer;
	border-radius: 5px;
}

.content {
	margin-left: 20px;
	padding: 20px;
	width: 100%;
}

.footer {
	background-color: #f8f9fa;
	padding: 10px;
	text-align: center;
}

.header {
	position: sticky;
	top: 0;
	z-index: 1000;
	background-color: #007bff;
	color: white;
	padding: 10px;
	text-align: center;
}

.no-bullet {
	list-style-type: none; /* Removes bullet */
}

ul {
	padding: 15px;
	margin: 0;
}

@media ( max-width : 768px) { /* Adjust the max-width as needed */
	.sidebar {
		display: none;
	}
	.h4-to-h5 {
		font-size: 1.05rem; /* h5 font size */
	}
	.navbar-mobile {
		display: block;
	}
}
</style>
<%@ page import="org.json.*, java.text.*,java.util.*"%>
</head>
<body>
	<%
		JSONObject empDtlReport = (JSONObject) request.getSession().getAttribute("empDtl");

		String header = "Welcome " + empDtlReport.get("emp_name").toString() + " (ID: "
				+ empDtlReport.get("erp_id").toString() + "); " + empDtlReport.get("designation").toString() + "; "
				+ empDtlReport.get("office_name").toString() + " (" + empDtlReport.get("office_code").toString() + ")";
	%>
	<div>
		<header class="bg-primary text-white text-center py-3">
			<h4 class="h4-to-h5"><%=header%></h4>
		</header>
	</div>
	<div class="sidebar bg-primary" id="sidebar">
		<br /> <br />
		<ul>

			<li><a onclick="showSummary()"
				style="color: white;">Summary</a></li>
			<li><a onclick="showTotal()"
				style="color: white;">Detail</a></li>
					</ul>
	</div>
	<button class="expand-btn" id="expandBtn">Reports</button>
	<div class="content" id="contentFrame">
		<%
			if (empDtlReport.getString("page_id").equals("401")) {
		%>
		<%@ include file="inspection_summary.jsp"%>
		<%
			} else if (empDtlReport.getString("page_id").equals("402")) {
		%>
		<%@ include file="vulnerability.jsp"%>
		<%
			} else if (empDtlReport.getString("page_id").equals("403")) {
				if(empDtlReport.getString("emp_office_level").equals("HQ")){
		%>
		
		<%@ include file="inspection_summary.jsp"%>
<%-- 		<%@ include file="vulnerability_summary.jsp"%> --%>
		<%
				}else{
					%>
						<%@ include file="inspection.jsp"%>
		<%@ include file="vulnerability.jsp"%>
				<%}
			} else {
				request.getSession().invalidate();
				response.sendRedirect("/SafetyProject");
			}
		%>

	</div>
	<footer class="footer">
		<p>&copy;2024-25. WBSEDCL.</p>
	</footer>
	<script>
		function showInspectionPage() {

			$.ajax({
				url : 'loadReportDashbrd',
				type : 'POST',
				success : function(response) {
					$('#contentFrame').html(response);
				},
				error : function(xhr, status, error) {
					console.error('Error loading page:', error);
					$('#contentFrame').html('<p>Error loading page</p>');
				}
			});
		}
		function showVulnerabilityPage() {

			$.ajax({
				url : 'loadVulnerabilityData',
				type : 'POST',
				success : function(response) {
					document.getElementById('contentFrame').innerHTML = '';
					document.getElementById('inspage').innerHTML = '';
					$('#contentFrame').html(response);
				},
				error : function(xhr, status, error) {
					console.error('Error loading page:', error);
					$('#contentFrame').html('<p>Error loading page</p>');
				}
			});
		}
		function showRectificationPage() {

			$.ajax({
				url : 'loadRectificationData',
				type : 'POST',
				success : function(response) {
					$('#contentFrame').html(response);
				},
				error : function(xhr, status, error) {
					console.error('Error loading page:', error);
					$('#contentFrame').html('<p>Error loading page</p>');
				}
			});
		}
		
	</script>
</body>
</html>