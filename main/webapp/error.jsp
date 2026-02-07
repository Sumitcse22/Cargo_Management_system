<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Error - Cargo Management System</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
    <div class="container">
        <div class="error-container">
            <h1>Error</h1>
            <p>An error occurred while processing your request.</p>
            <% if (request.getAttribute("error") != null) { %>
                <p style="color: #dc3545; font-weight: bold;"><%= request.getAttribute("error") %></p>
            <% } %>
            <p>Please try again or contact the administrator.</p>
            <a href="index.jsp" class="btn btn-primary">Go to Home</a>
            <a href="login.jsp" class="btn btn-secondary">Go to Login</a>
        </div>
    </div>
</body>
</html>
