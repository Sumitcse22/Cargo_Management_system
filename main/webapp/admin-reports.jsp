<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.Map" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Generate Reports - Admin</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
    <div class="container">
        <header class="dashboard-header">
            <h1>Generate Reports</h1>
            <div class="user-info">
                <span>Welcome, <%= session.getAttribute("userName") %></span>
                <a href="${pageContext.request.contextPath}/logout" class="btn btn-secondary">Logout</a>
            </div>
        </header>
        
        <nav class="dashboard-nav">
            <a href="${pageContext.request.contextPath}/admin/" class="nav-link">Dashboard</a>
            <a href="${pageContext.request.contextPath}/admin/users" class="nav-link">Manage Users</a>
            <a href="${pageContext.request.contextPath}/admin/shipments" class="nav-link">Manage Shipments</a>
            <a href="${pageContext.request.contextPath}/admin/reports" class="nav-link active">Generate Reports</a>
        </nav>
        
        <main class="dashboard-content">
            <h2>Performance Reports</h2>
            <% Map<String, Object> reportData = (Map<String, Object>) request.getAttribute("reportData"); %>
            
            <div class="report-section">
                <h3>Financial Summary</h3>
                <div class="report-card">
                    <p><strong>Total Revenue:</strong> $<%= reportData != null && reportData.get("totalRevenue") != null ? 
                        String.format("%.2f", reportData.get("totalRevenue")) : "0.00" %></p>
                    <p><strong>Pending Payments:</strong> $<%= reportData != null && reportData.get("pendingPayments") != null ? 
                        String.format("%.2f", reportData.get("pendingPayments")) : "0.00" %></p>
                </div>
            </div>
            
            <div class="report-section">
                <h3>Cargo Status Distribution</h3>
                <div class="report-card">
                    <% if (reportData != null && reportData.get("cargoByStatus") != null) { %>
                        <% Map<String, Integer> cargoByStatus = (Map<String, Integer>) reportData.get("cargoByStatus"); %>
                        <% for (Map.Entry<String, Integer> entry : cargoByStatus.entrySet()) { %>
                            <p><strong><%= entry.getKey() %>:</strong> <%= entry.getValue() %></p>
                        <% } %>
                    <% } else { %>
                        <p>No data available</p>
                    <% } %>
                </div>
            </div>
        </main>
    </div>
</body>
</html>
