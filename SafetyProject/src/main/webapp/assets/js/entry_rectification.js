var KEY1 = bigInt("10953483997285864814773860729");
var KEY2 = bigInt("37997636186218092599949125647");

var url = "http://10.251.37.170:8080/testSafety/testSafety";
var xUidEncrypted = "";
var dUidEncrypted = "";
var xUidJson = {};
var btn = document.createElement('button');

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
$(document).ready(function() {
	$('#resultsContainer').show();

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
		url: url,
		type: 'POST',
		data: JSON.stringify(jsonObjectInput),
		success: function(response) {
			var empList = response.assignEmpDtls.assignList;
			var newToken = response.tkn;
			if (response.ackMsgCode === "202") {
				populateTable(empList);
				setCookie("tkn", newToken, 30);
				console.log("new token: " + newToken);
				console.log("new token in new cookie: " + getCookie("tkn"));
				//$('#additionalSection1').show();
				//document.getElementById('additionalSection1').style.display = 'block';
			}
		}
	});

	$('#inspSubmitBtn, #inspSubmitBtn2, #resultsContainer').on('click', function() {
		function disableMouseInteraction(className) {
			var elements = document.querySelectorAll('.' + className);
			elements.forEach(function(element) {
				element.style.pointerEvents = 'none';
			});
		}

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
		/*			alert(assetList);
					alert(typeof(assetList));
					alert(assetList[network_type+ asset_name]);*/
		var jsonObj = {
			"network_type": network_type,
			"assetId": asset_name,
			"pageNm": "DASH",
			"ServType": "203",
			"tkn": tkn,
			"xUid": xUidEncrypted,
			"dUid": dUidEncrypted,
			"KST01CL": costCenter,
			"office_code_to_inspect": getCookie("office_code_to_inspect"),
			"assetId": assetList[network_type + asset_name]
		};
		//var jsonString = JSON.stringify(jsonObj);
		$.ajax({
			type: 'POST',
			url: url,
			data: JSON.stringify(jsonObj),
			success: function(response) {
				console.log("inside problem fetching success ajax");

				//populate problem dropdown
				var dropdown = $('#problem_list');
				dropdown.empty(); // Clear any existing options

				// Assuming response is a JSON array
				$.each(response.probDtls.probDtls, function(index, item) {
					console.log("item.key: ", item.probId);
					console.log("item.value: ", item.probDesc);
					dropdown.append($('<option></option>').attr('value', item.probId).text(item.probDesc));
				});

				//populate office dropdown
				var dropdown = $('#office_name');
				dropdown.empty(); // Clear any existing options
				// Assuming response is a JSON array
				$.each(response.rectifyOfficeDtls.officeList, function(index, item) {
					console.log("item.key: ", item.offCode);
					console.log("item.value: ", item.offName);
					dropdown.append($('<option></option>').attr('value', item.offCode).text(item.offName));
				});

				var newToken = response.tkn;
				setCookie("tkn", newToken, 30);
			},
			error: function(xhr, status, error) {
				console.log(`xhr: ${JSON.stringify(xhr)}\nstatus: ${status}\nerror: ${error}`)
			}
		});
		disableMouseInteraction('initial-section');
		$('#formContainer').show();
		$('#inspSubmitBtn').text('SUBMIT'); // Change button text to 'SUBMIT'
		isNextClicked = true; // Update flag
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

			var empAssignedByCell = document.createElement('td');
			empAssignedByCell.textContent = item.assigned_date;
			row.appendChild(empAssignedByCell);

			var empAssignedToCell = document.createElement('td');
			empAssignedToCell.textContent = item.emp_assigned_to_Nm;
			row.appendChild(empAssignedToCell);

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
			if (item.status !== "INSPECTED" || item.status !== "RECTIFIED") {
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
					$('#additionalSection1').show();
					var inspectionId = this.getAttribute('data-inspection-id');
					var dataFromDate = this.getAttribute('data-from-date');
					var dataEndDate = this.getAttribute('data-end-date');
					alert(`Inspection ID: ${inspectionId} is selected.\nYour inspection entry date should be within \n${dataFromDate} and ${dataEndDate}`);
					document.getElementById('inspection_id').value = inspectionId;
					//$('#submitBtn').show();
					//document.getElementById('submitBtn').style.display= 'block';
					setCookie("office_code_to_inspect", item.office_code_to_inspect, 30);
				});
			} else {
				// If status is not "INSPECTED", just add an empty cell
				var emptyCell = document.createElement('td');
				row.appendChild(emptyCell);
			}
			console.log(row);

			// Append the row to the table body
			tableBody.appendChild(row);
		});
	}
});