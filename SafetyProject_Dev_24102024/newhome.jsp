<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Submit JSON Data</title>
    <script src="js/jquery-3.5.1.min.js"></script>
    <style>
        .loading-animation {
            display: block;
            width: 100%;
            height: 100vh;
            background: #f3f3f3;
            position: fixed;
            top: 0;
            left: 0;
            z-index: 1000;
            text-align: center;
            line-height: 100vh;
            font-size: 2em;
        }
    </style>
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
               // 	console.log(response);
                  //  var newJspUrl = response.newJspUrl;
                  //  window.location.href = newJspUrl; // Load the new JSP in the same tab
                	// $("#result").html(response);
                	 window.location.href = "reportPage.jsp";
                },
                error: function(xhr, status, error) {
                    $("#result").html(xhr, status, error);
                }
            });
        }
        
        window.onload = function() {
            submitData();
        }
    </script>
</head>
<body>
    <div class="loading-animation">Report Loading, please wait...</div>
   <%--  <% Thread.sleep(5000); %> --%>
    <form id="jsonForm" style="display:none;">
        <input type="hidden" id="erp_id" name="erp_id" value="<%= request.getSession().getAttribute("erp_id") %>">
        <input type="hidden" id="role_id" name="role_id" value="<%= request.getSession().getAttribute("role_id") %>">
        <input type="hidden" id="emp_name" name="emp_name" value="<%= request.getSession().getAttribute("emp_name") %>">
        <input type="hidden" id="designation" name="designation" value="<%= request.getSession().getAttribute("designation") %>">
        <input type="hidden" id="office_code" name="office_code" value="<%= request.getSession().getAttribute("office_code") %>">
        <input type="hidden" id="office_name" name="office_name" value="<%= request.getSession().getAttribute("office_name") %>">
        <input type="hidden" id="role_name" name="role_name" value="<%= request.getSession().getAttribute("role_name") %>">
        <input type="hidden" id="auth" name="auth" value="<%= request.getSession().getAttribute("auth") %>">
        <input type="hidden" id="page_id" name="page_id" value="<%= request.getSession().getAttribute("page_id") %>">
        <input type="hidden" id="tkn" name="tkn" value="<%= request.getSession().getAttribute("tkn") %>">
    </form>
    <div id="result"></div>
</body>
</html>
