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

	//$('#searchBtn, #allAssignedByMeBtn').click(function() {

	$('#resultsContainer').show();

	var fromDate = $('#fromDate').val();
	var toDate = $('#toDate').val();
	var assignedTo = $('#assignedTo').val();
	//var pendingAssignments = document.querySelector("#pendingAssignments").checked;

	var jsonObjectInput = {};
	jsonObjectInput.pageNm = "DASH";
	jsonObjectInput.ServType = "204";
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

	//alert("before calling populate table");
	//populateTable(data);
	$.ajax({
		type: 'POST',
		url: url,
		data: JSON.stringify(jsonObjectInput),
		success: function(response) {
			var newToken = response.tkn;
			setCookie("tkn", newToken, 30);
			var empList = response.inspectListEmp.assignList;

			if (response.ackMsgCode=== "204") {
				// If data is available, hide the no-data alert and show the table
				$('#noDataAlert').hide();
				$('#tableContainer').show();

				fullData = empList;
				populateTable(empList);
			} else {
				// If no data is found, show the no-data alert and hide the table
				$('#tableContainer').hide();
				$('#filterSection').hide();
				$('#noDataAlert').show().text("No inspection data available to show.");
			}
		},
		error: function(xhr, status, error) {
			//if server not get connected 
			console.error("xhr: " + JSON.stringify(xhr) + "\nstatus: " + status + "\nerror: " + error);
		}
	});
	//});

	$('#fromDate, #toDate, #probName, #officeName').on('change', function() {
		filterAndDisplayData();
	});

	function filterAndDisplayData() {
		var fromDate = $('#fromDate').val();
		var toDate = $('#toDate').val();
		var problemName = $('#probName').val().trim().toLowerCase();
		var assignedOffice = $('#officeName').val().trim().toLowerCase();

		var filteredData = fullData.filter(function(item) {
			var itemInspDate = new Date(item.inspection_date);
			//var itemDateTo = new Date(item.inspection_to_date);

			var itemProblemName = item.problem_id.toLowerCase() + item.problem_remarks.toLowerCase();
			var itemAssignedOffice = item.assigned_office_code;

			let officeList = JSON.parse(localStorage.getItem("officeList"));
			let officeName = "";
			officeList.forEach((office) => {
				if (office.offCode === itemAssignedOffice) {
					officeName = office.offName;
				}
			});
			itemAssignedOffice = officeName.toLowerCase(); //toLowerCase not required

			// Check if the current item matches the filter criteria
			var match = true;

			if (fromDate && itemInspDate < new Date(fromDate)) {
				match = false;
			}
			if (toDate && itemInspDate > new Date(toDate)) {
				match = false;
			}
			if (problemName && !itemProblemName.includes(problemName)) {
				match = false;
			}
			if (assignedOffice && !itemAssignedOffice.includes(assignedOffice)) {
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

			var serialNumber = document.createElement('td');
			serialNumber.textContent = index++;
			row.appendChild(serialNumber);

			//row.append($('<td>').text(index++));

			// Create columns for each field
			var inspectionIdCell = document.createElement('td');
			inspectionIdCell.textContent = item.inspection_id;
			row.appendChild(inspectionIdCell);

			//office name
			var officeCodeCell = document.createElement('td');
			let officeCode = item.assigned_office_code;
			let officeList = JSON.parse(localStorage.getItem("officeList"));
			let officeName = "";
			officeList.forEach((office) => {
				if (office.offCode === officeCode) {
					officeName = office.offName;
				}
			});
			officeCodeCell.textContent = officeName;
			row.appendChild(officeCodeCell);

			//location
			var probLocationCell = document.createElement('td');
			probLocationCell.textContent = item.location_remarks;
			row.appendChild(probLocationCell);

			//problem code/name
			var probCodeCell = document.createElement('td');
			probCodeCell.textContent = item.problem_id;
			row.appendChild(probCodeCell);

			//problem details
			var probDetailsCell = document.createElement('td');
			probDetailsCell.textContent = item.problem_remarks;
			row.appendChild(probDetailsCell);

			//inspection date
			var inspDateCell = document.createElement('td');
			inspDateCell.textContent = item.inspection_date;
			row.appendChild(inspDateCell);

			var statusCell = document.createElement('td');
			statusCell.textContent = item.present_status;
			row.appendChild(statusCell);

			// Create a column for the anchor tag
			if (item.present_status === "INSPECTED" || item.present_status === "RECTIFIED") {
				var actionCell = document.createElement('td');
				var anchor = document.createElement('a');
				//anchor.href = "#"; //"detailsPage.jsp?inspectionId=" + item.inspection_id; // Dynamic URL
				anchor.innerHTML = '<i class="fas fa-eye" title="View Data"></i>'; // Use Font Awesome icon
				//anchor.textContent = "View Inspection"; // Anchor text
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


				//anchor.textContent = "MODIFY"; // Anchor text
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