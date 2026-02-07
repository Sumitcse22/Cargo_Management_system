package com.cargo.beans;

public class UserBean {
    private int customerId;
    private String name;
    private String contact;
    private String address;
    private String email;
    private String password;
    
    public UserBean() {
    }
    
    public UserBean(int customerId, String name, String contact, String address, String email, String password) {
        this.customerId = customerId;
        this.name = name;
        this.contact = contact;
        this.address = address;
        this.email = email;
        this.password = password;
    }
    
    public int getCustomerId() {
        return customerId;
    }
    
    public void setCustomerId(int customerId) {
        this.customerId = customerId;
    }
    
    public String getName() {
        return name;
    }
    
    public void setName(String name) {
        this.name = name;
    }
    
    public String getContact() {
        return contact;
    }
    
    public void setContact(String contact) {
        this.contact = contact;
    }
    
    public String getAddress() {
        return address;
    }
    
    public void setAddress(String address) {
        this.address = address;
    }
    
    public String getEmail() {
        return email;
    }
    
    public void setEmail(String email) {
        this.email = email;
    }
    
    public String getPassword() {
        return password;
    }
    
    public void setPassword(String password) {
        this.password = password;
    }
}
