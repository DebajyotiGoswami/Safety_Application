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
	var fullData = [];   // test numerous time before turning it to let

	var fromDate = $('#fromDate').val();
	var toDate = $('#toDate').val();
	var assignedTo = $('#assignedTo').val();
	//var pendingAssignments = document.querySelector("#pendingAssignments").checked;
	var assignedOffice = $('#assignedOffice').val();

	var jsonObjectInput = {};
	jsonObjectInput.pageNm = "DASH";
	jsonObjectInput.ServType = "201";
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
			console.log("response: " + JSON.stringify(response));
			let newToken = response.tkn;
			setCookie("tkn", newToken, 30);
			if (response.ackMsgCode === "201") {
				// If data is available, hide the no-data alert and show the table
				var empList = response.assignEmpDtls.assignList;
				fullData = empList;
				populateTable(empList);
				$('#noDataAlert').hide();
				$('#tableContainer').show();
			}
			else if (response.ackMsgCode === "501") {
				// If no data is found, show the no-data alert and hide the table
				$('#tableContainer').hide();
				$('#filterSection').hide();
				$('#noDataAlert').show().text("No assignment data available to show.");
			}
		}
	});

	$('#fromDate, #toDate, #assignedTo, #assignedOffice').on('input', function() {
		filterAndDisplayData();
	});

	function filterAndDisplayData() {
		var fromDate = $('#fromDate').val();
		var toDate = $('#toDate').val();
		var assignedTo = $('#assignedTo').val().trim().toLowerCase();
		var assignedOffice = $('#assignedOffice').val().trim().toLowerCase();


		var filteredData = fullData.filter(function(item) {
			var itemDateFrom = new Date(item.inspection_from_date);
			var itemDateTo = new Date(item.inspection_to_date);
			var itemAssignedTo = item.emp_assigned_to_Nm.toLowerCase();
			var itemAssignedOffice = item.office_code_to_inspect.toLowerCase();

			console.log("office_code: " + itemAssignedOffice);
			console.log("hello " + assignedOffice);

			let officeList = JSON.parse(localStorage.getItem("officeList"));
			let officeName = "";
			officeList.forEach((office) => {
				if (office.offCode === itemAssignedOffice) {
					officeName = office.offName;
				}
			});

			itemAssignedOffice = officeName.toLowerCase(); //toLowerCase not required
			console.log("after tolower: " + itemAssignedOffice);
			console.log(assignedTo + "-" + assignedOffice + "-" + itemAssignedOffice);

			// Check if the current item matches the filter criteria
			var match = true;

			if (fromDate && itemDateFrom < new Date(fromDate)) {
				match = false;
			}
			if (toDate && itemDateTo > new Date(toDate)) {
				match = false;
			}
			if (assignedTo && !itemAssignedTo.includes(assignedTo)) {
				match = false;
			}
			console.log("last check: " + assignedOffice + itemAssignedOffice);
			if (assignedOffice && !itemAssignedOffice.includes(assignedOffice)) {
				match = false;
			}

			return match;
		});

		populateTable(filteredData); // Display the filtered data
	}


	/*function populateTable(data) {
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

			var empAssignedByCell = document.createElement('td');
			empAssignedByCell.textContent = item.assigned_date;
			row.appendChild(empAssignedByCell);

			var empAssignedToCell = document.createElement('td');
			let name = item.emp_assigned_to_Nm;
			name = name.charAt(0).toUpperCase() + name.slice(1).toLowerCase();
			empAssignedToCell.textContent = name;
			row.appendChild(empAssignedToCell);

			var officeCodeCell = document.createElement('td');
			let officeCode = item.office_code_to_inspect;
			let officeList = JSON.parse(localStorage.getItem("officeList"));
			let officeName = "";
			officeList.forEach((office) => {
				if (office.offCode === officeCode) {
					officeName = office.offName;
				}
			});
			if (officeName == "") {
				officeName = officeCode;
			}
			officeCodeCell.textContent = officeName;
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

			// Create a column for the anchor tag
			if (item.status === "ASSIGNED") {
				var actionCell = document.createElement('td');
				var anchor = document.createElement('a');

				anchor.innerHTML = '<i class="fas fa-trash-alt" title="click to delete"></i>'; // Use Font Awesome icon

				// Add click event listener for the anchor element
				anchor.addEventListener('click', function(event) {
					event.preventDefault(); // Prevent the default anchor click behavior
					// Initialize Bootstrap 5 modal without jQuery
					var modal = new bootstrap.Modal(document.getElementById('confirmationModal'));

					// Event listener for the anchor (trash icon) to open modal
					document.querySelectorAll('.fas.fa-trash-alt').forEach(anchor => {
						anchor.addEventListener('click', function(event) {
							event.preventDefault();
							// Open the modal when clicking the trash icon
							modal.show();
						});
					});

					// When Yes button is clicked
					document.getElementById('yesBtn').addEventListener('click', function() {
						// Get the comment from the modal
						var comment = document.getElementById('commentField').value; // Get the comment

						let xUidJson = enCrypt(getCookie("User"), "123456");
						let jsonInput = {
							"inspection_id": item.inspection_id,
							"tkn": getCookie("tkn"),
							"remarks": comment,
							"xUid": xUidJson.User,
							"dUid": xUidJson.Pwd,
							"status": "CANCELLED",
							"pageNm": "DASH",
							"ServType": "208"
						}

						$.ajax({
							url: url,
							type: 'POST',
							data: JSON.stringify(jsonInput),
							success: function(response) {
								console.log("success");
								setCookie("tkn", response.tkn, 30);
								window.location.href = response.redirectURL;
							},
							error: function(xhr, status, error) {
								console.log(`xhr: ${JSON.stringify(xhr)}\nstatus: ${status}\nerror: ${error}`);
							}
						});
					});

					document.getElementById('noBtn').addEventListener('click', function() {
						modal.hide(); // Just close the modal without any action
					});

					// Ensure the modal close button works
					document.querySelector('.btn-close').addEventListener('click', function() {
						modal.hide(); // Close the modal when the X button is clicked
					});
				});



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
	}*/

	function populateTable(data) {
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

			var inspectionIdCell = document.createElement('td');
			inspectionIdCell.textContent = item.inspection_id;
			row.appendChild(inspectionIdCell);

			var empAssignedByCell = document.createElement('td');
			empAssignedByCell.textContent = item.assigned_date;
			row.appendChild(empAssignedByCell);

			var empAssignedToCell = document.createElement('td');
			let name = item.emp_assigned_to_Nm;
			name = name.charAt(0).toUpperCase() + name.slice(1).toLowerCase();
			empAssignedToCell.textContent = name;
			row.appendChild(empAssignedToCell);

			var officeCodeCell = document.createElement('td');
			let officeCode = item.office_code_to_inspect;
			let officeList = JSON.parse(localStorage.getItem("officeList"));
			let officeName = "";
			officeList.forEach((office) => {
				if (office.offCode === officeCode) {
					officeName = office.offName;
				}
			});
			officeName = officeName === "" ? officeCode : officeName;
			officeCodeCell.textContent = officeName;
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

			// Create a column for the anchor tag
			if (item.status === "ASSIGNED") {
				var actionCell = document.createElement('td');
				var anchor = document.createElement('a');
				anchor.innerHTML = '<i class="fas fa-trash-alt" title="click to delete"></i>';

				// Add click event listener for the anchor element
				anchor.addEventListener('click', function(event) {
					event.preventDefault(); // Prevent the default anchor click behavior

					// Initialize Bootstrap 5 modal without jQuery
					var modal = new bootstrap.Modal(document.getElementById('confirmationModal'));
					modal.show(); // Show the modal immediately

					// Clear the previous comment and ensure no multiple event listeners
					document.getElementById('commentField').value = '';

					// Remove old event listeners before adding new ones
					const yesBtn = document.getElementById('yesBtn');
					const noBtn = document.getElementById('noBtn');
					const closeBtn = document.querySelector('.btn-close');

					yesBtn.replaceWith(yesBtn.cloneNode(true));  // Remove old event listeners
					noBtn.replaceWith(noBtn.cloneNode(true));    // Remove old event listeners
					closeBtn.replaceWith(closeBtn.cloneNode(true));  // Remove old event listeners

					document.getElementById('yesBtn').addEventListener('click', function() {
						// Get the comment from the modal
						var comment = document.getElementById('commentField').value;

						let xUidJson = enCrypt(getCookie("User"), "123456");
						let jsonInput = {
							"inspection_id": item.inspection_id,
							"tkn": getCookie("tkn"),
							"remarks": comment,
							"xUid": xUidJson.User,
							"dUid": xUidJson.Pwd,
							"status": "CANCELLED",
							"pageNm": "DASH",
							"ServType": "208"
						};

						// Make the AJAX call
						$.ajax({
							url: url,
							type: 'POST',
							data: JSON.stringify(jsonInput),
							success: function(response) {
								console.log("success");
								setCookie("tkn", response.tkn, 30);
								window.location.href = response.redirectURL;
							},
							error: function(xhr, status, error) {
								console.log(`xhr: ${JSON.stringify(xhr)}\nstatus: ${status}\nerror: ${error}`);
							},
							complete: function() {
								modal.hide(); // Hide the modal after the AJAX call
							}
						});
					});

					document.getElementById('noBtn').addEventListener('click', function() {
						modal.hide(); // Close the modal without any action
					});

					document.querySelector('.btn-close').addEventListener('click', function() {
						modal.hide(); // Close the modal when the X button is clicked
					});
				});

				actionCell.appendChild(anchor);
				row.appendChild(actionCell);
			} else {
				var emptyCell = document.createElement('td');
				row.appendChild(emptyCell);
			}

			// Append the row to the table body
			tableBody.appendChild(row);
		});
	}

});