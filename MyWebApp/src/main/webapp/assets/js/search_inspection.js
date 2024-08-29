$(document).ready(function() {
	$('#searchBtn').click(function() {
		var fromDate = $('#fromDate').val();
		var toDate = $('#toDate').val();
		var erpId = $('#erpId').val();
		$.ajax({
			type: 'POST',
			url: 'searchInspectionServlet',
			data: { fromDate: fromDate, toDate: toDate, erpId: erpId },
			success: function(response) {
				var jsonArray = response.assignments;
				var msg=response.msg;
				if(msg=='success'){
				$('#inspectionListTable').DataTable({
					data: jsonArray,
					columns: [
						{ title: "Data" }
					],
					initComplete: function() {
						this.api().columns().every(function() {
							var column = this;
							var select = $('<select><option value=""></option></select>')
								.appendTo($(column.header()).empty())
								.on('change', function() {
									var val = $.fn.dataTable.util.escapeRegex($(this).val());
									column.search(val ? '^' + val + '$' : '', true, false).draw();
								});

							column.data().unique().sort().each(function(d, j) {
								select.append('<option value="' + d + '">' + d + '</option>');
							});
						});
					}
				});
				}
			}
		});
	});
});