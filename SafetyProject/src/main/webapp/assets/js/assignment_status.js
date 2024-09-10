$(document).ready(function() {

	$('#searchBtn, #allAssignedByMeBtn').click(function() {

		$('#resultsContainer').show();

		var fromDate = $('#fromDate').val();
		var toDate = $('#toDate').val();
		var assignedTo = $('#assignedTo').val();
		var pendingAssignments = document.querySelector("#pendingAssignments").checked;

		console.log(fromDate, toDate, assignedTo, pendingAssignments);

		var data = [
			{
				"inspection_id": "12345678",
				"emp_assigned_by": "90012775",
				"emp_assigned_to": ["90012775", "90012776"],
				"office_code_to_inspect": "3332103",
				"inspection_from_date": "2024-12-05",
				"inspection_to_date": "2024-12-06",
				"status": "ASSIGNED"
			},
			{
				"inspection_id": "12345678",
				"emp_assigned_by": "90012775",
				"emp_assigned_to": ["90012775", "90012776"],
				"office_code_to_inspect": "3332103",
				"inspection_from_date": "2024-12-05",
				"inspection_to_date": "2024-12-06",
				"status": "INSPECTED"
			},
			{
				"inspection_id": "12345678",
				"emp_assigned_by": "90012775",
				"emp_assigned_to": ["90012775", "90012776"],
				"office_code_to_inspect": "3332103",
				"inspection_from_date": "2024-12-05",
				"inspection_to_date": "2024-12-06",
				"status": "ASSIGNED"
			},
			{
				"inspection_id": "12345678",
				"emp_assigned_by": "90012775",
				"emp_assigned_to": ["90012775", "90012776"],
				"office_code_to_inspect": "3332103",
				"inspection_from_date": "2024-12-05",
				"inspection_to_date": "2024-12-06",
				"status": "RECTIFIED"
			},
			{
				"inspection_id": "12345678",
				"emp_assigned_by": "90012775",
				"emp_assigned_to": ["90012775", "90012776"],
				"office_code_to_inspect": "3332103",
				"inspection_from_date": "2024-12-05",
				"inspection_to_date": "2024-12-06",
				"status": "ASSIGNED"
			},
			{
				"inspection_id": "12345678",
				"emp_assigned_by": "90012775",
				"emp_assigned_to": ["90012775", "90012776"],
				"office_code_to_inspect": "3332103",
				"inspection_from_date": "2024-12-05",
				"inspection_to_date": "2024-12-06",
				"status": "INSPECTED"
			},
			{
				"inspection_id": "12345678",
				"emp_assigned_by": "90012775",
				"emp_assigned_to": ["90012775", "90012776"],
				"office_code_to_inspect": "3332103",
				"inspection_from_date": "2024-12-05",
				"inspection_to_date": "2024-12-06",
				"status": "ASSIGNED"
			},
			{
				"inspection_id": "12345678",
				"emp_assigned_by": "90012775",
				"emp_assigned_to": ["90012775", "90012776"],
				"office_code_to_inspect": "3332103",
				"inspection_from_date": "2024-12-05",
				"inspection_to_date": "2024-12-06",
				"status": "INSPECTED"
			},
			{
				"inspection_id": "12345678",
				"emp_assigned_by": "90012775",
				"emp_assigned_to": ["90012775", "90012776"],
				"office_code_to_inspect": "3332103",
				"inspection_from_date": "2024-12-05",
				"inspection_to_date": "2024-12-06",
				"status": "ASSIGNED"
			},
			{
				"inspection_id": "12345678",
				"emp_assigned_by": "90012775",
				"emp_assigned_to": ["90012775", "90012776"],
				"office_code_to_inspect": "3332103",
				"inspection_from_date": "2024-12-05",
				"inspection_to_date": "2024-12-06",
				"status": "RECTIFIED"
			},
			{
				"inspection_id": "12345678",
				"emp_assigned_by": "90012775",
				"emp_assigned_to": ["90012775", "90012776"],
				"office_code_to_inspect": "3332103",
				"inspection_from_date": "2024-12-05",
				"inspection_to_date": "2024-12-06",
				"status": "ASSIGNED"
			},
			{
				"inspection_id": "12345678",
				"emp_assigned_by": "90012775",
				"emp_assigned_to": ["90012775", "90012776"],
				"office_code_to_inspect": "3332103",
				"inspection_from_date": "2024-12-05",
				"inspection_to_date": "2024-12-06",
				"status": "INSPECTED"
			},
			{
				"inspection_id": "12345678",
				"emp_assigned_by": "90012775",
				"emp_assigned_to": ["90012775", "90012776"],
				"office_code_to_inspect": "3332103",
				"inspection_from_date": "2024-12-05",
				"inspection_to_date": "2024-12-06",
				"status": "ASSIGNED"
			},
			{
				"inspection_id": "12345678",
				"emp_assigned_by": "90012775",
				"emp_assigned_to": ["90012775", "90012776"],
				"office_code_to_inspect": "3332103",
				"inspection_from_date": "2024-12-05",
				"inspection_to_date": "2024-12-06",
				"status": "INSPECTED"
			},
			{
				"inspection_id": "12345678",
				"emp_assigned_by": "90012775",
				"emp_assigned_to": ["90012775", "90012776"],
				"office_code_to_inspect": "3332103",
				"inspection_from_date": "2024-12-05",
				"inspection_to_date": "2024-12-06",
				"status": "ASSIGNED"
			},
			{
				"inspection_id": "12345678",
				"emp_assigned_by": "90012775",
				"emp_assigned_to": ["90012775", "90012776"],
				"office_code_to_inspect": "3332103",
				"inspection_from_date": "2024-12-05",
				"inspection_to_date": "2024-12-06",
				"status": "RECTIFIED"
			},
			{
				"inspection_id": "12345678",
				"emp_assigned_by": "90012775",
				"emp_assigned_to": ["90012775", "90012776"],
				"office_code_to_inspect": "3332103",
				"inspection_from_date": "2024-12-05",
				"inspection_to_date": "2024-12-06",
				"status": "ASSIGNED"
			},
			{
				"inspection_id": "12345678",
				"emp_assigned_by": "90012775",
				"emp_assigned_to": ["90012775", "90012776"],
				"office_code_to_inspect": "3332103",
				"inspection_from_date": "2024-12-05",
				"inspection_to_date": "2024-12-06",
				"status": "INSPECTED"
			},
			{
				"inspection_id": "12345678",
				"emp_assigned_by": "90012775",
				"emp_assigned_to": ["90012775", "90012776"],
				"office_code_to_inspect": "3332103",
				"inspection_from_date": "2024-12-05",
				"inspection_to_date": "2024-12-06",
				"status": "ASSIGNED"
			},
			{
				"inspection_id": "12345678",
				"emp_assigned_by": "90012775",
				"emp_assigned_to": ["90012775", "90012776"],
				"office_code_to_inspect": "3332103",
				"inspection_from_date": "2024-12-05",
				"inspection_to_date": "2024-12-06",
				"status": "INSPECTED"
			},
			{
				"inspection_id": "12345678",
				"emp_assigned_by": "90012775",
				"emp_assigned_to": ["90012775", "90012776"],
				"office_code_to_inspect": "3332103",
				"inspection_from_date": "2024-12-05",
				"inspection_to_date": "2024-12-06",
				"status": "ASSIGNED"
			},
			{
				"inspection_id": "12345678",
				"emp_assigned_by": "90012775",
				"emp_assigned_to": ["90012775", "90012776"],
				"office_code_to_inspect": "3332103",
				"inspection_from_date": "2024-12-05",
				"inspection_to_date": "2024-12-06",
				"status": "RECTIFIED"
			},
			{
				"inspection_id": "12345678",
				"emp_assigned_by": "90012775",
				"emp_assigned_to": ["90012775", "90012776"],
				"office_code_to_inspect": "3332103",
				"inspection_from_date": "2024-12-05",
				"inspection_to_date": "2024-12-06",
				"status": "ASSIGNED"
			},
			{
				"inspection_id": "12345678",
				"emp_assigned_by": "90012775",
				"emp_assigned_to": ["90012775", "90012776"],
				"office_code_to_inspect": "3332103",
				"inspection_from_date": "2024-12-05",
				"inspection_to_date": "2024-12-06",
				"status": "INSPECTED"
			}
		];
		//alert("before calling populate table");
		populateTable(data);
		/*$.ajax({
			type: 'POST',
			url: 'searchAssignmentServlet',
			data: { fromDate: fromDate, toDate: toDate, erpId: erpId },
			success: function(response) {
				alert(response);
				var responseJson = JSON.parse(response);
				var jsonArray = responseJson.assignments;
				var msg = responseJson.msg;
				alert(jsonArray);
				alert(msg);
				if (msg == 'success') {
					populateTable(jsonArray);
				}
			}
		});*/
	});

	/*function populateTable(data) {
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
			console.log(row);
			tableBody.append("row: "+ row);
		});
	}*/

	function populateTable(data) {
		// Get the table body element
		var tableBody = document.getElementById('resultsTableBody');
		var index = 1;

		// Clear any existing rows in the table
		tableBody.innerHTML = '';

		// Loop through the data and create rows
		data.forEach(function(item) {
			var row = document.createElement('tr');

			var serialNumber = document.createElement('td');
			serialNumber.textContent = index++;
			row.appendChild(serialNumber);

			//row.append($('<td>').text(index++));

			// Create columns for each field
			var inspectionIdCell = document.createElement('td');
			inspectionIdCell.textContent = item.inspection_id;
			row.appendChild(inspectionIdCell);

			var empAssignedByCell = document.createElement('td');
			empAssignedByCell.textContent = item.emp_assigned_by;
			row.appendChild(empAssignedByCell);

			var empAssignedToCell = document.createElement('td');
			empAssignedToCell.textContent = item.emp_assigned_to.join(', ');
			row.appendChild(empAssignedToCell);

			var officeCodeCell = document.createElement('td');
			officeCodeCell.textContent = item.office_code_to_inspect;
			row.appendChild(officeCodeCell);

			var fromDateCell = document.createElement('td');
			fromDateCell.textContent = item.inspection_from_date;
			row.appendChild(fromDateCell);

			var toDateCell = document.createElement('td');
			toDateCell.textContent = item.inspection_to_date;
			row.appendChild(toDateCell);

			var statusCell = document.createElement('td');
			statusCell.textContent = item.status;
			row.appendChild(statusCell);

			// Create a column for the anchor tag
			if (item.status === "INSPECTED" || item.status === "RECTIFIED") {
				var actionCell = document.createElement('td');
				var anchor = document.createElement('a');
				anchor.href = "detailsPage.jsp?inspectionId=" + item.inspection_id; // Dynamic URL
				anchor.textContent = "View Inspection"; // Anchor text
				//anchor.className = "btn btn-primary"; // Optional: Bootstrap button styling
				actionCell.appendChild(anchor);
				row.appendChild(actionCell);
			} else {
				// If status is not "INSPECTED", just add an empty cell
				var emptyCell = document.createElement('td');
				row.appendChild(emptyCell);
			}

			// Append the row to the table body
			tableBody.appendChild(row);
		});
	}
});


