
$(document).ready(function() {
	// Fetch data for problem_code dropdown
	$.ajax({
		url: 'http://localhost:8080/MyWebApp/dbUpdate', 
		type: 'GET',
		data: { action: 'getProblems' },
		success: function(response) {
			console.log("js response: "+ response);
			var problems = JSON.parse(response);
			var problemSelect = $('#problem_code');
			problemSelect.empty();
			problemSelect.append('<option value="">Select Problem Code</option>');
			$.each(problems, function(index, problem) {
				problemSelect.append('<option value="' + problem.code + '">' + problem.description + '</option>');
			});
		}
	});

	// Fetch data for office_name dropdown
	$.ajax({
		url: 'dbUpdate', // Adjust URL to your servlet
		type: 'GET',
		data: { action: 'getOffices' },
		success: function(response) {
			var offices = JSON.parse(response);
			var officeSelect = $('#office_name');
			officeSelect.empty();
			officeSelect.append('<option value="">Select Office</option>');
			$.each(offices, function(index, office) {
				officeSelect.append('<option value="' + office.code + '">' + office.name + '</option>');
			});
		}
	});

	// Handle form submission
	$('#submitBtn').click(function() {
		$.ajax({
			url: 'dbUpdate', // Adjust URL to your servlet
			type: 'POST',
			data: $('#inspectionForm').serialize() + '&action=updateVulnerabilities',
			success: function(response) {
				alert('Inspection data submitted successfully!');
			},
			error: function() {
				alert('An error occurred while submitting the data.');
			}
		});
	});
});
