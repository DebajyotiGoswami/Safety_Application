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
<%@ page
	import="org.json.*, java.text.*,java.util.*, java.nio.charset.*, com.dcl.service.*"%>
</head>
<body>
	<%
// 	JSONObject empDtlReport = new JSONObject();
// 	Cookie[] cookies = request.getCookies();
//     if (cookies != null) {
//         for (Cookie cookie : cookies) {
//             if ("empDtl".equals(cookie.getName())) {
//                 String encodedJson  = cookie.getValue();
//                 try {
//                 	String jsonString = new String(Base64.getDecoder().decode(encodedJson));
//                     empDtlReport = new JSONObject(jsonString);
//                 } catch (JSONException e) {
//                     out.println("<p>Error parsing JSON data.</p>");
//                 }
//                 break;
//             }
//         }
//     } else {
//         out.println("<p>No cookies found.</p>");
//     }

		//String encodedString=(String)request.getSession().getAttribute("encodedString");
		JSONObject empDtlReport = new JSONObject();
		
// 		StringBuilder fullString = new StringBuilder();
//         for (int i = 0; i < 10; i++) {
//             String part = (String) session.getAttribute("part" + i);
//             if (part != null) {
//                 fullString.append(part);
//             }
//         }

//         // Handle any remaining part
//         String lastPart = (String) session.getAttribute("part10");
//         if (lastPart != null) {
//             fullString.append(lastPart);
//         }

//         String encodedString=fullString.toString();

String encodedString=(String)request.getSession().getAttribute("encodedString");
        
		if(encodedString!=null && !encodedString.isEmpty() && !encodedString.equals("")){
			byte[] decodedByte = Base64.getDecoder().decode(encodedString);
			//String decodedString=new String(decodedByte, StandardCharsets.UTF_8);
			
			compressDecompressString decompStr=new compressDecompressString();
			
			empDtlReport=new JSONObject(decompStr.decompressString(decodedByte));

		
	//	JSONObject empDtlReport = (JSONObject) request.getSession().getAttribute("empDtl");
	

		String header = "Welcome " + empDtlReport.get("emp_name").toString() + " (ID: "
				+ empDtlReport.get("erp_id").toString() + "); " + empDtlReport.get("designation").toString() + "; "
				+ empDtlReport.get("office_name").toString() + " (" + empDtlReport.get("office_code").toString()
				+ ")";
	%>
	<div>
		<header class="bg-primary text-white text-center py-3">
			<h4 class="h4-to-h5"><%=header%></h4>
		</header>
	</div>
	<div class="sidebar bg-primary" id="sidebar">
		<br /> <br />
		<ul>

			<li><a onclick="showSummary()" style="color: white;">Summary</a></li>
			<li><a onclick="showTotal()" style="color: white;">Detail</a></li>
		</ul>
	</div>
	<button class="expand-btn" id="expandBtn">Reports</button>
	<div class="content" id="contentFrame">
		<%
			if (empDtlReport.getString("page_id").equals("401")) {
		%>
		<%@ include file="inspection.jsp"%>
		<%
			} else if (empDtlReport.getString("page_id").equals("402")) {
		%>
		<%@ include file="vulnerability.jsp"%>
		<%
			} else if (empDtlReport.getString("page_id").equals("403")) {
		%>
		<%-- <%@ include file="office_wise_inspection_summary.jsp"%> --%>
		<%@ include file="inspection_summary_page.jsp"%>
		<%
		
			} else {
			%>
		No Data
		<%
			}
		%>
		<% } %>
	</div>
	<footer class="footer">
		<p>&copy;2024-25. WBSEDCL.</p>
	</footer>
	<script>

	
	function showSummary() {
		var erp_id='<%=empDtlReport.getString("erp_id")%>';
		var role_id='<%=empDtlReport.getString("role_id")%>';
		var emp_name='<%=empDtlReport.getString("emp_name")%>';
		var designation='<%=empDtlReport.getString("designation")%>';
		var office_code='<%=empDtlReport.getString("office_code")%>';
		var role_name='<%=empDtlReport.getString("role_name")%>';
		var auth='<%=empDtlReport.getString("auth")%>';
		var page_id='403';
		var tkn='<%=empDtlReport.getString("tkn")%>';
		$.ajax({
				url : 'frmprtl',
				type : 'POST',
				contentType: 'application/json',
				data: JSON.stringify({erp_id: erp_id , role_id: role_id, emp_name: emp_name, designation: designation,
					office_code: office_code, role_name: role_name, auth: auth, page_id: page_id, tkn: tkn }),
				success : function(response) {
					alert(response);
					$('#contentFrame').html(response);
				},
				error : function(xhr, status, error) {
					console.error(xhr, status, error);
					$('#contentFrame').html('<p>Error loading page</p>');
				}
			});
		}
	
	function showTotal() {
		var erp_id='<%=empDtlReport.getString("erp_id")%>';
		var role_id='<%=empDtlReport.getString("role_id")%>';
		var emp_name='<%=empDtlReport.getString("emp_name")%>';
		var designation='<%=empDtlReport.getString("designation")%>';
		var office_code='<%=empDtlReport.getString("office_code")%>';
		var role_name='<%=empDtlReport.getString("role_name")%>';
		var auth='<%=empDtlReport.getString("auth")%>';
		var page_id='<%=empDtlReport.getString("page_id")%>';
		var tkn='<%=empDtlReport.getString("tkn")%>';
		$.ajax({
				url : 'frmprtl',
				type : 'POST',
				data: {erp_id: erp_id, role_id: role_id, emp_name: emp_name, designation: designation,
					office_code: office_code, role_name: role_name, auth: auth, page_id: '401', tkn: tkn},
				success : function(response) {
					alert(response);
					$('#contentFrame').html(response);
				},
				error : function(xhr, status, error) {
					console.error(xhr, status, error);
					$('#contentFrame').html('<p>Error loading page</p>');
				}
			});
		}
	

	</script>
</body>
</html>
