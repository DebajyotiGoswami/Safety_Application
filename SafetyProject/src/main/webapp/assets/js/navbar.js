//const baseURL = "http://10.252.37.170:8080/SafetyProject/";
var baseURL= BASE_URL;

function getCookie(name) {
	const nameEQ = name + "=";
	const ca = document.cookie.split(';');
	for (let i = 0; i < ca.length; i++) {
		let c = ca[i];
		while (c.charAt(0) === ' ')
			c = c.substring(1, c.length);
		if (c.indexOf(nameEQ) === 0)
			return c.substring(nameEQ.length, c.length);
	}
	return null;
}

function preventBack() {
    history.pushState(null, null, window.location.href);
    window.onpopstate = function() {
        history.pushState(null, null, window.location.href);
        alert("The back button is disabled on this page.");
    };
}

window.addEventListener('load', preventBack);

try {
	const cookieData = JSON.parse(getCookie('empDtls'));
	if (cookieData) {
		const employeeName = cookieData.empDtls.EMNAMCL;
		const employeeId = cookieData.User;
		const employeeDesignation = cookieData.empDtls.STEXTCL;
		document.getElementById("cookieDisplay").innerText = `${employeeName}, ${employeeDesignation} (ERP ID: ${employeeId})`;
	} else {
		throw new Error("Cookie data not found.");
	}
} catch (e) {
	console.error("Session error: ", e.message);
	alert("Session is inactive. Redirecting to login page.");
	window.location.href = baseURL;
}

//$("#logOutSubmit").on('click', handleLogout);

/*document.getElementById('logOutSubmit').addEventListener('click', handleLogout);*/
document.getElementById('logOutSubmit').addEventListener('click', function(event) {
	event.preventDefault(); // Prevent form submission
	if (confirm("You will be logged out from Safety Portal. Sure?")) {
		handleLogout();
	}
});

function deleteAllCookies() {
	document.cookie.split(";").forEach(cookie => {
		document.cookie = cookie.replace(/^ +/, "")
			.replace(/=.*/, "=;expires=Thu, 01 Jan 1970 00:00:00 GMT;path=/");
	});
}

function handleLogout() {
	localStorage.clear();
	sessionStorage.clear();
	deleteAllCookies();
	window.location.href = baseURL; // Base URL already defined
	return;
}