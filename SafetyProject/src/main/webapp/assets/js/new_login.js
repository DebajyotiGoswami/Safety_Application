let generatedOtp;
var buttonIsOtpFlag = true;
/*var jsonobj= {};*/
var xUid = "";
var empDtls = "";

var erpId = "";
var emp_name = "";
var desig = "";
var office_name = "";

//var url = "http://10.251.37.170:8080/testSafety/testSafety";
var url = "/prodSafety/prodSafety";

/*var url1= "";
var url2= ""*/


$(document).ready(function() {
	/*This section is only for meeting with CE(Safety)*/
	$('#showInspectionReport').on('click', function() {
		alert("inside jewel page");
		$.ajax({
			url: 'http://10.250.34.61:8080/SafetyReportView/loadReportDashbrd', // replace with above Servlet URL
			type: 'POST',
			data: {
				erpId: empDtls.erpId,
				emp_name: empDtls.name,
				desig: empDtls.designation,
				office_name: empDtls.office
			},
			success: function(response) {
				console.log(response);
			},
			error: function(xhr, status, error) {
				console.error(xhr, status, error);
			}
		});
	});
	/*Above section is only for meeting with CE(Safety)*/



	$('#loginbttn').on('click', function() {
		var User = $('#userId').val();
		var Pwd = $('#password').val();
		var userAgent = navigator.userAgent;
		var userAgent = userAgent.replace(/[^\w\s.]/g, " "); //replace all symbols with space
		var jsonobj = {
			"User": User,
			"Pwd": Pwd,
			"userAgent": userAgent,
			"pageNm": "LOGIN"
		};
		//following ajx call is attempted when login button is clicked. 
		$.ajax({
			url: url, // replace with above Servlet URL
			type: 'POST',
			data: JSON.stringify(jsonobj),
			success: function(response) {
				console.log("data ack: ", response.ackMsgCode);
				if (response.ackMsgCode == '100') {
					console.log("Data from login serevr: "+ JSON.stringify(response));
					xUid = response.xUid;
					empDtls = response.empDtls;
					console.log("type of login empDtls: "+ typeof(empDtls));
					// Show OTP section
					$('#otpMessage').show();
					$('#otpForm').show();
					$('#otp').prop('disabled', false);
					$('#submitOtpBtn').prop('disabled', false);
					$('#loginbttn').prop('disabled', true);

					// Start OTP countdown
					buttonIsOtpFlag = startCountdown(30);
					console.log("button is : ", buttonIsOtpFlag);
				} else {
					// Handle error (e.g., show error message)
					alert("Incorrect credentials. Please try again.");
				}
				/*var empDtls = {
								"erpId": User,
								"name": data.empDtls.EMNAMCL,
								"office": data.empDtls.LTEXTCL,
								"designation": data.empDtls.STEXTCL
							};
							console.log(empDtls);
							$.ajax({
								url: 'http://localhost:8080/MyWebApp/StoreUserDetailsServlet', // Your servlet URL
								type: 'POST',
								contentType: 'application/json',
								data: JSON.stringify(empDtls),
								success: function(response) {
									console.log("Data sent and session updated successfully.");
								},
								error: function(xhr, status, error) {
									console.error("Error sending data:", status, error);
								}
							});*/
			},
			error: function(xhr, status, error) {
				//if server not get connected 
				/*console.log("error found");*/
				console.error("xhr: "+ JSON.stringify(xhr)+ "\nstatus: "+ status+ "\nerror: "+ error);
			}
		});
	});
});

$('#submitOtpBtn').on('click', function() {
	var User = $('#userId').val();
	var otp = $('#otp').val();
	console.log("user: ", User, "otp: ", otp);
	var jsonobjOtp = {
		"User": User,
		"otp": otp,
		"pageNm": "OTP",
		"xUid": xUid,
		"empDtls": empDtls
	};
	console.log("otp jsonobj is: ", jsonobjOtp);
	$.ajax({
		url: url, // replace with above Servlet URL
		type: 'POST',
		data: JSON.stringify(jsonobjOtp),
		success: function(data) {
			console.log("data ack: ", data.ackMsgCode);
			console.log("json inside success: ", JSON.stringify(jsonobjOtp));
			console.log("data inside success: ", data);
			alert("data from otp server: "+ data);
			if (data.ackMsgCode == '100') {
				alert(JSON.stringify(data));
				// data matched. go to dashboard
				console.log("OTP matched");
				window.location.href = 'dashboard.jsp';
				console.log(empDtls);
				console.log(typeof empDtls);
				//save the session variable
				var empDtls = {
					"erpId": User,
					"name": data.empDtls.EMNAMCL,
					"office": data.empDtls.LTEXTCL,
					"designation": data.empDtls.STEXTCL,
					"role": data.role,
					"xUid": data.xUid,
					"tkn": data.tkn
				};
				console.log(empDtls);
				$.ajax({
					url: 'StoreUserDetailsServlet', // Your servlet URL
					type: 'POST',
					contentType: 'application/json',
					data: JSON.stringify(empDtls),
					success: function(response) {
						console.log("Data sent and session updated successfully.");
						alert(response);
					},
					error: function(xhr, status, error) {
						console.error("Error sending data:", status, error);
					}
				});
			} else {
				if (buttonIsOtpFlag) { //button is for submit otp
					console.log("OTP did not matched. Show the section again.");
					alert("Incorrect OTP. Please try again.");
					// Show OTP section
					$('#otpMessage').show();
					$('#otpForm').show();
					$('#otp').prop('disabled', false);
					$('#submitOtpBtn').prop('disabled', false);

					// Start OTP countdown
					startCountdown(30);
					// Handle error (e.g., show error message)
				} else {
					//this section need to be written later
					console.log("not for now");
				}

				//console.log("inner failure function", data.ackMsgCode);
				//alert("Incorrect OTP. Please try again.");
			}

		},
		error: function(xhr, status, error) {
			//if server not get connected 
			console.log("error otp found");
			console.error('Error: ' + error);
		}
	});
});







function generateOtp() {
	return Math.floor(100000 + Math.random() * 900000).toString(); // Generate 6-digit OTP
}

function submitOtp() {
	var otp = document.getElementById('otp').value;

	if (otp === generatedOtp) {
		// Redirect to dashboard if OTP is correct
		window.location.href = 'dashboard.html';
		window.location.href = 'dashboard.jsp';
	} else {
		// Show error message
		var otpError = document.getElementById('otpError');
		console.log(otpError.textContent);
		otpError.textContent = "Invalid OTP. Please try again.";
		otpError.style.display = 'block';
	}
}

function startCountdown(seconds) {
	let counter = seconds;
	const button = document.getElementById('submitOtpBtn');
	button.innerHTML = 'Submit OTP (' + counter + ')';
	button.disabled = false;
	let buttonIsOtpFlag = true; //this button is for otp now

	const interval = setInterval(() => {
		counter--;
		button.innerHTML = 'Submit OTP (' + counter + ')';
		if (counter === 0) {
			clearInterval(interval);
			button.innerHTML = 'Resend OTP';
			button.disabled = false;
			button.onclick = resendOtp;
			buttonIsOtpFlag = false   //this button is for resend now
		}
	}, 1000);
	return buttonIsOtpFlag;
}

/*function resendOtp() {
	generatedOtp = generateOtp();
	console.log("Resent OTP:", generatedOtp);
	alert('OTP has been resent!');
	document.getElementById('otp').value = ''; // Clear previous OTP
	startCountdown(30); // Restart countdown for new OTP
}*/