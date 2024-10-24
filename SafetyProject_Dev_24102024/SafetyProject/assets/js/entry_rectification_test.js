var KEY1 = bigInt("10953483997285864814773860729");
var KEY2 = bigInt("37997636186218092599949125647");

//var url = "http://10.251.37.170:8080/testSafety/testSafety";
//var url = "/prodSafety/prodSafety";
//import { API_URL } from './config';
var url=API_URL;
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

function uploadImage() {
	var input = document.getElementById('rectificationImage');
	var file = input.files[0];
	const MAX_SIZE = 300;
	if (!file) {
		alert('Please select an image file.');
		return;
	}

	// Validate file size (max 250 KB)
	if (file.size > MAX_SIZE * 1024) {
		alert(`File size must be less than ${MAX_SIZE} KB.`);
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

function showError(message) {
    $('#errorMessage').text(message).show();
}

function hideError() {
    $('#errorMessage').hide();
}


$(document).ready(function() {
	const wipCheckbox = document.getElementById('wipCheckbox');
	const rectificationDateLabel = document.querySelector('label[for="rectification_date"]');
	const rectificationRemarksLabel = document.querySelector('label[for="rectification_remarks"]');
	const rectificationDateInput = document.getElementById('rectification_date');
	const rectificationRemarksInput = document.getElementById('rectification_remarks');
	const rectificationImage = document.getElementById('rectificationImage');
	const rectifySubmitBtn = document.getElementById('rectifySubmitBtn');

	//rectifySubmitBtn.disabled = true;

	function validateForm() {
		const inspectionDate = new Date($('#inspection_date').val());
		const targetDate = new Date(rectificationDateInput.value);
		//console.log("target Date: " + JSON.stringify(targetDate));
		//console.log(typeof (targetDate));
		const today = new Date();
		const problemRemarks = rectificationRemarksInput.value.trim();
		const isImageUploaded = rectificationImage.files.length > 0;

		// Helper function to compare dates
		function isDateInFuture(date) {
			return date >= today;
		}

		function isDateInvalid(date) {
			//return JSON.stringify(date) === "null";
			return isNaN(date.getTime());  //better way without JSON handling
		}

		function isDateWithinSixMonths(date) {
			const sixMonthsFromToday = new Date();
			sixMonthsFromToday.setMonth(sixMonthsFromToday.getMonth() + 6);
			return date <= sixMonthsFromToday;
		}


		// Clear previous errors
		//rectifySubmitBtn.disabled = true;

		if (wipCheckbox.checked) {
			// WIP Checked Validations
			if (targetDate < inspectionDate) {
				//alert(`Target date must be after the inspection date ${inspectionDate}.`);
				showError(`Target date must be after the inspection date ${inspectionDate}.`);
				return false;
			}

			if (isDateInvalid(targetDate)) {
				//alert("Invalid Date. Enter proper target date.");
				showError("Invalid Date. Enter proper target date.");
				return false;
			}

			if (!isDateInFuture(targetDate)) {
				//alert('Target date must be in the future.');
				showError('Target date must be in the future.');
				return false;
			}
			if (!isDateWithinSixMonths(targetDate)) {
				//alert('Target date should not be more than 6 months from today.');
				showError('Target date should not be more than 6 months from today.')
				return false;
			}
			if (problemRemarks.length < 10) {
				//alert('Problem remarks should be at least 10 characters long.');
				showError('Problem remarks should be at least 10 characters long.');
				return false;
			}
			if (problemRemarks.length > 50) {
				//alert('Problem remarks should be no more than 50 characters long.');
				showError('Problem remarks should be no more than 50 characters long.');
				return false;
			}

			// Image not required for WIP, so skip image validation
			//rectifySubmitBtn.disabled = false;
		} else {
			// WIP Unchecked Validations
			if (targetDate < inspectionDate) {
				//alert(`Rectification date must be after the inspection date ${inspectionDate}.`);
				showError(`Rectification date must be after the inspection date ${inspectionDate}.`);
				return false;
			}

			if (isDateInvalid(targetDate)) {
				//alert("Invalid Date. Enter proper rectification date.");
				showError("Invalid Date. Enter proper rectification date.");
				return false;
			}

			if (isDateInFuture(targetDate)) {
				//alert('Rectification date can not be in the future.');
				showError('Rectification date can not be in the future.');
				return false;
			}
			if (problemRemarks.length < 5) {
				//alert('Rectification remarks should be at least 5 characters long.');
				showError('Rectification remarks should be at least 5 characters long.');
				return false;
			}
			if (problemRemarks.length > 50) {
				//alert('Rectification remarks should be no more than 20 characters long.');
				showError('Rectification remarks should be no more than 50 characters long.');
				return false;
			}
			if (!isImageUploaded) {
				//alert('Please upload a rectification image.');
				showError('Please upload a rectification image.');
				return false;
			}

			//rectifySubmitBtn.disabled = false;
		}
		hideError();
		return true;
	}

	rectificationDateInput.addEventListener('change', validateForm);
	rectificationRemarksInput.addEventListener('change', validateForm);
	rectificationImage.addEventListener('change', validateForm);


	// Add event listener to the checkbox
	wipCheckbox.addEventListener('change', function() {
		// Clear the input fields
		rectificationDateInput.value = ""; // Clear rectification date
		rectificationRemarksInput.value = ""; // Clear rectification remarks
		rectificationImage.value = ""; // Clear the rectified image input

		if (this.checked) {
			// Change the labels
			rectificationDateLabel.textContent = "Target Date";
			rectificationRemarksLabel.textContent = "Problem Remarks";

			// Disable the rectification image input
			rectificationImage.disabled = true;

			// Change the submit button text
			rectifySubmitBtn.textContent = "Submit WIP";
		} else {
			// Revert the label changes
			rectificationDateLabel.textContent = "Rectification Date";
			rectificationRemarksLabel.textContent = "Rectification Remarks";

			// Enable the rectification image input
			rectificationImage.disabled = false;

			// Revert the submit button text
			rectifySubmitBtn.textContent = "Submit Rectification";
		}

		//rectifySubmitBtn.disabled = true;
		//validateForm(); // Re-validate the form when checkbox changes
	});

	// Enable submit button if form is valid
	/*$('#rectifySubmitBtn').on('click', function(event) {
		if (!validateForm()) {
			event.preventDefault(); // Prevent form submission if validation fails
		}
	});*/


	$('#resultsContainer').show();
	var fullData = [];

	var fromDate = $('#fromDate').val();
	var toDate = $('#toDate').val();
	var assignedTo = $('#assignedTo').val();
	//var pendingAssignments = document.querySelector("#pendingAssignments").checked;
	var assignedOffice = $('#assignedOffice').val();

	var jsonObjectInput = {};
	jsonObjectInput.pageNm = "DASH";
	jsonObjectInput.ServType = "205";
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
			if (response.ackMsgCode === "205") {
				let empList = response.inspectListEmp.assignList;
				fullData = empList;
				populateTable(empList);
				// Hide the no data alert and show the table
				$('#noDataAlert').hide();
				$('#tableContainer').show();
				populateTable(empList);
			}
			else {
				// Hide the table and show the no data alert
				$('#tableContainer').hide();
				$('#noDataAlert').show().text("No rectification task pending at you to show.");
			}
		},
		error: function(xhr, status, error) {
			//setCookie("tkn", response.tkn, 30);
			console.log(`xhr: ${xhr}\nstatus: ${status}\nerror: ${error}`);
			setCookie("tkn", response.tkn, 30);
		}
	});

	$('#rectifySubmitBtn').on('click', function() {
		/*if (wipCheckbox.checked) {
			let inspection_id = $('#inspection_id').val();
			let rectification_date = $('#rectification_date').val();
			let rectification_remarks = $('#rectification_remarks').val();
			let site_id = $('#site_id').val();
			let rectified_by = getCookie("User");
			let image1 = wipCheckbox.checked? "": $('#base64Output').val(); //no image is required WIP entry
			let User = getCookie("User");

			xUidJson = enCrypt(User, "123456");
			xUidEncrypted = xUidJson.User;
			dUidEncrypted = xUidJson.Pwd;
			let tkn = getCookie('tkn');
			let xUid = cookieData.xUid;
			let costCenter = getCookie("KST01CL");

			var jsonObjInput = {
				"inspectionId": inspection_id,
				//"rectificationDate": rectification_date,
				"rectificationDate": rectification_date,
				//"rectificationRemarks": rectification_remarks,
				"rectificationRemarks": rectification_remarks,
				"rectifiedBy": rectified_by,
				"postImage": image1,
				"ServType": "103",  //integer
				"latitude": 0.0, //double
				"longitude": 0.0, //double
				"gisId": "NA",
				"siteId": site_id,
				"presentStatus": "WIP",
				"pageNm": "DASH",
				"tkn": tkn,
				"xUid": xUidEncrypted,
				"dUid": dUidEncrypted,
				"KST01CL": costCenter,
				"solutionId": "NA"
			};
			$.ajax({
				url: url,
				type: 'POST',
				data: JSON.stringify(jsonObjInput),
				success: function(response) {
					setCookie("tkn", response.tkn, 30);
					if (response.ackMsgCode === "104") {
						alert(`${response.ackMsg}\nwith Site Id: ${site_id}\nagainst Inspection Id: ${inspection_id}.`);
						window.location.href = 'new_rectification.jsp';
					}
				},
				error: function(xhr, status, error) {
					setCookie("tkn", response.tkn, 30);
					console.log(`xhr: ${JSON.stringify(xhr)}\nstatus: ${status}\nerror: ${error}`);
				}
			});
		}
		else {
			let inspection_id = $('#inspection_id').val();
			let rectification_date = $('#rectification_date').val();
			let rectification_remarks = $('#rectification_remarks').val();
			let site_id = $('#site_id').val();
			let rectified_by = getCookie("User");
			let image1 = $('#base64Output').val();
			let User = getCookie("User");

			xUidJson = enCrypt(User, "123456");
			xUidEncrypted = xUidJson.User;
			dUidEncrypted = xUidJson.Pwd;
			let tkn = getCookie('tkn');
			let xUid = cookieData.xUid;
			let costCenter = getCookie("KST01CL");

			var jsonObjInput = {
				"inspectionId": inspection_id,
				"rectificationDate": rectification_date,
				"rectificationRemarks": rectification_remarks,
				"rectifiedBy": rectified_by,
				"postImage": image1,
				"ServType": "103",  //integer
				"latitude": 0.0, //double
				"longitude": 0.0, //double
				"gisId": "NA",
				"siteId": site_id,
				"presentStatus": "RECTIFIED",
				"pageNm": "DASH",
				"tkn": tkn,
				"xUid": xUidEncrypted,
				"dUid": dUidEncrypted,
				"KST01CL": costCenter,
				"solutionId": "NA"
			};
			$.ajax({
				url: url,
				type: 'POST',
				data: JSON.stringify(jsonObjInput),
				success: function(response) {
					setCookie("tkn", response.tkn, 30);
					if (response.ackMsgCode === "103") {
						alert(`${response.ackMsg}\nwith Site Id: ${site_id}\nagainst Inspection Id: ${inspection_id}.`);
						window.location.href = 'new_rectification.jsp';
					}
				},
				error: function(xhr, status, error) {
					setCookie("tkn", response.tkn, 30);
					console.log(`xhr: ${JSON.stringify(xhr)}\nstatus: ${status}\nerror: ${error}`);
				}
			});
		}*/

		if (!validateForm()) {
			event.preventDefault(); // Prevent form submission if validation fails
		}
		else {
			hideError();
			let inspection_id = $('#inspection_id').val();
			let rectification_date = $('#rectification_date').val();
			let rectification_remarks = $('#rectification_remarks').val();
			let site_id = $('#site_id').val();
			let rectified_by = getCookie("User");
			let image1 = wipCheckbox.checked ? "" : $('#base64Output').val(); //no image is required WIP entry
			let User = getCookie("User");

			xUidJson = enCrypt(User, "123456");
			xUidEncrypted = xUidJson.User;
			dUidEncrypted = xUidJson.Pwd;
			let tkn = getCookie('tkn');
			let xUid = cookieData.xUid;
			let costCenter = getCookie("KST01CL");
			let presentStatus = wipCheckbox.checked ? "WIP" : "RECTIFIED";

			var jsonObjInput = {
				"inspectionId": inspection_id,
				"rectificationDate": rectification_date,
				"rectificationRemarks": rectification_remarks,
				"rectifiedBy": rectified_by,
				"postImage": image1,
				"ServType": "103",  //integer
				"latitude": 0.0, //double
				"longitude": 0.0, //double
				"gisId": "NA",
				"siteId": site_id,
				"presentStatus": presentStatus,
				"pageNm": "DASH",
				"tkn": tkn,
				"xUid": xUidEncrypted,
				"dUid": dUidEncrypted,
				"KST01CL": costCenter,
				"solutionId": "NA"
			};
			$.ajax({
				url: url,
				type: 'POST',
				data: JSON.stringify(jsonObjInput),
				success: function(response) {
					setCookie("tkn", response.tkn, 30);
					if (response.ackMsgCode === "103") {
						alert(`${response.ackMsg}\nwith Site Id: ${site_id}\nagainst Inspection Id: ${inspection_id}.`);
						window.location.href = 'new_rectification_test.jsp';
					}
					if(response.ackMsgCode === '999'){
						alert(`${response.ackMsg}`);
					}
				},
				error: function(xhr, status, error) {
					setCookie("tkn", response.tkn, 30);
					console.log(`xhr: ${JSON.stringify(xhr)}\nstatus: ${status}\nerror: ${error}`);
				}
			});
		}
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

			var statusCell = document.createElement('td');
			statusCell.textContent = item.present_status;
			row.appendChild(statusCell);

			// Create a column for the anchor tag
			if (item.present_status === "INSPECTED") {
				var actionCell = document.createElement('td');
				var btn = document.createElement('button');
				btn.id = 'fetchInspectButton';
				//anchor.href = "#"; //"detailsPage.jsp?inspectionId=" + item.inspection_id; // Dynamic URL
				btn.textContent = "RECTIFY";
				btn.setAttribute('data-inspection-id', item.inspection_id);
				btn.setAttribute('data-inspection-date', item.inspection_date);
				btn.setAttribute('data-inspection-by', item.inspection_by);
				btn.setAttribute('data-problem-name', item.problem_id);
				btn.setAttribute('data-problem-details', item.problem_remarks);
				btn.setAttribute('data-location', item.location_remarks);
				btn.setAttribute('data-site-id', item.site_id);
				//btn.setAttribute('data-image', item.image);

				//btn.className = "btn btn-primary"; // Optional: Bootstrap button styling
				actionCell.appendChild(btn);
				row.appendChild(actionCell);

				btn.addEventListener('click', function() {
					let inspectionId = this.getAttribute('data-inspection-id');
					let siteId = this.getAttribute('data-site-id');
					let problemName = this.getAttribute('data-problem-name');

					let User = getCookie("User");

					xUidJson = enCrypt(User, "123456");
					xUidEncrypted = xUidJson.User;
					dUidEncrypted = xUidJson.Pwd;
					let tkn = getCookie('tkn');
					let costCenter = getCookie("KST01CL");

					var jsonObjInput = {
						"inspectId": inspectionId,
						"siteId": siteId,
						"problemId": problemName,
						"ServType": "206",  //integer
						"pageNm": "DASH",
						"tkn": tkn,
						"xUid": xUidEncrypted,
						"dUid": dUidEncrypted,
						"KST01CL": costCenter
					};
					$.ajax({
						url: url,
						type: 'POST',
						data: JSON.stringify(jsonObjInput),
						success: function(response) {
							setCookie("tkn", response.tkn, 30);
							if (response.ackMsgCode === "206") {
								let inspectionData = response.inspectListEmp.assignList[0];
								let latitude = inspectionData.latitude
								let longitude = inspectionData.longitude
								let location_remarks = inspectionData.location_remarks;
								let gis_id = inspectionData.gis_id;
								let inspection_date = inspectionData.inspection_date;
								let present_status = inspectionData.present_status;
								let inspection_by = inspectionData.inspection_by;
								let inspection_id = inspectionData.inspection_id;
								let problem_id = inspectionData.problem_id;
								let site_id = inspectionData.site_id;
								let problem_remarks = inspectionData.problem_remarks;
								let pre_image = inspectionData.pre_image;


								$('#resultsContainer').hide();
								$('#formContainer').show();
								$('#inspSubmitBtn').show();

								alert(`Inspection ID: ${inspection_id} \nwith Site ID: ${site_id} is selected.\nEnter rectification details carefully.`);
								document.getElementById('inspection_id').value = inspection_id;
								document.getElementById('inspection_date').value = inspection_date;
								document.getElementById('inspection_by').value = inspection_by;
								document.getElementById('problem_name').value = problem_id;
								document.getElementById('problem_details').value = problem_remarks;
								document.getElementById('location').value = location_remarks;
								document.getElementById('gpsLoc').value = `${latitude}, ${longitude}`;
								document.getElementById('site_id').value = site_id;
								let img = document.getElementById('imagePreview');
								img.src = 'data:image/jpeg;base64,' + pre_image;
								//document.getElementById('image').value = image;
								setCookie("office_code_to_inspect", item.office_code_to_inspect, 30);
								//window.location.href = 'new_rectification.jsp';
							}
						},
						error: function(xhr, status, error) {
							setCookie("tkn", response.tkn, 30);
							console.log(`xhr: ${JSON.stringify(xhr)}\nstatus: ${status}\nerror: ${error}`);
						}
					});
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