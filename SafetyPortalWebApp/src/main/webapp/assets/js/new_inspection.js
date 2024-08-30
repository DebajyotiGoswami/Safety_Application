function submitThisForm(){
	document.getElementById("inspectionForm").submit();
}



/*
$(document).ready(function() {
	// Fetch data for problem_code dropdown
	$.ajax({
		url: 'http://localhost:8080/MyWebApp/dbUpdate',
		type: 'GET',
		dataType: 'json',
		data: { action: 'getProblems' },
		success: function(data) {
			var $problemCodeSelect = $('#problem_code');
			$problemCodeSelect.empty(); //clear existing data, if any
			$.each(data, function(index, problem) {
				$problemCodeSelect.append($('<option>', {
					value: problem.decription,
					text: problem.decription
				}));
			});
		},
		error: function(xhr, status, error) {
			console.error('Error fetching problem codes: ' + error);
		}
	});
});
*/