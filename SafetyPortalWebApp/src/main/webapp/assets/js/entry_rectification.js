$(document).ready(function() {
	var erpId=document.getElementById('erpId').value;
	alert(erpId);
		
	$.ajax({
		url: 'searchInspectionServlet',
							type: 'POST',
							contentType: 'application/json',
							data: JSON.stringify({
								"erpId": erpId
							}),
							success: function(response) {
								console.log(response);
								const jsonObject = JSON.parse(response);
								console.log(jsonObject.inspectionIdList);
								var jsonArray = jsonObject.inspectionIdList;
								alert(JSON.stringify(jsonArray)); 
								populateDropdown(jsonArray);
							},
							error: function(xhr, status, error) {
								
								console.error(xhr,status, error);
							}
	})
	
	$('#submitBtn').on('click', function() {

		function disableMouseInteraction(className) {
			var elements = document.querySelectorAll('.' + className);
			elements.forEach(function(element) {
				element.style.pointerEvents = 'none';
			});
		}
		if ($('#submitBtn').text() === 'NEXT') {
			// Collect values from the input fields
			var network_type = $('#network_type').val();
			var asset_name = $('#asset_type').val();
			jsonString = JSON.stringify({
				"network_type": network_type,
				"asset_name": asset_name
			}),

				$.ajax({
					url: 'fetchProblemCodes',
					type: 'POST',
					contentType: 'application/json',
					data: JSON.stringify({
						"network_type": network_type,
						"asset_name": asset_name
					}),
					success: function(response) {
						console.log("entered in success function");
						console.log("Response received:", response);
						let problemsArray = response.problems;
						console.log("problemArray: ", problemsArray);
						let descriptions = problemsArray.map(problem => problem.description);
						console.log("Descriptions:", descriptions);
						let problemSelect = $('#problem_list');
						problemSelect.empty(); // Clear any existing options
						descriptions.forEach(function(description) {
							problemSelect.append($('<option>', {
								value: description,
								text: description
							}));
						});
						console.log("exit in success function");
					},
					error: function(xhr, status, error) {
						console.log("Error fetching problem codes.");
						console.error('Error:', error);
					}
				});
			console.log("outside of ")
			disableMouseInteraction('initial-section');
			$('#additionalSection').show(); // Show additional sections
			$('#submitBtn').text('SUBMIT'); // Change button text to 'SUBMIT'
			isNextClicked = true; // Update flag
		} else {
			//var inspection_id = $('#inspection_id').val();
			var inspection_id = $('#inspectionList').val();
			var location_remarks = $('#location').val();
			var problem_details = $('#problem_details').val();
			var assigned_office_code = $('#office_name').val();
			var inspection_date = $('#inspection_date').val();
			var image1= $('#base64Output').val(); 
			var inspectionBy= $('#erpId').val();

			var jsonObj = {
				"inspectionId": inspection_id,
				"locationRemarks": location_remarks,
				"problemRemarks": problem_details,
				"assignedOfficeCode": assigned_office_code,
				"inspectionDate": inspection_date,
				"preImage": image1,
				"ServType": 102,  //integer
				"latitude": 88.32, //double
				"longitude": 132.12, //double
				"gisId": "NA",
				"siteId": "NA",
				"presentStatus": "INSPECTED",
				"pageNm": "DASH",
				"inspectionBy":inspectionBy,  //to be fetched from session variable
				"problemId":14//,  //integer
				//"empDtls":JSON.parse(empDtls)
			};
			alert("inspectionBy: ", inspectionBy);
			alert("base64String: ", image1);
			alert("jsonobj: ", jsonObj);

			$.ajax({
				url: 'http://10.251.37.170:8080/testSafety/testSafety',
				//url: 'http://localhost:8080/MyWebApp/entryInspectionServlet', // replace with above Servlet URL
				type: 'POST',
				//contentType: 'application/json',
				data: JSON.stringify(jsonObj),
				success: function(response) {
					console.log(response);
					console.log("successful conn");
				},
				error: function(xhr, status, error) {
					console.log(xhr, status, error);
				}
			});
		}
		});
});