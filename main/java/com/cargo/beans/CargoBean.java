package com.cargo.beans;

public class CargoBean {
    private int cargoId;
    private String description;
    private double weight;
    private String origin;
    private String destination;
    private String status;
    private int customerId;
    
    public CargoBean() {
    }
    
    public CargoBean(int cargoId, String description, double weight, String origin, 
                     String destination, String status, int customerId) {
        this.cargoId = cargoId;
        this.description = description;
        this.weight = weight;
        this.origin = origin;
        this.destination = destination;
        this.status = status;
        this.customerId = customerId;
    }
    
    public int getCargoId() {
        return cargoId;
    }
    
    public void setCargoId(int cargoId) {
        this.cargoId = cargoId;
    }
    
    public String getDescription() {
        return description;
    }
    
    public void setDescription(String description) {
        this.description = description;
    }
    
    public double getWeight() {
        return weight;
    }
    
    public void setWeight(double weight) {
        this.weight = weight;
    }
    
    public String getOrigin() {
        return origin;
    }
    
    public void setOrigin(String origin) {
        this.origin = origin;
    }
    
    public String getDestination() {
        return destination;
    }
    
    public void setDestination(String destination) {
        this.destination = destination;
    }
    
    public String getStatus() {
        return status;
    }
    
    public void setStatus(String status) {
        this.status = status;
    }
    
    public int getCustomerId() {
        return customerId;
    }
    
    public void setCustomerId(int customerId) {
        this.customerId = customerId;
    }
}
