<!DOCTYPE html>
<html>
<head>
<title>Inspection Reporting Dashboard</title>
<link rel="stylesheet" type="text/css" href="css/jquery.dataTables.css">
<link rel="stylesheet" type="text/css"
	href="css/buttons.dataTables.min.css">
<script src="js/jquery-3.5.1.min.js"></script>
<link href="css/bootstrap_v4.5.2.min.css" rel="stylesheet">
<script type="text/javascript" charset="utf8"
	src="js/jquery.dataTables.js"></script>
<script type="text/javascript" charset="utf8"
	src="js/dataTables.buttons.min.js"></script>
<script src="js/popper.min.js"></script>
<script type="text/javascript" charset="utf8"
	src="js/buttons.html5.min.js"></script>
<script type="text/javascript" charset="utf8"
	src="js/buttons.print.min.js"></script>
<script type="text/javascript" charset="utf8" src="js/pdfmake.min.js"></script>
<script type="text/javascript" charset="utf8" src="js/vfs_fonts.js"></script>
<script type="text/javascript" charset="utf8" src="js/jszip.min.js"></script>
<!-- <link href="css/apexcharts_v3.35.3.css" rel="stylesheet"> -->
<link href="css/apexcharts_v3.50.css" rel="stylesheet">
<!--  <script src="js/apexcharts_v3.35.3.js"></script> -->
<script src="js/apexcharts_v3.50.js"></script>
<style>
body {
	display: flex;
	flex-direction: column;
	height: 100vh;
}

.main-content {
	flex: 1;
	margin-left: 100px; /* width of the sidebar */
	padding: 15px;
}

.clickable {
	cursor: pointer;
	color: blue;
	text-decoration: underline;
}

.loadsummary {
	cursor: pointer;
	color: green;
	text-decoration: underline;
}

.item {
	border: 1px solid #ccc;
	box-shadow: 2px 2px 12px rgba(0, 0, 0, 0.1);
	padding: 15px;
	margin: 10px 0;
	border-radius: 5px;
}

.field {
	margin-bottom: 5px;
}

.carousel-item img {
	max-height: 200px;
	object-fit: cover;
}

.table {
	border-collapse: collapse; /* Ensure borders collapse */
}

.table td, .table th {
	border: none; /* Remove cell borders */
}

td.mytd {
	font-size: 12px; /* Adjust the size as needed */
	padding: 5px;
}

.col-2-0 {
	flex: 0 0 16.66667%;
	max-width: 16.66667%;
}

@media ( max-width : 576px) {
	.col-2-0 {
		flex: 0 0 50%;
		max-width: 50%;
	}
}

@media ( min-width : 992px) {
	.fixed-height {
		height: 340px;
	}
}
.hidden-table {
            display: none;
        }
.print-button {
	margin: 20px;
	padding: 10px 20px;
	background-color: #4CAF50;
	color: white;
	border: none;
	cursor: pointer;
}
</style>
<script>
document.getElementById('expandBtn').addEventListener('click',
		function() {
			var sidebar = document.getElementById('sidebar');
			if (sidebar.classList.contains('active')) {
				sidebar.classList.remove('active');
				this.textContent = 'Reports';
			} else {
				sidebar.classList.add('active');
				this.textContent = 'Collapse';
			}
		});
</script>
<%@ page import="org.json.*, java.text.*, java.util.*,java.nio.charset.*, com.dcl.service.*"%>
</head>
<body>
	<div class="main-content">
		<div id="inspage" class="page">
			<%
// 			JSONObject reportDtl = new JSONObject();
			
// 			String encodedStr=(String)request.getSession().getAttribute("encodedString");
			
// 			if(encodedStr!=null && !encodedStr.isEmpty() && !encodedStr.equals("")){
// 				byte[] decodedByt = Base64.getDecoder().decode(encodedStr);
// 				String decodedStr=new String(decodedByt);
// 				reportDtl=new JSONObject(decodedStr);
// 			}else{
// 				request.getSession().invalidate();
// 				response.sendRedirect("/SafetyProject");
// 			}

	
		JSONObject reportDtl=new JSONObject();
// 		StringBuilder fullStr = new StringBuilder();
//         for (int i = 0; i < 10; i++) {
//             String part = (String) session.getAttribute("part" + i);
//             if (part != null) {
//             	fullStr.append(part);
//             }
//         }

//         // Handle any remaining part
//         String lastPartStr = (String) session.getAttribute("part10");
//         if (lastPartStr != null) {
//         	fullStr.append(lastPartStr);
//         }

