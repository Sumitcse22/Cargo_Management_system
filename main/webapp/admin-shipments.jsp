<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manage Shipments - Admin</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
    <div class="container">
        <header class="dashboard-header">
            <h1>Manage Shipments</h1>
            <div class="user-info">
                <span>Welcome, <%= session.getAttribute("userName") %></span>
                <a href="${pageContext.request.contextPath}/logout" class="btn btn-secondary">Logout</a>
            </div>
        </header>
        
        <nav class="dashboard-nav">
            <a href="${pageContext.request.contextPath}/admin/" class="nav-link">Dashboard</a>
            <a href="${pageContext.request.contextPath}/admin/users" class="nav-link">Manage Users</a>
            <a href="${pageContext.request.contextPath}/admin/shipments" class="nav-link active">Manage Shipments</a>
            <a href="${pageContext.request.contextPath}/admin/reports" class="nav-link">Generate Reports</a>
        </nav>
        
        <main class="dashboard-content">
            <h2>All Shipments</h2>
            <table class="data-table">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Description</th>
                        <th>Weight</th>
                        <th>Origin</th>
                        <th>Destination</th>
                        <th>Customer</th>
                        <th>Status</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <% List<Map<String, Object>> shipments = (List<Map<String, Object>>) request.getAttribute("shipments"); %>
                    <% if (shipments != null && !shipments.isEmpty()) { %>
                        <% for (Map<String, Object> shipment : shipments) { %>
                            <tr>
                                <td><%= shipment.get("cargoId") %></td>
                                <td><%= shipment.get("description") %></td>
                                <td><%= shipment.get("weight") %> kg</td>
                                <td><%= shipment.get("origin") %></td>
                                <td><%= shipment.get("destination") %></td>
                                <td><%= shipment.get("customerName") %></td>
                                <td><%= shipment.get("status") %></td>
                                <td>
                                    <form action="${pageContext.request.contextPath}/admin/updateShipment" method="post" style="display: inline;">
                                        <input type="hidden" name="cargoId" value="<%= shipment.get("cargoId") %>">
                                        <select name="status" onchange="this.form.submit()">
                                            <option value="Pending" <%= "Pending".equals(shipment.get("status")) ? "selected" : "" %>>Pending</option>
                                            <option value="In Transit" <%= "In Transit".equals(shipment.get("status")) ? "selected" : "" %>>In Transit</option>
                                            <option value="Delivered" <%= "Delivered".equals(shipment.get("status")) ? "selected" : "" %>>Delivered</option>
                                        </select>
                                    </form>
                                </td>
                            </tr>
                        <% } %>
                    <% } else { %>
                        <tr>
                            <td colspan="8">No shipments found</td>
                        </tr>
                    <% } %>
                </tbody>
            </table>
        </main>
    </div>
</body>
</html>
