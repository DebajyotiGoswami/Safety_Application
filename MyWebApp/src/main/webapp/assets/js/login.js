let generatedOtp;

$(document).ready(function() {
	$('#loginbttn').on('click', function() {
		var user = $('#userId').val();
		var password = $('#password').val();
		var jsonobj = {
			"User": user,
			"Pwd": password
		};
		var jsonString = JSON.stringify(jsonobj);

		$.ajax({
			url: 'http://10.251.37.170:8080/testSafety/testSafety', // replace with your Servlet URL
			type: 'POST',
			data: jsonString,
			success: function(data) {
				if (data.ackMsgCode == '100') {
					
					$.ajax({
						url: 'http://localhost:8080/MyWebApp/loginUpdateServlet', // replace with your Servlet URL
						type: 'POST',
						data: jsonString,
						success: function(response) {
							console.log(response);
							if (response.trim() == 'otpSent') {
							generatedOtp = generateOtp();
							console.log("Generated OTP:", generatedOtp);

							// Show OTP section
							$('#otpMessage').show();
							$('#otpForm').show();
							$('#otp').prop('disabled', false);
							$('#submitOtpBtn').prop('disabled', false);

							// Start OTP countdown
							startCountdown(30);}
						}
					});
				} else {
					// Handle error (e.g., show error message)
					alert("Incorrect credentials. Please try again.");
				}
				console.log(data);
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
		window.location.href = 'dashboard.html';
	} else {
		// Show error message
		var otpError = document.getElementById('otpError');
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