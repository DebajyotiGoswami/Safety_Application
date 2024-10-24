$(document).ready(function() {
	$('#searchBtn').click(function() {
		var fromDate = $('#fromDate').val();
		var toDate = $('#toDate').val();
		var erpId = $('#erpId').val();
		
		$.ajax({
			type: 'POST',
			url: 'searchAssignmentServlet',
			data: { fromDate: fromDate, toDate: toDate, erpId: erpId },
			success: function(response) {
				//alert(response);
				var responseJson=JSON.parse(response);
				var jsonArray = responseJson.assignments;
				var msg=responseJson.msg;
				//alert(jsonArray);
				//alert(msg);
				if(msg=='success'){
					populateTable(jsonArray);
				}
			}
		});
	});
	
	function populateTable(data) {
	        var tableBody = $('#resultsTableBody');
	        tableBody.empty(); // Clear any existing rows

	        // Loop through the JSON array
	        $.each(data, function(index, item) {
	            var row = $('<tr>');
	            row.append($('<td>').text(index + 1));
	            row.append($('<td>').text(item.inspection_id));
	            row.append($('<td>').text(item.emp_assigned_by));
	            row.append($('<td>').text(item.emp_assigned_to));
	            row.append($('<td>').text(item.office_code_to_inspect));
	            row.append($('<td>').text(item.inspection_from_date));
	            row.append($('<td>').text(item.inspection_to_date));
	            row.append($('<td>').text(item.status));
	            tableBody.append(row);
	        });
	    }

	
	
	
});


