$(document).ready(function() {
	// Add event listener for the 'NEXT' or 'SUBMIT' button click
	$('#inspSubmitBtn').on('click', function() {
		if ($('#inspSubmitBtn').text() === 'NEXT') {
			// If 'NEXT' is clicked, show the next section and update the button to 'SUBMIT'
			$('#additionalSection2').show();
			$('#inspSubmitBtn').text('SUBMIT');
		} else if ($('#inspSubmitBtn').text() === 'SUBMIT') {
			// If 'SUBMIT' is clicked, show the confirmation modal
			populateConfirmationModal(); // Populate modal with form data
			$('#confirmationModal').modal('show');
		}
	});

	// Handle the final submission from the modal
	$('#finalSubmitBtn').on('click', function() {
		submitInspectionData(); // Submit the data via AJAX
		$('#confirmationModal').modal('hide'); // Close modal after submission
	});

	// Handle modal reset
	$('#resetInspBtn').on('click', function() {
		location.reload(); // Reload the page
	});

	// Check form validity to enable/disable the 'NEXT' button
	function checkFormValidity() {
		var inspectionDate = $('#inspection_date').val();
		var location = $('#location').val();
		var networkType = $('#network_type').val();
		var assetType = $('#asset_type').val();

		if (inspectionDate && location && networkType && assetType) {
			$('#inspSubmitBtn').prop('disabled', false);  // Enable the button
		} else {
			$('#inspSubmitBtn').prop('disabled', true);   // Disable the button
		}
	}

	// Attach event listeners to form fields for validity check
	$('#inspection_date, #location, #network_type, #asset_type').on('input change', checkFormValidity);

	// Image input validity check
	$('#imageInput').on('change', function() {
		uploadImage();  // Handle image upload
		checkFormValidity();  // Check form validity
	});

	// Handling the "Inspection without Assignment" button click
	if (getUrlParameter('type') === 'suo_moto') {
		$('#resultsContainer').hide();
		$('#additionalSection1').show();
		$('#inspSubmitBtn').show();
		$('#inspection_id').val('Suo Moto Inspection');

		// Populate the dropdown with the last 7 days for Suo Moto inspections
		populateLast7DaysDropdown();
	} else {
		// Standard AJAX call to fetch inspections for assigned tasks
		var jsonObjectInput = {};
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
			//url: 'http://10.251.37.170:8080/testSafety/testSafety',
			url: '/testSafety/testSafety',
			type: 'POST',
			data: JSON.stringify(jsonObjectInput),
			success: function(response) {
				setCookie("tkn", response.tkn, 30);
				if (response.ackMsgCode === "202") {
					let empList = response.assignEmpDtls.assignList;
					$('#noDataAlert').hide();
					$('#tableContainer').show();
					populateTable(empList);
				} else {
					$('#tableContainer').hide();
					$('#noDataAlert').show().text("No inspection task pending at you to show.");
				}
			},
			error: function(xhr, status, error){
				setCookie("tkn", response.tkn, 30);
				console.log(`xhr: ${JSON.stringify(xhr)}\nstatus: ${status}\nerror: ${error}`);
			}
		});
	}
});

// Helper function to populate the last 7 days in the dropdown
function populateLast7DaysDropdown() {
	const dropdown = $('#inspection_date');

	// Clear existing options
	dropdown.empty();

	// Get today's date
	const today = new Date();

	// Loop through the last 7 days
	for (let i = 0; i < 7; i++) {
		const date = new Date(today);
		date.setDate(today.getDate() - i); // Subtract i days from today

		// Format the date as yyyy-mm-dd
		const formattedDate = date.toISOString().split('T')[0];

		// Create and append option element
		dropdown.append(new Option(formattedDate, formattedDate));
	}
}

// Helper functions
function populateConfirmationModal() {
	$('#confirmInspectionId').text($('#inspection_id').val());
	$('#confirmLocationRemarks').text($('#location').val());
	$('#confirmAssignedOffice').text($('#office_name option:selected').text());
	$('#confirmInspectionDate').text($('#inspection_date').val());
	$('#confirmSeverityLevel').text($('input[name="difficulty"]:checked').val());

	var problemDetailsArray = [];
	$('#problem_list input[type="checkbox"]:checked').each(function() {
		var problemDesc = $(this).data('description');
		var problemDetails = $('#problem_details_' + $(this).val()).val();
		problemDetailsArray.push(`<strong>Problem:</strong> ${problemDesc}, <strong>Details:</strong> ${problemDetails || "none"}`);
	});
	$('#confirmProblemDetails').html(problemDetailsArray.join('<br>'));
}

function submitInspectionData() {
	var jsonObjInput = {
		"inspectionId": $('#inspection_id').val(),
		"locationRemarks": $('#location').val(),
		"assignedOfficeCode": $('#office_name').val(),
		"inspectionDate": $('#inspection_date').val(),
		"preImage": $('#base64Output').val(),
		"ServType": "102",  //integer
		"presentStatus": "INSPECTED",
		"pageNm": "DASH",
		"inspectionBy": getCookie("User"),
		"problems": getSelectedProblems(),
		"tkn": getCookie('tkn'),
		"xUid": xUidEncrypted,
		"dUid": dUidEncrypted,
		"severityLevel": $('input[name="difficulty"]:checked').val()
	};

	$.ajax({
//		url: 'http://10.251.37.170:8080/testSafety/testSafety',
		url: '/testSafety/testSafety',
		type: 'POST',
		data: JSON.stringify(jsonObjInput),
		success: function(response) {
			var newToken = response.tkn;
			setCookie("tkn", newToken, 30);
			if (response.ackMsgCode === "102") {
				alert(`${response.ackMsg}`);
				window.location.href = 'new_inspection.jsp';
			} else {
				alert(`ERROR!! ${response.ackMsg}`);
			}
		},
		error: function(xhr, status, error) {
			console.log(`xhr: ${JSON.stringify(xhr)}\nstatus: ${status}\nerror: ${error}`);
		}
	});
}

function getSelectedProblems() {
	var problemsArray = [];
	$('#problem_list input[type="checkbox"]:checked').each(function() {
		var problemId = $(this).val();
		var problemDetails = $('#problem_details_' + problemId).val();
		problemsArray.push({
			"problemId": problemId,
			"problemRemarks": problemDetails
		});
	});
	return problemsArray;
}

function getUrlParameter(name) {
	name = name.replace(/[\[]/, '\\[').replace(/[\]]/, '\\]');
	var regex = new RegExp('[\\?&]' + name + '=([^&#]*)');
	var results = regex.exec(location.search);
	return results === null ? '' : decodeURIComponent(results[1].replace(/\+/g, ' '));
}


// Helper functions

function enCrypt(uid, pwd) {
	var uidConver = [];
	var pwdConver = [];
	var enIden = [];
	var enAuth = [];
	var enIdCon = "";
	var enAuthCon = "";
	var jsonObj = {};
	let KEY1 = bigInt("10953483997285864814773860729");
	let KEY2 = bigInt("37997636186218092599949125647");

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