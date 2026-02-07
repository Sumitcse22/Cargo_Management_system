<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page errorPage="error.jsp" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Customer Dashboard - Cargo Management System</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
    <div class="container">
        <header class="dashboard-header">
            <h1>Customer Dashboard</h1>
            <div class="user-info">
                <span>Welcome, <%= session.getAttribute("userName") != null ? session.getAttribute("userName") : "User" %></span>
                <a href="${pageContext.request.contextPath}/logout" class="btn btn-secondary">Logout</a>
            </div>
        </header>
        
        <nav class="dashboard-nav">
            <a href="${pageContext.request.contextPath}/customer/" class="nav-link active">Dashboard</a>
            <a href="${pageContext.request.contextPath}/customer/bookings" class="nav-link">My Bookings</a>
            <a href="${pageContext.request.contextPath}/customer/track" class="nav-link">Track Shipment</a>
            <a href="${pageContext.request.contextPath}/customer/invoice" class="nav-link">Invoices</a>
        </nav>
        
        <main class="dashboard-content">
            <h2>Welcome to Your Dashboard</h2>
            <div class="action-cards">
                <div class="action-card">
                    <h3>Submit Booking Request</h3>
                    <p>Create a new cargo booking</p>
                    <a href="${pageContext.request.contextPath}/customer/bookings" class="btn btn-primary">Book Now</a>
                </div>
                <div class="action-card">
                    <h3>Track Shipment</h3>
                    <p>Track your cargo status</p>
                    <a href="${pageContext.request.contextPath}/customer/track" class="btn btn-primary">Track</a>
                </div>
                <div class="action-card">
                    <h3>View Invoices</h3>
                    <p>Generate and view invoices</p>
                    <a href="${pageContext.request.contextPath}/customer/invoice" class="btn btn-primary">View Invoices</a>
                </div>
            </div>
        </main>
    </div>
</body>
</html>
