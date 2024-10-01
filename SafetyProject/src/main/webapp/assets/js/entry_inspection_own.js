var KEY1 = bigInt("10953483997285864814773860729");
var KEY2 = bigInt("37997636186218092599949125647");

var url = "http://10.251.37.170:8080/testSafety/testSafety";
var xUidEncrypted = "";
var dUidEncrypted = "";
var xUidJson = {};
var btn = document.createElement('button');

function enCrypt(uid, pwd) {
	var uidConver = [];
	var pwdConver = [];
	var enIden = [];
	var enAuth = [];
	var enIdCon = "";
	var enAuthCon = "";
	var jsonObj = {};

	for (var i = 0; i < uid.length; i++) {
		uidConver[i] = uid.charCodeAt(i);
		var bigtemp = bigInt(uidConver[i]);
		enIden[i] = bigInt(uidConver[i]).modPow(KEY1, KEY2).toString(16);
		enIdCon = enIdCon.concat(enIden[i]);
		if (i != (uid.length - 1)) {
			enIdCon = enIdCon.concat("@");
		}
	}
	for (var i = 0; i < pwd.length; i++) {
		pwdConver[i] = pwd.charCodeAt(i);
		enAuth[i] = bigInt(pwdConver[i]).modPow(KEY1, KEY2).toString(16);
		enAuthCon = enAuthCon.concat(enAuth[i]);
		if (i != (pwd.length - 1)) {
			enAuthCon = enAuthCon.concat("?");
		}
	}


	jsonObj = {
		"User": enIdCon,
		"Pwd": enAuthCon
	};

	return jsonObj;
}

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

function setCookie(name, value, minutes) {
	//value passed as object
	let expires = "";
	if (minutes) {
		const date = new Date();
		date.setTime(date.getTime() + (minutes * 60 * 1000));
		expires = "; expires=" + date.toUTCString();
	}
	document.cookie = name + "=" + (value || "") + expires + "; path=/";
}

function getCookie(name) {
	const nameEQ = name + "=";
	const ca = document.cookie.split(';');
	for (let i = 0; i < ca.length; i++) {
		let c = ca[i];
		while (c.charAt(0) === ' ') c = c.substring(1, c.length);
		if (c.indexOf(nameEQ) === 0) {
			return c.substring(nameEQ.length, c.length);
		}
	}
	return null;
}

function populateDateDropdown(startDateStr, endDateStr) {
	// Parse the input dates
	const startDate = new Date(startDateStr);
	const endDate = new Date(endDateStr);

	// Get the dropdown element
	const dropdown = document.getElementById('dateDropdown');

	// Clear the previous options if any
	dropdown.innerHTML = 'Select Inspection Date';

	const defaultOption = document.createElement('option');
	defaultOption.value = '';
	defaultOption.textContent = 'Select Inspection Date';
	defaultOption.disabled = true; // Make it non-selectable
	defaultOption.selected = true; // Make it selected by default
	dropdown.appendChild(defaultOption);

	// Iterate over the range of dates
	for (let date = startDate; date <= endDate; date.setDate(date.getDate() + 1)) {
		// Create an option element
		const option = document.createElement('option');

		// Format the date to yyyy-mm-dd
		const formattedDate = date.toISOString().split('T')[0];
		option.value = formattedDate;
		option.textContent = formattedDate;

		// Append the option to the dropdown
		dropdown.appendChild(option);
	}
}


