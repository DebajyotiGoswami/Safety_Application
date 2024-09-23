var url = 'http://10.251.37.170:8080/testSafety/testSafety'

var KEY1 = bigInt("10953483997285864814773860729");
var KEY2 = bigInt("37997636186218092599949125647");

var xUidEncrypted = "";
var dUidEncrypted = "";

function enCrypt(uid, pwd) {
	//var uid=devEle["enIdCon"];
	//var pwd=devEle["enAuthCon"];
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

function fetchERPIds() {
	// Simulate an async fetch from an ERP server via RFC
	return new Promise((resolve) => {
		setTimeout(() => {
			// Example ERP IDs
			const erpIds = ["90012775", "90009977", "90009981", "900012774", "90012776"];
			resolve(erpIds);
		}, 1000); // Simulates a 1-second delay
	});
}

function validateForm() {
	const button = document.getElementById('assgnSubmitbtn');
	var isFormValid;

	inspectStartDate = document.getElementById('inspectionDateStart').value
	inspectEndDate = document.getElementById('inspectionDateEnd').value
	officeName = document.getElementById('officeName').value;

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
}

document.addEventListener('DOMContentLoaded', () => {
	// Fetch office list from localStorage
	var officeList = JSON.parse(localStorage.getItem('officeList'));
	function populateOfficeDropdown() {
		var officeDropdown = document.getElementById('officeName');

		// Clear any existing options
		officeDropdown.innerHTML = '<option value="">Select Office Name</option>';

		// Loop through the officeList and append options
		if (officeList && officeList.length > 0) {
			officeList.forEach(function(office) {
				//officeJSON= JSON.parse(office);
				var option = document.createElement('option');
				option.value = office.offCode;
				option.text = office.offName + ' (' + office.offCode + ')';
				officeDropdown.appendChild(option);
			});
		}
	}
	populateOfficeDropdown();

	document.getElementById('inspectionDateStart').addEventListener('input', validateInspectionDates);
	document.getElementById('inspectionDateEnd').addEventListener('input', validateInspectionDates);

	var cookieData = JSON.parse(getCookie('empDtls'));
	//get different value based on key of cookieData json
	var name = cookieData.empDtls.EMNAMCL;
	var erp_id = cookieData.xUid.slice(0, 8);
	var designation = cookieData.empDtls.STEXTCL;
	var office = cookieData.empDtls.KST01CL;
	var costCenter = cookieData.empDtls.KST01CL; //cost center
	var userRole = cookieData.empDtls.STELLCL;

	var xUid = cookieData.xUid;
	var xUidJson = enCrypt(xUid, "123456");
	xUidEncrypted = xUidJson.User;
	dUidEncrypted = xUidJson.Pwd;

	//validateForm();
	$('#assgnSubmitbtn').on('click', function() {
		var cookieDataToken = getCookie('tkn');
		var tkn = cookieDataToken; //cookieData.tkn;
		var jsonObject = {};
		jsonObject["KST01CL"] = costCenter;
		jsonObject.assignedDate = getCurrentDate();
		jsonObject.inspectionFromDate = document.getElementById('inspectionDateStart').value;
		jsonObject.inspectionToDate = document.getElementById('inspectionDateEnd').value;
		jsonObject.remarks = document.getElementById('remarks').value;
		jsonObject.inspectionId = "";

		// Collect all ERP IDs
		var erpIds = [];
		$('.erp-select').each(function() {
			var erpId = $(this).val();
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
		jsonObject.empAssignedBy = erp_id;
		jsonObject.rectifiedBy = "";
		jsonObject.assignedFromOff = office;
		jsonObject.officeCodeToInspect = document.getElementById('officeName').value;
		jsonObject.status = "ASSIGNED";
		jsonObject.inspectedBy = "";
		jsonObject.tkn = tkn;
		jsonObject.empAssignedByNm = name;
		jsonObject.pageNm = "DASH";
		jsonObject.ServType = 101;
		$.ajax({
			url: url, // replace with above Servlet URL
			type: 'POST',
			data: JSON.stringify(jsonObject),
			success: function(response) {
				if (response.ackMsgCode == '101') {
					var newToken = response.tkn;
					var ackMsg = response.ackMsg;
					var ackMsgCode = response.ackMsgCode;
					var inspectionId = response.inspectionId;
					if (ackMsgCode === "101") {
						alert(`${ackMsg}. Inspection ID: ${inspectionId}`);
						setCookie("tkn", newToken, 30);
						window.location.href = 'new_assignment.jsp';
					}

				}
			},
			error: function(xhr, status, error) {
				console.error("xhr: " + JSON.stringify(xhr) + "\nstatus: " + status + "\nerror: " + error);
			}
		});
	});
});

// Fetch employee list from localStorage
var empList = JSON.parse(localStorage.getItem('empList'));
function populateEmployeeDropdown() {
	var employeeDropdown = document.getElementById('empDetails');

	// Clear any existing options
	employeeDropdown.innerHTML = '<option value="">Select Employee Name</option>';

	// Loop through the officeList and append options
	if (empList && empList.length > 0) {
		empList.forEach(function(emp) {
			//officeJSON= JSON.parse(office);
			var option = document.createElement('option');
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
	
	var data = localStorage.getItem("empList");
	const erpIds= formatEmployeeData(JSON.parse(data)).empList;
	
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
		assgnSubmitbtn.disabled = false;
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
			assgnSubmitbtn.disabled = false;
		}
	}

	// If both start and end dates are valid, clear the error message
	if (startDate >= today && (!endDateInput.value || (endDate >= today && endDate >= startDate))) {
		errorDisplay.textContent = ""; // Clear error message
		errorDisplay.classList.remove('text-danger');
	}
}

