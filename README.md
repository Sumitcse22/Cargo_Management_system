# Cargo Management System

A comprehensive Java web application for managing cargo shipments, bookings, and transport operations.

## Technologies Used

- **Java 11**
- **JSP (JavaServer Pages)**
- **MySQL Database**
- **Maven** (Build Tool)
- **CSS/JavaScript** (Frontend)
- **Servlet API**

## Project Structure

```
CMS/
├── src/
│   ├── main/
│   │   ├── java/
│   │   │   └── com/cargo/
│   │   │       ├── beans/
│   │   │       │   ├── BookingBean.java
│   │   │       │   ├── CargoBean.java
│   │   │       │   ├── TransportBean.java
│   │   │       │   ├── UserBean.java
│   │   │       │   └── DatabaseConnection.java
│   │   │       └── servlets/
│   │   │           ├── LoginServlet.java
│   │   │           ├── LogoutServlet.java
│   │   │           ├── AdminServlet.java
│   │   │           ├── CustomerServlet.java
│   │   │           └── StaffServlet.java
│   │   └── webapp/
│   │       ├── WEB-INF/
│   │       │   └── web.xml
│   │       ├── admin/
│   │       │   ├── dashboard.jsp
│   │       │   ├── users.jsp
│   │       │   ├── shipments.jsp
│   │       │   └── reports.jsp
│   │       ├── customer/
│   │       │   ├── dashboard.jsp
│   │       │   ├── bookings.jsp
│   │       │   ├── track.jsp
│   │       │   ├── invoice.jsp
│   │       │   └── register.jsp
│   │       ├── staff/
│   │       │   ├── dashboard.jsp
│   │       │   └── cargo.jsp
│   │       ├── css/
│   │       │   └── style.css
│   │       ├── js/
│   │       │   └── main.js
│   │       ├── index.jsp
│   │       ├── login.jsp
│   │       ├── error.jsp
│   │       └── logout.jsp
├── cargo_database.sql
├── pom.xml
└── README.md
```

## Database Setup

1. Make sure MySQL is installed and running on your system.

2. Update the database connection details in `DatabaseConnection.java`:
   - Default URL: `jdbc:mysql://localhost:3306/cargo_management`
   - Default User: `root`
   - Default Password: (empty - update as needed)

3. Run the SQL script to create the database and tables:
   ```sql
   mysql -u root -p < cargo_database.sql
   ```

## Default Login Credentials

### Admin
- Username: `admin`
- Password: `admin123`

### Transport Staff
- Username: `staff`
- Password: `staff123`

### Customer
- Register a new account or use existing customer credentials from the database

## Building and Running

### Prerequisites
- Java 11 or higher
- Maven 3.6+
- MySQL 8.0+
- Apache Tomcat 9.0+ (or similar servlet container)

### Build the Project
```bash
mvn clean package
```

### Deploy
1. Copy the generated WAR file from `target/cargo-management-system.war` to your Tomcat `webapps` directory
2. Start Tomcat server
3. Access the application at `http://localhost:8080/cargo-management-system`

### Run with Maven Tomcat Plugin (if configured)
```bash
mvn tomcat7:run
```

## Features

### Admin Features
- Manage Users (Add, Delete)
- Manage Shipments (View, Update Status)
- Generate Reports (Revenue, Cargo Status Distribution)
- View System Statistics

### Customer Features
- Register Account
- Submit Booking Requests
- Track Shipments
- View Bookings
- Generate Invoices

### Transport Staff Features
- View Assigned Cargo
- Update Cargo Status
- Assign Transport to Cargo
- Update Delivery Records

## Database Schema

The system uses the following main tables:
- **Customer**: Stores customer information
- **Cargo**: Stores cargo/shipment details
- **Transport**: Stores transport vehicle and driver information
- **Booking**: Stores booking and payment information
- **Admin**: Stores administrator credentials
- **Transport_Staff**: Stores transport staff credentials

## Notes

- Passwords are stored in plain text (for development only). In production, use password hashing.
- The application uses session management for authentication.
- All database operations are handled directly in servlets (no DAO/Model layer as per requirements).

## License

This project is for educational purposes.
