package com.cargo.beans;

import java.sql.Date;

public class BookingBean {
    private int bookingId;
    private int customerId;
    private int cargoId;
    private Date bookingDate;
    private String paymentStatus;
    private double amount;
    
    public BookingBean() {
    }
    
    public BookingBean(int bookingId, int customerId, int cargoId, 
                       Date bookingDate, String paymentStatus, double amount) {
        this.bookingId = bookingId;
        this.customerId = customerId;
        this.cargoId = cargoId;
        this.bookingDate = bookingDate;
        this.paymentStatus = paymentStatus;
        this.amount = amount;
    }
    
    public int getBookingId() {
        return bookingId;
    }
    
    public void setBookingId(int bookingId) {
        this.bookingId = bookingId;
    }
    
    public int getCustomerId() {
        return customerId;
    }
    
    public void setCustomerId(int customerId) {
        this.customerId = customerId;
    }
    
    public int getCargoId() {
        return cargoId;
    }
    
    public void setCargoId(int cargoId) {
        this.cargoId = cargoId;
    }
    
    public Date getBookingDate() {
        return bookingDate;
    }
    
    public void setBookingDate(Date bookingDate) {
        this.bookingDate = bookingDate;
    }
    
    public String getPaymentStatus() {
        return paymentStatus;
    }
    
    public void setPaymentStatus(String paymentStatus) {
        this.paymentStatus = paymentStatus;
    }
    
    public double getAmount() {
        return amount;
    }
    
    public void setAmount(double amount) {
        this.amount = amount;
    }
}
