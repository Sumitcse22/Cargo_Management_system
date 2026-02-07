<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login - Cargo Management System</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
    <div class="container">
        <div class="login-container">
            <h2>Login</h2>
            
            <% if (request.getSession().getAttribute("errorMessage") != null) { %>
                <div class="error-message">
                    <%= request.getSession().getAttribute("errorMessage") %>
                </div>
                <% request.getSession().removeAttribute("errorMessage"); %>
            <% } %>
            
            <form action="loginProcess" method="post" class="login-form">
                <div class="form-group">
                    <label for="role">Login As:</label>
                    <select name="role" id="role" required>
                        <option value="">Select Role</option>
                        <option value="admin">Admin</option>
                        <option value="customer">Customer</option>
                        <option value="staff">Transport Staff</option>
                    </select>
                </div>
                
                <div class="form-group">
                    <label for="username">Username/Email:</label>
                    <input type="text" id="username" name="username" required>
                </div>
                
                <div class="form-group">
                    <label for="password">Password:</label>
                    <input type="password" id="password" name="password" required>
                </div>
                
                <button type="submit" class="btn btn-primary">Login</button>
            </form>
            
            <div class="login-footer">
                <p>Don't have an account? <a href="registration.jsp">Register here</a></p>
                <p><a href="index.jsp">Back to Home</a></p>
            </div>
        </div>
    </div>
</body>
</html>
