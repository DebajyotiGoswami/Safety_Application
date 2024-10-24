//var url = "http://10.251.37.170:8080/testSafety/testSafety";
//import { API_URL } from './config';
//var url = "/prodSafety/prodSafety";
var url = API_URL;

var xUidEncrypted = "";
var dUidEncrypted = "";
var jsonObjInput = {};
var jsonObjCookie = {};

function enCrypt(uid, pwd) {
	let uidConver = [];
	let pwdConver = [];
	let enIden = [];
	let enAuth = [];
	let enIdCon = "";
	let enAuthCon = "";
	let jsonObj = {};
	let KEY1 = bigInt("10953483997285864814773860729");
	let KEY2 = bigInt("37997636186218092599949125647");

	for (let i = 0; i < uid.length; i++) {
		uidConver[i] = uid.charCodeAt(i);
		let bigtemp = bigInt(uidConver[i]);
		enIden[i] = bigInt(uidConver[i]).modPow(KEY1, KEY2).toString(16);
		enIdCon = enIdCon.concat(enIden[i]);
		if (i != (uid.length - 1)) {
			enIdCon = enIdCon.concat("@");
		}
	}
	for (let i = 0; i < pwd.length; i++) {
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

function isValidNumber(input) {
	const numericRegex = /^[0-9]+$/;
	return numericRegex.test(input) && input.length === 8 && input.startsWith('9');
}

function isValidOtp(input) {
	const numericRegex = /^[0-9]+$/;
	return numericRegex.test(input) && input.length == 5
}

function validateOtpAndSubmit(otp) {
	const errorDisplay = document.getElementById('otpError');
	if (!isValidOtp(otp)) {
		errorDisplay.textContent = 'OTP must be numeric and should be 5 digits long.';
		return false;
	}
	errorDisplay.textContent = "";
	return true;
}
function validateLoginAndSubmit(User, Pwd) {
	const userId = User;
	const password = Pwd;
	const errorDisplay = document.getElementById('loginError');
	if (!isValidNumber(userId)) {
		errorDisplay.textContent = 'User ID must be numeric, start with 9, and be 8 digits long.';
		return;
	}
	if (userId === password) {
		errorDisplay.textContent = 'User ID and Password must not match.';
		return;
	}
	errorDisplay.textContent = '';
	return true;
}

function enableResendButton() {
	const resendButton = document.getElementById('resendOtpBtn');
	resendButton.disabled = false;
	resendButton.textContent = 'Resend OTP';
}

function startResendOtpTimer() {
	const resendButton = document.getElementById('resendOtpBtn');
	resendButton.disabled = true;
	let countdown = 30;
	resendButton.textContent = `Resend OTP (${String(countdown)}s)`;

	const interval = setInterval(() => {
		countdown--;
		resendButton.textContent = `Resend OTP (${countdown}s)`;

		if (countdown === 0) {
			clearInterval(interval);
			enableResendButton();
		}
	}, 1000);
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
		if (c.indexOf(nameEQ) === 0) return c.substring(nameEQ.length, c.length);
	}
	return null;
}

function getCurrentDate() {
	const date = new Date();
	let year = String(date.getFullYear());

	let month = String(date.getMonth() + 1); // Add 1 to the month
	month = month.length === 1 ? "0" + month : month;
	let day = String(date.getDate());
	day = day.length === 1 ? "0" + day : day;

	//return `${year}-${day}-${month}`;
	return year + "-" + day + "-" + month;
}

$(document).ready(function() {
	$('#loginbttn, #submitOtpBtn, #resendOtpBtn, #assgnSubmitbtn').on('click', handleButtonClick);
});

function handleButtonClick(event) {
	const buttonId = event.target.id;

	if (buttonId === 'loginbttn') {
		let User = $('#userId').val();
		let Pwd = $('#password').val();
		let userAgent = navigator.userAgent;
		userAgent = userAgent.replace(/[^\w\s.]/g, " "); //replace all symbols with space

		if (validateLoginAndSubmit(User, Pwd)) {
			jsonObjInput = enCrypt(User, Pwd);
			jsonObjInput["userAgent"] = userAgent;
			jsonObjInput["pageNm"] = "LOGIN";

			jsonObjCookie["User"] = User;
			jsonObjCookie["userAgent"] = userAgent;
		} else {
			return;
		}
	}
	else if ((buttonId === 'submitOtpBtn') || (buttonId === 'resendOtpBtn')) {
		let otp= $('#otp').val();
		jsonObjInput = {};
		jsonObjInput['otp'] = otp;
		jsonObjInput["pageNm"] = "OTP";
		jsonObjInput["xUid"] = xUidEncrypted;
		jsonObjInput["dUid"] = dUidEncrypted;
		jsonObjInput["empDtls"] = jsonObjCookie.empDtls;
		jsonObjInput["stell"] = jsonObjCookie.userRole;

		if (buttonId === 'submitOtpBtn') {
			if (validateOtpAndSubmit(otp)) {
				startResendOtpTimer();
			} else {
				return;
			}
		}
		else if (buttonId === 'resendOtpBtn') {
			document.getElementById("otp").value = '';
			jsonObjInput["pageNm"] = "RESOTP";
		}
	}
	else if (buttonId === 'assgnSubmitbtn') {
		let tkn = getCookie('tkn'); //cookieData.tkn;
		jsonObjInput = {};
		jsonObjInput["KST01CL"] = getCookie("costCenter");
		jsonObjInput.assignedDate = getCurrentDate();
		jsonObjInput.inspectionFromDate = document.getElementById('inspectionDateStart').value;
		jsonObjInput.inspectionToDate = document.getElementById('inspectionDateEnd').value;
		jsonObjInput.remarks = document.getElementById('remarks').value;
		jsonObjInput.inspectionId = "";

		// Collect all ERP IDs
		let erpIds = [];
		$('.erp-select').each(function() {
			let erpId = $(this).val();
			if (erpId !== 'Select Team Member') {
				let tempJson = {};
				erpName = erpId.slice(0, erpId.indexOf("(") - 1);
				erpId = erpId.slice(erpId.indexOf("(") + 1, erpId.length - 1);
				tempJson.erpId = erpId;
				tempJson.erpName = erpName;
				erpIds.push(tempJson);
			}
		});
		xUidJson= enCrypt(getCookie("User"), "123456");
		jsonObjInput.xUid = xUidJson.User;
		jsonObjInput.dUid = xUidJson.Pwd;
		jsonObjInput.empAssignedTo = erpIds;
		jsonObjInput.empAssignedBy = getCookie("User");
		jsonObjInput.rectifiedBy = "";
		jsonObjInput.assignedFromOff = getCookie("KST01CL");
		jsonObjInput.officeCodeToInspect = document.getElementById('officeName').value;
		jsonObjInput.status = "ASSIGNED";
		jsonObjInput.inspectedBy = "";
		jsonObjInput.tkn = tkn;
		jsonObjInput.empAssignedByNm = getCookie("empName");
		jsonObjInput.pageNm = "DASH";
		jsonObjInput.ServType = 101;
	}

	$.ajax({
		url: url, // replace with above Servlet URL
		type: 'POST',
		data: JSON.stringify(jsonObjInput),
		success: function(response) {
			if (response.ackMsgCode === '105') {
				let xUid = response.xUid;
				let empDtls = response.empDtls;
				let xUidJson = enCrypt(xUid, "123456");
				xUidEncrypted = xUidJson.User;
				dUidEncrypted = xUidJson.Pwd;
				// Show OTP section
				$('#otpMessage').show();
				$('#otpForm').show();
				$('#otp').prop('disabled', false);
				$('#submitOtpBtn').prop('disabled', false);
				$('#loginbttn').prop('disabled', true);
				startResendOtpTimer();
				jsonObjCookie["xUid"] = xUid;
				jsonObjCookie["empDtls"] = empDtls;
			}
			else if (response.ackMsgCode === "901") {
				alert("Incorrect credentials. Please try again.");
			}
			else if (response.ackMsgCode === '100') {
				let employee_list = JSON.stringify(response.empList.empList);
				let office_list = JSON.stringify(response.offList.officeList);
				let asset_list = response.assetList.assetDtls;
				let new_asset_list = {};
				for (let i = 0; i < asset_list.length; i++) {
					let curr_asset = asset_list[i];
					new_asset_list[curr_asset.networkType + curr_asset.assetDesc] = curr_asset.assetId;
				}
				setCookie("assetList", JSON.stringify(new_asset_list), 30);

				window.location.href = 'dashboard.jsp';

				jsonObjInput["tkn"] = response.tkn;
				jsonObjCookie["tkn"] = response.tkn;

				setCookie("empDtls", JSON.stringify(jsonObjCookie), 30); // this cookie variable store detailed data
				//following cookie variables store individual data
				setCookie("tkn", jsonObjCookie["tkn"], 30);
				setCookie("empList", employee_list, 30);
				setCookie("User", jsonObjCookie["User"], 30);
				setCookie("userAgent", jsonObjCookie["userAgent"], 30);
				setCookie("empName", jsonObjCookie.empDtls.EMNAMCL, 30);
				setCookie("designation", jsonObjCookie.empDtls.STEXTCL, 30);
				setCookie("userRole", jsonObjCookie.empDtls.STELLCL, 30);
				setCookie("office", jsonObjCookie.empDtls.LTEXTCL, 30);
				setCookie("KST01CL", jsonObjCookie.empDtls.KST01CL, 30);
				setCookie("costCenter", jsonObjCookie.empDtls.KST01CL, 30);
				setCookie("xUid", jsonObjCookie.xUid, 30);

				// Store office list in localStorage
				localStorage.setItem("officeList", office_list);  // Store full office list in localStorage
				localStorage.setItem("empList", employee_list);  // Store full employee list in localStorage

				localStorage.empListCount = JSON.parse(localStorage.getItem("empList")).length;
				localStorage.officeListCount = JSON.parse(localStorage.getItem("officeList")).length;
			}
			else if (response.ackMsgCode === '902') {
				alert("Incorrect OTP. Please check the OTP and try again.");
			}
			else if (response.ackMsgCode === "306") {
				alert(`${response.ackMsg}`);
			}
			else if (response.ackMsgCode === '105') {
				document.getElementById('resendOtpBtn').disabled = true;
				startResendOtpTimer();
			}
			else if (response.ackMsgCode === "902") {
				alert("OTP resent. Please check your registered mobile number.");
			}
			else if (response.ackMsgCode === "101") {
				setCookie("tkn", response.tkn, 30);
				alert(`${response.ackMsg}. Inspection ID: ${response.inspectionId}`);
				if (response.ackMsgCode == '101') {
					window.location.href = 'new_assignment.jsp';
				}
			}
			else if (response.ackMsgCode === "301"){
				setCookie("tkn", response.tkn, 30);
				alert(`${response.ackMsg}`);				
			}
		},
		error: function(xhr, status, error) {
			//if server not get connected 
			console.error("xhr: " + JSON.stringify(xhr) + "\nstatus: " + status + "\nerror: " + error);
		}
	});
}


