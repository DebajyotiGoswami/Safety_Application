var url = "http://10.251.37.170:8080/testSafety/testSafety";

var KEY1 = bigInt("10953483997285864814773860729");
var KEY2 = bigInt("37997636186218092599949125647");

var xUid= "";
var xUidEncrypted= "";
var dUidEncrypted= "";
var empDtls= "";
/*var jsonObjInput = {};
var jsonObjCookie= {};*/

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
	let countdown = 5;
	resendButton.textContent = "Resend OTP (" + String(countdown) + "s)";

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

function getCurrentDate(){
		const date = new Date();
	    let year = String(date.getFullYear());
	    
	    let month = String(date.getMonth() + 1); // Add 1 to the month
	    month = month.length === 1 ? "0" + month : month;
	    let day = String(date.getDate());
	    day = day.length === 1 ? "0" + day : day;
	    
	    //return `${year}-${day}-${month}`;
	    return year+ "-"+ day+ "-"+ month;
	}

$(document).ready(function() {
	$('#loginbttn, #submitOtpBtn, #resendOtpBtn, #assgnSubmitbtn').on('click', handleButtonClick);
});

function handleButtonClick(event) {
	const buttonId = event.target.id;
	var loginflg = false;
	var submitotpflg = false;
	var resendotpflg = false;
	var assignmentflg= false;

	var jsonObjInput = {};
	var jsonObjCookie= {};
	
	if (buttonId === 'loginbttn') {
		var User = $('#userId').val();
		var Pwd = $('#password').val();
		var userAgent = navigator.userAgent;
		var userAgent = userAgent.replace(/[^\w\s.]/g, " "); //replace all symbols with space

		if (validateLoginAndSubmit(User, Pwd)) {
			jsonObjInput = enCrypt(User, Pwd);  // use this line if encryption is working
			//jsonObj= {"User": User, "Pwd": Pwd}; // use this line if encryption is not working
			loginflg = true;
			jsonObjInput["userAgent"] = userAgent;
			jsonObjInput["pageNm"] = "LOGIN";
			jsonObjCookie["User"]= User;
			jsonObjCookie["userAgent"]= userAgent;
		} else {
			return;
		}
	}
	else if((buttonId === 'submitOtpBtn') || (buttonId === 'resendOtpBtn')) {
		var otp = $('#otp').val();
		jsonObjInput['otp']=$('#otp').val();
		jsonObjInput["pageNm"] = "OTP";
		jsonObjInput["xUid"] = xUidEncrypted;
		jsonObjInput["dUid"]= dUidEncrypted;
		jsonObjInput["empDtls"]= empDtls;
		jsonObjCookie["xUid"]= xUid;
		jsonObjCookie["empDtls"]= empDtls;
		//jsonObj["empDtls"] = JSON.parse(getCookie("empDtls"));
		if (buttonId === 'submitOtpBtn') {
			submitotpflg = true;
			if (validateOtpAndSubmit(otp)) {
				startResendOtpTimer();
			} else {
				return;
			}
		}
		else if (buttonId === 'resendOtpBtn') {
			jsonObjInput["pageNm"] = "RESOTP";
			resendotpflg = true;
		}
	}
	else if(buttonId === 'assgnSubmitbtn'){
		alert("found");
		assignmentflg= true;
		var jsonObjInput = {};
		var cookieData = JSON.parse(getCookie('empDtls'));
		var name= cookieData.empDtls.EMNAMCL;
		var designation= cookieData.empDtls.STEXTCL;
		var userRole= cookieData.empDtls.STELLCL;
		var office= cookieData.empDtls.LTEXTCL;
		
    	jsonObjInput.assignedDate= getCurrentDate();
    	jsonObjInput.inspectionFromDate= document.getElementById('inspectionDateStart').value;
    	jsonObjInput.inspectionToDate= document.getElementById('inspectionDateEnd').value;
    	jsonObjInput.inspectionId= "";
    	jsonObjInput.empAssignedTo= document.getElementById('erpId1').value;
    	jsonObjInput.empAssignedBy= cookieData.User;
    	jsonObjInput.rectifiedBy= "";
    	jsonObjInput.assignedFromOff= cookieData.empDtls.LTEXTCL;
    	jsonObjInput.officeCodeToInspect= document.getElementById('officeName').value;
    	jsonObjInput.status= "ASSIGNED";
    	jsonObjInput.inspectedBy= "";
    	jsonObjInput.tkn= cookieData.tkn;
    	jsonObjInput.pageNm= "DASH";
    	jsonObjInput.ServType= 101;
    	/*$.ajax({
    		url: 'http://10.251.37.170:8080/testSafety/testSafety', // replace with above Servlet URL
    		type: 'POST',
    		data: JSON.stringify(jsonObject),
    		success: function(response) {
    			if(response.ackMsgCode== '101'){
    				alert("assignment successful");
    				window.location.href = 'assign_inspection.jsp';
    			}
    			console.log("entered success function");
    			//alert(JSON.stringify(jsonObject));
				console.log("Data sent and session updated successfully.");
			},
			error: function(xhr, status, error) {
				//console.error("Error sending data:", status, error);
				console.error("xhr: " + JSON.stringify(xhr) + "\nstatus: " + status + "\nerror: " + error);
			}
    	});*/	
		
		alert("jsonObjInput in assignment: "+ jsonObjInput);
	}
	$.ajax({
		url: url, // replace with above Servlet URL
		type: 'POST',
		data: JSON.stringify(jsonObjInput),
		success: function(response) {
			if (loginflg) {
				if (response.ackMsgCode == '105') {
					xUid = response.xUid;
					empDtls= response.empDtls;
					xUidJson= enCrypt(xUid, "123456");
					xUidEncrypted= xUidJson.User;
					dUidEncrypted= xUidJson.Pwd;
					// Show OTP section
					$('#otpMessage').show();
					$('#otpForm').show();
					$('#otp').prop('disabled', false);
					$('#submitOtpBtn').prop('disabled', false);
					$('#loginbttn').prop('disabled', true);
					startResendOtpTimer();
				} else {
					alert("Incorrect credentials. Please try again.");
				}
			} 
			else if (submitotpflg || resendotpflg){
				if (submitotpflg) {
					if (response.ackMsgCode == '100') {
						window.location.href = 'dashboard.jsp';
						jsonObjInput["tkn"]= response.tkn;
						jsonObjCookie["tkn"]= response.tkn;
						//setCookie("empDtls", JSON.stringify(jsonObjInput), 30);
						setCookie("empDtls", JSON.stringify(jsonObjCookie), 30);
						setCookie("tkn", jsonObjCookie["tkn"], 30);
					} else {
						alert("Incorrect OTP. Please check the OTP and try again.");
					}
				} else if (resendotpflg) {
					if (response.ackMsgCode == '105') {
						document.getElementById('resendOtp').disabled = true;
						window.location.href = 'dashboard.jsp';
					} else {
						alert("OTP resent. Please check your registered mobile number.");
					}
				}
			}
			else if(assignmentflg){
				if (response.ackMsgCode == '101') {
					alert("new assignment successful");
					window.location.href = 'assign_inspection.jsp';
				}
			}
		}, error: function(xhr, status, error) {
			//if server not get connected 
			console.error("xhr: " + JSON.stringify(xhr) + "\nstatus: " + status + "\nerror: " + error);
		}
	});
}

