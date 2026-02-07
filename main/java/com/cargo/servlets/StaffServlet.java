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

public class StaffServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String action = request.getPathInfo();
        HttpSession session = request.getSession();
        
        if (session.getAttribute("userRole") == null || !"staff".equals(session.getAttribute("userRole"))) {
            response.sendRedirect("/login.jsp");
            return;
        }
        
        try {
            Connection conn = DatabaseConnection.getConnection();
            
            if (action == null || action.equals("/") || action.equals("")) {
                // Dashboard - show assigned cargo
                List<Map<String, Object>> assignedCargo = getAssignedCargo(conn);
                request.setAttribute("assignedCargo", assignedCargo);
                conn.close();
                request.getRequestDispatcher("/staff-dashboard.jsp").forward(request, response);
                return;
            } else if (action.equals("/dashboard") || action.equals("/dashboard/")) {
                // Dashboard - show assigned cargo
                List<Map<String, Object>> assignedCargo = getAssignedCargo(conn);
                request.setAttribute("assignedCargo", assignedCargo);
                conn.close();
                request.getRequestDispatcher("/staff-dashboard.jsp").forward(request, response);
                return;
            } else if (action.equals("/cargo")) {
                // View all cargo
                List<Map<String, Object>> allCargo = getAllCargo(conn);
                request.setAttribute("allCargo", allCargo);
                conn.close();
                request.getRequestDispatcher("/staff-cargo.jsp").forward(request, response);
                return;
            }
            
            conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
            try {
                request.setAttribute("error", "Database error: " + e.getMessage());
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
        
        if (session.getAttribute("userRole") == null || !"staff".equals(session.getAttribute("userRole"))) {
            response.sendRedirect("/login.jsp");
            return;
        }
        
        try {
            Connection conn = DatabaseConnection.getConnection();
            
            if (action.equals("/updateStatus")) {
                // Update cargo status
                int cargoId = Integer.parseInt(request.getParameter("cargoId"));
                String status = request.getParameter("status");
                
                String sql = "UPDATE Cargo SET Status = ? WHERE Cargo_ID = ?";
                PreparedStatement pst = conn.prepareStatement(sql);
                pst.setString(1, status);
                pst.setInt(2, cargoId);
                pst.executeUpdate();
                pst.close();
                
                response.sendRedirect("cargo");
            } else if (action.equals("/assignTransport")) {
                // Assign transport to cargo
                int cargoId = Integer.parseInt(request.getParameter("cargoId"));
                String vehicleNo = request.getParameter("vehicleNo");
                String driverName = request.getParameter("driverName");
                String contact = request.getParameter("contact");
                
                // Check if transport already exists for this cargo
                String checkSql = "SELECT Transport_ID FROM Transport WHERE Cargo_ID = ?";
                PreparedStatement checkPst = conn.prepareStatement(checkSql);
                checkPst.setInt(1, cargoId);
                ResultSet rs = checkPst.executeQuery();
                
                if (rs.next()) {
                    // Update existing transport
                    int transportId = rs.getInt("Transport_ID");
                    String updateSql = "UPDATE Transport SET Vehicle_No = ?, Driver_Name = ?, Contact = ?, Status = 'Assigned' WHERE Transport_ID = ?";
                    PreparedStatement updatePst = conn.prepareStatement(updateSql);
                    updatePst.setString(1, vehicleNo);
                    updatePst.setString(2, driverName);
                    updatePst.setString(3, contact);
                    updatePst.setInt(4, transportId);
                    updatePst.executeUpdate();
                    updatePst.close();
                } else {
                    // Insert new transport
                    String insertSql = "INSERT INTO Transport (Vehicle_No, Driver_Name, Contact, Cargo_ID, Status) VALUES (?, ?, ?, ?, 'Assigned')";
                    PreparedStatement insertPst = conn.prepareStatement(insertSql);
                    insertPst.setString(1, vehicleNo);
                    insertPst.setString(2, driverName);
                    insertPst.setString(3, contact);
                    insertPst.setInt(4, cargoId);
                    insertPst.executeUpdate();
                    insertPst.close();
                }
                
                rs.close();
                checkPst.close();
                
                response.sendRedirect("cargo");
            } else if (action.equals("/updateDelivery")) {
                // Update delivery records
                int cargoId = Integer.parseInt(request.getParameter("cargoId"));
                String deliveryNotes = request.getParameter("deliveryNotes");
                
                // Update cargo status to delivered
                String sql = "UPDATE Cargo SET Status = 'Delivered' WHERE Cargo_ID = ?";
                PreparedStatement pst = conn.prepareStatement(sql);
                pst.setInt(1, cargoId);
                pst.executeUpdate();
                pst.close();
                
                response.sendRedirect("cargo");
            }
            
            conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("../error.jsp");
        }
    }
    
    private List<Map<String, Object>> getAssignedCargo(Connection conn) throws SQLException {
        List<Map<String, Object>> cargoList = new ArrayList<>();
        String sql = "SELECT c.*, t.Vehicle_No, t.Driver_Name, t.Contact as DriverContact " +
                     "FROM Cargo c " +
                     "JOIN Transport t ON c.Cargo_ID = t.Cargo_ID " +
                     "WHERE t.Status = 'Assigned' ORDER BY c.Cargo_ID DESC";
        PreparedStatement pst = conn.prepareStatement(sql);
        ResultSet rs = pst.executeQuery();
        
        while (rs.next()) {
            Map<String, Object> cargo = new HashMap<>();
            cargo.put("cargoId", rs.getInt("Cargo_ID"));
            cargo.put("description", rs.getString("Description"));
            cargo.put("weight", rs.getDouble("Weight"));
            cargo.put("origin", rs.getString("Origin"));
            cargo.put("destination", rs.getString("Destination"));
            cargo.put("status", rs.getString("Status"));
            cargo.put("vehicleNo", rs.getString("Vehicle_No"));
            cargo.put("driverName", rs.getString("Driver_Name"));
            cargo.put("driverContact", rs.getString("DriverContact"));
            cargoList.add(cargo);
        }
        
        rs.close();
        pst.close();
        return cargoList;
    }
    
    private List<Map<String, Object>> getAllCargo(Connection conn) throws SQLException {
        List<Map<String, Object>> cargoList = new ArrayList<>();
        String sql = "SELECT c.*, t.Vehicle_No, t.Driver_Name, cu.Name as CustomerName " +
                     "FROM Cargo c " +
                     "LEFT JOIN Transport t ON c.Cargo_ID = t.Cargo_ID " +
                     "LEFT JOIN Customer cu ON c.Customer_ID = cu.Customer_ID " +
                     "ORDER BY c.Cargo_ID DESC";
        PreparedStatement pst = conn.prepareStatement(sql);
        ResultSet rs = pst.executeQuery();
        
        while (rs.next()) {
            Map<String, Object> cargo = new HashMap<>();
            cargo.put("cargoId", rs.getInt("Cargo_ID"));
            cargo.put("description", rs.getString("Description"));
            cargo.put("weight", rs.getDouble("Weight"));
            cargo.put("origin", rs.getString("Origin"));
            cargo.put("destination", rs.getString("Destination"));
            cargo.put("status", rs.getString("Status"));
            cargo.put("vehicleNo", rs.getString("Vehicle_No"));
            cargo.put("driverName", rs.getString("Driver_Name"));
            cargo.put("customerName", rs.getString("CustomerName"));
            cargoList.add(cargo);
        }
        
        rs.close();
        pst.close();
        return cargoList;
    }
}
