<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manage Users - Admin</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
    <div class="container">
        <header class="dashboard-header">
            <h1>Manage Users</h1>
            <div class="user-info">
                <span>Welcome, <%= session.getAttribute("userName") %></span>
                <a href="${pageContext.request.contextPath}/logout" class="btn btn-secondary">Logout</a>
            </div>
        </header>
        
        <nav class="dashboard-nav">
            <a href="${pageContext.request.contextPath}/admin/" class="nav-link">Dashboard</a>
            <a href="${pageContext.request.contextPath}/admin/users" class="nav-link active">Manage Users</a>
            <a href="${pageContext.request.contextPath}/admin/shipments" class="nav-link">Manage Shipments</a>
            <a href="${pageContext.request.contextPath}/admin/reports" class="nav-link">Generate Reports</a>
        </nav>
        
        <main class="dashboard-content">
            <div class="section-header">
                <h2>All Customers</h2>
                <button onclick="showAddUserForm()" class="btn btn-primary">Add New User</button>
            </div>
            
            <div id="addUserForm" class="form-container" style="display: none;">
                <h3>Add New Customer</h3>
                <form action="${pageContext.request.contextPath}/admin/addUser" method="post">
                    <div class="form-group">
                        <label>Name:</label>
                        <input type="text" name="name" required>
                    </div>
                    <div class="form-group">
                        <label>Email:</label>
                        <input type="email" name="email" required>
                    </div>
                    <div class="form-group">
                        <label>Contact:</label>
                        <input type="text" name="contact" required>
                    </div>
                    <div class="form-group">
                        <label>Address:</label>
                        <textarea name="address" required></textarea>
                    </div>
                    <div class="form-group">
                        <label>Password:</label>
                        <input type="password" name="password" required>
                    </div>
                    <button type="submit" class="btn btn-primary">Add User</button>
                    <button type="button" onclick="hideAddUserForm()" class="btn btn-secondary">Cancel</button>
                </form>
            </div>
            
            <table class="data-table">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Name</th>
                        <th>Email</th>
                        <th>Contact</th>
                        <th>Address</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <% List<Map<String, Object>> users = (List<Map<String, Object>>) request.getAttribute("users"); %>
                    <% if (users != null && !users.isEmpty()) { %>
                        <% for (Map<String, Object> user : users) { %>
                            <tr>
                                <td><%= user.get("customerId") %></td>
                                <td><%= user.get("name") %></td>
                                <td><%= user.get("email") %></td>
                                <td><%= user.get("contact") %></td>
                                <td><%= user.get("address") %></td>
                                <td>
                                    <form action="${pageContext.request.contextPath}/admin/deleteUser" method="post" style="display: inline;">
                                        <input type="hidden" name="id" value="<%= user.get("customerId") %>">
                                        <button type="submit" class="btn btn-danger" onclick="return confirm('Are you sure?')">Delete</button>
                                    </form>
                                </td>
                            </tr>
                        <% } %>
                    <% } else { %>
                        <tr>
                            <td colspan="6">No users found</td>
                        </tr>
                    <% } %>
                </tbody>
            </table>
        </main>
    </div>
    
    <script>
        function showAddUserForm() {
            document.getElementById('addUserForm').style.display = 'block';
        }
        function hideAddUserForm() {
            document.getElementById('addUserForm').style.display = 'none';
        }
    </script>
</body>
</html>
