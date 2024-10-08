/*function submitThisForm(){
	document.getElementById("inspectionForm").submit();
}
*/

function uploadImage() {
           var input = document.getElementById('imageInput');
           var file = input.files[0];

           if (!file) {
               alert('Please select an image file.');
               return;
           }

           // Validate file size (max 250 KB)
           if (file.size > 250 * 1024) {
               alert('File size must be less than 250 KB.');
               return;
           }

           // Validate file type
           var validTypes = ['image/jpeg', 'image/jpg', 'image/png'];
           if (!validTypes.includes(file.type)) {
               alert('Only JPG, JPEG, and PNG files are allowed.');
               return;
           }

		   
		   var reader = new FileReader();
		              reader.onload = function(event) {
		                  var base64String = event.target.result.split(',')[1]; // Get Base64 string
		                  document.getElementById('base64Output').value = base64String;
		              };
		              reader.readAsDataURL(file);
          
       }

$(document).ready(function() {
	var erpId=document.getElementById('erpId').value;
	alert(erpId);
	var pageLoadFlag='pageLoad';
		
	$.ajax({
		url: 'http://localhost:8080/MyWebApp/searchInspectionServlet',
							type: 'POST',
							contentType: 'application/json',
							data: JSON.stringify({
								"erpId": erpId,
								"pageLoadFlag": pageLoadFlag
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
					url: 'http://localhost:8080/MyWebApp/fetchProblemCodes',
					type: 'POST',
					contentType: 'application/json',
					data: JSON.stringify({
						"network_type": network_type,
						"asset_name": asset_name
					}),
					success: function(response) {
//						console.log("entered in success function");
//						console.log("Response received:", response);
//						let problemsArray = response.problems;
//						console.log("problemArray: ", problemsArray);
//						let descriptions = problemsArray.map(problem => problem.description);
//						console.log("Descriptions:", descriptions);
//						let problemSelect = $('#problem_list');
//						problemSelect.empty(); // Clear any existing options
//						descriptions.forEach(function(index, description) {
//							console.log(index,'  ',description);
//							problemSelect.append($('<option>', {
//								value: description ,
//								text: index
//							}));
//						});
//						console.log("exit in success function");
var dropdown = $('#problem_list');
                    dropdown.empty(); // Clear any existing options

                    // Assuming response is a JSON array
                    $.each(response.problems, function(index, item) {
						console.log("item.key: ", item.problem_id);
						console.log("item.value: ", item.description);
                        dropdown.append($('<option></option>').attr('value', item.problem_id).text(item.description));
                    });
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
			var problem_id= $('#problem_list').val();
			alert(problem_id);
			
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
				"problemId":problem_id//,  //integer
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


function populateDropdown(jsonArray) {
    var dropdown = $('#inspectionList');
    dropdown.empty(); // Clear existing options
    dropdown.append('<option selected="true" disabled selected hidden>Choose Option</option>');
    dropdown.prop('selectedIndex', 0);

    $.each(jsonArray, function(index, item) {
        dropdown.append($('<option></option>').attr('value', item).text(item));
    });
	
	$.each(jsonArray, function(index, item) {
		console.log(item.name);
		});
}		