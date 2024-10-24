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
<link href="css/apexcharts_v3.35.3.css" rel="stylesheet">
<script src="js/apexcharts_v3.35.3.js"></script>
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

.dataTables_length {
	float: left;
}

.dataTables_filter {
	float: right;
}

.dataTables_info {
	float: left;
	margin-left: 20px;
}

.dataTables_paginate {
	float: left;
	margin-right: 20px;
}

.custom-select {
	width: 100%;
	padding: 5px;
	border: 1px solid #ccc;
	border-radius: 4px;
	background-color: #f9f9f9;
	font-size: 14px;
}

.dataTables_wrapper .dataTables_paginate .paginate_button {
	padding: 5px 10px;
	margin: 2px;
	border: 1px solid #ddd;
	border-radius: 4px;
	background-color: #f9f9f9;
	color: #333;
	cursor: pointer;
}

.dataTables_wrapper .dataTables_paginate .paginate_button:hover {
	background-color: #e9e9e9;
	border-color: #ccc;
}

.dataTables_wrapper .dataTables_paginate .paginate_button.current {
	background-color: #007bff;
	border-color: #007bff;
	color: #fff;
}

.clickable {
	cursor: pointer;
	color: blue;
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
<%@ page import="org.json.*, java.text.*, java.util.*"%>
</head>
<body>
	<%
		JSONObject empdtlInspection=(JSONObject) request.getSession().getAttribute("empDtl");
	%>
	<%=empdtlInspection.toString() %>
	<%
		request.getSession().setAttribute("erp_id", empdtlInspection.getString("erp_id"));
		request.getSession().setAttribute("emp_name", empdtlInspection.getString("emp_name"));
		request.getSession().setAttribute("designation", empdtlInspection.getString("designation"));
		request.getSession().setAttribute("office_name", empdtlInspection.getString("office_name"));
		request.getSession().setAttribute("office_code", empdtlInspection.getString("office_code"));
		request.getSession().setAttribute("role_id", empdtlInspection.getString("role_id"));
		if(empdtlInspection.has("inspectionarray")){
	%>

	<div class="main-content">
		<div id="inspage" class="page">
			<div class="row">
				<div class="col-lg-6 col-md-6 col-sm-12 col-12">
					<div id="info">
						<h2>Office-Wise Inspection Summary</h2>
						<p>Summary of the inspections assigned to individual site
							offices.</p>
						<%

							JSONArray inspectionarray = empdtlInspection.getJSONArray("inspectionarray");

							String inspChart1FileName = empdtlInspection.getString("inspChart1FileName");

							String chartStrForAssignedInspection = empdtlInspection.getString("chartStrForAssigned");
							String chartStrForInspectedInspection = empdtlInspection.getString("chartStrForInspected");
							String chartStrForRectifiedInspection = empdtlInspection.getString("chartStrForRectified");
							String officeListForChartInspection = empdtlInspection.getString("officeListForChart");

							String chart2StrForVulnrIdentifiedInspection = empdtlInspection.getString("chart2StrForVulnrIdentified");
							String chart2StrForVulnrRectifiedInspection = empdtlInspection.getString("chart2StrForVulnrRectified");
						%>

					</div>
					<div id="inspchart1" style="width: 100%; height: 400px;"></div>
				</div>
				<div class="col-lg-6 col-md-6 col-sm-12 col-12">
					<div id="info">
						<h2>Inspection Outcome</h2>
						<p>Status summary of the vulnerabilities identified during the
							inspections till date.</p>
					</div>
					<div id="inspchart2" style="width: 100%; height: 400px;"></div>
				</div>
			</div>
			<div class="container justify-content-center">
				<div class="row">
					<div class="col-lg-3 col-md-3 col-sm-12 col-12">
						<button id="selectAllButton" class="print-button btn-lg btn-block">Select
							All Rows</button>
					</div>
					<div class="col-lg-3 col-md-3 col-sm-12 col-12">
						<button id="resetButton" class="print-button btn-lg btn-block">Reset
							Selections</button>
					</div>
					<div class="col-lg-3 col-md-3 col-sm-12 col-12">
						<button class="print-button btn-lg btn-block"
							onclick="printSelectedRows()">Print Selected Rows</button>
					</div>
				</div>
			</div>



			<div class="row">
				<div class="col-lg-12 col-md-12 col-sm-12 col-12">

					<table id="insptable" class="display"
						style="width: 100%; font-size: 12px;">
						<thead>
							<tr>
								<!-- 								<th>Select</th> -->
								<th>Insp.ID</th>
								<th>Month</th>
								<!-- 								<th>From</th> -->
								<!-- 								<th>To</th> -->
								<th>Schedule</th>
								<th>Assigned By</th>
								<th>Assigned On</th>
								<th>Assigned To</th>
								<th>Assigned Office</th>
								<th>Type</th>
								<th>Status</th>
								<th>Vulnerabilities</th>
								<th>Rectified</th>
								<!-- 								<th>Action</th> -->
							</tr>
						</thead>
						<tfoot>
							<tr>
								<!-- 								<th>Select</th> -->
								<th>Insp.ID</th>
								<th>Month</th>
								<!-- 								<th>From</th> -->
								<!-- 								<th>To</th> -->
								<th>Schedule</th>
								<th>Assigned By</th>
								<th>Assigned Date</th>
								<th>Assigned To</th>
								<th>Assigned Office</th>
								<th>Type</th>
								<th>Status</th>
								<th>Vulnerabilities</th>
								<th>Rectified</th>
								<!-- 								<th>Action</th> -->
							</tr>
						</tfoot>
						<tbody>
							<%
								for (int i = 0; i < inspectionarray.length(); i++) {
									JSONObject buffjsonObj = inspectionarray.getJSONObject(i);
							%>
							<tr>
								<td class="clickable" data-type="inspID"><%=(buffjsonObj.get("inspection_id").toString())%></td>
								<td><%=(buffjsonObj.get("month").toString())%></td>
								<td><%=(buffjsonObj.get("schedule").toString())%></td>
								<td><%=(buffjsonObj.get("emp_assigned_by").toString())%></td>
								<td><%=(buffjsonObj.get("assigned_date").toString())%></td>
								<td><%=(buffjsonObj.get("emp_assigned_to").toString())%></td>
								<td><%=(buffjsonObj.get("office_code_to_inspect").toString())%></td>
								<td><%=(buffjsonObj.get("office_type").toString())%></td>
								<td><%=(buffjsonObj.get("status").toString())%></td>
								<td><%=(buffjsonObj.get("vulnr").toString())%></td>
								<td><%=(buffjsonObj.get("rectified").toString())%></td>
							</tr>
							<%
								}
							%>
						</tbody>
					</table>
				</div>

			</div>
			<br />
			<div id="detailsDiv" style="display: none;"></div>

		</div>
	</div>


	<script>
	 
	var selectedRows = [];
	



document.addEventListener('DOMContentLoaded', function() {
    const mainTable = document.getElementById('insptable');
    const detailsDiv = document.getElementById('detailsDiv');
    //const detailsTable = document.getElementById('detailsTable');

    mainTable.addEventListener('click', function(event) {
        if (event.target.classList.contains('clickable')) {
            const type = event.target.getAttribute('data-type');
            const value = event.target.textContent;

            // Fetch data via AJAX based on the clicked cell
           // alert('type: '+type+' value: '+value);
            fetchDetails(type, value);
        }
    });

    
    function getRandomNumber(min, max) {
        return Math.random() * (max - min) + min;
    }

    
        function fetchDetails(type, value) {
        //	alert('type: '+type+' value: '+value);
        $.ajax({
            url: 'fetchVulnerabilityData', // Replace with your API endpoint
            method: 'POST',
            data: { type: type, value: value },
            dataType: 'json',
            success: function(data) {
//            	alert(data.vulnerabilityArray);
            	populateDetailsDiv(data.vulnerabilityArray);
            //	populateDetailsDiv(vulnerabilityArraydata);
                detailsDiv.style.display = 'block';
                detailsDiv.scrollIntoView({ behavior: 'smooth' });
            },
            error: function(xhr, status, error) {
                console.error('Error fetching data:', error);
            }
        });
    }

        function populateDetailsDiv(data) {
            const detailsDiv = document.getElementById('detailsDiv');
            detailsDiv.innerHTML = '';

            for (let i = 0; i < data.length; i++) {
                const row = data[i];
                const table = document.createElement('table');
                table.classList.add('table', 'table-bordered', 'shadow-lg', 'table-responsive');

                const tbody = document.createElement('tbody');

                const columns1 = [
                    'site_id', 'inspection_id', 'month', 'inspection_by', 'inspected_on',
                    'office_name', 'office_type'
                ];
                const columns2 = [
                    'longitude', 'latitude', 'network_type',
                    'asset_name', 'problem_type', 'present_status','severity'
                ];
                
                const columns1nme = [
                    'Site ID', 'Inspection ID', 'Calendar Month', 'Inspected By', 'Inspected On',
                    'Under', 'Office Type'
                ];
                const columns2nme = [
                    'Longitude', 'Latitude', 'Network Type',
                    'Asset Type', 'Problem', 'Status', 'Severity'
                ];

                for (let j = 0; j < columns1.length; j++) {
                    const tr = document.createElement('tr');

                    const td1 = document.createElement('td');
                    td1.classList.add('col-lg-1','col-md-1','col-sm-6','col-6', 'mytd');
                //    td1.id = 'row-${i}-col-${j}';
                    td1.style.fontWeight = 'bold';
                    td1.style.color = '#7997ba';
                    td1.textContent = columns1nme[j] + ' : ' ;
                    tr.appendChild(td1);
                    
                    const td2 = document.createElement('td');
                    td2.classList.add('col-lg-2','col-md-2','col-sm-6','col-6', 'mytd');
               //     td2.id = 'row-${i}-col2-${j}';
                    td2.textContent = (row[columns1[j]] !== undefined ? row[columns1[j]] : '');
                    tr.appendChild(td2);

                    const td3 = document.createElement('td');
                    td3.classList.add('col-lg-1','col-md-1','col-sm-6','col-6', 'mytd');
                   td3.style.fontWeight = 'bold';
                    td3.style.color = '#7d935e';
                    if (columns2[j] !== undefined) {
                        td3.textContent = columns2nme[j] + ' : ';
                    }
                    tr.appendChild(td3);
                    
                    const td4 = document.createElement('td');
                    td4.classList.add('col-lg-2','col-md-2','col-sm-6','col-6', 'mytd');
                    if (columns2[j] !== undefined) {
                        if (columns2[j] === 'severity') {
                            // Map severity values to labels
                            const severityMap = {
                                0: 'Low',
                                1: 'Medium',
                                2: 'High'
                            };
                            td4.textContent = severityMap[row[columns2[j]]] || '';
                        } else {
                            td4.textContent = (row[columns2[j]] !== undefined ? row[columns2[j]] : '');
                        }
                    }
                    tr.appendChild(td4);

                    // Add the third column for the images
                    if (j === 0) {
                        const td5 = document.createElement('td');
                        td5.classList.add('col-lg-3', 'col-md-3', 'col-sm-6', 'col-6');
                        td5.setAttribute('rowspan', columns1.length); // Span the entire height of the table

                        if (row.pre_image) {
                        //	alert(row.pre_image);
                            const preImageDiv = document.createElement('div');
                            const preImage = document.createElement('img');
                            preImage.classList.add('d-block', 'w-100', 'fixed-height');
                            preImage.src = "data:image/jpeg;base64," + row.pre_image;
                            preImage.alt = 'Pre Image';
                            preImageDiv.appendChild(preImage);

                            const preImageLabel = document.createElement('div');
                            preImageLabel.textContent = 'Inspected';
                            preImageLabel.style.textAlign = 'center';
                            preImageDiv.appendChild(preImageLabel);

                            td5.appendChild(preImageDiv);

                            // Add click event to open large image in a new tab
                            preImage.addEventListener('click', function() {
                                fetchLargeImage(row.pre_image_large);
                            });
                        }

                        tr.appendChild(td5);

                        const td6 = document.createElement('td');
                        td6.classList.add('col-lg-3', 'col-md-3', 'col-sm-6', 'col-6');
                        td6.setAttribute('rowspan', columns1.length); // Span the entire height of the table

                        if (row.post_image) {
                        //	alert(row.post_image);
                            const postImageDiv = document.createElement('div');
                            const postImage = document.createElement('img');
                            postImage.classList.add('d-block', 'w-100', 'fixed-height');
                            postImage.src = "data:image/jpeg;base64," + row.post_image;
                            postImage.alt = 'Post Image';
                            postImageDiv.appendChild(postImage);

                            const postImageLabel = document.createElement('div');
                            postImageLabel.textContent = 'Rectified';
                            postImageLabel.style.textAlign = 'center';
                            postImageDiv.appendChild(postImageLabel);

                            td6.appendChild(postImageDiv);

                            // Add click event to open large image in a new tab
                            postImage.addEventListener('click', function() {
                                fetchLargeImage(row.post_image_large);
                            });
                        }

                        tr.appendChild(td6);
                    }

                    tbody.appendChild(tr);
                }

                if (row.severity !== undefined) {
                    switch (row.severity) {
                        case 0: // Low
                            table.style.backgroundColor = '#d4edda'; 
                            break;
                        case 1: // Medium
                            table.style.backgroundColor = '#fff3cd'; 
                            break;
                        case 2: // High
                            table.style.backgroundColor = '#f8d7da'; 
                            break;
                        default:
                            table.style.backgroundColor = '#f8f9fa'; 
                    }
                }

                
                
                table.appendChild(tbody);
                detailsDiv.appendChild(table);
                

                
            }
        }
        
            // Add animation class to tables
            const tables = document.querySelectorAll('.table');
            console.log(tables); // Log the tables NodeList to verify

            function showTables() {
                const triggerBottom = window.innerHeight / 5 * 4;
                console.log('Trigger Bottom:', triggerBottom); // Log the triggerBottom value

                for (let i = 0; i < tables.length; i++) {
                    const table = tables[i];
                    const tableTop = table.getBoundingClientRect().top;
                    console.log('Table Top:', tableTop); // Log the tableTop value

                    if (tableTop < triggerBottom) {
                        table.classList.add('visible');
                    } else {
                        table.classList.remove('visible');
                    }
                }
            }

            window.addEventListener('scroll', showTables);
            showTables(); // Initial check
        

        function fetchLargeImage(imageId) {
            $.ajax({
                url: 'fetchImage', // Replace with your servlet URL
                method: 'POST',
                data: { imageId: imageId },
                success: function(response) {
              //  	alert(response.large_image);
                	const newTab = window.open();
                    newTab.document.write('<html><head><title>Large Image</title></head><body>');
                    newTab.document.write('<img src="data:image/jpeg;base64,' + response.large_image + '" alt="Large Image" class="d-block w-100 fixed-height">');
                    newTab.document.write('</body></html>');
                    newTab.document.close();
                },
                error: function(error) {
                    console.error('Error fetching large image:', error);
                }
            });
        }



  });


		
		$(document)
				.ready(
						function() {
							var table = $('#insptable')
									.DataTable(
											{
												dom : '<"top"Bf>rt<"bottom"ilp><"clear">',
												lengthMenu : [
														[ 10, 25, 50, -1 ],
														[ 10, 25, 50, "All" ] ],
												"columns" : [
													// { "visible": true },
									                    { "visible": true },
									                    { "visible": true },
									                    { "visible": true },
									                    { "visible": true },
									                    { "visible": true },
									                    { "visible": true },
									                    { "visible": true },
									                    { "visible": true },
									                    { "visible": true },
									                    { "visible": true },
									                    //{ "visible": true },
									                    { "visible": true } ],

												fixedColumns : {
													start : 2
												},
												layout : {
													topStart : {
														buttons : [ 'colvis' ]
													}
												},
												paging : false,
												scrollCollapse : true,
												scrollX : true,
												scrollY : 300,
												buttons : [
														{
															extend : 'copyHtml5',
															title : '<%=inspChart1FileName%>',
                    exportOptions: {
                        columns: ':visible'
                    }
                },
                {
                    extend: 'excelHtml5',
                    title: '<%=inspChart1FileName%>',
                    exportOptions: {
                        columns: ':visible'
                    }
                },
                {
                    extend: 'pdfHtml5',
                    title: '<%=inspChart1FileName%>',
                    orientation: 'landscape', // Set the orientation to landscape
                    pageSize: 'LEGAL', // Set the page size to Legal
                    exportOptions: {
                        columns: ':visible'
                    },
                    customize: function (doc) {
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
                   
                }
                ],
												columnDefs : [ {
													targets : [ 3, 4 ],
													visible : false
												} ],
												initComplete : function() {
													this
															.api()
															.columns()
															.every(
																	function() {
																		var column = this;

																		// Create select element
																		var select = document
																				.createElement('select');
																		select.className = 'custom-select';
																		select
																				.add(new Option(
																						''));
																		column
																				.footer()
																				.replaceChildren(
																						select);

																		// Apply listener for user change in value
																		select
																				.addEventListener(
																						'change',
																						function() {
																							column
																									.search(
																											select.value)
																									.draw();
																						});

																		// Add list of options
																		column
																				.data()
																				.unique()
																				.sort()
																				.each(
																						function(
																								d,
																								j) {
																							select
																									.add(new Option(
																											d));
																						});
																	});
												}
											});
							
							$('#selectAllButton').on('click', function() {
						        $('#insptable tbody tr').addClass('selected');
						        updateSelectedRows();
						    });
							
							$('#resetButton').on('click', function() {
						        $('#insptable tbody tr').removeClass('selected');
						        updateSelectedRows();
						    });
							
							var inspoptions1 = {
								series : [ {
									name : 'Total Assigned',
									data : [
	<%=chartStrForAssignedInspection%>
		]
								}, {
									name : 'Inspected',
									data : [
	<%=chartStrForInspectedInspection%>
		]
								}, {
									name : 'Rectified',
									data : [
	<%=chartStrForRectifiedInspection%>
		]
								} ],
								chart : {
									type : 'bar',
									stacked : false,
									height : 350
								},
								plotOptions : {
									bar : {
										horizontal : false,
										columnWidth : '55%',
										endingShape : 'rounded'
									}
								},
								dataLabels : {
									enabled : true
								},
								stroke : {
									show : true,
									width : 2,
									colors : [ 'transparent' ]
								},
								xaxis : {
									categories : [
	<%=officeListForChartInspection%>
		], labels: {
		    offsetX: 0,
		    offsetY: 0
		  },rotate: 0
								},
								yaxis : {
									title : {
										text : 'Number'
									}
								},
								fill : {
									opacity : 1
								},
								tooltip : {
									y : {
										formatter : function(val) {
											return val + " Nos."
										}
									}
								}
							};

							var inspchart1 = new ApexCharts(document
									.querySelector("#inspchart1"), inspoptions1);
							inspchart1.render();

							function updateChart1() {
								var data = table.rows({
									search : 'applied'
								}).data().toArray();
								
								updateSelectedRows();
								
								var positionCounts = {};

								data.forEach(function(row) {
								//	var position = row[7]; // Position
									var position = row[6];
									if (positionCounts[position]) {
										positionCounts[position]++;
									} else {
										positionCounts[position] = 1;
									}
								});

								var categories = Object.keys(positionCounts);
								var values = Object.values(positionCounts);

								inspchart1.updateSeries([ {
									data : values
								} ]);
								inspchart1.updateOptions({
									chart : {
										height : 350
									},
									xaxis : {
										categories : categories
									}
								});
								
							//	alert("data: "+data);
								
								updateChart2(data);

							}

							table.on('draw', function() {
								var selectedData = table.rows({
									search : 'applied'
								}).data().toArray();
								$(this).toggleClass('selected');
								updateChart1();

							});

							updateSelectedRows();
							
							$('#insptable tbody').on('click', 'tr', function() {
								var selectedData = table.rows({
									search : 'applied'
								}).data().toArray();
								$(this).toggleClass('selected');
							//	updateChart1();
								updateSelectedRows();
							});
							
							
							updateChart1(); // Initial chart update

							function updateChart2(selectedData) {
								var jsonArray = JSON.stringify(selectedData);
						//		alert("jsonArray: "+jsonArray);
								console.log("jsonArray: "+jsonArray);
								$.ajax({
									url : 'updateInspChart',
									type : 'POST',
									contentType : 'application/json',
									data : jsonArray,
									success : function(response) {
										$('#inspchart2').html(response);
									},
									error : function(xhr, status, error) {
										console.error('Error fetching data:',
												error);
									}
								});
							}
							
						});

		function showPage(pageId) {
			$('.page').hide();
			$('#' + pageId).show();
		}
		
function updateSelectedRows() {
    selectedRows = [];
    $('#insptable tbody tr.selected').each(function(index) {
        var $row = $(this);
        var rowHtml = '<tr><td>' + (index + 1) + '</td>'; // Add serial number
        $row.children('td').each(function(tdIndex) {
            rowHtml += '<td>' + $(this).html() + '</td>';
        });
        rowHtml += '</tr>';
        selectedRows.push(rowHtml);
    });
    console.log('Selected Rows:', selectedRows); // Debugging: Check selected rows
}

function printSelectedRows() {
	updateSelectedRows();
    if (selectedRows.length > 0) {
        var newWindow = window.open('', '', 'width=800, height=600');
        newWindow.document.write('<html><head><title>Print Selected Rows</title>');
        newWindow.document.write('<style>');
        newWindow.document.write('table { border-collapse: collapse; width: 100%; }');
        newWindow.document.write('th, td { border: 1px solid black; padding: 8px; text-align: left; }');
        newWindow.document.write('tr:nth-child(even) { background-color: #f2f2f2; }'); // Color alternate rows
        newWindow.document.write('tr:nth-child(odd) { background-color: #ffffff; }'); // Ensure odd rows are white
        newWindow.document.write('</style>');
        newWindow.document.write('</head><body>');
        newWindow.document.write('<header><h3>Confidential Document of WBSEDCL. File Name: <%=inspChart1FileName%></h3></header>'); // Custom header
        newWindow.document.write('<table><thead><tr><th>Sl. No.</th><th>Insp.ID</th><th>Month</th><th>Schedule</th><th>By</th><th>Assigned On</th><th>Assigned To</th><th>Assigned Office</th><th>Type</th><th>Status</th><th>Vulnerabilities</th><th>Rectified</th></tr></thead><tbody>' + selectedRows.join('') + '</tbody></table>');
        newWindow.document.write('<footer><div style="text-align: center; font-weight: bold;">Confidential Document of WBSEDCL</div><br /><div style="text-align: right; font-weight: bold;">This is a system generated report and does not require any signature</div></footer>'); // Custom footer
        newWindow.document.write('</body></html>');
        newWindow.document.close();
        newWindow.print();
    } else {
        alert('No rows selected!');
    }
}



	</script>
	<% }else{ %>
	No data
	<%} %>
</body>
</html>