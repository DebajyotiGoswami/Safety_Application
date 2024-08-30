package com.example;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

/*import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;*/

/*@WebServlet("/uploadImageServlet")
@MultipartConfig*/
public class UploadImageServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	System.out.println("inside the upload image servlet");
        Part filePart = request.getPart("image1"); // Retrieves <input type="file" name="image1">
        String fileName = filePart.getSubmittedFileName();
        
        // Define the path to store the image
        String savePath = "/user_images/" + fileName;
        
        // Save the image to the local drive
        try (InputStream fileContent = filePart.getInputStream();
             FileOutputStream fos = new FileOutputStream(new File(savePath))) {
            byte[] buffer = new byte[1024];
            int bytesRead;
            while ((bytesRead = fileContent.read(buffer)) != -1) {
                fos.write(buffer, 0, bytesRead);
            }
        }

        // Save the image name to the PostgreSQL database
		/*
		 * String dbURL = "jdbc:postgresql://localhost:5432/your_database"; String
		 * dbUser = "your_username"; String dbPass = "your_password";
		 */

		/*
		 * try (Connection conn = DriverManager.getConnection(dbURL, dbUser, dbPass)) {
		 * String sql = "INSERT INTO your_table (image_name) VALUES (?)"; try
		 * (PreparedStatement statement = conn.prepareStatement(sql)) {
		 * statement.setString(1, fileName); statement.executeUpdate(); } } catch
		 * (SQLException e) { e.printStackTrace();
		 * response.getWriter().println("Error storing image in database: " +
		 * e.getMessage()); return; }
		 */

        response.getWriter().println("Image uploaded successfully!");
    }
}
