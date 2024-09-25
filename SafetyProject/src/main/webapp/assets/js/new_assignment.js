var url = 'http://10.251.37.170:8080/testSafety/testSafety'

var KEY1 = bigInt("10953483997285864814773860729");
var KEY2 = bigInt("37997636186218092599949125647");

function enCrypt(uid, pwd) {
	let uidConver = [];
	let pwdConver = [];
	let enIden = [];
	let enAuth = [];
	let enIdCon = "";
	let enAuthCon = "";
	let jsonObj = {};

	for (let i = 0; i < uid.length; i++) {
		uidConver[i] = uid.charCodeAt(i);
		let bigtemp = bigInt(uidConver[i]);
		enIden[i] = bigInt(uidConver[i]).modPow(KEY1, KEY2).toString(16);
		enIdCon = enIdCon.concat(enIden[i]);
		if (i != (uid.length - 1)) {
			enIdCon = enIdCon.concat("@");
		}
	}
	for (let i = 0; i < pwd.length; i++) {
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

const getCurrentDate = () => {
	const date = new Date();
	let year = String(date.getFullYear());

	let month = String(date.getMonth() + 1); // Add 1 to the month
	month = month.length === 1 ? "0" + month : month;
	let day = String(date.getDate());
	day = day.length === 1 ? "0" + day : day;

	//return `${year}-${day}-${month}`;
	return year + "-" + day + "-" + month;
}

/*function validateForm() {
	alert("inside validate");
	const button = document.getElementById('assgnSubmitbtn');
	let isFormValid = false;

	inspectStartDate = document.getElementById('inspectionDateStart').value
	inspectEndDate = document.getElementById('inspectionDateEnd').value
	officeName = document.getElementById('officeName').value;

	alert(inspectStartDate, inspectEndDate, officename);

	if (inspectStartDate === null || inspectEndDate === null || officeName === null) {
		isFormValid = false;
	}
	else {
		isFormValid = true;
	}

	if (isFormValid) {
		button.disabled = false;
	} else {
		button.disabled = true;
	}
}*/

document.addEventListener('DOMContentLoaded', () => {
	$('#assgnSubmitbtn').prop('disabled', true);
	// Function to check if all fields are valid
	function checkFormValidity() {
		var teamMembers = $('#teamMembers').val();
		var inspectionDateStart = $('#inspectionDateStart').val();
		var inspectionDateEnd = $('#inspectionDateEnd').val();
		var officeName = $('#officeName').val();

		// Check if all fields are non-empty
		if (teamMembers && inspectionDateStart && inspectionDateEnd && officeName) {
			$('#assgnSubmitbtn').prop('disabled', false);  // Enable the button
		} else {
			$('#assgnSubmitbtn').prop('disabled', true);   // Keep it disabled
		}
	}

	// Attach event listeners to form fields
	$('#teamMembers').on('change', checkFormValidity);
	$('#inspectionDateStart').on('input', checkFormValidity);
	$('#inspectionDateEnd').on('change', checkFormValidity);
	$('#officeName').on('change', checkFormValidity);

	// Fetch office list from localStorage
	let officeList = JSON.parse(localStorage.getItem('officeList'));
	function populateOfficeDropdown() {
		let officeDropdown = document.getElementById('officeName');

		// Clear any existing options
		officeDropdown.innerHTML = '<option value="">Select Office Name</option>';

		// Loop through the officeList and append options
		if (officeList && officeList.length > 0) {
			officeList.forEach(function(office) {
				//officeJSON= JSON.parse(office);
				let option = document.createElement('option');
				option.value = office.offCode;
				option.text = office.offName + ' (' + office.offCode + ')';
				officeDropdown.appendChild(option);
			});
		}
	}
	populateOfficeDropdown();

	document.getElementById('inspectionDateStart').addEventListener('input', validateInspectionDates);
	document.getElementById('inspectionDateEnd').addEventListener('input', validateInspectionDates);

	//get different value based on key of cookieData json
	let xUid = getCookie("User");
	let xUidJson = enCrypt(xUid, "123456");
	let xUidEncrypted = xUidJson.User;
	let dUidEncrypted = xUidJson.Pwd;

	//validateForm();
	$('#assgnSubmitbtn').on('click', function() {
		let tkn = getCookie('tkn'); //cookieData.tkn;
		let jsonObject = {};
		jsonObject["KST01CL"] = getCookie("costCenter");
		jsonObject.assignedDate = getCurrentDate();
		jsonObject.inspectionFromDate = document.getElementById('inspectionDateStart').value;
		jsonObject.inspectionToDate = document.getElementById('inspectionDateEnd').value;
		jsonObject.remarks = document.getElementById('remarks').value;
		jsonObject.inspectionId = "";

		// Collect all ERP IDs
		let erpIds = [];
		$('.erp-select').each(function() {
			let erpId = $(this).val();
			if (erpId !== 'Select Team Member') {
				let tempJson = {};
				erpName = erpId.slice(0, erpId.indexOf("(") - 1);
				erpId = erpId.slice(erpId.indexOf("(") + 1, erpId.length - 1);
				tempJson.erpId = erpId;
				tempJson.erpName = erpName;
				erpIds.push(tempJson);
			}
		});

		jsonObject.xUid = xUidEncrypted;
		jsonObject.dUid = dUidEncrypted
		jsonObject.empAssignedTo = erpIds;
		jsonObject.empAssignedBy = getCookie("User");
		jsonObject.rectifiedBy = "";
		jsonObject.assignedFromOff = getCookie("KST01CL");
		jsonObject.officeCodeToInspect = document.getElementById('officeName').value;
		jsonObject.status = "ASSIGNED";
		jsonObject.inspectedBy = "";
		jsonObject.tkn = tkn;
		jsonObject.empAssignedByNm = getCookie("empName");
		jsonObject.pageNm = "DASH";
		jsonObject.ServType = 101;
		$.ajax({
			url: url, // replace with above Servlet URL
			type: 'POST',
			data: JSON.stringify(jsonObject),
			success: function(response) {
				let newToken = response.tkn;
				setCookie("tkn", newToken, 30);
				let ackMsg = response.ackMsg;
				let ackMsgCode = response.ackMsgCode;
				let inspectionId = response.inspectionId;
				alert(`${ackMsg}. Inspection ID: ${inspectionId}`);
				if (ackMsgCode == '101') {
					window.location.href = 'new_assignment.jsp';
				}
			},
			error: function(xhr, status, error) {
				console.error("xhr: " + JSON.stringify(xhr) + "\nstatus: " + status + "\nerror: " + error);
			}
		});
	});
});

// Fetch employee list from localStorage

function populateEmployeeDropdown() {
	let empList = JSON.parse(localStorage.getItem('empList'));
	let employeeDropdown = document.getElementById('empDetails');

	// Clear any existing options
	employeeDropdown.innerHTML = '<option value="">Select Employee Name</option>';

	// Loop through the empList and append options
	if (empList && empList.length > 0) {
		empList.forEach(function(emp) {
			//officeJSON= JSON.parse(office);
			let option = document.createElement('option');
			option.value = emp.empId;
			option.text = emp.empName + ' (' + emp.empId + ')';
			employeeDropdown.appendChild(option);
		});
	}
}


function formatEmployeeData(inputData) {
	let formattedEmpList = inputData.map(emp => {
		return `${emp.empName.trim()} (${emp.empId})`;
	});

	let outputJson = { "empList": formattedEmpList };
	return outputJson;
}

function updateERPFields() {
	const number = document.getElementById('teamMembers').value;
	const container = document.getElementById('erpIdContainer');
	container.innerHTML = ''; // Clear previous fields

	let data = localStorage.getItem("empList");
	const erpIds = formatEmployeeData(JSON.parse(data)).empList;

	for (let i = 1; i <= number; i++) {

		const div = document.createElement('div');
		div.className = 'mb-3 row';

		// Create label
		const label = document.createElement('label');
		label.setAttribute('for', 'erpId' + i);
		label.className = 'col-sm-3 col-form-label';
		label.textContent = 'Team Member ' + i;

		// Create select dropdown
		const inputDiv = document.createElement('div');
		inputDiv.className = 'col-sm-9';
		const select = document.createElement('select');
		select.className = 'form-control erp-select';
		select.id = 'erpId' + i;
		select.name = 'erpId' + i;

		// Add a default disabled option
		const defaultOption = document.createElement('option');
		defaultOption.textContent = 'Select Team Member';
		defaultOption.disabled = true;
		defaultOption.selected = true;
		select.appendChild(defaultOption);

		// Populate the select dropdown with ERP IDs
		erpIds.forEach(function(erpId) {
			const option = document.createElement('option');
			option.value = erpId;
			option.textContent = erpId;
			select.appendChild(option);
		});

		// Append the select dropdown to the div
		inputDiv.appendChild(select);
		div.appendChild(label);
		div.appendChild(inputDiv);
		container.appendChild(div);
	}
	// Add event listeners to all the dropdowns
	$('.erp-select').on('change', function() {
		filterDropdownOptions();
	});
}

// Function to filter options in dropdowns
function filterDropdownOptions() {
	const allSelects = document.querySelectorAll('.erp-select');
	const selectedValues = [];

	// Get all selected values
	allSelects.forEach(select => {
		if (select.value !== 'Select Team Member') {
			selectedValues.push(select.value);
		}
	});

	// Update options in each dropdown
	allSelects.forEach(select => {
		const currentSelection = select.value;
		const options = select.querySelectorAll('option');

		// Enable/disable options based on the selected values in other dropdowns
		options.forEach(option => {
			if (option.value !== 'Select Team Member') {
				if (selectedValues.includes(option.value) && option.value !== currentSelection) {
					//option.disabled = true;
					option.style.display = 'none';
				} else {
					//option.disabled = false;
					option.style.display = 'block';
				}
			}
		});
	});
}


function validateInspectionDates() {
	const startDateInput = document.getElementById('inspectionDateStart');
	const endDateInput = document.getElementById('inspectionDateEnd');
	const errorDisplay = document.getElementById('dateError');
	const assgnSubmitbtn = document.getElementById('assgnSubmitbtn');

	const startDate = new Date(startDateInput.value);
	const endDate = new Date(endDateInput.value);
	const today = new Date();
	today.setHours(0, 0, 0, 0); // Reset time to midnight


	// Validate start date
	if (startDate < today) {
		errorDisplay.textContent = ""; // Clear previous error
		errorDisplay.textContent = "Start date cannot be in the past.";
		startDateInput.classList.add('is-invalid'); // Add Bootstrap error styling
		errorDisplay.classList.add('text-danger'); // Show red error message
		assgnSubmitbtn.disabled = true;
	} else if ((startDate - today) / (1000 * 60 * 60 * 24) >= 180) {
		errorDisplay.textContent = ""; // Clear previous error
		errorDisplay.textContent = "Start date cannot be more than 6 months in advance.";
		startDateInput.classList.add('is-invalid'); // Add Bootstrap error styling
		errorDisplay.classList.add('text-danger'); // Show red error message
		assgnSubmitbtn.disabled = true;
	}
	else {
		startDateInput.classList.remove('is-invalid');
		//assgnSubmitbtn.disabled = false;
	}

	// Validate end date only if it's entered
	if (endDateInput.value) {
		if (endDate < today) {
			errorDisplay.textContent = ""; // Clear previous error
			errorDisplay.textContent = "End date cannot be in the past.";
			endDateInput.classList.add('is-invalid');
			errorDisplay.classList.add('text-danger');
			assgnSubmitbtn.disabled = true;
		} else if (endDate < startDate) {
			errorDisplay.textContent = ""; // Clear previous error
			errorDisplay.textContent = "End date cannot be before start date.";
			endDateInput.classList.add('is-invalid');
			errorDisplay.classList.add('text-danger');
			assgnSubmitbtn.disabled = true;
		} else if ((endDate - startDate) / (1000 * 60 * 60 * 24) >= 7) {
			errorDisplay.textContent = ""; // Clear previous error
			errorDisplay.textContent = "End date";// cannot be more than 7 days from start date.";
			endDateInput.classList.add('is-invalid');
			errorDisplay.classList.add('text-danger');
			assgnSubmitbtn.disabled = true;
		} else {
			endDateInput.classList.remove('is-invalid');
			//assgnSubmitbtn.disabled = false;
		}
	}

	// If both start and end dates are valid, clear the error message
	if (startDate >= today && (!endDateInput.value || (endDate >= today && endDate >= startDate))) {
		errorDisplay.textContent = ""; // Clear error message
		errorDisplay.classList.remove('text-danger');
	}
}

