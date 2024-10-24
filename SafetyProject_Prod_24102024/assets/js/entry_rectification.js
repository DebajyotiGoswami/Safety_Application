var KEY1 = bigInt("10953483997285864814773860729");
var KEY2 = bigInt("37997636186218092599949125647");

//var url = "http://10.252.37.170:8080/testSafety/testSafety";
var url = "/prodSafety/prodSafety";//by jd
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
			}
		},
		error: function(xhr, status, error){
			setCookie("tkn", response.tkn, 30);
			console.log(`xhr: ${xhr}\nstatus: ${status}\nerror: ${error}`);
		}
	});

	$('#rectifySubmitBtn').on('click', function() {
		let inspection_id = $('#inspection_id').val();
		let rectification_date = $('#rectification_date').val();
		let rectification_remarks = $('#rectification_remarks').val();
		let site_id = $('#site_id').val();
		let rectified_by = getCookie("User");
		let image1 = $('#base64Output').val();
		let User = getCookie("User");
		let siteId = $('#site_id').val();

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
			"latitude": 88.32, //double
			"longitude": 132.12, //double
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
					alert(`${response.ackMsg}\nwith Site Id: ${siteId}\nagainst Inspection Id: ${inspection_id}.`);
					//console.log(JSON.stringify(response));
					window.location.href = 'new_rectification.jsp';
				}
			},
			error: function(xhr, status, error) {
				setCookie("tkn", response.tkn, 30);
				console.log(`xhr: ${JSON.stringify(xhr)}\nstatus: ${status}\nerror: ${error}`);
			}
		});
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
				/*console.log("start");
				var actionCell = document.createElement('td');
				var anchor = document.createElement('a');
				anchor.href = "#"; //"detailsPage.jsp?inspectionId=" + item.inspection_id; // Dynamic URL
				anchor.innerHTML = '<i class="fas fa-eye fa-lg" title="View Data"></i>'; // Use Font Awesome icon
				//anchor.textContent = "MODIFY"; // Anchor text
				//anchor.className = "btn btn-primary"; // Optional: Bootstrap button styling
				actionCell.appendChild(anchor);
				row.appendChild(actionCell);
				console.log("end");*/
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
				//console.log("1: " + item.site_id);

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
					//console.log("Request: "+ JSON.stringify(jsonObjInput));
					$.ajax({
						url: url,
						type: 'POST',
						data: JSON.stringify(jsonObjInput),
						success: function(response) {
							//console.log("rectify: " + JSON.stringify(response));
							setCookie("tkn", response.tkn, 30);
							//console.log(getCookie("tkn"));
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
								
								alert(`Inspection ID: ${inspection_id} \nunder ${site_id} is selected.\nEnter rectification details carefully.`);
								document.getElementById('inspection_id').value = inspection_id;
								document.getElementById('inspection_date').value = inspection_date;
								document.getElementById('inspection_by').value = inspection_by;
								document.getElementById('problem_name').value = problem_id;
								document.getElementById('problem_details').value = problem_remarks;
								document.getElementById('location').value = location_remarks;
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




					/*//show additional section
					let inspectionId = this.getAttribute('data-inspection-id');
					let inspectionDate = this.getAttribute('data-inspection-date');
					let inspectionBy = this.getAttribute('data-inspection-by');
					let problemName = this.getAttribute('data-problem-name');
					let problemDetails = this.getAttribute('data-problem-details');
					let location = this.getAttribute('data-location');
					let siteId = this.getAttribute('data-site-id');
					console.log("2: " + siteId);
					//let image = this.getAttribute('data-image');*/


					//populateDateDropdown(dataFromDate, dataEndDate);

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