<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manage Cargo - Staff</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
    <div class="container">
        <header class="dashboard-header">
            <h1>Manage Cargo</h1>
            <div class="user-info">
                <span>Welcome, <%= session.getAttribute("userName") %></span>
                <a href="${pageContext.request.contextPath}/logout" class="btn btn-secondary">Logout</a>
            </div>
        </header>
        
        <nav class="dashboard-nav">
            <a href="${pageContext.request.contextPath}/staff/" class="nav-link">Dashboard</a>
            <a href="${pageContext.request.contextPath}/staff/cargo" class="nav-link active">Manage Cargo</a>
        </nav>
        
        <main class="dashboard-content">
            <h2>All Cargo</h2>
            <table class="data-table">
                <thead>
                    <tr>
                        <th>Cargo ID</th>
                        <th>Description</th>
                        <th>Weight</th>
                        <th>Origin</th>
                        <th>Destination</th>
                        <th>Customer</th>
                        <th>Status</th>
                        <th>Vehicle No</th>
                        <th>Driver</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <% List<Map<String, Object>> allCargo = (List<Map<String, Object>>) request.getAttribute("allCargo"); %>
                    <% if (allCargo != null && !allCargo.isEmpty()) { %>
                        <% for (Map<String, Object> cargo : allCargo) { %>
                            <tr>
                                <td><%= cargo.get("cargoId") %></td>
                                <td><%= cargo.get("description") %></td>
                                <td><%= cargo.get("weight") %> kg</td>
                                <td><%= cargo.get("origin") %></td>
                                <td><%= cargo.get("destination") %></td>
                                <td><%= cargo.get("customerName") != null ? cargo.get("customerName") : "N/A" %></td>
                                <td><%= cargo.get("status") %></td>
                                <td><%= cargo.get("vehicleNo") != null ? cargo.get("vehicleNo") : "Not Assigned" %></td>
                                <td><%= cargo.get("driverName") != null ? cargo.get("driverName") : "Not Assigned" %></td>
                                <td>
                                    <button onclick="showUpdateStatusForm(<%= cargo.get("cargoId") %>)" class="btn btn-sm">Update Status</button>
                                    <button onclick="showAssignTransportForm(<%= cargo.get("cargoId") %>)" class="btn btn-sm">Assign Transport</button>
                                    <button onclick="showDeliveryForm(<%= cargo.get("cargoId") %>)" class="btn btn-sm">Update Delivery</button>
                                </td>
                            </tr>
                        <% } %>
                    <% } else { %>
                        <tr>
                            <td colspan="10">No cargo found</td>
                        </tr>
                    <% } %>
                </tbody>
            </table>
        </main>
    </div>
    
    <!-- Update Status Form -->
    <div id="updateStatusModal" class="modal" style="display: none;">
        <div class="modal-content">
            <span class="close" onclick="closeModal('updateStatusModal')">&times;</span>
            <h3>Update Cargo Status</h3>
            <form action="${pageContext.request.contextPath}/staff/updateStatus" method="post">
                <input type="hidden" id="statusCargoId" name="cargoId">
                <div class="form-group">
                    <label>Status:</label>
                    <select name="status" required>
                        <option value="Pending">Pending</option>
                        <option value="In Transit">In Transit</option>
                        <option value="Delivered">Delivered</option>
                    </select>
                </div>
                <button type="submit" class="btn btn-primary">Update</button>
                <button type="button" onclick="closeModal('updateStatusModal')" class="btn btn-secondary">Cancel</button>
            </form>
        </div>
    </div>
    
    <!-- Assign Transport Form -->
    <div id="assignTransportModal" class="modal" style="display: none;">
        <div class="modal-content">
            <span class="close" onclick="closeModal('assignTransportModal')">&times;</span>
            <h3>Assign Transport</h3>
            <form action="${pageContext.request.contextPath}/staff/assignTransport" method="post">
                <input type="hidden" id="transportCargoId" name="cargoId">
                <div class="form-group">
                    <label>Vehicle No:</label>
                    <input type="text" name="vehicleNo" required>
                </div>
                <div class="form-group">
                    <label>Driver Name:</label>
                    <input type="text" name="driverName" required>
                </div>
                <div class="form-group">
                    <label>Contact:</label>
                    <input type="text" name="contact" required>
                </div>
                <button type="submit" class="btn btn-primary">Assign</button>
                <button type="button" onclick="closeModal('assignTransportModal')" class="btn btn-secondary">Cancel</button>
            </form>
        </div>
    </div>
    
    <!-- Update Delivery Form -->
    <div id="deliveryModal" class="modal" style="display: none;">
        <div class="modal-content">
            <span class="close" onclick="closeModal('deliveryModal')">&times;</span>
            <h3>Update Delivery Record</h3>
            <form action="${pageContext.request.contextPath}/staff/updateDelivery" method="post">
                <input type="hidden" id="deliveryCargoId" name="cargoId">
                <div class="form-group">
                    <label>Delivery Notes:</label>
                    <textarea name="deliveryNotes"></textarea>
                </div>
                <button type="submit" class="btn btn-primary">Update Delivery</button>
                <button type="button" onclick="closeModal('deliveryModal')" class="btn btn-secondary">Cancel</button>
            </form>
        </div>
    </div>
    
    <script>
        function showUpdateStatusForm(cargoId) {
            document.getElementById('statusCargoId').value = cargoId;
            document.getElementById('updateStatusModal').style.display = 'block';
        }
        
        function showAssignTransportForm(cargoId) {
            document.getElementById('transportCargoId').value = cargoId;
            document.getElementById('assignTransportModal').style.display = 'block';
        }
        
        function showDeliveryForm(cargoId) {
            document.getElementById('deliveryCargoId').value = cargoId;
            document.getElementById('deliveryModal').style.display = 'block';
        }
        
        function closeModal(modalId) {
            document.getElementById(modalId).style.display = 'none';
        }
        
        window.onclick = function(event) {
            if (event.target.classList.contains('modal')) {
                event.target.style.display = 'none';
            }
        };
    </script>
</body>
</html>