$(document).ready(function() {

	$('#resultsContainer').hide();
	$('#additionalSection1').show();
	$('#inspSubmitBtn').show();
	// Initially disable the submit button
	$('#inspSubmitBtn').prop('disabled', true);

	let dataFromDate = new Date();
	let dataEndDate = new Date();
	dataFromDate.setDate(dataFromDate.getDate() - 7);
	populateDateDropdown(dataFromDate, dataEndDate);
	$('#inspection_id').val('SUO_MOTO_INSP');
	$('#inspection_id').prop('disabled', true);


	// Function to check if all fields are valid
	function checkFormValidity() {
		var inspectionDate = $('#dateDropdown').val();
		var location = $('#location').val();
		var image = $('#base64Output').val();
		var networkType = $('#network_type').val();
		var assetType = $('#asset_type').val();
		var asset_name = $('#asset_type').val();

		if (location.length < 10 || location.length > 50) {
			alert("Location should be at least 10 characters and at most 50 characters");
			location = false;
		}

		// Check if all fields are non-empty
		if (inspectionDate && location && image && networkType && assetType) {
			/*$('#inspSubmitBtn').prop('disabled', false);  // Enable the button*/
			let assetList = JSON.parse(getCookie("assetList"));
			if (assetList[networkType + asset_name] === undefined) {
				alert(`No problems found in ${networkType} network and ${asset_name} asset combination`);
				$('#inspSubmitBtn').prop('disabled', true);   // Keep it disabled
			}
			else {
				$('#inspSubmitBtn').prop('disabled', false);  // Enable the button
			}
		} else {
			$('#inspSubmitBtn').prop('disabled', true);   // Keep it disabled
		}
	}

	// Attach event listeners to form fields
	$('#dateDropdown').on('change', checkFormValidity);
	$('#location').on('input', checkFormValidity);
	$('#network_type').on('change', checkFormValidity);
	$('#asset_type').on('change', checkFormValidity);

	// For image upload, trigger the check when the image is uploaded
	$('#imageInput').on('change', function() {
		uploadImage();  // Call the existing uploadImage function
		checkFormValidity();  // Check form validity
	});

	const problemList = document.getElementById("problem_list");
	const difficultyRadios = document.getElementsByName("difficulty");
	const officeNameSelect = document.getElementById("office_name");
	const submitButton = document.getElementById("inspSubmitBtn");

	// Function to check if at least one problem is selected
	function isProblemSelected() {
		return problemList.children.length > 0;
	}

	function isDifficultySelected() {
		return Array.from(difficultyRadios).some(radio => radio.checked);
	}

	function isOfficeSelected() {
		return officeNameSelect.value !== "Select Office";
	}

	// Function to enable or disable the button
	function updateButtonState() {
		if (isProblemSelected() && isDifficultySelected() && isOfficeSelected()) {
			submitButton.disabled = false;
		} else {
			submitButton.disabled = true;
		}
	}

	// Observe changes in the problem list using MutationObserver
	const observer = new MutationObserver(updateButtonState);
	observer.observe(problemList, { childList: true, subtree: true });

	// Event listeners for other form fields
	Array.from(difficultyRadios).forEach(radio =>
		radio.addEventListener("change", updateButtonState)
	); // For radio button changes
	officeNameSelect.addEventListener("change", updateButtonState); // For office selection changes

	// Initially call the updateButtonState function in case the fields are already filled
	updateButtonState();

	/*	var jsonObjectInput = {};
		jsonObjectInput.pageNm = "DASH";
		jsonObjectInput.ServType = "202";
		var cookieData = JSON.parse(getCookie('empDtls'));
		var tkn = getCookie('tkn');
		var xUid = getCookie("User");
		var costCenter = cookieData.empDtls.KST01CL;
		xUidJson = enCrypt(xUid, "123456");
		xUidEncrypted = xUidJson.User;
		dUidEncrypted = xUidJson.Pwd;
		jsonObjectInput.xUid = xUidEncrypted;
		jsonObjectInput.dUid = dUidEncrypted;
		jsonObjectInput.tkn = tkn;
		jsonObjectInput["KST01CL"] = costCenter;
		$.ajax({
			url: url,
			type: 'POST',
			data: JSON.stringify(jsonObjectInput),
			success: function(response) {
				var empList = response.assignEmpDtls.assignList;
				var newToken = response.tkn;
				setCookie("tkn", newToken, 30);
				if (response.ackMsgCode === "202") {
					// Hide the no data alert and show the table
					$('#noDataAlert').hide();
					$('#tableContainer').show();
					populateTable(empList);
				} else {
					// Hide the table and show the no data alert
					$('#tableContainer').hide();
					$('#noDataAlert').show().text("No inspection task pending at you to show.");
				}
			}
		});*/

	$('#inspSubmitBtn, #inspSubmitBtn2').on('click', function() {
		function disableMouseInteraction(className) {
			var elements = document.querySelectorAll('.' + className);
			elements.forEach(function(element) {
				element.style.pointerEvents = 'none';
			});
		}
		if ($('#inspSubmitBtn').text() === 'NEXT') {
			// Collect values from the input fields
			var network_type = $('#network_type').val();
			var asset_name = $('#asset_type').val();
			var cookieData = JSON.parse(getCookie('empDtls'));
			var tkn = getCookie('tkn');
			var xUid = getCookie("User");
			var costCenter = cookieData.empDtls.KST01CL;
			//var costCenter = cookieData.empDtls.KST01CL;
			xUidJson = enCrypt(xUid, "123456");
			xUidEncrypted = xUidJson.User;
			dUidEncrypted = xUidJson.Pwd;
			let assetList = JSON.parse(getCookie("assetList"));

			var jsonObj = {
				"network_type": network_type,
				"pageNm": "DASH",
				"ServType": "203",
				"tkn": tkn,
				"xUid": xUidEncrypted,
				"dUid": dUidEncrypted,
				"KST01CL": costCenter,
				"office_code_to_inspect": costCenter,
				"assetId": assetList[network_type + asset_name]
			};
			//var jsonString = JSON.stringify(jsonObj);
			console.log("request: " + JSON.stringify(jsonObj));
			$.ajax({
				type: 'POST',
				url: url,
				data: JSON.stringify(jsonObj),
				success: function(response) {
					console.log("response: " + JSON.stringify(response));
					var problemContainer = $('#problem_list');
					problemContainer.empty(); // Clear any existing options

					// Assuming response is a JSON array
					// Iterate over the problems in the response
					$.each(response.probDtls.probDtls, function(index, item) {
						// Create a new row for each problem
						var row = $('<div></div>').addClass('row form-row');

						// Create a column for the checkbox
						var checkboxCol = $('<div></div>').addClass('col-sm-6 form-group');
						var checkbox = $('<input>').attr({
							type: 'checkbox',
							id: 'problem_' + item.probId,
							name: 'problem_list',
							value: item.probId,
							'data-description': item.probDesc  // Store problem description
						});

						// Create label with space and style to match the input placeholder
						var checkboxLabel = $('<label></label>')
							.attr('for', 'problem_' + item.probId)
							.css({
								'margin-left': '10px',
								'font-size': '20px',
								'font-family': 'inherit'
							})
							.text(item.probDesc);

						// Append checkbox and label to the column
						checkboxCol.append(checkbox, checkboxLabel);

						// Create a column for the corresponding problem details input field with a placeholder
						var inputCol = $('<div></div>').addClass('col-sm-6 form-group');
						var input = $('<input>').attr({
							type: 'text',
							class: 'form-control',
							id: 'problem_details_' + item.probId,
							name: 'problem_details_' + item.probId,
							placeholder: 'Detailed Problem',
							//disabled: true // Initially disable the input field
							style: 'display: none;' // Hide the input field initially
						});
						inputCol.append(input);

						// Add an event listener to the checkbox to toggle the input field
						checkbox.on('change', function() {
							if (this.checked) {
								//input.prop('disabled', false); // Enable input if checkbox is checked
								input.show();
							} else {
								//input.prop('disabled', true); // Disable input if checkbox is unchecked
								input.hide();
							}
						});

						// Append both columns to the row
						row.append(checkboxCol, inputCol);

						// Append the row to the container
						problemContainer.append(row);
					});


					/*//populate problem dropdown
					var dropdown = $('#problem_list');
					dropdown.empty(); // Clear any existing options

					// Assuming response is a JSON array
					$.each(response.probDtls.probDtls, function(index, item) {
						dropdown.append($('<option></option>').attr('value', item.probId).text(item.probDesc));
					});*/

					//populate office dropdown
					var dropdown = $('#office_name');
					dropdown.empty(); // Clear any existing options
					// Assuming response is a JSON array
					dropdown.append($('<option></option>').attr('value', "Select Office").text("Select Office"));
					$.each(response.rectifyOfficeDtls.officeList, function(index, item) {
						dropdown.append($('<option></option>').attr('value', item.offCode).text(item.offName));
					});

					setCookie("tkn", response.tkn, 30);
				},
				error: function(xhr, status, error) {
					setCookie("tkn", response.tkn, 30);
					console.log(`xhr: ${JSON.stringify(xhr)}\nstatus: ${status}\nerror: ${error}`);
				}
			});
			disableMouseInteraction('initial-section');
			$('#additionalSection2').show(); // Show additional sections
			$('#inspSubmitBtn').text('SUBMIT'); // Change button text to 'SUBMIT'
			isNextClicked = true; // Update flag
		}
		else if ($('#inspSubmitBtn').text() === 'SUBMIT') {
			// Populate the modal with the entered data
			$('#confirmInspectionId').text($('#inspection_id').val());
			$('#confirmLocationRemarks').text($('#location').val());
			//$('#confirmProblemDetails').text($('#problem_details').val());  // Modify for multiple problems
			$('#confirmAssignedOffice').text($('#office_name').val());
			$('#confirmAssignedOffice').text($('#office_name option:selected').text());
			$('#confirmInspectionDate').text($('#dateDropdown').val());
			$('#confirmSeverityLevel').text($('input[name="difficulty"]:checked').val());

			var problemDetailsArray = [];
			$('#problem_list input[type="checkbox"]:checked').each(function() {
				var problemDesc = $(this).data('description');  // Get the problem description from the data attribute
				var problemDetails = $('#problem_details_' + $(this).val()).val();  // Get the corresponding problem details
				problemDetailsArray.push(`<strong>Problem:</strong> ${problemDesc}, <strong>Details:</strong> ${problemDetails || "none"}`);
			});
			let probString = "";

			problemDetailsArray.forEach((item, index, arr) => {
				probString += `<br>${index + 1}. ${item}`;
			})
			// Join all problem descriptions and details into a single string to display in the modal
			//$('#confirmProblemDetails').text(problemDetailsArray.join(' , ').trim(",").trim());
			//$('#confirmProblemDetails').text(probString);

			$('#confirmProblemDetails').html(probString);

			// Show the modal
			$('#confirmationModal').modal('show');
		}
		/*
				$('#finalSubmitBtn').on('click', function() {
					// Proceed with the AJAX submission
					var inspection_id = $('#inspection_id').val();
					var location_remarks = $('#location').val();
					var assigned_office_code = $('#office_name').val();
					var inspection_date = $('#dateDropdown').val();
					var image1 = $('#base64Output').val();
					var inspectionBy = $('#erpId').val();
					jsonObjectInput.pageNm = "DASH";
					jsonObjectInput.ServType = "202";
					var cookieData = JSON.parse(getCookie('empDtls'));
					var tkn = getCookie('tkn');
					var xUid = cookieData.xUid;
					xUidJson = enCrypt(xUid, "123456");
					xUidEncrypted = xUidJson.User;
					dUidEncrypted = xUidJson.Pwd;
					var costCenter = cookieData.empDtls.KST01CL;
					var inspectionBy = cookieData.xUid.slice(0, 8);
					var severityLevel = $('input[name="difficulty"]:checked').val();
					alert("severity: " + severityLevel);
		
					// Create an array to store selected problem IDs and details
					var problemsArray = [];
		
					// Iterate over each checked checkbox
					$('#problem_list input[type="checkbox"]:checked').each(function() {
						var problemId = $(this).val();  // Get the problem ID from the checkbox
						var problemDetails = $('#problem_details_' + problemId).val();  // Get the corresponding problem details
						problemsArray.push({
							"problemId": problemId,
							"problemRemarks": problemDetails
						});
					});
		
					var jsonObjInput = {
						"inspectionId": inspection_id,
						"locationRemarks": location_remarks,
						//"problemRemarks": problem_details,
						"assignedOfficeCode": assigned_office_code,
						"inspectionDate": inspection_date,
						"preImage": image1,
						"ServType": "102",  //integer
						"latitude": 0.0, //double
						"longitude": 0.0, //double
						"gisId": "NA",
						"siteId": "NA",
						"presentStatus": "INSPECTED",
						"pageNm": "DASH",
						"inspectionBy": inspectionBy,  //to be fetched from session variable
						//"problemId": problem_id,  //integer
						//"empDtls":JSON.parse(empDtls)
						"problems": problemsArray,  // Array of problem IDs and details
						"tkn": tkn,
						"xUid": xUidEncrypted,
						"dUid": dUidEncrypted,
						"KST01CL": costCenter,
						"severityLevel": severityLevel
					};
		
					$.ajax({
						url: 'http://10.251.37.170:8080/testSafety/testSafety',
						//url: 'http://localhost:8080/MyWebApp/entryInspectionServlet', // replace with above Servlet URL
						type: 'POST',
						//contentType: 'application/json',
						data: JSON.stringify(jsonObjInput),
						success: function(response) {
							var newToken = response.tkn;
							setCookie("tkn", newToken, 30);
							if (response.ackMsgCode === "102") {
								alert(`${response.ackMsg}\nwith Site Id: ${response.siteId}\nagainst Inspection Id: ${inspection_id}.`);
								window.location.href = 'new_inspection.jsp';
							}
						},
						error: function(xhr, status, error) {
							console.log(`xhr: ${JSON.stringify(xhr)}\nstatus: ${status}\nerror: ${error}`);
						}
					});
				});*/
	});



	$('#finalSubmitBtn').on('click', function() {
		// Proceed with the AJAX submission 
		var xUid = getCookie("User");
		xUidJson = enCrypt(xUid, "123456");
		xUidEncrypted = xUidJson.User;
		dUidEncrypted = xUidJson.Pwd;
		var severityLevel = $('input[name="difficulty"]:checked').val();

		// Create an array to store selected problem IDs and details
		var problemsArray = [];

		// Iterate over each checked checkbox
		$('#problem_list input[type="checkbox"]:checked').each(function() {
			var problemId = $(this).val();  // Get the problem ID from the checkbox
			var problemDetails = $('#problem_details_' + problemId).val();  // Get the corresponding problem details
			problemsArray.push({
				"problemId": problemId,
				"problemRemarks": problemDetails
			});
		});

		var jsonObjInput = {
			"inspectionId": $('#inspection_id').val(),
			"locationRemarks": $('#location').val(),
			//"problemRemarks": problem_details,
			"assignedOfficeCode": $('#office_name').val(),
			"inspectionDate": $('#dateDropdown').val(),
			"preImage": $('#base64Output').val(),
			"ServType": "102",  //integer
			"latitude": 0.0, //double
			"longitude": 0.0, //double
			"gisId": "NA",
			"siteId": "NA",
			"presentStatus": "INSPECTED",
			"pageNm": "DASH",
			"inspectionBy": getCookie("User"),  //to be fetched from session variable
			//"problemId": problem_id,  //integer
			//"empDtls":JSON.parse(empDtls)
			"problems": problemsArray,  // Array of problem IDs and details
			"tkn": getCookie('tkn'),
			"xUid": xUidEncrypted,
			"dUid": dUidEncrypted,
			"KST01CL": getCookie("costCenter"),
			"severityLevel": severityLevel
		};

		$.ajax({
			url: 'http://10.251.37.170:8080/testSafety/testSafety',
			//url: 'http://localhost:8080/MyWebApp/entryInspectionServlet', // replace with above Servlet URL
			type: 'POST',
			//contentType: 'application/json',
			data: JSON.stringify(jsonObjInput),
			success: function(response) {
				setCookie("tkn", response.tkn, 30);
				if (response.ackMsgCode === "102") {
					alert(`${response.ackMsg} with Inspection Id ${response.inspectionId}`);
					window.location.href = 'new_inspection_own.jsp';
					console.log("response: " + JSON.stringify(response));
				}
				else {
					alert(`ERROR!! ${response.ackMsg}\nagainst Inspection Id: ${inspection_id}.`);
				}
			},
			error: function(xhr, status, error) {
				setCookie("tkn", response.tkn, 30);
				console.log(`xhr: ${JSON.stringify(xhr)}\nstatus: ${status}\nerror: ${error}`);
			}
		});
	});

	// Event listener for the RESET button
	$('#resetInspBtn').on('click', function() {
		//location.reload();  // This will reload the entire page
		$('#confirmationModal').modal('hide'); // Close the modal when the RESET button is clicked
	});

	// Event listener for the "X" button
	$('#btn-close').on('click', function() {
		//location.reload();  // This will reload the entire page
		$('#confirmationModal').modal('hide'); // Close the modal when the X button is clicked
	});

	function populateTable(data) {
		// Get the table body element
		var tableBody = document.getElementById('resultsTableBody');
		var index = 1;

		// Clear any existing rows in the table
		tableBody.innerHTML = '';

		// Loop through the data and create rows
		data.forEach(function(item) {
			var row = document.createElement('tr');

			var serialNumber = document.createElement('td');
			serialNumber.textContent = index++;
			row.appendChild(serialNumber);

			//row.append($('<td>').text(index++));

			// Create columns for each field
			var inspectionIdCell = document.createElement('td');
			inspectionIdCell.textContent = item.inspection_id;
			row.appendChild(inspectionIdCell);

			var empAssignedDateCell = document.createElement('td');
			empAssignedDateCell.textContent = item.assigned_date;
			row.appendChild(empAssignedDateCell);

			/*var empAssignedToCell = document.createElement('td');
			empAssignedToCell.textContent = item.emp_assigned_to_Nm;
			row.appendChild(empAssignedToCell);*/

			var officeCodeCell = document.createElement('td');
			officeCodeCell.textContent = item.office_name_to_inspect;
			row.appendChild(officeCodeCell);

			var fromDateCell = document.createElement('td');
			fromDateCell.textContent = item.inspection_from_date;
			row.appendChild(fromDateCell);

			var toDateCell = document.createElement('td');
			toDateCell.textContent = item.inspection_to_date;
			row.appendChild(toDateCell);

			var statusCell = document.createElement('td');
			statusCell.textContent = item.status;
			row.appendChild(statusCell);

			// Create a column for the button tag
			if (item.status === "INSPECTED" || item.status !== "RECTIFIED") {
				var actionCell = document.createElement('td');
				var btn = document.createElement('button');
				//anchor.href = "#"; //"detailsPage.jsp?inspectionId=" + item.inspection_id; // Dynamic URL
				btn.textContent = "Enter Inspection";
				btn.setAttribute('data-inspection-id', item.inspection_id);
				btn.setAttribute('data-from-date', item.inspection_from_date);
				btn.setAttribute('data-end-date', item.inspection_to_date);
				btn.setAttribute('office_code_to_inspect', item.office_code_to_inspect);
				//btn.className = "btn btn-primary"; // Optional: Bootstrap button styling
				actionCell.appendChild(btn);
				row.appendChild(actionCell);

				btn.addEventListener('click', function() {
					//show additional section
					var inspectionId = this.getAttribute('data-inspection-id');
					var dataFromDate = this.getAttribute('data-from-date');
					var dataEndDate = this.getAttribute('data-end-date');
					populateDateDropdown(dataFromDate, dataEndDate);
					$('#resultsContainer').hide();
					$('#additionalSection1').show();
					$('#inspSubmitBtn').show();
					alert(`Inspection ID: ${inspectionId} is selected.\nYour inspection entry date should be within \n${dataFromDate} and ${dataEndDate}`);
					document.getElementById('inspection_id').value = inspectionId;
					setCookie("office_code_to_inspect", item.office_code_to_inspect, 30);
				});
			} else {
				// If status is not "INSPECTED", just add an empty cell
				var emptyCell = document.createElement('td');
				row.appendChild(emptyCell);
			}

			// Append the row to the table body
			tableBody.appendChild(row);
		});
	}
});