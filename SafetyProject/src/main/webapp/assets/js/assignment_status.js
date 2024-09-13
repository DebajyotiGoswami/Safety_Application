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

	$('#searchBtn, #allAssignedByMeBtn').click(function() {
		alert("view assignment button clicked");

		$('#resultsContainer').show();

		var fromDate = $('#fromDate').val();
		var toDate = $('#toDate').val();
		var assignedTo = $('#assignedTo').val();
		var pendingAssignments = document.querySelector("#pendingAssignments").checked;
		
		var jsonObjectInput= {};
		jsonObjectInput.pageNm= "DASH";
		jsonObjectInput.ServType= "201";
		var cookieData = JSON.parse(getCookie('empDtls'));
		var tkn = getCookie('tkn');
		var xUid = cookieData.xUid;
		var costCenter = cookieData.empDtls.KST01CL;
		xUidJson = enCrypt(xUid, "123456");
		xUidEncrypted = xUidJson.User;
		dUidEncrypted = xUidJson.Pwd;
		jsonObjectInput.xUid= xUidEncrypted;
		jsonObjectInput.dUid= dUidEncrypted;
		jsonObjectInput.tkn= tkn;
		jsonObjectInput["KST01CL"] = costCenter;
		

		alert("data: "+ fromDate+ toDate+ assignedTo+ pendingAssignments);


		//alert("before calling populate table");
		//populateTable(data);
		alert("just before ajax call: "+JSON.stringify(jsonObjectInput));
		$.ajax({
			type: 'POST',
			url: url,
			data: JSON.stringify(jsonObjectInput),
			success: function(response) {
				alert("total response: "+ JSON.stringify(response));
				console.log(response);
/*				var responseJson = JSON.parse(response);
				var jsonArray = responseJson.assignments;
				var msg = responseJson.msg;
				alert(jsonArray);
				alert(msg);*/
				
				var empList= response.assignEmpDtls.assignList;
				alert("empList"+ JSON.stringify(empList));
				var newToken = response.tkn;
				if (response.ackMsgCode === "201") {
					alert("only employee list: "+ JSON.stringify(empList));					
					populateTable(empList);
					setCookie("tkn", newToken, 30);
				}
				alert("success ends. new token: "+ newToken);
			}
		});
	});

	/*function populateTable(data) {
		var tableBody = $('#resultsTableBody');
		tableBody.empty(); // Clear any existing rows

		
		// Loop through the JSON array
		$.each(data, function(index, item) {
			var row = $('<tr>');
			row.append($('<td>').text(index + 1));
			row.append($('<td>').text(item.inspection_id));
			row.append($('<td>').text(item.emp_assigned_by));
			row.append($('<td>').text(item.emp_assigned_to));
			row.append($('<td>').text(item.office_code_to_inspect));
			row.append($('<td>').text(item.inspection_from_date));
			row.append($('<td>').text(item.inspection_to_date));
			row.append($('<td>').text(item.status));
			console.log(row);
			tableBody.append("row: "+ row);
		});
	}*/

	function populateTable(data) {
		alert("inside populateTable");
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
			officeCodeCell.textContent = item.office_code_to_inspect;
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
			if (item.status === "INSPECTED" || item.status === "RECTIFIED") {
				var actionCell = document.createElement('td');
				var anchor = document.createElement('a');
				anchor.href = "#"; //"detailsPage.jsp?inspectionId=" + item.inspection_id; // Dynamic URL
				anchor.textContent = "View Inspection"; // Anchor text
				//anchor.className = "btn btn-primary"; // Optional: Bootstrap button styling
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
		alert("populate table ends here");
	}
});