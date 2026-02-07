<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.Map" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Invoice - Customer</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
    <div class="container">
        <header class="dashboard-header">
            <h1>Invoice</h1>
            <div class="user-info">
                <span>Welcome, <%= session.getAttribute("userName") %></span>
                <a href="${pageContext.request.contextPath}/logout" class="btn btn-secondary">Logout</a>
            </div>
        </header>
        
        <nav class="dashboard-nav">
            <a href="${pageContext.request.contextPath}/customer/" class="nav-link">Dashboard</a>
            <a href="${pageContext.request.contextPath}/customer/bookings" class="nav-link">My Bookings</a>
            <a href="${pageContext.request.contextPath}/customer/track" class="nav-link">Track Shipment</a>
            <a href="${pageContext.request.contextPath}/customer/invoice" class="nav-link active">Invoices</a>
        </nav>
        
        <main class="dashboard-content">
            <h2>Generate Invoice</h2>
            
            <form action="${pageContext.request.contextPath}/customer/invoice" method="get" class="invoice-form">
                <div class="form-group">
                    <label for="bookingId">Booking ID:</label>
                    <input type="number" id="bookingId" name="bookingId" 
                           value="<%= request.getParameter("bookingId") != null ? request.getParameter("bookingId") : "" %>" 
                           required>
                    <button type="submit" class="btn btn-primary">Generate Invoice</button>
                </div>
            </form>
            
            <% Map<String, Object> invoice = (Map<String, Object>) request.getAttribute("invoice"); %>
            <% if (invoice != null && !invoice.isEmpty()) { %>
                <div class="invoice-container">
                    <div class="invoice-header">
                        <h2>INVOICE</h2>
                        <p>Invoice #<%= invoice.get("bookingId") %></p>
                    </div>
                    
                    <div class="invoice-body">
                        <div class="invoice-section">
                            <h3>Bill To:</h3>
                            <p><strong><%= invoice.get("customerName") %></strong></p>
                            <p><%= invoice.get("customerAddress") %></p>
                            <p>Contact: <%= invoice.get("customerContact") %></p>
                        </div>
                        
                        <div class="invoice-section">
                            <p><strong>Booking Date:</strong> <%= invoice.get("bookingDate") %></p>
                            <p><strong>Payment Status:</strong> <%= invoice.get("paymentStatus") %></p>
                        </div>
                        
                        <table class="invoice-table">
                            <thead>
                                <tr>
                                    <th>Description</th>
                                    <th>Weight</th>
                                    <th>Origin</th>
                                    <th>Destination</th>
                                    <th>Amount</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td><%= invoice.get("description") %></td>
                                    <td><%= invoice.get("weight") %> kg</td>
                                    <td><%= invoice.get("origin") %></td>
                                    <td><%= invoice.get("destination") %></td>
                                    <td>$<%= invoice.get("amount") %></td>
                                </tr>
                            </tbody>
                            <tfoot>
                                <tr>
                                    <td colspan="4" style="text-align: right;"><strong>Total:</strong></td>
                                    <td><strong>$<%= invoice.get("amount") %></strong></td>
                                </tr>
                            </tfoot>
                        </table>
                    </div>
                    
                    <div class="invoice-footer">
                        <button onclick="window.print()" class="btn btn-primary">Print Invoice</button>
                    </div>
                </div>
            <% } else if (request.getParameter("bookingId") != null) { %>
                <div class="error-message">
                    No invoice found for the given Booking ID.
                </div>
            <% } %>
        </main>
    </div>
</body>
</html>
