/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.math.BigDecimal;
import java.sql.Timestamp;
import java.time.LocalDateTime;

/**
 *
 * @author Administrator
 */
public class Order {
    private Integer OrderID;
    private Integer CustomerID;
    private Integer AddressID;
    private String ReceiverName;
    private String Phone;
    private BigDecimal TotalAmount;
    private Integer Status;
    private LocalDateTime OrderedAt;
    private LocalDateTime PaidAt;
    private LocalDateTime ShippedAt;
    private LocalDateTime DeliveredAt;
    private LocalDateTime CancelledAt;
    private String Note;

    public Order() {}

    public Order(Integer OrderID, Integer CustomerID, Integer AddressID, String ReceiverName, String Phone, BigDecimal TotalAmount, Integer Status, LocalDateTime OrderedAt, LocalDateTime PaidAt, LocalDateTime ShippedAt, LocalDateTime DeliveredAt, LocalDateTime CancelledAt, String Note) {
        this.OrderID = OrderID;
        this.CustomerID = CustomerID;
        this.AddressID = AddressID;
        this.ReceiverName = ReceiverName;
        this.Phone = Phone;
        this.TotalAmount = TotalAmount;
        this.Status = Status;
        this.OrderedAt = OrderedAt;
        this.PaidAt = PaidAt;
        this.ShippedAt = ShippedAt;
        this.DeliveredAt = DeliveredAt;
        this.CancelledAt = CancelledAt;
        this.Note = Note;
    }
    
    

    public Integer getOrderID() { return OrderID; }
    public void setOrderID(Integer OrderID) { this.OrderID = OrderID; }

    public Integer getCustomerID() { return CustomerID; }
    public void setCustomerID(Integer CustomerID) { this.CustomerID = CustomerID; }

    public Integer getAddressID() { return AddressID; }
    public void setAddressID(Integer AddressID) { this.AddressID = AddressID; }

    public String getReceiverName() { return ReceiverName; }
    public void setReceiverName(String ReceiverName) { this.ReceiverName = ReceiverName; }

    public String getPhone() { return Phone; }
    public void setPhone(String Phone) { this.Phone = Phone; }

    public BigDecimal getTotalAmount() { return TotalAmount; }
    public void setTotalAmount(BigDecimal TotalAmount) { this.TotalAmount = TotalAmount; }

    public Integer getStatus() { return Status; }
    public void setStatus(Integer Status) { this.Status = Status; }

    public LocalDateTime getOrderedAt() { return OrderedAt; }
    public void setOrderedAt(LocalDateTime OrderedAt) { this.OrderedAt = OrderedAt; }

    public LocalDateTime getPaidAt() { return PaidAt; }
    public void setPaidAt(LocalDateTime PaidAt) { this.PaidAt = PaidAt; }

    public LocalDateTime getShippedAt() { return ShippedAt; }
    public void setShippedAt(LocalDateTime ShippedAt) { this.ShippedAt = ShippedAt; }

    public LocalDateTime getDeliveredAt() { return DeliveredAt; }
    public void setDeliveredAt(LocalDateTime DeliveredAt) { this.DeliveredAt = DeliveredAt; }

    public LocalDateTime getCancelledAt() { return CancelledAt; }
    public void setCancelledAt(LocalDateTime CancelledAt) { this.CancelledAt = CancelledAt; }

    public String getNote() { return Note; }
    public void setNote(String Note) { this.Note = Note; }
}
