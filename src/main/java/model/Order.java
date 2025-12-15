/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.math.BigDecimal;
import java.sql.Timestamp;

/**
 *
 * @author Administrator
 */
public class Order {
    private int orderID;
    private int customerID;

    private String receiverName;
    private String phone;
    private String province;
    private String district;
    private String ward;
    private String detailAddress;

    private BigDecimal totalAmount;
    private byte status;

    private Timestamp orderedAt;
    private Timestamp paidAt;
    private Timestamp shippedAt;
    private Timestamp deliveredAt;
    private Timestamp cancelledAt;

    private String note;

    public Order() {}

    public Order(int orderID, int customerID, String receiverName, String phone, String province, String district, String ward, String detailAddress, BigDecimal totalAmount, byte status, Timestamp orderedAt, Timestamp paidAt, Timestamp shippedAt, Timestamp deliveredAt, Timestamp cancelledAt, String note) {
        this.orderID = orderID;
        this.customerID = customerID;
        this.receiverName = receiverName;
        this.phone = phone;
        this.province = province;
        this.district = district;
        this.ward = ward;
        this.detailAddress = detailAddress;
        this.totalAmount = totalAmount;
        this.status = status;
        this.orderedAt = orderedAt;
        this.paidAt = paidAt;
        this.shippedAt = shippedAt;
        this.deliveredAt = deliveredAt;
        this.cancelledAt = cancelledAt;
        this.note = note;
    }

    public int getOrderID() {
        return orderID;
    }

    public void setOrderID(int orderID) {
        this.orderID = orderID;
    }

    public int getCustomerID() {
        return customerID;
    }

    public void setCustomerID(int customerID) {
        this.customerID = customerID;
    }

    public String getReceiverName() {
        return receiverName;
    }

    public void setReceiverName(String receiverName) {
        this.receiverName = receiverName;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getProvince() {
        return province;
    }

    public void setProvince(String province) {
        this.province = province;
    }

    public String getDistrict() {
        return district;
    }

    public void setDistrict(String district) {
        this.district = district;
    }

    public String getWard() {
        return ward;
    }

    public void setWard(String ward) {
        this.ward = ward;
    }

    public String getDetailAddress() {
        return detailAddress;
    }

    public void setDetailAddress(String detailAddress) {
        this.detailAddress = detailAddress;
    }

    public BigDecimal getTotalAmount() {
        return totalAmount;
    }

    public void setTotalAmount(BigDecimal totalAmount) {
        this.totalAmount = totalAmount;
    }

    public byte getStatus() {
        return status;
    }

    public void setStatus(byte status) {
        this.status = status;
    }

    public Timestamp getOrderedAt() {
        return orderedAt;
    }

    public void setOrderedAt(Timestamp orderedAt) {
        this.orderedAt = orderedAt;
    }

    public Timestamp getPaidAt() {
        return paidAt;
    }

    public void setPaidAt(Timestamp paidAt) {
        this.paidAt = paidAt;
    }

    public Timestamp getShippedAt() {
        return shippedAt;
    }

    public void setShippedAt(Timestamp shippedAt) {
        this.shippedAt = shippedAt;
    }

    public Timestamp getDeliveredAt() {
        return deliveredAt;
    }

    public void setDeliveredAt(Timestamp deliveredAt) {
        this.deliveredAt = deliveredAt;
    }

    public Timestamp getCancelledAt() {
        return cancelledAt;
    }

    public void setCancelledAt(Timestamp cancelledAt) {
        this.cancelledAt = cancelledAt;
    }

    public String getNote() {
        return note;
    }

    public void setNote(String note) {
        this.note = note;
    }
    
    
}
