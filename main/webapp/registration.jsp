<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Register - Cargo Management System</title>
    <link rel="stylesheet" href="css/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
</head>
<body>
    <div class="container">
        <div class="register-wrapper">
            <div class="register-left">
                <div class="register-brand">
                    <i class="fas fa-shipping-fast"></i>
                    <h1>Cargo Management</h1>
                </div>
                <h2>Create Your Account</h2>
                <p>Join thousands of users managing their cargo operations efficiently</p>
                
                <div class="register-benefits">
                    <div class="benefit-item">
                        <i class="fas fa-check-circle"></i>
                        <span>Real-time cargo tracking</span>
                    </div>
                    <div class="benefit-item">
                        <i class="fas fa-check-circle"></i>
                        <span>Easy booking management</span>
                    </div>
                    <div class="benefit-item">
                        <i class="fas fa-check-circle"></i>
                        <span>Invoice generation</span>
                    </div>
                    <div class="benefit-item">
                        <i class="fas fa-check-circle"></i>
                        <span>24/7 customer support</span>
                    </div>
                </div>
            </div>
            
            <div class="register-right">
                <div class="register-form-container">
                    <h3>Sign Up</h3>
                    <p class="register-subtitle">Fill in your details to create an account</p>
                    
                    <% if (request.getSession().getAttribute("errorMessage") != null) { %>
                        <div class="error-message">
                            <%= request.getSession().getAttribute("errorMessage") %>
                        </div>
                        <% request.getSession().removeAttribute("errorMessage"); %>
                    <% } %>
                    
                    <% if (request.getSession().getAttribute("successMessage") != null) { %>
                        <div class="success-message">
                            <%= request.getSession().getAttribute("successMessage") %>
                        </div>
                        <% request.getSession().removeAttribute("successMessage"); %>
                    <% } %>
                    
                    <form action="customer/register" method="post" class="register-form" id="registerForm">
                        <div class="form-row">
                            <div class="form-group">
                                <label for="name">
                                    <i class="fas fa-user"></i> Full Name
                                </label>
                                <input type="text" id="name" name="name" placeholder="Enter your full name" required>
                            </div>
                        </div>
                        
                        <div class="form-row">
                            <div class="form-group">
                                <label for="email">
                                    <i class="fas fa-envelope"></i> Email Address
                                </label>
                                <input type="email" id="email" name="email" placeholder="Enter your email" required>
                            </div>
                        </div>
                        
                        <div class="form-row">
                            <div class="form-group">
                                <label for="contact">
                                    <i class="fas fa-phone"></i> Contact Number
                                </label>
                                <input type="text" id="contact" name="contact" placeholder="Enter your contact number" required>
                            </div>
                        </div>
                        
                        <div class="form-row">
                            <div class="form-group">
                                <label for="address">
                                    <i class="fas fa-map-marker-alt"></i> Address
                                </label>
                                <textarea id="address" name="address" rows="3" placeholder="Enter your complete address" required></textarea>
                            </div>
                        </div>
                        
                        <div class="form-row">
                            <div class="form-group">
                                <label for="password">
                                    <i class="fas fa-lock"></i> Password
                                </label>
                                <input type="password" id="password" name="password" placeholder="Create a password" required>
                            </div>
                        </div>
                        
                        <div class="form-row">
                            <div class="form-group">
                                <label for="confirmPassword">
                                    <i class="fas fa-lock"></i> Confirm Password
                                </label>
                                <input type="password" id="confirmPassword" name="confirmPassword" placeholder="Confirm your password" required>
                            </div>
                        </div>
                        
                        <div class="form-checkbox">
                            <input type="checkbox" id="terms" name="terms" required>
                            <label for="terms">I agree to the <a href="#">Terms and Conditions</a> and <a href="#">Privacy Policy</a></label>
                        </div>
                        
                        <button type="submit" class="btn btn-register">
                            <i class="fas fa-user-plus"></i> Create Account
                        </button>
                    </form>
                    
                    <div class="register-footer">
                        <p>Already have an account? <a href="login.jsp">Login here</a></p>
                        <p><a href="index.jsp"><i class="fas fa-arrow-left"></i> Back to Home</a></p>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <script>
        // Password confirmation validation
        document.getElementById('registerForm').addEventListener('submit', function(e) {
            const password = document.getElementById('password').value;
            const confirmPassword = document.getElementById('confirmPassword').value;
            
            if (password !== confirmPassword) {
                e.preventDefault();
                alert('Passwords do not match!');
                return false;
            }
            
            if (password.length < 6) {
                e.preventDefault();
                alert('Password must be at least 6 characters long!');
                return false;
            }
        });
    </script>
</body>
</html>
