<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.ArrayList" %>
<%@ page errorPage="error.jsp" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Staff Dashboard - Cargo Management System</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
    <div class="container">
        <header class="dashboard-header">
            <h1>Transport Staff Dashboard</h1>
            <div class="user-info">
                <span>Welcome, <%= session.getAttribute("userName") != null ? session.getAttribute("userName") : "User" %></span>
                <a href="${pageContext.request.contextPath}/logout" class="btn btn-secondary">Logout</a>
            </div>
        </header>
        
        <nav class="dashboard-nav">
            <a href="${pageContext.request.contextPath}/staff/" class="nav-link active">Dashboard</a>
            <a href="${pageContext.request.contextPath}/staff/cargo" class="nav-link">Manage Cargo</a>
        </nav>
        
        <main class="dashboard-content">
            <h2>Assigned Cargo</h2>
            <table class="data-table">
                <thead>
                    <tr>
                        <th>Cargo ID</th>
                        <th>Description</th>
                        <th>Weight</th>
                        <th>Origin</th>
                        <th>Destination</th>
                        <th>Status</th>
                        <th>Vehicle No</th>
                        <th>Driver Name</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <% 
                        List<Map<String, Object>> assignedCargo = (List<Map<String, Object>>) request.getAttribute("assignedCargo");
                        if (assignedCargo == null) {
                            assignedCargo = new java.util.ArrayList<>();
                        }
                    %>
                    <% if (assignedCargo != null && !assignedCargo.isEmpty()) { %>
                        <% for (Map<String, Object> cargo : assignedCargo) { %>
                            <tr>
                                <td><%= cargo.get("cargoId") %></td>
                                <td><%= cargo.get("description") %></td>
                                <td><%= cargo.get("weight") %> kg</td>
                                <td><%= cargo.get("origin") %></td>
                                <td><%= cargo.get("destination") %></td>
                                <td><%= cargo.get("status") %></td>
                                <td><%= cargo.get("vehicleNo") %></td>
                                <td><%= cargo.get("driverName") %></td>
                                <td>
                                    <form action="${pageContext.request.contextPath}/staff/updateStatus" method="post" style="display: inline;">
                                        <input type="hidden" name="cargoId" value="<%= cargo.get("cargoId") %>">
                                        <select name="status" onchange="this.form.submit()">
                                            <option value="Pending" <%= "Pending".equals(cargo.get("status")) ? "selected" : "" %>>Pending</option>
                                            <option value="In Transit" <%= "In Transit".equals(cargo.get("status")) ? "selected" : "" %>>In Transit</option>
                                            <option value="Delivered" <%= "Delivered".equals(cargo.get("status")) ? "selected" : "" %>>Delivered</option>
                                        </select>
                                    </form>
                                </td>
                            </tr>
                        <% } %>
                    <% } else { %>
                        <tr>
                            <td colspan="9">No assigned cargo found</td>
                        </tr>
                    <% } %>
                </tbody>
            </table>
        </main>
    </div>
</body>
</html>
