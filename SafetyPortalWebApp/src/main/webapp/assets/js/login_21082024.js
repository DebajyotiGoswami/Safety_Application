let generatedOtp;
/*
$(document).ready(function() {
	$('#loginbttn').on('click', function() {
		var user = $('#userId').val();
		var password = $('#password').val();
		var userAgent = navigator.userAgent;

		// Fetch IP address using another servlet
		$.ajax({
			url: 'http://localhost:8080/MyWebApp/GetIpServlet',
			type: 'GET',
			success: function(ipResponse) {
				var ipAddr = ipResponse.ipAddr; // Extract IP address from response
				console.log("ip address: " + ipAddr);
				var jsonobj = {
					"User": user,
					"Pwd": password,
					"userAgent": userAgent,
					"ipAddr": ipAddr
				};
				console.log("jsonobj: " + jsonobj);
				var jsonString = JSON.stringify(jsonobj);
				console.log("jsonstring: " + jsonString);
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
									console.log(`inner success function ${response}`);
									console.log("test");
									console.log("response from servlet: " + response);
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
						} else {
							// Handle error (e.g., show error message)
							alert("Incorrect credentials. Please try again.");
						}
						console.log("console_data: ", data);

						var empDtls = {
							"erpId": user,
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
						});
					},
					error: function(xhr, status, error) {
						console.error('Error: ' + error);
					}
				});
			},
			error: function(xhr, status, error){
				console.error('IP Address Servlet Error: '+ error);
			}
		});
	});*/
/*
	$(document).ready(function() {
		$('#loginbttn').on('click', function() {
			var user = $('#userId').val();
			var password = $('#password').val();
			var userAgent = navigator.userAgent;
	
			// Fetch IP address using another servlet
			$.ajax({
				url: 'http://localhost:8080/MyWebApp/GetIpServlet',
				type: 'GET',
				success: function(ipResponse) {
					var ipAddr = ipResponse.ipAddr; // Extract IP address from response
					console.log("ip address: "+ ipAddr);
					var jsonobj = {
						"User": user,
						"Pwd": password,
						"userAgent": userAgent,
						"ipAddr": ipAddr
					};
					console.log("jsonobj: "+ jsonobj);
					var jsonString = JSON.stringify(jsonobj);
					console.log("jsonstring: "+ jsonString);					
					$.ajax({
						url: 'http://10.251.37.170:8080/testSafety/testSafety', // replace with your Servlet URL
						type: 'POST',
						contentType: 'application/json',
						data: jsonString,
						success: function(data) {
							if (data.ackMsgCode == '100') {
								$.ajax({
									url: 'http://localhost:8080/MyWebApp/loginUpdateServlet', // replace with your Servlet URL
									type: 'POST',
									contentType: 'application/json',
									data: jsonString,
									success: function(response) {
										if (response.trim() == 'otpSent') {
											generatedOtp = generateOtp();
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
							} else {
								// Handle error (e.g., show error message)
								alert("Incorrect credentials. Please try again.");
							}
						},
						error: function(xhr, status, error) {
							console.error('Error: ' + error);
						}
					});
				},
				error: function(xhr, status, error) {
					console.error('Error fetching IP address: ' + error);
				}
			});
		});
	});
	*/
$(document).ready(function() {
	$('#loginbttn').on('click', function() {
		var user = $('#userId').val();
		var password = $('#password').val();
		var userAgent = navigator.userAgent;

		// Fetch IP address using another servlet
		$.ajax({
			url: 'GetIpServlet',
			type: 'GET',
			success: function(ipResponse) {
				var ipAddr = ipResponse.ipAddr; // Extract IP address from response
				console.log("ip address: " + ipAddr);
				var jsonobj = {
					"User": user,
					"Pwd": password,
					"userAgent": userAgent,
					"ipAddr": ipAddr
				};
				console.log("jsonobj: " + jsonobj);
				var jsonString = JSON.stringify(jsonobj);
				console.log("jsonstring: " + jsonString);
				
				sendToTestSafety(jsonString);
			},
			error: function(xhr, status, error) {
				console.error('Error fetching IP address: ' + error);
			}
		});

		
		// Function to send data to testSafety servlet
		function sendToTestSafety(jsonString) {
		    $.ajax({
		        url: 'http://10.251.37.170:8080/testSafety/testSafety', // replace with your Servlet URL
		        type: 'POST',
		        contentType: 'application/json',
		        data: jsonString,
		        success: function(data) {
		            if (data.ackMsgCode == '100') {
		                $.ajax({
		                    url: 'loginUpdateServlet', // replace with your Servlet URL
		                    type: 'POST',
		                    contentType: 'application/json',
		                    data: jsonString,
		                    success: function(response) {
		                        if (response.trim() == 'otpSent') {
		                            generatedOtp = generateOtp();
		                            // Show OTP section
		                            $('#otpMessage').show();
		                            $('#otpForm').show();
		                            $('#otp').prop('disabled', false);
		                            $('#submitOtpBtn').prop('disabled', false);

		                            // Start OTP countdown
		                            startCountdown(30);
		                        }
		                    },
		                    error: function(xhr, status, error) {
		                        console.error('Error in loginUpdateServlet: ' + error);
		                    }
		                });
		            } else {
		                // Handle error (e.g., show error message)
		                alert("Incorrect credentials. Please try again.");
		            }
		        },
		        error: function(xhr, status, error) {
		            console.error('Error in testSafety servlet: ' + error);
		        }
		    });
		}


/*		$.ajax({
			url: 'http://10.251.37.170:8080/testSafety/testSafety', // replace with your Servlet URL
			type: 'POST',
			contentType: 'application/json',
			data: jsonString,
			success: function(data) {
				if (data.ackMsgCode == '100') {
					$.ajax({
						url: 'http://localhost:8080/MyWebApp/loginUpdateServlet', // replace with your Servlet URL
						type: 'POST',
						contentType: 'application/json',
						data: jsonString,
						success: function(response) {
							if (response.trim() == 'otpSent') {
								generatedOtp = generateOtp();
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
				} else {
					// Handle error (e.g., show error message)
					alert("Incorrect credentials. Please try again.");
				}
			},
			error: function(xhr, status, error) {
				console.error('Error: ' + error);
			}
		});
*/
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