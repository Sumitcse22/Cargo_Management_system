-- Cargo Management System Database Schema
-- MySQL Database Creation Script

CREATE DATABASE IF NOT EXISTS cargo_management;
USE cargo_management;

-- Customer Table
CREATE TABLE IF NOT EXISTS Customer (
    Customer_ID INT AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    Contact VARCHAR(50) NOT NULL,
    Address VARCHAR(255) NOT NULL,
    Email VARCHAR(100) NOT NULL,
    Password VARCHAR(255) NOT NULL,
    Created_Date TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Cargo Table
CREATE TABLE IF NOT EXISTS Cargo (
    Cargo_ID INT AUTO_INCREMENT PRIMARY KEY,
    Description VARCHAR(255) NOT NULL,
    Weight DECIMAL(10, 2) NOT NULL,
    Origin VARCHAR(100) NOT NULL,
    Destination VARCHAR(100) NOT NULL,
    Status VARCHAR(50) DEFAULT 'Pending',
    Customer_ID INT NOT NULL,
    Created_Date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (Customer_ID) REFERENCES Customer(Customer_ID) ON DELETE CASCADE
);

-- Transport Table
CREATE TABLE IF NOT EXISTS Transport (
    Transport_ID INT AUTO_INCREMENT PRIMARY KEY,
    Vehicle_No VARCHAR(50) NOT NULL,
    Driver_Name VARCHAR(100) NOT NULL,
    Contact VARCHAR(50) NOT NULL,
    Cargo_ID INT,
    Status VARCHAR(50) DEFAULT 'Available',
    Created_Date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (Cargo_ID) REFERENCES Cargo(Cargo_ID) ON DELETE SET NULL
);

-- Booking Table
CREATE TABLE IF NOT EXISTS Booking (
    Booking_ID INT AUTO_INCREMENT PRIMARY KEY,
    Customer_ID INT NOT NULL,
    Cargo_ID INT NOT NULL,
    Booking_Date DATE NOT NULL,
    Payment_Status VARCHAR(50) DEFAULT 'Pending',
    Amount DECIMAL(10, 2),
    Created_Date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (Customer_ID) REFERENCES Customer(Customer_ID) ON DELETE CASCADE,
    FOREIGN KEY (Cargo_ID) REFERENCES Cargo(Cargo_ID) ON DELETE CASCADE
);

-- Admin Table
CREATE TABLE IF NOT EXISTS Admin (
    Admin_ID INT AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    Username VARCHAR(50) UNIQUE NOT NULL,
    Password VARCHAR(255) NOT NULL,
    Created_Date TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Transport Staff Table
CREATE TABLE IF NOT EXISTS Transport_Staff (
    Staff_ID INT AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    Username VARCHAR(50) UNIQUE NOT NULL,
    Password VARCHAR(255) NOT NULL,
    Contact VARCHAR(50) NOT NULL,
    Created_Date TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Insert default admin user (password: admin123)
INSERT INTO Admin (Name, Username, Password) VALUES 
('System Administrator', 'admin', 'admin123');

-- Insert default transport staff (password: staff123)
INSERT INTO Transport_Staff (Name, Username, Password, Contact) VALUES 
('John Driver', 'staff', 'staff123', '1234567890');

-- Sample data for testing
INSERT INTO Customer (Name, Contact, Address, Email, Password) VALUES 
('John Doe', '9876543210', '123 Main St, City', 'john@example.com', 'customer123'),
('Jane Smith', '9876543211', '456 Oak Ave, City', 'jane@example.com', 'customer123');
