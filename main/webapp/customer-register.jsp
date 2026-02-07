<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Register - Customer</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
    <div class="container">
        <div class="register-container">
            <h2>Customer Registration</h2>
            
            <form action="${pageContext.request.contextPath}/customer/register" method="post" class="register-form">
                <div class="form-group">
                    <label for="name">Full Name:</label>
                    <input type="text" id="name" name="name" required>
                </div>
                
                <div class="form-group">
                    <label for="email">Email:</label>
                    <input type="email" id="email" name="email" required>
                </div>
                
                <div class="form-group">
                    <label for="contact">Contact:</label>
                    <input type="text" id="contact" name="contact" required>
                </div>
                
                <div class="form-group">
                    <label for="address">Address:</label>
                    <textarea id="address" name="address" required></textarea>
                </div>
                
                <div class="form-group">
                    <label for="password">Password:</label>
                    <input type="password" id="password" name="password" required>
                </div>
                
                <button type="submit" class="btn btn-primary">Register</button>
            </form>
            
            <div class="register-footer">
                <p>Already have an account? <a href="login.jsp">Login here</a></p>
                <p><a href="index.jsp">Back to Home</a></p>
            </div>
        </div>
    </div>
</body>
</html>
