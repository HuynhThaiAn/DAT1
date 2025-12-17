/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.math.BigDecimal;

/**
 *
 * @author Administrator
 */
public class OrderDetail {
    private Integer OrderID;
    private Integer ProductVariantID;
    private BigDecimal UnitPrice;
    private Integer Quantity;

    public OrderDetail() {}

    public OrderDetail(Integer OrderID, Integer ProductVariantID, BigDecimal UnitPrice, Integer Quantity) {
        this.OrderID = OrderID;
        this.ProductVariantID = ProductVariantID;
        this.UnitPrice = UnitPrice;
        this.Quantity = Quantity;
    }
    

    public Integer getOrderID() { return OrderID; }
    public void setOrderID(Integer OrderID) { this.OrderID = OrderID; }

    public Integer getProductVariantID() { return ProductVariantID; }
    public void setProductVariantID(Integer ProductVariantID) { this.ProductVariantID = ProductVariantID; }

    public BigDecimal getUnitPrice() { return UnitPrice; }
    public void setUnitPrice(BigDecimal UnitPrice) { this.UnitPrice = UnitPrice; }

    public Integer getQuantity() { return Quantity; }
    public void setQuantity(Integer Quantity) { this.Quantity = Quantity; }
}
