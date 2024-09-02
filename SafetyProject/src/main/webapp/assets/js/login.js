var url = "http://10.251.37.170:8080/testSafety/testSafety";

var KEY1=bigInt("10953483997285864814773860729");
var KEY2=bigInt("37997636186218092599949125647");

var devEle= {};
var jsonObj = {};

function enCrypt(uid,pwd)
{	
	alert("inside enCrypt");
	//$(document).ready(function(){
		alert("inside document ready");
		//var uid=devEle["enIdCon"];
		//var pwd=devEle["enAuthCon"];
		var uidConver= [];
		var pwdConver=[];
		var enIden =[];
		var enAuth =[];
		var enIdCon="";
		var enAuthCon="";
//		var devEle= {};
		
		for (var i = 0; i < uid.length; i++) 
		{
			uidConver[i]=uid.charCodeAt(i);
			var bigtemp=bigInt(uidConver[i]);
			enIden[i]=bigInt(uidConver[i]).modPow(KEY1,KEY2).toString(16);
			enIdCon=enIdCon.concat(enIden[i]);
			if(i!=(uid.length-1)){
				enIdCon=enIdCon.concat("@");}
		}
		for (var i = 0; i < pwd.length; i++) 
		{
			pwdConver[i]=pwd.charCodeAt(i);
			enAuth[i]=bigInt(pwdConver[i]).modPow(KEY1,KEY2).toString(16);
			enAuthCon=enAuthCon.concat(enAuth[i]);
			if(i!=(pwd.length-1)){
				enAuthCon=enAuthCon.concat("?");}

		}
		//devEle["User"]=enIdCon;
		//devEle["Pwd"]=enAuthCon;
		jsonObj["User"]= enIdCon;
		jsonObj["Pwd"]= enAuthCon;
		alert("User: "+ JSON.stringify(jsonObj))
		//console.log(JSON.stringify(jsonObj));
	//});
	//return devEle;
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

$(document).ready(function() {
	$('#loginbttn, #submitOtpBtn, #resendOtpBtn').on('click', handleButtonClick);
});

function handleButtonClick(event) {
	const buttonId = event.target.id;
	var loginflg = false;
	var submitotpflg = false;
	var resendotpflg = false;
	//var jsonObj = {};
	

	if (buttonId === 'loginbttn') {
		var User = $('#userId').val();
		var Pwd = $('#password').val();
		if (validateLoginAndSubmit(User, Pwd)) {
			console.log("User: "+ User+ " Pwd: "+ Pwd);
//			jsonObj= enCrypt(User, Pwd);
			enCrypt(User, Pwd);
			alert("after enCrypt");
			alert("jsonObj after enCrypt: "+ JSON.stringify(jsonObj));
			//console.log("jsonObj after enCrypt: "+ JSON.stringify(jsonObj));
			//jsonObj= devEle;
			//console.log(jsonObj);
			loginflg = true;
			var userAgent = navigator.userAgent;
			var userAgent = userAgent.replace(/[^\w\s.]/g, " "); //replace all symbols with space
			jsonObj["userAgent"]= userAgent;
			jsonObj["pageNm"]= "LOGIN";
/*			jsonObj = {
				"User": User,
				"Pwd": Pwd,
				"userAgent": userAgent,
				"pageNm": "LOGIN"
			};*/
		} else {
			return;
		}
	}
	else {
		var otp = $('#otp').val();
		jsonObj["pageNm"]= "OTP";
		jsonObj["xUid"]= xUid;
		jsonObj["empDtls"]= JSON.parse(getCookie("empDtls"));
	/*	jsonObj = {
			"User": User,
			"otp": otp,
			"pageNm": "OTP",
			"xUid": xUid,
			"empDtls": JSON.parse(getCookie("empDtls"))
		};*/
		if (buttonId === 'submitOtpBtn') {
			submitotpflg = true;
			if (validateOtpAndSubmit(otp)) {
				startResendOtpTimer();
			} else {
				return;
			}
		}
		else if (buttonId === 'resendOtpBtn') {
			jsonObj["pageNm"]= "RESOTP";
			resendotpflg = true;
		}
	}

	$.ajax({
		url: url, // replace with above Servlet URL
		type: 'POST',
		data: JSON.stringify(jsonObj),
		success: function(response) {
			if (loginflg) {
				if (response.ackMsgCode == '105') {
					xUid = response.xUid;
					setCookie("empDtls", JSON.stringify(response.empDtls), 30);
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
			} else {
				var empDtls = {
					"erpId": User,
					"name": response.empDtls.EMNAMCL,
					"office": response.empDtls.LTEXTCL,
					"designation": response.empDtls.STEXTCL,
					"role": response.role,
					"xUid": response.xUid,
					"tkn": response.tkn
				};
				if (submitotpflg) {
					if (response.ackMsgCode == '100') {
						window.location.href = 'dashboard.jsp';
						setCookie("empDtls", empDtls, 30);
					} else {
						alert("Incorrect OTP. Please check the OTP and try again.");
					}
				} else if (resendotpflg) {
					if (response.ackMsgCode == '100') {
						document.getElementById('resendOtp').disabled = true;
						window.location.href = 'dashboard.jsp';
					} else {
						alert("OTP resent. Please check your registered mobile number.");
					}
				}
			}
		}, error: function(xhr, status, error) {
			//if server not get connected 
			console.error("xhr: " + JSON.stringify(xhr) + "\nstatus: " + status + "\nerror: " + error);
		}
	});


}


