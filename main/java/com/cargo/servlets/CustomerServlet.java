package com.cargo.servlets;

import com.cargo.beans.DatabaseConnection;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class CustomerServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String action = request.getPathInfo();
        HttpSession session = request.getSession();
        
        if (session.getAttribute("userRole") == null || !"customer".equals(session.getAttribute("userRole"))) {
            response.sendRedirect("/login.jsp");
            return;
        }
        
        Object userIdObj = session.getAttribute("userId");
        if (userIdObj == null) {
            response.sendRedirect("/login.jsp");
            return;
        }
        
        int customerId = (Integer) userIdObj;
        
        try {
            Connection conn = DatabaseConnection.getConnection();
            
            if (action == null || action.equals("/") || action.equals("")) {
                // Dashboard
                request.getRequestDispatcher("/customer-dashboard.jsp").forward(request, response);
                conn.close();
                return;
            } else if (action.equals("/dashboard") || action.equals("/dashboard/")) {
                // Dashboard
                request.getRequestDispatcher("/customer-dashboard.jsp").forward(request, response);
                conn.close();
                return;
            } else if (action.equals("/bookings")) {
                // View bookings
                List<Map<String, Object>> bookings = getBookings(conn, customerId);
                request.setAttribute("bookings", bookings);
                request.getRequestDispatcher("/customer-bookings.jsp").forward(request, response);
            } else if (action.equals("/track")) {
                // Track shipment
                int cargoId = request.getParameter("cargoId") != null ? 
                    Integer.parseInt(request.getParameter("cargoId")) : 0;
                Map<String, Object> trackingInfo = getTrackingInfo(conn, cargoId, customerId);
                request.setAttribute("trackingInfo", trackingInfo);
                request.getRequestDispatcher("/customer-track.jsp").forward(request, response);
            } else if (action.equals("/invoice")) {
                // Generate invoice
                int bookingId = request.getParameter("bookingId") != null ? 
                    Integer.parseInt(request.getParameter("bookingId")) : 0;
                Map<String, Object> invoice = getInvoice(conn, bookingId, customerId);
                request.setAttribute("invoice", invoice);
                conn.close();
                request.getRequestDispatcher("/customer-invoice.jsp").forward(request, response);
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
        
        try {
            Connection conn = DatabaseConnection.getConnection();
            
            if (action.equals("/register")) {
                // Customer registration - no authentication required
                String name = request.getParameter("name");
                String email = request.getParameter("email");
                String contact = request.getParameter("contact");
                String address = request.getParameter("address");
                String password = request.getParameter("password");
                
                try {
                    String sql = "INSERT INTO Customer (Name, Email, Contact, Address, Password) VALUES (?, ?, ?, ?, ?)";
                    PreparedStatement pst = conn.prepareStatement(sql);
                    pst.setString(1, name);
                    pst.setString(2, email);
                    pst.setString(3, contact);
                    pst.setString(4, address);
                    pst.setString(5, password);
                    pst.executeUpdate();
                    pst.close();
                    
                    session.setAttribute("successMessage", "Registration successful! Please login to continue.");
                    response.sendRedirect("/login.jsp");
                    conn.close();
                    return;
                } catch (SQLException e) {
                    e.printStackTrace();
                    session.setAttribute("errorMessage", "Registration failed. Email may already exist.");
                    response.sendRedirect("/registration.jsp");
                    conn.close();
                    return;
                }
            }
            
            // For other actions, authentication is required
            if (session.getAttribute("userRole") == null || !"customer".equals(session.getAttribute("userRole"))) {
                response.sendRedirect("/login.jsp");
                conn.close();
                return;
            }
            
            int customerId = (Integer) session.getAttribute("userId");
            
            if (action.equals("/submitBooking")) {
                // Submit booking request
                String description = request.getParameter("description");
                double weight = Double.parseDouble(request.getParameter("weight"));
                String origin = request.getParameter("origin");
                String destination = request.getParameter("destination");
                double amount = Double.parseDouble(request.getParameter("amount"));
                
                // Insert cargo
                String sql1 = "INSERT INTO Cargo (Description, Weight, Origin, Destination, Status, Customer_ID) " +
                             "VALUES (?, ?, ?, ?, 'Pending', ?)";
                PreparedStatement pst1 = conn.prepareStatement(sql1, PreparedStatement.RETURN_GENERATED_KEYS);
                pst1.setString(1, description);
                pst1.setDouble(2, weight);
                pst1.setString(3, origin);
                pst1.setString(4, destination);
                pst1.setInt(5, customerId);
                pst1.executeUpdate();
                
                ResultSet rs = pst1.getGeneratedKeys();
                int cargoId = 0;
                if (rs.next()) {
                    cargoId = rs.getInt(1);
                }
                rs.close();
                pst1.close();
                
                // Insert booking
                String sql2 = "INSERT INTO Booking (Customer_ID, Cargo_ID, Booking_Date, Payment_Status, Amount) " +
                             "VALUES (?, ?, CURDATE(), 'Pending', ?)";
                PreparedStatement pst2 = conn.prepareStatement(sql2);
                pst2.setInt(1, customerId);
                pst2.setInt(2, cargoId);
                pst2.setDouble(3, amount);
                pst2.executeUpdate();
                pst2.close();
                
                response.sendRedirect("bookings");
            }
            
            conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("../error.jsp");
        }
    }
    
    private List<Map<String, Object>> getBookings(Connection conn, int customerId) throws SQLException {
        List<Map<String, Object>> bookings = new ArrayList<>();
        String sql = "SELECT b.*, c.Description, c.Origin, c.Destination, c.Status as CargoStatus " +
                     "FROM Booking b JOIN Cargo c ON b.Cargo_ID = c.Cargo_ID " +
                     "WHERE b.Customer_ID = ? ORDER BY b.Booking_ID DESC";
        PreparedStatement pst = conn.prepareStatement(sql);
        pst.setInt(1, customerId);
        ResultSet rs = pst.executeQuery();
        
        while (rs.next()) {
            Map<String, Object> booking = new HashMap<>();
            booking.put("bookingId", rs.getInt("Booking_ID"));
            booking.put("cargoId", rs.getInt("Cargo_ID"));
            booking.put("description", rs.getString("Description"));
            booking.put("origin", rs.getString("Origin"));
            booking.put("destination", rs.getString("Destination"));
            booking.put("bookingDate", rs.getDate("Booking_Date"));
            booking.put("paymentStatus", rs.getString("Payment_Status"));
            booking.put("amount", rs.getDouble("Amount"));
            booking.put("cargoStatus", rs.getString("CargoStatus"));
            bookings.add(booking);
        }
        
        rs.close();
        pst.close();
        return bookings;
    }
    
    private Map<String, Object> getTrackingInfo(Connection conn, int cargoId, int customerId) throws SQLException {
        Map<String, Object> trackingInfo = new HashMap<>();
        
        if (cargoId > 0) {
            String sql = "SELECT c.*, t.Vehicle_No, t.Driver_Name, t.Contact as DriverContact, " +
                         "b.Booking_Date, b.Payment_Status " +
                         "FROM Cargo c " +
                         "LEFT JOIN Transport t ON c.Cargo_ID = t.Cargo_ID " +
                         "LEFT JOIN Booking b ON c.Cargo_ID = b.Cargo_ID " +
                         "WHERE c.Cargo_ID = ? AND c.Customer_ID = ?";
            PreparedStatement pst = conn.prepareStatement(sql);
            pst.setInt(1, cargoId);
            pst.setInt(2, customerId);
            ResultSet rs = pst.executeQuery();
            
            if (rs.next()) {
                trackingInfo.put("cargoId", rs.getInt("Cargo_ID"));
                trackingInfo.put("description", rs.getString("Description"));
                trackingInfo.put("origin", rs.getString("Origin"));
                trackingInfo.put("destination", rs.getString("Destination"));
                trackingInfo.put("status", rs.getString("Status"));
                trackingInfo.put("vehicleNo", rs.getString("Vehicle_No"));
                trackingInfo.put("driverName", rs.getString("Driver_Name"));
                trackingInfo.put("driverContact", rs.getString("DriverContact"));
                trackingInfo.put("bookingDate", rs.getDate("Booking_Date"));
                trackingInfo.put("paymentStatus", rs.getString("Payment_Status"));
            }
            
            rs.close();
            pst.close();
        }
        
        return trackingInfo;
    }
    
    private Map<String, Object> getInvoice(Connection conn, int bookingId, int customerId) throws SQLException {
        Map<String, Object> invoice = new HashMap<>();
        
        if (bookingId > 0) {
            String sql = "SELECT b.*, c.Description, c.Weight, c.Origin, c.Destination, " +
                         "cu.Name as CustomerName, cu.Address as CustomerAddress, cu.Contact as CustomerContact " +
                         "FROM Booking b " +
                         "JOIN Cargo c ON b.Cargo_ID = c.Cargo_ID " +
                         "JOIN Customer cu ON b.Customer_ID = cu.Customer_ID " +
                         "WHERE b.Booking_ID = ? AND b.Customer_ID = ?";
            PreparedStatement pst = conn.prepareStatement(sql);
            pst.setInt(1, bookingId);
            pst.setInt(2, customerId);
            ResultSet rs = pst.executeQuery();
            
            if (rs.next()) {
                invoice.put("bookingId", rs.getInt("Booking_ID"));
                invoice.put("bookingDate", rs.getDate("Booking_Date"));
                invoice.put("customerName", rs.getString("CustomerName"));
                invoice.put("customerAddress", rs.getString("CustomerAddress"));
                invoice.put("customerContact", rs.getString("CustomerContact"));
                invoice.put("description", rs.getString("Description"));
                invoice.put("weight", rs.getDouble("Weight"));
                invoice.put("origin", rs.getString("Origin"));
                invoice.put("destination", rs.getString("Destination"));
                invoice.put("amount", rs.getDouble("Amount"));
                invoice.put("paymentStatus", rs.getString("Payment_Status"));
            }
            
            rs.close();
            pst.close();
        }
        
        return invoice;
    }
}
