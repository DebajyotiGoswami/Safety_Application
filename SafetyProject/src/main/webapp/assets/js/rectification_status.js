var KEY1 = bigInt("10953483997285864814773860729");
var KEY2 = bigInt("37997636186218092599949125647");

var url = "http://10.251.37.170:8080/testSafety/testSafety";
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

$(document).ready(function() {
	var fullData = [];

	var fromDate = $('#fromDate').val();
	var toDate = $('#toDate').val();
	var assignedTo = $('#assignedTo').val();
	//var pendingAssignments = document.querySelector("#pendingAssignments").checked;
	var assignedOffice = $('#assignedOffice').val();

	var jsonObjectInput = {};
	jsonObjectInput.pageNm = "DASH";
	jsonObjectInput.ServType = "207";
	var cookieData = JSON.parse(getCookie('empDtls'));
	var tkn = getCookie('tkn');
	var xUid = cookieData.xUid;
	var costCenter = cookieData.empDtls.KST01CL;
	xUidJson = enCrypt(xUid, "123456");
	xUidEncrypted = xUidJson.User;
	dUidEncrypted = xUidJson.Pwd;
	jsonObjectInput.xUid = xUidEncrypted;
	jsonObjectInput.dUid = dUidEncrypted;
	jsonObjectInput.tkn = tkn;
	jsonObjectInput["KST01CL"] = costCenter;
	$.ajax({
		type: 'POST',
		url: url,
		data: JSON.stringify(jsonObjectInput),
		success: function(response) {
			setCookie("tkn", response.tkn, 30);
			if (response.ackMsgCode === "207") {
				// If data is available, hide the no-data alert and show the table
				let empList = response.inspectListEmp.assignList;
				fullData = empList;
				populateTable(empList);
				$('#noDataAlert').hide();
				$('#tableContainer').show();

				fullData = empList;
				populateTable(empList)
			}
			else {
				// If no data is found, show the no-data alert and hide the table
				$('#tableContainer').hide();
				$('#filterSection').hide();
				$('#noDataAlert').show().text("No rectification data available to show.");
			}
		},
		error: function(xhr, status, error) {
			//if server not get connected 
			setCookie("tkn", response.tkn, 30);
			console.error("xhr: " + JSON.stringify(xhr) + "\nstatus: " + status + "\nerror: " + error);
		}
	});

	$('#fromDate, #toDate, #problemName, #locationName').on('input', function() {
		filterAndDisplayData();
	});

	function filterAndDisplayData() {
		var fromDate = $('#fromDate').val();
		var toDate = $('#toDate').val();
		var problemName = $('#problemName').val().trim().toLowerCase();
		var locationName = $('#locationName').val().trim().toLowerCase();

		var filteredData = fullData.filter(function(item) {
			var itemInspectionDate = new Date(item.inspection_date);
			var itemProblemName = item.problem_remarks.toLowerCase() + item.problem_id.toLowerCase();
			var itemLocationName = item.location_remarks.toLowerCase();

			var match = true;

			if (fromDate && itemInspectionDate < new Date(fromDate)) {
				match = false;
			}
			if (toDate && itemInspectionDate > new Date(toDate)) {
				match = false;
			}
			if (problemName && !itemProblemName.includes(problemName)) {
				match = false;
			}
			if (locationName && !itemLocationName.includes(locationName)) {
				match = false;
			}

			return match;
		});

		populateTable(filteredData); // Display the filtered data
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

			//Serial Number
			var serialNumber = document.createElement('td');
			serialNumber.textContent = index++;
			row.appendChild(serialNumber);

			//row.append($('<td>').text(index++));

			// Create columns for each field

			//Inspection Id
			var inspectionIdCell = document.createElement('td');
			inspectionIdCell.textContent = item.inspection_id;
			row.appendChild(inspectionIdCell);

			//Inspection Date
			var inspectionDateCell = document.createElement('td');
			inspectionDateCell.textContent = item.inspection_date;
			row.appendChild(inspectionDateCell);

			//Inspected By
			var inspectedByCell = document.createElement('td');
			inspectedByCell.textContent = item.inspection_by;
			row.appendChild(inspectedByCell);

			//problem name
			var problemNameCell = document.createElement('td');
			problemNameCell.textContent = item.problem_id;
			row.appendChild(problemNameCell);

			//problem details
			var problemDetailsCell = document.createElement('td');
			problemDetailsCell.textContent = item.problem_remarks;
			row.appendChild(problemDetailsCell);

			//location details
			var locationCell = document.createElement('td');
			locationCell.textContent = item.location_remarks;
			row.appendChild(locationCell);

			var rectifiedOn = document.createElement('td');
			rectifiedOn.textContent = item.rectification_date;
			row.appendChild(rectifiedOn);

			var rectifyRemarks = document.createElement('td');
			rectifyRemarks.textContent = item.rectification_remarks;
			row.appendChild(rectifyRemarks);

			var statusCell = document.createElement('td');
			statusCell.textContent = item.present_status;
			row.appendChild(statusCell);

			// Create a column for the anchor tag
			if (item.status !== "INSPECTED" || item.status !== "RECTIFIED") {
				var actionCell = document.createElement('td');
				var anchor = document.createElement('a');
				//anchor.href = "#"; //"detailsPage.jsp?inspectionId=" + item.inspection_id; // Dynamic URL
				anchor.innerHTML = '<i class="fas fa-eye fa-lg" title="View Data"></i>'; // Use Font Awesome icon
				//anchor.textContent = "MODIFY"; // Anchor text
				//anchor.className = "btn btn-primary"; // Optional: Bootstrap button styling

				// Attach an onclick event to the anchor
				anchor.onclick = function(event) {
					let jsonInput = {
						"role_id": "1",
						"inspection_id": item.inspection_id,
						"emp_name": getCookie("empName"),
						"erp_id": getCookie("User"),
						"office_name": getCookie("office"),
						"designation": getCookie("designation"),
						"office_code": getCookie("KST01CL"),
						"tkn": getCookie("tkn"),
						"page_id": "401",
						"auth": "INSP_PRTL"
					}

					$.ajax({
						url: "http://10.251.37.170:8080/SafetyReportView/frmprtl",
						type: 'POST',
						data: JSON.stringify(jsonInput),
						success: function(response) {
							console.log("success");
							window.location.href = response.redirectURL;
						},
						error: function(xhr, status, error) {
							console.log(`xhr: ${JSON.stringify(xhr)}\nstatus: ${status}\nerror: ${error}`);
						}
					});
				};


				actionCell.appendChild(anchor);
				row.appendChild(actionCell);
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