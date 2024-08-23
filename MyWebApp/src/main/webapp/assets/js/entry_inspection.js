/*function submitThisForm(){
	document.getElementById("inspectionForm").submit();
}
*/
$(document).ready(function() {
	$('#submitBtn').on('click', function() {
		var inspection_id = $('#inspection_id').val();
		var location_remarks = $('#location').val();
		var problem_details = $('#problem_details').val();
		var assigned_office_code = $('#office_name').val();
		var inspection_date = $('#inspection_date').val();
		
		var jsonObj = {
			"inspection_id": inspection_id,
			"location_remarks": location_remarks,
			"problem_details": problem_details,
			"assigned_office_code": assigned_office_code,
			"inspection_date": inspection_date
		};
				
		console.log(inspection_id, inspection_date);
		console.log(jsonObj);
		
		$.ajax({
					url: 'http://localhost:8080/MyWebApp/entryInspectionServlet', // replace with above Servlet URL
					type: 'POST',
					data: JSON.stringify(jsonObj),
					success: function(data) {
						console.log("successful conn");
					},
					error: function(xhr, status, error) {
						console.log("connection failed");
						console.error('Error: ' + error);
					}
				});

	});
});		