<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.HashMap" %>
<%@ page errorPage="error.jsp" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard - Cargo Management System</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
    <div class="container">
        <header class="dashboard-header">
            <h1>Admin Dashboard</h1>
            <div class="user-info">
                <span>Welcome, <%= session.getAttribute("userName") != null ? session.getAttribute("userName") : "User" %></span>
                <a href="${pageContext.request.contextPath}/logout" class="btn btn-secondary">Logout</a>
            </div>
        </header>
        
        <nav class="dashboard-nav">
            <a href="${pageContext.request.contextPath}/admin/" class="nav-link active">Dashboard</a>
            <a href="${pageContext.request.contextPath}/admin/users" class="nav-link">Manage Users</a>
            <a href="${pageContext.request.contextPath}/admin/shipments" class="nav-link">Manage Shipments</a>
            <a href="${pageContext.request.contextPath}/admin/reports" class="nav-link">Generate Reports</a>
        </nav>
        
        <main class="dashboard-content">
            <% Map<String, Integer> stats = (Map<String, Integer>) request.getAttribute("stats"); %>
            <div class="stats-grid">
                <div class="stat-card">
                    <h3>Total Customers</h3>
                    <p class="stat-number"><%= stats != null ? stats.get("totalCustomers") : 0 %></p>
                </div>
                <div class="stat-card">
                    <h3>Total Cargo</h3>
                    <p class="stat-number"><%= stats != null ? stats.get("totalCargo") : 0 %></p>
                </div>
                <div class="stat-card">
                    <h3>Total Bookings</h3>
                    <p class="stat-number"><%= stats != null ? stats.get("totalBookings") : 0 %></p>
                </div>
                <div class="stat-card">
                    <h3>Total Transports</h3>
                    <p class="stat-number"><%= stats != null ? stats.get("totalTransports") : 0 %></p>
                </div>
            </div>
        </main>
    </div>
</body>
</html>
