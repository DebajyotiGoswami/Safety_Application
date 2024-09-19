// Function to prevent back navigation
function preventBack() {
	alert("prevent back called");
	history.pushState(null, null, location.href);
	window.onpopstate = function() {
		history.go(1);
	};
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

function portalAllView() {
	alert("clicked");
	let jsonInput = {
		"role_id": "1",
		"inspection_id": "1234567890",
		"emp_name": getCookie("empName"),
		"erp_id": getCookie("User"),
		"office_name": getCookie("office"),
		"designation": getCookie("designation"),
		"office_code": getCookie("KST01CL"),
		"tkn": getCookie("tkn"),
		"page_id": "403",
		"auth": "INSP_PRTL"
	}

	$.ajax({
		url: "http://10.251.37.170:8080/SafetyReportView/frmprtl",
		type: 'POST',
		data: JSON.stringify(jsonInput),
		success: function(response) {
			alert("success");
		},
		error: function(xhr, status, error) {
			console.log(`xhr: ${JSON.stringify(xhr)}\nstatus: ${status}\nerror: ${error}`);
		}
	});
	alert("button click function ends");
}

document.addEventListener('DOMContentLoaded', () => {
	const cookieData = JSON.parse(getCookie('empDtls'));
	//get different value based on key of cookieData json
	const name = cookieData.empDtls.EMNAMCL;
	const erp_id = cookieData.xUid.slice(0, 8);
	const designation = cookieData.empDtls.STEXTCL;
	const office = cookieData.empDtls.LTEXTCL;
	const userRole = cookieData.empDtls.STELLCL;

	//document.getElementById("cookieDisplay").innerText = cookieData ?name+ ", "+ designation+" (ERP ID: "+ erp_id+ ") " : "Cookie not found.";

	/*  if (userRole === "1"){
		//Disable "Inspection Assignment" section for role 1
		$(".card-title:contains('Inspection Assignment')").closest(".card").addClass("disabled-card");
	}
	if (userRole === "2") {
		// Disable "Inspection Entry" section for role 2
		$(".card-title:contains('Inspection Entry')").closest(".card").addClass("disabled-card");
	} else if (userRole === "3") {
		// Disable "Rectification Entry" section for role 3
		$(".card-title:contains('Rectification Entry')").closest(".card").addClass("disabled-card");
	} else if (userRole === "4") {
		// Disable "Reports" section for role 4
		$(".card-title:contains('Reports')").closest(".card").addClass("disabled-card");
	} */


	preventBack();
});