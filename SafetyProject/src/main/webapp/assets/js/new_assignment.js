
var KEY1 = bigInt("10953483997285864814773860729");
var KEY2 = bigInt("37997636186218092599949125647");

//var name = "";
//var erp_id = "";
//var designation = "";
//var office = "";
//var userRole = "";
//var tkn = "";
var xUidEncrypted = "";
var dUidEncrypted = "";
var xUidJson = {};

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

function getCookie(name) {
	const nameEQ = name + "=";
	const ca = document.cookie.split(';');
	for (let i = 0; i < ca.length; i++) {
		let c = ca[i];
		while (c.charAt(0) === ' ') c = c.substring(1, c.length);
		if (c.indexOf(nameEQ) === 0) return c.substring(nameEQ.length, c.length);
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

document.addEventListener('DOMContentLoaded', () => {
	document.getElementById('inspectionDateStart').addEventListener('input', validateInspectionDates);
	document.getElementById('inspectionDateEnd').addEventListener('input', validateInspectionDates);

	var cookieData = JSON.parse(getCookie('empDtls'));
	//get different value based on key of cookieData json
	var name = cookieData.empDtls.EMNAMCL;
	var erp_id = cookieData.xUid.slice(0, 8);
	var designation = cookieData.empDtls.STEXTCL;
	var office = cookieData.empDtls.LTEXTCL;
	var userRole = cookieData.empDtls.STELLCL;
	console.log(cookieData.tkn);
	var tkn = cookieData.tkn;
	console.log("token: "+ tkn);
	var xUid = cookieData.xUid;
	xUidJson = enCrypt(xUid, "123456");
	xUidEncrypted = xUidJson.User;
	dUidEncrypted = xUidJson.Pwd;

	$('#assgnSubmitbtn').on('click', function() {
		var jsonObject = {};
		jsonObject.assignedDate = getCurrentDate();
		jsonObject.inspectionFromDate = document.getElementById('inspectionDateStart').value;
		jsonObject.inspectionToDate = document.getElementById('inspectionDateEnd').value;
		jsonObject.inspectionId = "";
		jsonObject.xUid = xUidEncrypted;
		jsonObject.dUid = dUidEncrypted
		jsonObject.empAssignedTo = document.getElementById('erpId1').value;
		jsonObject.empAssignedBy = erp_id;
		jsonObject.rectifiedBy = "";
		jsonObject.assignedFromOff = office;
		jsonObject.officeCodeToInspect = document.getElementById('officeName').value;
		jsonObject.status = "ASSIGNED";
		jsonObject.inspectedBy = "";
		jsonObject.tkn = tkn;
		jsonObject.pageNm = "DASH";
		jsonObject.ServType = 101;
		$.ajax({
			url: 'http://10.251.37.170:8080/testSafety/testSafety', // replace with above Servlet URL
			type: 'POST',
			data: JSON.stringify(jsonObject),
			success: function(response) {
				if (response.ackMsgCode == '101') {
					alert("assignment successful");
					window.location.href = 'assign_inspection.jsp';
				}
			},
			error: function(xhr, status, error) {
				//console.error("Error sending data:", status, error);
				console.error("xhr: " + JSON.stringify(xhr) + "\nstatus: " + status + "\nerror: " + error);
			}
		});
	});

	preventBack();
	//document.getElementById("cookieDisplay").innerText = cookieData ?name+ ", "+ designation+" (ERP ID: "+ erp_id+ ") " : "Cookie not found.";
});

function updateERPFields() {
	const number = document.getElementById('teamMembers').value;
	const container = document.getElementById('erpIdContainer');
	container.innerHTML = ''; // Clear previous fields

	for (let i = 1; i <= number; i++) {
		const div = document.createElement('div');
		div.className = 'mb-3 row';
		const label = document.createElement('label');
		label.setAttribute('for', 'erpId' + i);
		label.className = 'col-sm-3 col-form-label';
		label.textContent = 'ERP ID ' + i;
		const inputDiv = document.createElement('div');
		inputDiv.className = 'col-sm-9';
		const input = document.createElement('input');
		input.type = 'text';
		input.className = 'form-control';
		input.id = 'erpId' + i;
		input.name = 'erpId' + i;
		input.placeholder = 'Enter ERP ID';
		inputDiv.appendChild(input);
		div.appendChild(label);
		div.appendChild(inputDiv);
		container.appendChild(div);
	}
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
		errorDisplay.textContent = "Start date cannot be in the past.";
		startDateInput.classList.add('is-invalid'); // Add Bootstrap error styling
		errorDisplay.classList.add('text-danger'); // Show red error message
		assgnSubmitbtn.disabled = true;
	} else {
		startDateInput.classList.remove('is-invalid');
		assgnSubmitbtn.disabled = false;
	}

	// Validate end date only if it's entered
	if (endDateInput.value) {
		if (endDate < today) {
			errorDisplay.textContent = "End date cannot be in the past.";
			endDateInput.classList.add('is-invalid');
			errorDisplay.classList.add('text-danger');
			assgnSubmitbtn.disabled = true;
		} else if (endDate < startDate) {
			errorDisplay.textContent = "End date cannot be before start date.";
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

