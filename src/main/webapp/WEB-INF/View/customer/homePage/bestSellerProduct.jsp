
<%@page import="java.text.NumberFormat"%>
<%@page import="java.util.Locale"%>
<%@page import="java.math.BigDecimal"%>
<%@page import="model.Product"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    List<Product> productListBestSeller = (List<Product>) request.getAttribute("productListBestSeller");

    // Config format VN currency
    Locale localeVN = new Locale("vi", "VN");
    NumberFormat currencyVN = NumberFormat.getInstance(localeVN);
%>

<section class="section-card">
    <div class="section-heading">
        <div>
            <p class="section-eyebrow">Trending Now</p>
            <h2>Best-Selling Products of the Week</h2>
            <p>The most purchased and highly trusted items by the TShop community.</p>
        </div>
        <a class="section-link" href="${pageContext.request.contextPath}/FilterProduct?sort=popular">
            Explore more
        </a>
    </div>

    <div class="product-scroll-wrapper">

        <button class="carousel-btn prev" data-target="product-scroll-best" data-direction="prev">
            <i class="bi bi-arrow-left"></i>
        </button>

        <div class="product-scroll-container" id="product-scroll-best">

            <% if (productListBestSeller != null && !productListBestSeller.isEmpty()) {
                    for (Product pro : productListBestSeller) {
                        if (!pro.isIsActive()) {
                            continue;
                        }

                        BigDecimal price = pro.getPrice();
                        BigDecimal newPrice = price;
                        String formattedOldPrice = currencyVN.format(price);
                        BigDecimal discountAmount = BigDecimal.ZERO;

                        boolean hasDiscount = pro.getDiscount() > 0;

                        if (hasDiscount) {
                            BigDecimal discountRate = BigDecimal.valueOf(pro.getDiscount()).divide(BigDecimal.valueOf(100));
                            newPrice = price.multiply(BigDecimal.ONE.subtract(discountRate));
                            discountAmount = price.subtract(newPrice);
                        }
            %>

            <a class="product-card"
               href="<%= request.getContextPath()%>/ProductDetail?productId=<%= pro.getProductId()%>&categoryId=<%= pro.getCategoryId()%>">

                <span class="badge-pill">
                    <i class="bi bi-graph-up-arrow"></i> Top Rated
                </span>

                <img src="<%= pro.getImageUrl()%>" alt="<%= pro.getProductName()%>">
                <p class="product-name"><%= pro.getProductName()%></p>

                <div class="price-row">
                    <span class="current-price"><%= currencyVN.format(newPrice)%> đ</span>

                    <% if (hasDiscount) {%>
                    <span class="old-price"><%= formattedOldPrice%></span>
                    <% } %>
                </div>

                <% if (hasDiscount) {%>
                <span class="discount-tag">-<%= pro.getDiscount()%>%</span>
                <p class="saving-tag">Save <%= currencyVN.format(discountAmount)%> đ</p>
                <% } %>

            </a>

            <% }
            } else { %>

            <p>No best-selling items available at the moment.</p>

            <% }%>

        </div>

        <button class="carousel-btn next" data-target="product-scroll-best" data-direction="next">
            <i class="bi bi-arrow-right"></i>
        </button>

    </div>
</section>