//         String encodedStr=fullStr.toString();

String encodedStr=(String)request.getSession().getAttribute("encodedString");
        
        if(encodedStr!=null && !encodedStr.isEmpty() && !encodedStr.equals("")){
			byte[] decodedByt = Base64.getDecoder().decode(encodedStr);
			compressDecompressString decompString=new compressDecompressString();
			//String decodedStr=new String(decodedByt, StandardCharsets.UTF_8);
			//empDtlReport=new JSONObject(decodedString);
    	reportDtl = new JSONObject(decompString.decompressString(decodedByt));
		
    	JSONObject empdtlInspection = reportDtl;
			request.getSession().setAttribute("erp_id", empdtlInspection.getString("erp_id"));
			request.getSession().setAttribute("emp_name", empdtlInspection.getString("emp_name"));
			request.getSession().setAttribute("designation", empdtlInspection.getString("designation"));
			request.getSession().setAttribute("office_name", empdtlInspection.getString("office_name"));
			request.getSession().setAttribute("office_code", empdtlInspection.getString("office_code"));
			request.getSession().setAttribute("role_id", empdtlInspection.getString("role_id"));
			request.getSession().setAttribute("emp_office_level", empdtlInspection.getString("emp_office_level"));
			
			
				if (reportDtl.getString("emp_office_level").equalsIgnoreCase("HQ")) {
			%>
			<div class="row">
				<div class="col-lg-6 col-md-6 col-sm-12 col-12">
					<div id="info">
						<h2>Zone Wise Inspection Summary</h2>
						<p>Summary of the inspections assigned under Zonal offices.</p>
					</div>
					<div id="zonechart1" style="width: 100%; height: 400px;"></div>
				</div>
				<div class="col-lg-6 col-md-6 col-sm-12 col-12">
					<div id="info">
						<h2>Zone wise Inspection Outcome</h2>
						<p>Status summary of the vulnerabilities identified during the
							inspections till date.</p>
					</div>
					<div id="zonechart2" style="width: 100%; height: 400px;"></div>
				</div>
			</div>
<script type="text/javascript">
	
	var officeNames = [<%=reportDtl.getString("zonelistforchart")%>];
    var totalInspections = [<%=reportDtl.getString("chart1_total_no_of_inspection")%>];
    var inspectedVulnerabilities = [<%=reportDtl.getString("chart2_total_no_of_vulnerability")%>];
    var withheldVulnerabilities = [<%=reportDtl.getString("chart2_withheld_no_of_vulnerability")%>];
    var rectifiedVulnerabilities = [<%=reportDtl.getString("chart2_rectified_no_of_vulnerability")%>];
    var pendingVulnerabilities = [<%=reportDtl.getString("chart2_pending_no_of_vulnerability")%>];

    // Chart 1: Total Inspections
    var options1 = {
        series: [{
            name: 'Total Inspections',
            data: totalInspections
        }],
        chart: {
            type: 'bar',
            height: 350
        },
        title: {
            text: 'Total Inspections per Office'
        },
        xaxis: {
            categories: officeNames
        }
    };

    var chart1 = new ApexCharts(document.querySelector("#zonechart1"), options1);
    chart1.render();

    // Chart 2: Vulnerabilities
    var options2 = {
        series: [{
            name: 'Inspected',
            data: inspectedVulnerabilities
        }, {
            name: 'Rectified',
            data: rectifiedVulnerabilities
        }, {
            name: 'Withheld',
            data: withheldVulnerabilities
        }, {
            name: 'Pending',
            data: withheldVulnerabilities
        }],
        chart: {
            type: 'bar',
            height: 350
        },
        title: {
            text: 'Vulnerabilities per Office'
        },
        xaxis: {
            categories: officeNames
        }
    };

    var chart2 = new ApexCharts(document.querySelector("#zonechart2"), options2);
    chart2.render();
    
    </script>
    
			<div class="row table-responsive">
				<div class="col-lg-12 col-md-12 col-sm-12 col-12">
					<%=reportDtl.getString("zoneTableWholeData") %>
				</div>

			</div>

			<%
				}
			%>
<br />
			<%
			if(false){
			//	if (reportDtl.getString("emp_office_level").equalsIgnoreCase("HQ")
				//		|| reportDtl.getString("emp_office_level").equalsIgnoreCase("Zone")) {
					JSONArray listOfZone = reportDtl.getJSONArray("listOfZone");
					JSONArray listOfRegion = reportDtl.getJSONArray("listOfRegion");
					JSONObject regionwiselist=reportDtl.getJSONObject("regionwiselist");
					for (int i = 0; i < listOfZone.length(); i++) {
						JSONArray zonedtl=(JSONArray)listOfZone.get(i);
						String zonecode=zonedtl.getString(0);
						%>
						<div class="row table-responsive">
				<div class="col-lg-12 col-md-12 col-sm-12 col-12">
					<table id="<%=zonecode%>" class="table table-bordered table-striped  hidden-table"
						style="width: 100%; font-size: 12px;">
						<thead  class="thead-dark">
						<tr>
								<th colspan="11" class="table-title" style="text-align: center;">Inspection Summary Data for Regions under <%=zonedtl.getString(1) %></th>
							</tr>
							<tr>
								<th>Office Name</th>
								<th>No. of Inspection Programs</th>
								<th>Assigned Inspections</th>
								<th>Self Inspections</th>
								<th>Vulnerabilities identified</th>
								<th>Vulnerabilities rectified</th>
								<th>Vulnerabilities withheld</th>
								<th>Vulnerabilities pending</th>
								<th>Pending for 90 days</th>
								<th>Pending for 60 days</th>
								<th>Pending for 30 days</th>
							</tr>
						</thead>

						<tbody>
						<%
						for(int j=0; j < listOfRegion.length(); j++){
							JSONArray regiondtl=(JSONArray)listOfRegion.get(j);
							String regioncode=regiondtl.getString(0);
							if(regioncode.startsWith(zonecode.substring(0, 2))){
								JSONObject buffjsonobj=regionwiselist.getJSONObject(regioncode);
						%>
						<tr data-target="<%=buffjsonobj.getString("indv_office_code") %>">
								<td class="clickable"><%=buffjsonobj.getString("office") + " (" + buffjsonobj.getString("indv_office_code") + ")"%></td>
								<td><%=buffjsonobj.getInt("total_no_of_inspection")%></td>
								<td><%=buffjsonobj.getInt("assigned_inspection_count")%></td>
								<td><%=buffjsonobj.getInt("self_inspection_count")%></td>
								<td><%=buffjsonobj.getInt("total_no_of_vulnerability")%></td>
								<td><%=buffjsonobj.getInt("rectified_no_of_vulnerability")%></td>
								<td><%=buffjsonobj.getInt("withheld_no_of_vulnerability")%></td>
								<td><%=buffjsonobj.getInt("pending_no_of_vulnerability")%></td>
								<td><%=buffjsonobj.getInt("more_than_90")%></td>
								<td><%=buffjsonobj.getInt("more_than_60")%></td>
								<td><%=buffjsonobj.getInt("more_than_30")%></td>
							</tr>
						<%
							}
						}%>
						</tbody>
						</table>
						</div>
						</div>
		
						<%
					}%>
					<br />
					<%
				}
			%>
			
			<% 
			if(false){
		//	if(reportDtl.getString("emp_office_level").equalsIgnoreCase("HQ")
			//		|| reportDtl.getString("emp_office_level").equalsIgnoreCase("Zone")
				//	|| reportDtl.getString("emp_office_level").equalsIgnoreCase("Region")){ 
					JSONArray listOfRegion = reportDtl.getJSONArray("listOfRegion");
					JSONArray listOfDivision = reportDtl.getJSONArray("listOfDivision");
					JSONObject divisionwiselist=reportDtl.getJSONObject("divisionwiselist");
					for (int i = 0; i < listOfRegion.length(); i++) {
						JSONArray regiondtl=(JSONArray)listOfRegion.get(i);
						String regioncode=regiondtl.getString(0);
					%>
					<div class="row table-responsive">
				<div class="col-lg-12 col-md-12 col-sm-12 col-12">
					<table id="<%=regioncode%>" class="table table-bordered table-striped  hidden-table"
						style="width: 100%; font-size: 12px;">
						<thead  class="thead-dark">
						<tr>
								<th colspan="11" class="table-title" style="text-align: center;">Inspection Summary Data for Divisions under <%=regiondtl.getString(1) %></th>
							</tr>
							<tr>
								<th>Office Name</th>
								<th>No. of Inspection Programs</th>
								<th>Assigned Inspections</th>
								<th>Self Inspections</th>
								<th>Vulnerabilities identified</th>
								<th>Vulnerabilities rectified</th>
								<th>Vulnerabilities withheld</th>
								<th>Vulnerabilities pending</th>
								<th>Pending for 90 days</th>
								<th>Pending for 60 days</th>
								<th>Pending for 30 days</th>
							</tr>
						</thead>

						<tbody>
						<%
						for(int j=0; j < listOfDivision.length(); j++){
							JSONArray divisiondtl=(JSONArray)listOfDivision.get(j);
							String divisioncode=divisiondtl.getString(0);
							if(divisioncode.startsWith(regioncode.substring(0, 3))){
								JSONObject buffjsonobj=divisionwiselist.getJSONObject(divisioncode);
						%>
						<tr data-target="<%=buffjsonobj.getString("indv_office_code") %>">
								<td class="clickable"><%=buffjsonobj.getString("office") + " (" + buffjsonobj.getString("indv_office_code") + ")"%></td>
								<td><%=buffjsonobj.getInt("total_no_of_inspection")%></td>
								<td><%=buffjsonobj.getInt("assigned_inspection_count")%></td>
								<td><%=buffjsonobj.getInt("self_inspection_count")%></td>
								<td><%=buffjsonobj.getInt("total_no_of_vulnerability")%></td>
								<td><%=buffjsonobj.getInt("rectified_no_of_vulnerability")%></td>
								<td><%=buffjsonobj.getInt("withheld_no_of_vulnerability")%></td>
								<td><%=buffjsonobj.getInt("pending_no_of_vulnerability")%></td>
								<td><%=buffjsonobj.getInt("more_than_90")%></td>
								<td><%=buffjsonobj.getInt("more_than_60")%></td>
								<td><%=buffjsonobj.getInt("more_than_30")%></td>
							</tr>
						<%
							}
						}%>
						</tbody>
						</table>
						</div>
						</div>
		
			<% } 
			}%>
			
			<%
			if(false){
		//	if(reportDtl.getString("emp_office_level").equalsIgnoreCase("HQ")
			//		|| reportDtl.getString("emp_office_level").equalsIgnoreCase("Zone")
				//	|| reportDtl.getString("emp_office_level").equalsIgnoreCase("Region")
					//|| reportDtl.getString("emp_office_level").equalsIgnoreCase("Division")){
				JSONArray listOfDivision = reportDtl.getJSONArray("listOfDivision");
				JSONArray listOfCCC = reportDtl.getJSONArray("listOfCCC");
				JSONObject cccwiselist=reportDtl.getJSONObject("cccwiselist");
				for (int i = 0; i < listOfDivision.length(); i++) {
					JSONArray divisiondtl=(JSONArray)listOfDivision.get(i);
					String divisioncode=divisiondtl.getString(0);
			%>
			<div class="row table-responsive">
				<div class="col-lg-12 col-md-12 col-sm-12 col-12">
					<table id="<%=divisioncode%>" class="table table-bordered table-striped  hidden-table"
						style="width: 100%; font-size: 12px;">
						<thead  class="thead-dark">
						<tr>
								<th colspan="11" class="table-title" style="text-align: center;">Inspection Summary Data for CCCs under <%=divisiondtl.getString(1) %></th>
							</tr>
							<tr>
								<th>Office Name</th>
								<th>No. of Inspection Programs</th>
								<th>Assigned Inspections</th>
								<th>Self Inspections</th>
								<th>Vulnerabilities identified</th>
								<th>Vulnerabilities rectified</th>
								<th>Vulnerabilities withheld</th>
								<th>Vulnerabilities pending</th>
								<th>Pending for 90 days</th>
								<th>Pending for 60 days</th>
								<th>Pending for 30 days</th>
							</tr>
						</thead>
						<tbody>
						<% for(int j=0; j < listOfCCC.length(); j++){
							JSONArray cccdtl=(JSONArray)listOfCCC.get(j);
							String ccccode=cccdtl.getString(0);
							if(ccccode.startsWith(divisioncode.substring(0, 4))){
								JSONObject buffjsonobj=cccwiselist.getJSONObject(ccccode);%>
								<tr data-target="<%=buffjsonobj.getString("indv_office_code") %>">
								<td class="clickable"><%=buffjsonobj.getString("office") + " (" + buffjsonobj.getString("indv_office_code") + ")"%></td>
								<td><%=buffjsonobj.getInt("total_no_of_inspection")%></td>
								<td><%=buffjsonobj.getInt("assigned_inspection_count")%></td>
								<td><%=buffjsonobj.getInt("self_inspection_count")%></td>
								<td><%=buffjsonobj.getInt("total_no_of_vulnerability")%></td>
								<td><%=buffjsonobj.getInt("rectified_no_of_vulnerability")%></td>
								<td><%=buffjsonobj.getInt("withheld_no_of_vulnerability")%></td>
								<td><%=buffjsonobj.getInt("pending_no_of_vulnerability")%></td>
								<td><%=buffjsonobj.getInt("more_than_90")%></td>
								<td><%=buffjsonobj.getInt("more_than_60")%></td>
								<td><%=buffjsonobj.getInt("more_than_30")%></td>
							</tr>
						<% }
							}%>
						</tbody>
						</table>
						</div>
						</div>
		
			<% 
				}
			}
			}%>
			<div class="row">
				<div class="col-lg-6 col-md-6 col-sm-12 col-12">
				<a href="<%=reportDtl.getString("reportExcelFile") %>" class="btn btn-primary btn-block">
      Download Report in Excel Format
    </a>
				</div>
				</div>
			</div>
		</div>
	
    <script type="text/javascript">
    $(document).ready(function() {
        $('#zonetable').DataTable({
        	dom: 'Bfrtip',
            buttons: [

                {
                    extend: 'copyHtml5',
                    title: '<%=reportDtl.getString("inspChart1FileName")%>',
                    messageTop: 'Confidential document of WBSEDCL'
                },
                {
                    extend: 'csvHtml5',
                    title: '<%=reportDtl.getString("inspChart1FileName")%>',
                    messageTop: 'Confidential document of WBSEDCL'
                },
                {
                    extend: 'excelHtml5',
                    title: '<%=reportDtl.getString("inspChart1FileName")%>',
                    messageTop: 'Confidential document of WBSEDCL'
                },
                {
	                extend: 'pdfHtml5',
	                title: '<%=reportDtl.getString("inspChart1FileName")%>',
	                orientation: 'landscape', // Set the orientation to landscape
	                pageSize: 'LEGAL', // Set the page size to Legal
	                exportOptions: {
	                    columns: ':visible'
	                },
	                customize: function(doc) {
	                    // Add a new column for Sl. No.
	                    var body = doc.content[1].table.body;
	                    body[0].unshift({ text: 'Sl. No.', style: 'tableHeader', alignment: 'left' }); // Add header

	                    for (var i = 1; i < body.length; i++) {
	                        body[i].unshift({ text: i.toString(), style: 'tableBody' }); // Add row numbers
	                    }

	                    // Adjust column widths
	                    doc.content[1].table.widths = ['auto'].concat('*'.repeat(body[0].length - 1).split(''));

	                    // Lower the font size
	                    doc.styles.tableHeader.fontSize = 8; // Adjust the header font size
	                    doc.styles.tableBodyEven.fontSize = 8; // Adjust the body font size for even rows
	                    doc.styles.tableBodyOdd.fontSize = 8; // Adjust the body font size for odd rows

	                    // Match the style of other rows and columns
	                    var tableBody = doc.content[1].table.body;
	                    for (var i = 0; i < tableBody.length; i++) {
	                        var row = tableBody[i];
	                        for (var j = 0; j < row.length; j++) {
	                            if (i === 0) {
	                                row[j].fillColor = '#4d4d4d'; // Header background color (darker gray)
	                                row[j].fontSize = 8; // Header font size
	                                row[j].bold = true; // Header font weight
	                                row[j].alignment = 'left'; // Header text alignment
	                            } else {
	                                row[j].fillColor = (i % 2 === 0) ? '#ffffff' : '#e0f7fa'; // Alternating row background color (white and light blue)
	                                row[j].fontSize = 8; // Body font size
	                            }
	                        }
	                    }

	                    // Add footnote
	                    doc['footer'] = function(currentPage, pageCount) {
	                        return {
	                            columns: [
	                                { text: 'Confidential Document of WBSEDCL', alignment: 'left', fontSize: 8 },
	                                { text: 'Page ' + currentPage.toString() + ' of ' + pageCount, alignment: 'center', fontSize: 8 },
	                                { text: 'This is a system generated report and does not require any signature', alignment: 'right', fontSize: 8 }
	                            ],
	                            margin: [10, 0]
	                        };
	                    };
	                }
	            },
                {
                    extend: 'print',
                    title: '<%=reportDtl.getString("inspChart1FileName")%>',
                    messageTop: 'Confidential document of WBSEDCL'
                }
            
            ]
        	});
        
        $('#zonetable tbody').on('click', 'tr', function() {
            var targetTableId = $(this).data('target');
            $('.hidden-table').hide();
            $('#' + targetTableId).show();
        });
        
        $('body').on('click', '.hidden-table tbody tr', function() {
            var targetTableId = $(this).data('target');
            $('#' + targetTableId).show();
        });
        
    });
			
			
	</script>
</body>
</html>