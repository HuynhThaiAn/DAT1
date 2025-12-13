<%@page import="java.text.NumberFormat"%>
<%@page import="java.util.Locale"%>
<%@page import="java.math.BigDecimal"%>
<%@page import="model.Product"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<style>
/* WRAP BUYBOX */
.buybox-wrapper{
    width: 100%;
    display:flex;
    flex-direction:column;
    gap:18px;
}

/* BANNER */
.buybox-banner img{
    width:100%;border-radius:12px;
    box-shadow:0 8px 25px rgba(0,0,0,0.08);
}

/* CARD GIÁ */
.buybox-price{
    border-radius:14px;
    padding:16px 20px;
    background:linear-gradient(to top right,#fcfeff,#eff5ff) padding-box,
               linear-gradient(to top right,#dbe8fe,#609afa) border-box;
    border:1px solid transparent;
}

.buybox-label{font-size:13px;color:#4b5563;margin-bottom:5px;}
.price-row{display:flex;align-items:center;gap:8px;flex-wrap:wrap;}

.newPrice{
    color:#d92d20;
    font-size:25px;
    font-weight:800;
}
.oldPrice{
    text-decoration:line-through;
    color:#9ca3af;
    font-size:14px;
}
.discount-tag{
    background:#dcfce7;
    color:#15803d;
    padding:2px 8px;
    border-radius:20px;
    font-size:13px;
    font-weight:600;
}
.save-text{
    margin-top:4px;
    font-size:13px;
    color:#374151;
}

/* PROMOTION BOX */
.promo-box{
    padding:18px 20px;
    border-radius:14px;
    background:#fff;
    border:1px solid #dedede;
}
.promo-box h3{
    font-size:18px;font-weight:700;margin-bottom:10px;color:#166534;
}
.promo-box ul{font-size:14px;color:#374151;line-height:1.7;margin-left:14px;}
.promo-box ul ul{list-style:circle;margin-left:16px;margin-top:6px;}

/* BUTTONS */
.btn-ecom{
    width:100%;
    border:none;
    padding:12px 14px;
    border-radius:999px;
    font-size:16px;
    font-weight:600;
    cursor:pointer;
    transition:0.12s;
}

/* ADD TO CART */
.btn-add{
    background:linear-gradient(to right,#e8f1ff,#dbeafe);
    color:#2563eb;
    box-shadow:0 4px 10px rgba(37,99,235,.22);
}
.btn-add:hover{
    transform:translateY(-1.5px);
    box-shadow:0 6px 14px rgba(37,99,235,.32);
}

/* BUY NOW */
.btn-buy{
    background:linear-gradient(125deg,#ff8a33,#ff5e00);
    color:white;
    box-shadow:0 5px 18px rgba(255,94,0,.45);
}
.btn-buy:hover{
    transform:translateY(-1.5px);
    box-shadow:0 8px 22px rgba(255,94,0,.55);
}

/* TRUST BADGES */
.trust-block{
    display:flex;flex-wrap:wrap;gap:10px;margin-top:10px;
    padding-top:10px;border-top:1px dashed #ddd;
}
.trust-item{
    display:flex;align-items:center;gap:6px;
    font-size:13px;color:#555;
}
.trust-item i{color:#22c55e;}
</style>

<%
    Product p = (Product) request.getAttribute("product");

    Locale vn = new Locale("vi","VN");
    NumberFormat nf = NumberFormat.getInstance(vn);

    BigDecimal oldP = p.getPrice();
    int dis = p.getDiscount();
    BigDecimal sale = oldP.multiply(BigDecimal.ONE.subtract(BigDecimal.valueOf(dis).divide(BigDecimal.valueOf(100))));
    BigDecimal drop = oldP.subtract(sale);

    String giaCu = nf.format(oldP);
    String giaMoi = nf.format(sale);
    String giam = nf.format(drop);
%>

<div class="buybox-wrapper">

    <!-- Banner -->
    <div class="buybox-banner">
        <img src="https://cdnv2.tgdd.vn/mwg-static/dmx/Banner/1d/b2/1db2c7a4cf2fd229fa0817c2714c6eff.png">
    </div>

    <!-- PRICE -->
    <div class="buybox-price">
        <p class="buybox-label">Product price</p>

        <% if(dis > 0){ %>
        <div class="price-row">
            <span class="newPrice"><%= giaMoi %> đ</span>
            <span class="oldPrice"><%= giaCu %> đ</span>
            <span class="discount-tag">-<%= dis %>%</span>
        </div>
        <p class="save-text">You save <b><%= giam %> đ</b></p>
        <% }else{ %>
        <p class="newPrice"><%= giaMoi %> đ</p>
        <% } %>
    </div>

    <!-- PROMOTION -->
    <div class="promo-box">
        <h3>🎁 Promotions & Special Offers</h3>
        <ul>
            <li><strong>2-year official warranty</strong></li>
            <li>Free installation service</li>
            
        </ul>

        <!-- BUTTONS -->
        <form action="AddCartServlet?productId=<%=p.getProductId()%>&action=addcart" method="post">
            <button class="btn-ecom btn-add">Add to cart</button>
        </form>

        <form action="AddCartServlet?productId=<%=p.getProductId()%>&action=buynow" method="post">
            <button class="btn-ecom btn-buy">Buy now</button>
        </form>

        <!-- TRUST -->
        <div class="trust-block">
            <div class="trust-item"><i class="fa fa-shield-alt"></i> Genuine</div>
            <div class="trust-item"><i class="fa fa-truck"></i> Fast Delivery</div>
            <div class="trust-item"><i class="fa fa-sync"></i> 7-day Return</div>
        </div>
    </div>
</div>
