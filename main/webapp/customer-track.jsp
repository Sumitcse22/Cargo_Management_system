<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.Map" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Track Shipment - Customer</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
    <div class="container">
        <header class="dashboard-header">
            <h1>Track Shipment</h1>
            <div class="user-info">
                <span>Welcome, <%= session.getAttribute("userName") %></span>
                <a href="${pageContext.request.contextPath}/logout" class="btn btn-secondary">Logout</a>
            </div>
        </header>
        
        <nav class="dashboard-nav">
            <a href="${pageContext.request.contextPath}/customer/" class="nav-link">Dashboard</a>
            <a href="${pageContext.request.contextPath}/customer/bookings" class="nav-link">My Bookings</a>
            <a href="${pageContext.request.contextPath}/customer/track" class="nav-link active">Track Shipment</a>
            <a href="${pageContext.request.contextPath}/customer/invoice" class="nav-link">Invoices</a>
        </nav>
        
        <main class="dashboard-content">
            <h2>Track Your Shipment</h2>
            
            <form action="${pageContext.request.contextPath}/customer/track" method="get" class="track-form">
                <div class="form-group">
                    <label for="cargoId">Cargo ID:</label>
                    <input type="number" id="cargoId" name="cargoId" 
                           value="<%= request.getParameter("cargoId") != null ? request.getParameter("cargoId") : "" %>" 
                           required>
                    <button type="submit" class="btn btn-primary">Track</button>
                </div>
            </form>
            
            <% Map<String, Object> trackingInfo = (Map<String, Object>) request.getAttribute("trackingInfo"); %>
            <% if (trackingInfo != null && !trackingInfo.isEmpty()) { %>
                <div class="tracking-info">
                    <h3>Tracking Details</h3>
                    <div class="info-card">
                        <p><strong>Cargo ID:</strong> <%= trackingInfo.get("cargoId") %></p>
                        <p><strong>Description:</strong> <%= trackingInfo.get("description") %></p>
                        <p><strong>Origin:</strong> <%= trackingInfo.get("origin") %></p>
                        <p><strong>Destination:</strong> <%= trackingInfo.get("destination") %></p>
                        <p><strong>Status:</strong> <span class="status-badge"><%= trackingInfo.get("status") %></span></p>
                        <% if (trackingInfo.get("vehicleNo") != null) { %>
                            <p><strong>Vehicle No:</strong> <%= trackingInfo.get("vehicleNo") %></p>
                            <p><strong>Driver Name:</strong> <%= trackingInfo.get("driverName") %></p>
                            <p><strong>Driver Contact:</strong> <%= trackingInfo.get("driverContact") %></p>
                        <% } %>
                        <p><strong>Booking Date:</strong> <%= trackingInfo.get("bookingDate") %></p>
                        <p><strong>Payment Status:</strong> <%= trackingInfo.get("paymentStatus") %></p>
                    </div>
                </div>
            <% } else if (request.getParameter("cargoId") != null) { %>
                <div class="error-message">
                    No tracking information found for the given Cargo ID.
                </div>
            <% } %>
        </main>
    </div>
</body>
</html>
