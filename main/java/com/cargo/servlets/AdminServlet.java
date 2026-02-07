package com.cargo.servlets;

import com.cargo.beans.DatabaseConnection;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class AdminServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String action = request.getPathInfo();
        HttpSession session = request.getSession();
        
        if (session.getAttribute("userRole") == null || !"admin".equals(session.getAttribute("userRole"))) {
            response.sendRedirect("/login.jsp");
            return;
        }
        
        try {
            Connection conn = DatabaseConnection.getConnection();
            
            if (action == null || action.equals("/") || action.equals("")) {
                // Dashboard - show statistics
                Map<String, Integer> stats = getStatistics(conn);
                request.setAttribute("stats", stats);
                conn.close();
                request.getRequestDispatcher("/admin-dashboard.jsp").forward(request, response);
                return;
            } else if (action.equals("/dashboard") || action.equals("/dashboard/")) {
                // Dashboard - show statistics
                Map<String, Integer> stats = getStatistics(conn);
                request.setAttribute("stats", stats);
                conn.close();
                request.getRequestDispatcher("/admin-dashboard.jsp").forward(request, response);
                return;
            } else if (action.equals("/users")) {
                // Manage users
                List<Map<String, Object>> users = getUsers(conn);
                request.setAttribute("users", users);
                request.getRequestDispatcher("/admin-users.jsp").forward(request, response);
            } else if (action.equals("/shipments")) {
                // Manage shipments
                List<Map<String, Object>> shipments = getShipments(conn);
                request.setAttribute("shipments", shipments);
                request.getRequestDispatcher("/admin-shipments.jsp").forward(request, response);
            } else if (action.equals("/reports")) {
                // Generate reports
                Map<String, Object> reportData = generateReports(conn);
                request.setAttribute("reportData", reportData);
                conn.close();
                request.getRequestDispatcher("/admin-reports.jsp").forward(request, response);
                return;
            }
            
            conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("error", "Database error: " + e.getMessage());
            try {
                request.getRequestDispatcher("/error.jsp").forward(request, response);
            } catch (Exception ex) {
                response.sendRedirect("/error.jsp");
            }
        } catch (Exception e) {
            e.printStackTrace();
            try {
                request.setAttribute("error", "Error: " + e.getMessage());
                request.getRequestDispatcher("/error.jsp").forward(request, response);
            } catch (Exception ex) {
                response.sendRedirect("/error.jsp");
            }
        }
    }
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String action = request.getPathInfo();
        HttpSession session = request.getSession();
        
        if (session.getAttribute("userRole") == null || !"admin".equals(session.getAttribute("userRole"))) {
            response.sendRedirect("/login.jsp");
            return;
        }
        
        try {
            Connection conn = DatabaseConnection.getConnection();
            
            if (action.equals("/addUser")) {
                String name = request.getParameter("name");
                String email = request.getParameter("email");
                String contact = request.getParameter("contact");
                String address = request.getParameter("address");
                String password = request.getParameter("password");
                
                String sql = "INSERT INTO Customer (Name, Email, Contact, Address, Password) VALUES (?, ?, ?, ?, ?)";
                PreparedStatement pst = conn.prepareStatement(sql);
                pst.setString(1, name);
                pst.setString(2, email);
                pst.setString(3, contact);
                pst.setString(4, address);
                pst.setString(5, password);
                pst.executeUpdate();
                pst.close();
                
                response.sendRedirect("users");
            } else if (action.equals("/deleteUser")) {
                int userId = Integer.parseInt(request.getParameter("id"));
                String sql = "DELETE FROM Customer WHERE Customer_ID = ?";
                PreparedStatement pst = conn.prepareStatement(sql);
                pst.setInt(1, userId);
                pst.executeUpdate();
                pst.close();
                
                response.sendRedirect("users");
            } else if (action.equals("/updateShipment")) {
                int cargoId = Integer.parseInt(request.getParameter("cargoId"));
                String status = request.getParameter("status");
                
                String sql = "UPDATE Cargo SET Status = ? WHERE Cargo_ID = ?";
                PreparedStatement pst = conn.prepareStatement(sql);
                pst.setString(1, status);
                pst.setInt(2, cargoId);
                pst.executeUpdate();
                pst.close();
                
                response.sendRedirect("shipments");
            }
            
            conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("../error.jsp");
        }
    }
    
    private Map<String, Integer> getStatistics(Connection conn) throws SQLException {
        Map<String, Integer> stats = new HashMap<>();
        
        String sql1 = "SELECT COUNT(*) as count FROM Customer";
        PreparedStatement pst1 = conn.prepareStatement(sql1);
        ResultSet rs1 = pst1.executeQuery();
        if (rs1.next()) stats.put("totalCustomers", rs1.getInt("count"));
        rs1.close();
        pst1.close();
        
        String sql2 = "SELECT COUNT(*) as count FROM Cargo";
        PreparedStatement pst2 = conn.prepareStatement(sql2);
        ResultSet rs2 = pst2.executeQuery();
        if (rs2.next()) stats.put("totalCargo", rs2.getInt("count"));
        rs2.close();
        pst2.close();
        
        String sql3 = "SELECT COUNT(*) as count FROM Booking";
        PreparedStatement pst3 = conn.prepareStatement(sql3);
        ResultSet rs3 = pst3.executeQuery();
        if (rs3.next()) stats.put("totalBookings", rs3.getInt("count"));
        rs3.close();
        pst3.close();
        
        String sql4 = "SELECT COUNT(*) as count FROM Transport";
        PreparedStatement pst4 = conn.prepareStatement(sql4);
        ResultSet rs4 = pst4.executeQuery();
        if (rs4.next()) stats.put("totalTransports", rs4.getInt("count"));
        rs4.close();
        pst4.close();
        
        return stats;
    }
    
    private List<Map<String, Object>> getUsers(Connection conn) throws SQLException {
        List<Map<String, Object>> users = new ArrayList<>();
        String sql = "SELECT * FROM Customer ORDER BY Customer_ID DESC";
        PreparedStatement pst = conn.prepareStatement(sql);
        ResultSet rs = pst.executeQuery();
        
        while (rs.next()) {
            Map<String, Object> user = new HashMap<>();
            user.put("customerId", rs.getInt("Customer_ID"));
            user.put("name", rs.getString("Name"));
            user.put("email", rs.getString("Email"));
            user.put("contact", rs.getString("Contact"));
            user.put("address", rs.getString("Address"));
            users.add(user);
        }
        
        rs.close();
        pst.close();
        return users;
    }
    
    private List<Map<String, Object>> getShipments(Connection conn) throws SQLException {
        List<Map<String, Object>> shipments = new ArrayList<>();
        String sql = "SELECT c.*, cu.Name as CustomerName FROM Cargo c " +
                     "LEFT JOIN Customer cu ON c.Customer_ID = cu.Customer_ID ORDER BY c.Cargo_ID DESC";
        PreparedStatement pst = conn.prepareStatement(sql);
        ResultSet rs = pst.executeQuery();
        
        while (rs.next()) {
            Map<String, Object> shipment = new HashMap<>();
            shipment.put("cargoId", rs.getInt("Cargo_ID"));
            shipment.put("description", rs.getString("Description"));
            shipment.put("weight", rs.getDouble("Weight"));
            shipment.put("origin", rs.getString("Origin"));
            shipment.put("destination", rs.getString("Destination"));
            shipment.put("status", rs.getString("Status"));
            shipment.put("customerName", rs.getString("CustomerName"));
            shipments.add(shipment);
        }
        
        rs.close();
        pst.close();
        return shipments;
    }
    
    private Map<String, Object> generateReports(Connection conn) throws SQLException {
        Map<String, Object> reportData = new HashMap<>();
        
        // Total revenue
        String sql1 = "SELECT SUM(Amount) as total FROM Booking WHERE Payment_Status = 'Paid'";
        PreparedStatement pst1 = conn.prepareStatement(sql1);
        ResultSet rs1 = pst1.executeQuery();
        if (rs1.next()) reportData.put("totalRevenue", rs1.getDouble("total"));
        rs1.close();
        pst1.close();
        
        // Pending payments
        String sql2 = "SELECT SUM(Amount) as total FROM Booking WHERE Payment_Status = 'Pending'";
        PreparedStatement pst2 = conn.prepareStatement(sql2);
        ResultSet rs2 = pst2.executeQuery();
        if (rs2.next()) reportData.put("pendingPayments", rs2.getDouble("total"));
        rs2.close();
        pst2.close();
        
        // Cargo by status
        Map<String, Integer> cargoByStatus = new HashMap<>();
        String sql3 = "SELECT Status, COUNT(*) as count FROM Cargo GROUP BY Status";
        PreparedStatement pst3 = conn.prepareStatement(sql3);
        ResultSet rs3 = pst3.executeQuery();
        while (rs3.next()) {
            cargoByStatus.put(rs3.getString("Status"), rs3.getInt("count"));
        }
        reportData.put("cargoByStatus", cargoByStatus);
        rs3.close();
        pst3.close();
        
        return reportData;
    }
}
