// Function to prevent back navigation
function preventBack() {
    history.pushState(null, null, location.href);
    window.onpopstate = function () {
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

document.addEventListener('DOMContentLoaded', () => {
	const cookieData = JSON.parse(getCookie('empDtls'));
	//get different value based on key of cookieData json
	console.log(cookieData);
	const name= cookieData.empDtls.EMNAMCL;
	const erp_id= cookieData.xUid.slice(0,8);
	const designation= cookieData.empDtls.STEXTCL;
	const office= cookieData.empDtls.LTEXTCL;
	const userRole= cookieData.empDtls.STELLCL;
	
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