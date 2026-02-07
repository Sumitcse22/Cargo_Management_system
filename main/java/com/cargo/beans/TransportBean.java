package com.cargo.beans;

public class TransportBean {
    private int transportId;
    private String vehicleNo;
    private String driverName;
    private String contact;
    private int cargoId;
    private String status;
    
    public TransportBean() {
    }
    
    public TransportBean(int transportId, String vehicleNo, String driverName, 
                        String contact, int cargoId, String status) {
        this.transportId = transportId;
        this.vehicleNo = vehicleNo;
        this.driverName = driverName;
        this.contact = contact;
        this.cargoId = cargoId;
        this.status = status;
    }
    
    public int getTransportId() {
        return transportId;
    }
    
    public void setTransportId(int transportId) {
        this.transportId = transportId;
    }
    
    public String getVehicleNo() {
        return vehicleNo;
    }
    
    public void setVehicleNo(String vehicleNo) {
        this.vehicleNo = vehicleNo;
    }
    
    public String getDriverName() {
        return driverName;
    }
    
    public void setDriverName(String driverName) {
        this.driverName = driverName;
    }
    
    public String getContact() {
        return contact;
    }
    
    public void setContact(String contact) {
        this.contact = contact;
    }
    
    public int getCargoId() {
        return cargoId;
    }
    
    public void setCargoId(int cargoId) {
        this.cargoId = cargoId;
    }
    
    public String getStatus() {
        return status;
    }
    
    public void setStatus(String status) {
        this.status = status;
    }
}
