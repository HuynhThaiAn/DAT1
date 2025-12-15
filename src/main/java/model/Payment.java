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
public class Payment {
    private int paymentID;
    private int orderID;
    private byte method;
    private BigDecimal amount;
    private byte status;
    private String transactionCode;
    private Timestamp paidAt;
    private Timestamp createdAt;

    public Payment() {}

    public Payment(int paymentID, int orderID, byte method, BigDecimal amount, byte status, String transactionCode, Timestamp paidAt, Timestamp createdAt) {
        this.paymentID = paymentID;
        this.orderID = orderID;
        this.method = method;
        this.amount = amount;
        this.status = status;
        this.transactionCode = transactionCode;
        this.paidAt = paidAt;
        this.createdAt = createdAt;
    }

    public int getPaymentID() {
        return paymentID;
    }

    public void setPaymentID(int paymentID) {
        this.paymentID = paymentID;
    }

    public int getOrderID() {
        return orderID;
    }

    public void setOrderID(int orderID) {
        this.orderID = orderID;
    }

    public byte getMethod() {
        return method;
    }

    public void setMethod(byte method) {
        this.method = method;
    }

    public BigDecimal getAmount() {
        return amount;
    }

    public void setAmount(BigDecimal amount) {
        this.amount = amount;
    }

    public byte getStatus() {
        return status;
    }

    public void setStatus(byte status) {
        this.status = status;
    }

    public String getTransactionCode() {
        return transactionCode;
    }

    public void setTransactionCode(String transactionCode) {
        this.transactionCode = transactionCode;
    }

    public Timestamp getPaidAt() {
        return paidAt;
    }

    public void setPaidAt(Timestamp paidAt) {
        this.paidAt = paidAt;
    }

    public Timestamp getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt;
    }
    
    
}
