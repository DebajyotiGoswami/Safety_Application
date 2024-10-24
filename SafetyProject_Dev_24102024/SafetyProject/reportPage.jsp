<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="javax.servlet.http.HttpSession" %>
<!DOCTYPE html>
<html>
<head>
    <title>Report</title>
</head>
<body>
    <%
      
        String reportContent = (String) request.getSession().getAttribute("reportContent");
        if (reportContent != null) {
            out.println(reportContent);
        } else {
            out.println("No report available.");
        }
    %>
</body>
</html>