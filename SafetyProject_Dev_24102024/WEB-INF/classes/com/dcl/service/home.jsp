<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Submit JSON Data</title>
    <script src="js/jquery-3.5.1.min.js"></script>
    <script>
    function submitData() {
        var jsonobj = {
            "erp_id": $("#erp_id").val(),
            "role_id": $("#role_id").val(),
            "emp_name": $("#emp_name").val(),
            "designation": $("#designation").val(),
            "office_code": $("#office_code").val(),
            "office_name": $("#office_name").val(),
            "role_name": $("#role_name").val(),
            "auth": $("#auth").val(),
            "page_id": $("#page_id").val(),
            "tkn": $("#tkn").val()
        };
		//alert(JSON.stringify(jsonobj));
        $.ajax({
            type: "POST",
            url: "frmprtl", // replace with your actual servlet URL
            data: JSON.stringify(jsonobj),
            contentType: "application/json; charset=utf-8",
            success: function(response) {
                var newJspUrl = response.newJspUrl;
                window.location.href = newJspUrl; // Load the new JSP in the same tab
            },
            error: function(xhr, status, error) {
                $("#result").html(xhr, status, error);
            }
        });
    }
    </script>
</head>
<body>
    <h2 id="heading">Submit JSON Data</h2>
    <form id="jsonForm">
        <label for="erp_id">ERP ID:</label><br>
        <input type="text" id="erp_id" name="erp_id" value="90017401" required><br>
        <label for="role_id">Role ID:</label><br>
        <input type="text" id="role_id" name="role_id" value="4" required><br>
        <label for="emp_name">Employee Name:</label><br>
        <input type="text" id="emp_name" name="emp_name" value="Jewel Daw" required><br>
        <label for="designation">Designation:</label><br>
        <input type="text" id="designation" name="designation" value="DE (IT&C)" required><br>
        <label for="office_code">Office Code:</label><br>
        <input type="text" id="office_code" name="office_code" value="4300000" required><br>
        <label for="office_name">Office Name:</label><br>
        <input type="text" id="office_name" name="office_name" value="IT&C Cell" required><br>
        <label for="role_name">Role Name:</label><br>
        <input type="text" id="role_name" name="role_name" value="ASSIGNER-INSPECTOR" required><br>
         <label for="auth">Auth Code:</label><br>
         <input type="text" id="auth" name="auth" value="INSP_PRTL" required><br>
          <label for="page_id">Page ID:</label><br>
         <input type="text" id="page_id" name="page_id" value="403" required><br>
         
         <label for="tkn">Token:</label><br>
         <input type="text" id="tkn" name="tkn" value="gtu1y23t123twqhehqweytqwuetutwqetuqwety" required><br>
         
        <button type="button" onclick="submitData()">Submit</button>
    </form>
    <div id="result"></div>
</body>
</html>
