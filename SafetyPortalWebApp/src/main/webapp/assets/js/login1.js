/*$(document).ready(function() {
	// Handle login form submission
	$('#loginForm').on('submit', function(e) {
		e.preventDefault(); // Prevent default form submission

		var userId = $('#userId').val();
		var password = $('#password').val();

		// AJAX call to authenticate user and request OTP
		$.ajax({
			url: 'LoginServlet', // Server-side servlet to handle login
			type: 'POST',
			data: { userId: userId, password: password },
			success: function(response) {
				if (response.otpSent) {
					// Show OTP message and form if OTP is sent
					$('#otpMessage').show();
					$('#otpForm').show();
				} else if (response.error) {
					// Show error message if login failed
					alert(response.error);
				}
			},
			error: function(xhr, status, error) {
				console.error('Login failed: ' + error);
			}
		});
	});

	// Handle OTP form submission
	$('#otpForm').on('submit', function(e) {
		e.preventDefault(); // Prevent default form submission

		var otp = $('#otp').val();

		// AJAX call to validate OTP
		$.ajax({
			url: 'OtpServlet', // Server-side servlet to handle OTP validation
			type: 'POST',
			data: { otp: otp },
			success: function(response) {
				if (response.valid) {
					// Redirect to dashboard if OTP is correct
					window.location.href = 'dashboard.html';
				} else {
					// Show error message if OTP is incorrect
					$('#otpError').text("Invalid OTP. Please try again.").show();
				}
			},
			error: function(xhr, status, error) {
				console.error('OTP validation failed: ' + error);
			}
		});
	});
});
*/

function requestOtp() {
		document.getElementById('loginError').style.display = 'none';
		var userId = document.getElementById('userId').value;
		var password = document.getElementById('password').value;

		fetch('LoginServlet', {
			method: 'POST',
			headers: {
				'Content-Type': 'application/x-www-form-urlencoded'
			},
			body: 'userId=' + encodeURIComponent(userId) + '&password=' + encodeURIComponent(password)
		})
			.then(response => response.text())
			.then(data => {
				if (data.includes("otpSentMessage")) {
					document.getElementById('otpMessage').style.display = 'block';
					document.getElementById('otpForm').style.display = 'block';
					startOtpCountdown();
				} else {
					document.getElementById('loginError').textContent = "Invalid User ID or Password. Please try again.";
					document.getElementById('loginError').style.display = 'block';
				}
			})
			.catch(error => console.error('Error:', error));
	}

	function startOtpCountdown() {
		var submitBtn = document.getElementById('submitOtpBtn');
		var countdown = 30;
		submitBtn.disabled = false;
		submitBtn.textContent = "Submit OTP (" + countdown + ")";

		var interval = setInterval(() => {
			countdown--;
			submitBtn.textContent = "Submit OTP (" + countdown + ")";
			if (countdown <= 0) {
				clearInterval(interval);
				submitBtn.textContent = "Resend OTP";
				submitBtn.disabled = false;
				submitBtn.onclick = requestOtp;
			}
		}, 1000);
	}

	function submitOtp() {
		var otp = document.getElementById('otp').value;

		fetch('OtpServlet', {
			method: 'POST',
			headers: {
				'Content-Type': 'application/x-www-form-urlencoded'
			},
			body: 'otp=' + encodeURIComponent(otp)
		})
			.then(response => response.json())
			.then(data => {
				if (data.valid) {
					window.location.href = 'dashboard.html';
				} else {
					var otpError = document.getElementById('otpError');
					otpError.textContent = "Invalid OTP. Please try again.";
					otpError.style.display = 'block';
				}
			})
			.catch(error => console.error('Error:', error));
	}