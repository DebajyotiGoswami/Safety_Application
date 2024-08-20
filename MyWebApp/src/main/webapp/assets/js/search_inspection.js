document.getElementById('searchBtn').addEventListener('click', function() {
	const fromDate = document.getElementById('fromDate').value;
	const toDate = document.getElementById('toDate').value;

	console.log(fromDate);
	console.log(toDate);

	jsonObject = {
		"from_date": fromDate,
		"to_date": toDate
	};
	jsonString = JSON.stringify(jsonObject);
	console.log(jsonString, "is the jsonString");

	$.ajax({
		url: 'http://localhost:8080/MyWebApp/searchAssignmentServlet', 
		type: 'POST',
		data: jsonString,
		success: function(response) {
			console.log(`inner success function ${response}`);
			console.log("test");
			if (response.trim() == 'assignment data fetched') console.log("data fetch success");
			else console.log("data fetch failure");
		}
	});

	/*const results = [
		{ inspection_id: 101, assigned_by: 'debajyoti', assigned_to: 'amal', office_name: 'Office 1', from_date: '2024-08-01', to_date: '2024-08-10', status: 'Pending' },
		{ inspection_id: 102, assigned_by: 'debajyoti', assigned_to: 'bimal', office_name: 'Office 2', from_date: '2024-08-05', to_date: '2024-08-15', status: 'Completed' }
	];*/

	// Clear previous results
	/*const resultsTableBody = document.getElementById('resultsTableBody');
	resultsTableBody.innerHTML = '';*/

// Populate new results
	/*results.forEach(result => {
	if (result.from_date >= fromDate && result.to_date <= toDate) {
		const row = document.createElement('tr');
		row.innerHTML = `
		               <td>${result.inspection_id}</td>
		               <td>${result.assigned_by}</td>
                  <td>${result.assigned_to}</td>
                  <td>${result.office_name}</td>
                  <td>${result.from_date}</td>
                  <td>${result.to_date}</td>
                  <td>${result.status}</td>
              `;
			resultsTableBody.appendChild(row);
		}
		;
	// Show the results container
	document.getElementById('resultsContainer').style.display = 'block';
});*/
});