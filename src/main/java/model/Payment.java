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
public class Payment {
    private Integer PaymentID;
    private Integer OrderID;
    private Integer Method;
    private BigDecimal Amount;
    private Integer Status;
    private String TransactionCode;
    private LocalDateTime PaidAt;
    private LocalDateTime CreatedAt;

    public Payment() {}

    public Payment(Integer PaymentID, Integer OrderID, Integer Method, BigDecimal Amount, Integer Status, String TransactionCode, LocalDateTime PaidAt, LocalDateTime CreatedAt) {
        this.PaymentID = PaymentID;
        this.OrderID = OrderID;
        this.Method = Method;
        this.Amount = Amount;
        this.Status = Status;
        this.TransactionCode = TransactionCode;
        this.PaidAt = PaidAt;
        this.CreatedAt = CreatedAt;
    }


    public Integer getPaymentID() { return PaymentID; }
    public void setPaymentID(Integer PaymentID) { this.PaymentID = PaymentID; }

    public Integer getOrderID() { return OrderID; }
    public void setOrderID(Integer OrderID) { this.OrderID = OrderID; }

    public Integer getMethod() { return Method; }
    public void setMethod(Integer Method) { this.Method = Method; }

    public BigDecimal getAmount() { return Amount; }
    public void setAmount(BigDecimal Amount) { this.Amount = Amount; }

    public Integer getStatus() { return Status; }
    public void setStatus(Integer Status) { this.Status = Status; }

    public String getTransactionCode() { return TransactionCode; }
    public void setTransactionCode(String TransactionCode) { this.TransactionCode = TransactionCode; }

    public LocalDateTime getPaidAt() { return PaidAt; }
    public void setPaidAt(LocalDateTime PaidAt) { this.PaidAt = PaidAt; }

    public LocalDateTime getCreatedAt() { return CreatedAt; }
    public void setCreatedAt(LocalDateTime CreatedAt) { this.CreatedAt = CreatedAt; }
}
