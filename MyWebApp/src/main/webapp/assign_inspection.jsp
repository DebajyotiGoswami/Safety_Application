<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Assign Inspection</title>
<!-- Link to Bootstrap CSS -->
<link rel="stylesheet" href="assets/css/bootstrap.min.css">
<link rel="stylesheet" href="assets/css/inspection_navigation.css">
</head>
<body>
	<!-- Navigation Bar -->
	<nav>
		<jsp:include page="navbar.jsp" />
	</nav>

	<!-- Main Content -->
	<div class="container">
		<div class="form-container">
			<h2 class="text-center mb-4">Assign Inspection</h2>
			<form>
				<div class="mb-3 row">
					<label class="col-sm-3 col-form-label">Hello, <strong>username</strong>
						(Office Code)
					</label>
					<div class="col-sm-9">
						<p class="form-control-static"></p>
					</div>
				</div>
				<!-- <div class="mb-3 row">
                    <label for="officeCode" class="col-sm-3 col-form-label">Your Office Code</label>
                    <div class="col-sm-9">
                        <input type="text" class="form-control" id="officeCode" placeholder="Enter Office Code" required>
                    </div>
                </div> -->
				<div class="mb-3 row">
					<label for="teamMembers" class="col-sm-3 col-form-label">Number
						of Team Members</label>
					<div class="col-sm-9">
						<select class="form-control" id="teamMembers"
							onchange="updateERPFields()">
							<option value="">Select Team Members</option>
							<option value="1">1</option>
							<option value="2">2</option>
							<option value="3">3</option>
							<option value="4">4</option>
							<option value="5">5</option>
						</select>
					</div>
				</div>
				<div id="erpIdContainer"></div>
				<div class="mb-3 row">
					<label class="col-sm-3 col-form-label">Inspection Date</label>
					<div class="col-sm-4">
						<input type="date" class="form-control" id="inspectionDateStart"
							required>
					</div>
					<div class="col-sm-1 text-center">to</div>
					<div class="col-sm-4">
						<input type="date" class="form-control" id="inspectionDateEnd"
							required>
					</div>
				</div>
				<div class="mb-3 row">
					<label for="officeName" class="col-sm-3 col-form-label">Office
						Name</label>
					<!-- <div class="col-sm-9">
                        <input type="text" class="form-control" id="officeName" placeholder="Enter Office Name" required>
                    </div> -->
					<div class="col-sm-9">
						<select class="form-control" id="officeName" name="officeName"
							required>
							<option value="">Select Office Name</option>
							<!-- Add options here dynamically or hardcode them -->
							<option value="office1">Office 1</option>
							<option value="office2">Office 2</option>
							<option value="office3">Office 3</option>
						</select>
					</div>
				</div>
				<div class="mb-3 row">
					<label for="remarks" class="col-sm-3 col-form-label">Remarks</label>
					<div class="col-sm-9">
						<textarea class="form-control" id="remarks" rows="3"
							placeholder="Enter remarks"></textarea>
					</div>
				</div>
				<div class="mb-3 row">
					<div class="col-sm-12 text-center">
						<button type="submit" class="btn btn-primary">Assign
							Inspection</button>
					</div>
				</div>
			</form>
		</div>
	</div>

	<!-- Footer -->
	<footer class="text-center mt-auto">
		<div class="text-center p-3">© 2024 IT&C Cell, WBSEDCL</div>
	</footer>

	<script>
 // Fetch office names from the server
    document.addEventListener("DOMContentLoaded", function() {
    fetch('dbUpdate')  // URL to your dbUpdate servlet
        .then(response => response.json())
        .then(data => {
            const officeSelect = document.getElementById('officeName');
            data.offices.forEach(office => {
                const option = document.createElement('option');
                option.value = office.office_name; // Unique value for each option
                option.textContent = office.office_name;
                officeSelect.appendChild(option);
            });
        })
        .catch(error => console.error('Error fetching office names:', error));
});
    
    
        function updateERPFields() {
            const number = document.getElementById('teamMembers').value;
            const container = document.getElementById('erpIdContainer');
            container.innerHTML = ''; // Clear previous fields
            for (let i = 1; i <= number; i++) {
                const div = document.createElement('div');
                div.className = 'mb-3 row';
                const label = document.createElement('label');
                label.setAttribute('for', 'erpId' + i);
                label.className = 'col-sm-3 col-form-label';
                label.textContent = 'ERP ID ' + i;
                const inputDiv = document.createElement('div');
                inputDiv.className = 'col-sm-9';
                const input = document.createElement('input');
                input.type = 'text';
                input.className = 'form-control';
                input.id = 'erpId' + i;
                input.name = 'erpId' + i;
                input.placeholder = 'Enter ERP ID';
                inputDiv.appendChild(input);
                div.appendChild(label);
                div.appendChild(inputDiv);
                container.appendChild(div);
            }
        }
    </script>
</body>
</html>