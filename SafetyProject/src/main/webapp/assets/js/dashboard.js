// Function to prevent back navigation
function preventBack() {
	//alert("prevent back called");
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
	let jsonInput = {
        "role_id": "1",
        "emp_name": getCookie("empName"),
        "erp_id": getCookie("User"),
        "office_name": getCookie("office"),
        "designation": getCookie("designation"),
        "office_code": getCookie("KST01CL"),
        "tkn": getCookie("tkn"),
        "page_id": "403",
        "auth": "INSP_PRTL",
        "role_name": "INSPECTOR"
    }
    console.log(JSON.stringify(jsonInput));
	$.ajax({
        url: "reportServlet", // Make sure this URL maps to your MyServlet servlet
        type: 'POST',
        contentType: "application/json; charset=utf-8",
        data: JSON.stringify(jsonInput),
        success: function(response) {
            console.log("success");
            window.open("newhome.jsp", '_blank');
        },
        error: function(xhr, status, error) {
            console.log(`xhr: ${JSON.stringify(xhr)}\nstatus: ${status}\nerror: ${error}`);
        }
    });
}

document.addEventListener('DOMContentLoaded', () => {
	const cookieData = JSON.parse(getCookie('empDtls'));
	//get different value based on key of cookieData json
	const name = cookieData.empDtls.EMNAMCL;
	const erp_id = cookieData.xUid.slice(0, 8);
	const designation = cookieData.empDtls.STEXTCL;
	const office = cookieData.empDtls.LTEXTCL;
	const userRole = cookieData.empDtls.STELLCL; //50032705

	/*document.getElementById('floatingPlusBtn').addEventListener('click', function(event) {
		event.preventDefault(); // Prevent default anchor behavior

		// Define the JSON object for the AJAX request
		let jsonInput = {
			"action": "triggerNewAction", // Add your necessary key-value pairs for the server
			"tkn": getCookie("tkn")
		};

		// Make the AJAX call
		$.ajax({
			url: 'yourAjaxEndpointUrl', // Replace with your actual endpoint
			type: 'POST',
			data: JSON.stringify(jsonInput),
			success: function(response) {
				console.log('Success:', response);
				alert('AJAX call made successfully');
			},
			error: function(xhr, status, error) {
				console.error('Error:', error);
			}
		});
	});*/


	//document.getElementById("cookieDisplay").innerText = cookieData ?name+ ", "+ designation+" (ERP ID: "+ erp_id+ ") " : "Cookie not found.";

	/*if (userRole === "50032662" || userRole === "50032705") {
		//Chief Engineers and above
		//$(".card-title:contains('Inspection Assignment')").closest(".card").addClass("disabled-card");
		$(".card-title:contains('Inspection Entry')").closest(".card").addClass("disabled-card");
		$(".card-title:contains('Rectification Entry')").closest(".card").addClass("disabled-card");
		//$(".card-title:contains('Reports')").closest(".card").addClass("disabled-card");
	}
	if (userRole === "50032624") {
		//Additional Chief Engineer
		//$(".card-title:contains('Inspection Assignment')").closest(".card").addClass("disabled-card");
		//$(".card-title:contains('Inspection Entry')").closest(".card").addClass("disabled-card");
		$(".card-title:contains('Rectification Entry')").closest(".card").addClass("disabled-card");
		//$(".card-title:contains('Reports')").closest(".card").addClass("disabled-card");
	} else if (userRole === "50032737" || userRole === "50032552" || userRole === "50032567") {
		//SE and DE and AE
		//$(".card-title:contains('Inspection Assignment')").closest(".card").addClass("disabled-card");
		$(".card-title:contains('Inspection Entry')").closest(".card").addClass("disabled-card");
		$(".card-title:contains('Rectification Entry')").closest(".card").addClass("disabled-card");
		$(".card-title:contains('Reports')").closest(".card").addClass("disabled-card");
	} else if (userRole === "50032588" || userRole === "50032722") {
		//JE Gr 1 and JE Gr 2
		$(".card-title:contains('Inspection Assignment')").closest(".card").addClass("disabled-card");
		$(".card-title:contains('Inspection Entry')").closest(".card").addClass("disabled-card");
		//$(".card-title:contains('Rectification Entry')").closest(".card").addClass("disabled-card");
		$(".card-title:contains('Reports')").closest(".card").addClass("disabled-card");
	} else {
		$(".card-title:contains('Inspection Assignment')").closest(".card").addClass("disabled-card");
		$(".card-title:contains('Inspection Entry')").closest(".card").addClass("disabled-card");
		//$(".card-title:contains('Rectification Entry')").closest(".card").addClass("disabled-card");
		$(".card-title:contains('Reports')").closest(".card").addClass("disabled-card");
	}*/


	preventBack();
});