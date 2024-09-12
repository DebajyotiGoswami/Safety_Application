package com.example;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.json.JSONArray;
import org.json.JSONObject;

/*@WebServlet("/EmployeeListServlet")*/
public class fetchInspectorList extends HttpServlet {
    private static final long serialVersionUID = 1L;

    // Simulating some hardcoded data for additional employees
	/*
	 * private static final String ADDITIONAL_EMP = "Debajyoti Goswami (90012775)";
	 */
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException  {
        // Set response type to JSON
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        // Reading the input JSON data from the request body
        StringBuilder sb = new StringBuilder();
        String line;
        while ((line = request.getReader().readLine()) != null) {
        	System.out.println("inside while");
        	System.out.println("line: "+ line);
            sb.append(line);
        }
        System.out.println("outside while sb= "+ sb);
        String jsonInput = sb.toString();
        System.out.println("jsonInput: "+ jsonInput);
        try {
            // Parse the input JSON array
        	System.out.println("Inside try block");
            JSONArray jsonArray = new JSONArray(jsonInput);
            System.out.println("jsonArray: "+ jsonArray);

            // Create a list to hold formatted employee details
            List<String> employeeList = new ArrayList<>();

            // Loop through the input array and format each employee
            for (int i = 0; i < jsonArray.length(); i++) {
                JSONObject empObject = jsonArray.getJSONObject(i);
                String empId = empObject.getString("empId");
                String empName = empObject.getString("empName").trim(); // trim spaces
                String formattedEmp = empName + " (" + empId + ")";
                employeeList.add(formattedEmp);
            }

            // Adding the hardcoded employee to the list
            //employeeList.add(ADDITIONAL_EMP);

            // Creating the output JSON object
            JSONObject outputJson = new JSONObject();
            outputJson.put("empList", employeeList);

            // Writing the JSON response
            response.getWriter().write(outputJson.toString());

        } catch (Exception e) {
            // Handling parsing or processing errors
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            response.getWriter().write("{\"error\":\"Invalid input data\"}");
        }
    }
}
