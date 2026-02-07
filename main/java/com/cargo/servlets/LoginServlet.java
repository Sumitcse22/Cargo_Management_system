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

public class LoginServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String role = request.getParameter("role");
        
        HttpSession session = request.getSession();
        
        try {
            Connection conn = DatabaseConnection.getConnection();
            boolean isValid = false;
            String name = "";
            int id = 0;
            
            if ("admin".equals(role)) {
                String sql = "SELECT Admin_ID, Name FROM Admin WHERE Username = ? AND Password = ?";
                PreparedStatement pst = conn.prepareStatement(sql);
                pst.setString(1, username);
                pst.setString(2, password);
                ResultSet rs = pst.executeQuery();
                
                if (rs.next()) {
                    isValid = true;
                    id = rs.getInt("Admin_ID");
                    name = rs.getString("Name");
                    session.setAttribute("userRole", "admin");
                    session.setAttribute("userId", id);
                    session.setAttribute("userName", name);
                }
                rs.close();
                pst.close();
            } else if ("customer".equals(role)) {
                String sql = "SELECT Customer_ID, Name FROM Customer WHERE Email = ? AND Password = ?";
                PreparedStatement pst = conn.prepareStatement(sql);
                pst.setString(1, username);
                pst.setString(2, password);
                ResultSet rs = pst.executeQuery();
                
                if (rs.next()) {
                    isValid = true;
                    id = rs.getInt("Customer_ID");
                    name = rs.getString("Name");
                    session.setAttribute("userRole", "customer");
                    session.setAttribute("userId", id);
                    session.setAttribute("userName", name);
                }
                rs.close();
                pst.close();
            } else if ("staff".equals(role)) {
                String sql = "SELECT Staff_ID, Name FROM Transport_Staff WHERE Username = ? AND Password = ?";
                PreparedStatement pst = conn.prepareStatement(sql);
                pst.setString(1, username);
                pst.setString(2, password);
                ResultSet rs = pst.executeQuery();
                
                if (rs.next()) {
                    isValid = true;
                    id = rs.getInt("Staff_ID");
                    name = rs.getString("Name");
                    session.setAttribute("userRole", "staff");
                    session.setAttribute("userId", id);
                    session.setAttribute("userName", name);
                }
                rs.close();
                pst.close();
            }
            
            conn.close();
            
            if (isValid) {
                String contextPath = request.getContextPath();
                if ("admin".equals(role)) {
                    response.sendRedirect(contextPath + "/admin/dashboard");
                } else if ("customer".equals(role)) {
                    response.sendRedirect(contextPath + "/customer/dashboard");
                } else if ("staff".equals(role)) {
                    response.sendRedirect(contextPath + "/staff/dashboard");
                }
            } else {
                session.setAttribute("errorMessage", "Invalid username or password");
                response.sendRedirect("login.jsp");
            }
            
        } catch (SQLException e) {
            e.printStackTrace();
            session.setAttribute("errorMessage", "Database error occurred");
            response.sendRedirect("login.jsp");
        }
    }
}
