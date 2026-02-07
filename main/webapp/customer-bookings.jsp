<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Bookings - Customer</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
    <div class="container">
        <header class="dashboard-header">
            <h1>My Bookings</h1>
            <div class="user-info">
                <span>Welcome, <%= session.getAttribute("userName") %></span>
                <a href="${pageContext.request.contextPath}/logout" class="btn btn-secondary">Logout</a>
            </div>
        </header>
        
        <nav class="dashboard-nav">
            <a href="${pageContext.request.contextPath}/customer/" class="nav-link">Dashboard</a>
            <a href="${pageContext.request.contextPath}/customer/bookings" class="nav-link active">My Bookings</a>
            <a href="${pageContext.request.contextPath}/customer/track" class="nav-link">Track Shipment</a>
            <a href="${pageContext.request.contextPath}/customer/invoice" class="nav-link">Invoices</a>
        </nav>
        
        <main class="dashboard-content">
            <div class="section-header">
                <h2>My Bookings</h2>
                <button onclick="showBookingForm()" class="btn btn-primary">Submit New Booking</button>
            </div>
            
            <div id="bookingForm" class="form-container" style="display: none;">
                <h3>Submit Booking Request</h3>
                <form action="${pageContext.request.contextPath}/customer/submitBooking" method="post">
                    <div class="form-group">
                        <label>Description:</label>
                        <input type="text" name="description" required>
                    </div>
                    <div class="form-group">
                        <label>Weight (kg):</label>
                        <input type="number" step="0.01" name="weight" required>
                    </div>
                    <div class="form-group">
                        <label>Origin:</label>
                        <input type="text" name="origin" required>
                    </div>
                    <div class="form-group">
                        <label>Destination:</label>
                        <input type="text" name="destination" required>
                    </div>
                    <div class="form-group">
                        <label>Amount ($):</label>
                        <input type="number" step="0.01" name="amount" required>
                    </div>
                    <button type="submit" class="btn btn-primary">Submit Booking</button>
                    <button type="button" onclick="hideBookingForm()" class="btn btn-secondary">Cancel</button>
                </form>
            </div>
            
            <table class="data-table">
                <thead>
                    <tr>
                        <th>Booking ID</th>
                        <th>Description</th>
                        <th>Origin</th>
                        <th>Destination</th>
                        <th>Booking Date</th>
                        <th>Payment Status</th>
                        <th>Amount</th>
                        <th>Cargo Status</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <% List<Map<String, Object>> bookings = (List<Map<String, Object>>) request.getAttribute("bookings"); %>
                    <% if (bookings != null && !bookings.isEmpty()) { %>
                        <% for (Map<String, Object> booking : bookings) { %>
                            <tr>
                                <td><%= booking.get("bookingId") %></td>
                                <td><%= booking.get("description") %></td>
                                <td><%= booking.get("origin") %></td>
                                <td><%= booking.get("destination") %></td>
                                <td><%= booking.get("bookingDate") %></td>
                                <td><%= booking.get("paymentStatus") %></td>
                                <td>$<%= booking.get("amount") %></td>
                                <td><%= booking.get("cargoStatus") %></td>
                                <td>
                                    <a href="${pageContext.request.contextPath}/customer/track?cargoId=<%= booking.get("cargoId") %>" class="btn btn-sm">Track</a>
                                    <a href="${pageContext.request.contextPath}/customer/invoice?bookingId=<%= booking.get("bookingId") %>" class="btn btn-sm">Invoice</a>
                                </td>
                            </tr>
                        <% } %>
                    <% } else { %>
                        <tr>
                            <td colspan="9">No bookings found</td>
                        </tr>
                    <% } %>
                </tbody>
            </table>
        </main>
    </div>
    
    <script>
        function showBookingForm() {
            document.getElementById('bookingForm').style.display = 'block';
        }
        function hideBookingForm() {
            document.getElementById('bookingForm').style.display = 'none';
        }
    </script>
</body>
</html>
