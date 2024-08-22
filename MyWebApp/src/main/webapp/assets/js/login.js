let generatedOtp;

$(document).ready(function() {
	$('#loginbttn').on('click', function() {
		var user = $('#userId').val();
		var password = $('#password').val();
		var userAgent = navigator.userAgent;
		var jsonobj = {
			"User": user,
			"Pwd": password,
			"userAgent": userAgent,
			"pageName": "LOGIN"
		};
		console.log("userAgent: ", userAgent);
		console.log("jsonObj with userAgent: ", jsonobj);
		var url= 'http://10.251.37.170:8080/testSafety/testSafety';
		var jsonString = JSON.stringify(jsonobj);
		$.ajax({
			url: 'http://10.251.37.170:8080/testSafety/testSafety', // replace with above Servlet URL
			type: 'POST',
			data: jsonString,
			success: function(data) {
				console.log("url: ", url);
				console.log(typeof data);
				console.log("data: ",  data);
				console.log("data ack: ", data.ackMsgCode);
				console.log("type: ", typeof data.ackMsgCode);
				if (data.ackMsgCode == '100') {
					$.ajax({
						url: 'http://localhost:8080/MyWebApp/loginUpdateServlet', // replace with your Servlet URL
						type: 'POST',
						data: jsonString,
						success: function(response) {
							console.log(`inner success function ${response}`);
							console.log("test");
							console.log("response from servlet: "+ response);
							if (response.trim() == 'otpSent') {
								generatedOtp = generateOtp();
								console.log("Generated OTP:", generatedOtp);

							 	// Show OTP section
								$('#otpMessage').show();
								$('#otpForm').show();
								$('#otp').prop('disabled', false);
								$('#submitOtpBtn').prop('disabled', false);

								// Start OTP countdown
								startCountdown(30);
							}
						}
					});
				}else if(data.ackMsgCode == undefined){
					console.log("yes. found it");
					$('#otpMessage').show();
					$('#otpForm').show();
					$('#otp').prop('disabled', false);
					$('#submitOtpBtn').prop('disabled', false);

					// Start OTP countdown
					startCountdown(30);
				} else {
					// Handle error (e.g., show error message)
					console.log("inner failure function", data.ackMsgCode);
					alert("Incorrect credentials. Please try again.");
				}
				console.log("console_data: ", data);
				
				var empDtls = {
							    "erpId": user,
							    "name": data.empDtls.EMNAMCL,
							    "office": data.empDtls.LTEXTCL,
								"designation": data.empDtls.STEXTCL
							};
							/*console.log(empDtls);*/
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
							});
			},
			error: function(xhr, status, error) {
				console.error('Error: ' + error);
			}
		});
	});
});





function generateOtp() {
	return Math.floor(100000 + Math.random() * 900000).toString(); // Generate 6-digit OTP
}

function submitOtp() {
	var otp = document.getElementById('otp').value;

	if (otp === generatedOtp) {
		// Redirect to dashboard if OTP is correct
		/*window.location.href = 'dashboard.html';*/
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

	const interval = setInterval(() => {
		counter--;
		button.innerHTML = 'Submit OTP (' + counter + ')';
		if (counter === 0) {
			clearInterval(interval);
			button.innerHTML = 'Resend OTP';
			button.disabled = false;
			button.onclick = resendOtp;
		}
	}, 1000);
}

function resendOtp() {
	generatedOtp = generateOtp();
	console.log("Resent OTP:", generatedOtp);
	alert('OTP has been resent!');
	document.getElementById('otp').value = ''; // Clear previous OTP
	startCountdown(30); // Restart countdown for new OTP
}