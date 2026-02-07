<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Cargo Management System - Efficient Cargo Tracking & Management</title>
    <link rel="stylesheet" href="css/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
</head>
<body>
    <div class="landing-page">
        <!-- Navigation Bar -->
        <nav class="top-nav">
            <div class="nav-container">
                <div class="logo">
                    <i class="fas fa-shipping-fast"></i>
                    <span>Cargo Management</span>
                </div>
                <div class="nav-links">
                    <a href="#features">Features</a>
                    <a href="#about">About</a>
                    <a href="login.jsp" class="nav-login">Login</a>
                    <a href="registration.jsp" class="nav-register">Register</a>
                </div>
            </div>
        </nav>

        <!-- Hero Section -->
        <section class="hero-section">
            <div class="hero-content">
                <h1 class="hero-title">Streamline Your Cargo Operations</h1>
                <p class="hero-subtitle">Complete cargo management solution for tracking, booking, and managing shipments with ease</p>
                <div class="hero-buttons">
                    <a href="registration.jsp" class="btn btn-hero-primary">
                        <i class="fas fa-user-plus"></i> Get Started Free
                    </a>
                    <a href="login.jsp" class="btn btn-hero-secondary">
                        <i class="fas fa-sign-in-alt"></i> Login
                    </a>
                </div>
                <div class="hero-stats">
                    <div class="stat-item">
                        <div class="stat-number">1000+</div>
                        <div class="stat-label">Active Users</div>
                    </div>
                    <div class="stat-item">
                        <div class="stat-number">50K+</div>
                        <div class="stat-label">Shipments Tracked</div>
                    </div>
                    <div class="stat-item">
                        <div class="stat-number">99%</div>
                        <div class="stat-label">Satisfaction Rate</div>
                    </div>
                </div>
            </div>
            <div class="hero-image">
                <div class="floating-card card-1">
                    <i class="fas fa-box"></i>
                    <span>Cargo Tracking</span>
                </div>
                <div class="floating-card card-2">
                    <i class="fas fa-truck"></i>
                    <span>Fast Delivery</span>
                </div>
                <div class="floating-card card-3">
                    <i class="fas fa-chart-line"></i>
                    <span>Analytics</span>
                </div>
            </div>
        </section>

        <!-- Features Section -->
        <section id="features" class="features-section">
            <div class="section-container">
                <h2 class="section-title">Why Choose Our Platform?</h2>
                <p class="section-subtitle">Everything you need to manage your cargo operations efficiently</p>
                
                <div class="features-grid">
                    <div class="feature-box">
                        <div class="feature-icon">
                            <i class="fas fa-map-marked-alt"></i>
                        </div>
                        <h3>Real-Time Tracking</h3>
                        <p>Track your shipments in real-time from origin to destination. Get instant updates on cargo status and location.</p>
                    </div>
                    
                    <div class="feature-box">
                        <div class="feature-icon">
                            <i class="fas fa-calendar-check"></i>
                        </div>
                        <h3>Easy Booking</h3>
                        <p>Simple and intuitive booking system. Submit cargo requests with just a few clicks and manage all your bookings in one place.</p>
                    </div>
                    
                    <div class="feature-box">
                        <div class="feature-icon">
                            <i class="fas fa-file-invoice-dollar"></i>
                        </div>
                        <h3>Invoice Management</h3>
                        <p>Generate invoices instantly, track payments, and manage all your financial records seamlessly.</p>
                    </div>
                    
                    <div class="feature-box">
                        <div class="feature-icon">
                            <i class="fas fa-chart-bar"></i>
                        </div>
                        <h3>Analytics & Reports</h3>
                        <p>Comprehensive reports and analytics to help you make data-driven decisions for your business.</p>
                    </div>
                    
                    <div class="feature-box">
                        <div class="feature-icon">
                            <i class="fas fa-users-cog"></i>
                        </div>
                        <h3>User Management</h3>
                        <p>Efficient user management system for admins to manage customers, staff, and system operations.</p>
                    </div>
                    
                    <div class="feature-box">
                        <div class="feature-icon">
                            <i class="fas fa-shield-alt"></i>
                        </div>
                        <h3>Secure & Reliable</h3>
                        <p>Enterprise-grade security with reliable infrastructure to keep your data safe and operations running smoothly.</p>
                    </div>
                </div>
            </div>
        </section>

        <!-- How It Works Section -->
        <section class="how-it-works">
            <div class="section-container">
                <h2 class="section-title">How It Works</h2>
                <div class="steps-container">
                    <div class="step-item">
                        <div class="step-number">1</div>
                        <div class="step-icon"><i class="fas fa-user-plus"></i></div>
                        <h3>Register</h3>
                        <p>Create your account in seconds. Choose your role - Customer, Admin, or Transport Staff.</p>
                    </div>
                    <div class="step-arrow"><i class="fas fa-arrow-right"></i></div>
                    <div class="step-item">
                        <div class="step-number">2</div>
                        <div class="step-icon"><i class="fas fa-box"></i></div>
                        <h3>Book Cargo</h3>
                        <p>Submit your cargo booking request with details like weight, origin, and destination.</p>
                    </div>
                    <div class="step-arrow"><i class="fas fa-arrow-right"></i></div>
                    <div class="step-item">
                        <div class="step-number">3</div>
                        <div class="step-icon"><i class="fas fa-shipping-fast"></i></div>
                        <h3>Track & Manage</h3>
                        <p>Track your shipments in real-time and manage all operations from your dashboard.</p>
                    </div>
                </div>
            </div>
        </section>

        <!-- CTA Section -->
        <section class="cta-section">
            <div class="cta-content">
                <h2>Ready to Get Started?</h2>
                <p>Join thousands of satisfied customers managing their cargo operations efficiently</p>
                <div class="cta-buttons">
                    <a href="registration.jsp" class="btn btn-cta-primary">
                        <i class="fas fa-rocket"></i> Start Free Trial
                    </a>
                    <a href="login.jsp" class="btn btn-cta-secondary">
                        <i class="fas fa-sign-in-alt"></i> Login to Account
                    </a>
                </div>
            </div>
        </section>

        <!-- Footer -->
        <footer class="landing-footer">
            <div class="footer-container">
                <div class="footer-section">
                    <h3><i class="fas fa-shipping-fast"></i> Cargo Management</h3>
                    <p>Your trusted partner for efficient cargo operations and shipment management.</p>
                </div>
                <div class="footer-section">
                    <h4>Quick Links</h4>
                    <ul>
                        <li><a href="index.jsp">Home</a></li>
                        <li><a href="#features">Features</a></li>
                        <li><a href="login.jsp">Login</a></li>
                        <li><a href="registration.jsp">Register</a></li>
                    </ul>
                </div>
                <div class="footer-section">
                    <h4>Support</h4>
                    <ul>
                        <li><a href="#about">About Us</a></li>
                        <li><a href="#">Contact</a></li>
                        <li><a href="#">Help Center</a></li>
                        <li><a href="#">Privacy Policy</a></li>
                    </ul>
                </div>
            </div>
            <div class="footer-bottom">
                <p>&copy; 2024 Cargo Management System. All rights reserved.</p>
            </div>
        </footer>
    </div>
</body>
</html>
