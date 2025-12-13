<%@page import="java.text.NumberFormat"%>
<%@page import="java.util.Locale"%>
<%@page import="java.math.BigDecimal"%>
<%@page import="model.Product"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    List<Product> productList = (List<Product>) request.getAttribute("productListFeatured");
    BigDecimal oldPrice;
    BigDecimal newPrice;
%>

<section class="section-card">
    <div class="section-heading">
        <div>
            <p class="section-eyebrow">Editor's Pick</p>
            <h2>Featured Products</h2>
            <p>Top selections curated for study, entertainment, and professional work.</p>
        </div>
        <a class="section-link" href="${pageContext.request.contextPath}/FilterProduct">View More</a>
    </div>

    <div class="product-scroll-wrapper">
        <button class="carousel-btn prev" data-target="product-scroll-featured" data-direction="prev">
            <i class="bi bi-arrow-left"></i>
        </button>

        <div class="product-scroll-container" id="product-scroll-featured">
            <% if (productList != null && !productList.isEmpty()) {
                for (Product pro : productList) {
                    if (!pro.isIsActive()) {
                        continue;
                    }
                    Locale localeVN = new Locale("vi", "VN");
                    NumberFormat currencyVN = NumberFormat.getInstance(localeVN);
                    String originalPriceFormatted = currencyVN.format(pro.getPrice());

                    if (pro.getDiscount() != 0) {
                        oldPrice = pro.getPrice();
                        int discount = pro.getDiscount();
                        BigDecimal discountRate = BigDecimal.valueOf(discount).divide(BigDecimal.valueOf(100));
                        newPrice = pro.getPrice().multiply(BigDecimal.ONE.subtract(discountRate));
                        BigDecimal amountSaved = oldPrice.subtract(newPrice);
            %>

            <a class="product-card" 
               href="<%= request.getContextPath()%>/ProductDetail?productId=<%= pro.getProductId()%>&categoryId=<%= pro.getCategoryId()%>">
                <span class="badge-pill"><i class="bi bi-star-fill"></i> Featured</span>
                <img src="<%= pro.getImageUrl()%>" alt="<%= pro.getProductName()%>">
                <p class="product-name"><%= pro.getProductName()%></p>

                <div class="price-row">
                    <span class="current-price"><%= currencyVN.format(newPrice)%> đ</span>
                    <span class="old-price"><%= originalPriceFormatted%></span>
                </div>

                <span class="discount-tag">-<%= discount%>%</span>
                <p class="saving-tag">Save <%= currencyVN.format(amountSaved)%> đ</p>
            </a>

            <%  } else { %>

            <a class="product-card" 
               href="<%= request.getContextPath()%>/ProductDetail?productId=<%= pro.getProductId()%>&categoryId=<%= pro.getCategoryId()%>">
                <span class="badge-pill"><i class="bi bi-star-fill"></i> Featured</span>
                <img src="<%= pro.getImageUrl()%>" alt="<%= pro.getProductName()%>">
                <p class="product-name"><%= pro.getProductName()%></p>

                <div class="price-row">
                    <span class="current-price"><%= originalPriceFormatted%> đ</span>
                </div>
            </a>

            <%  }
                }
            } else { %>

            <p>Featured products are being updated.</p>

            <% } %>
        </div>

        <button class="carousel-btn next" data-target="product-scroll-featured" data-direction="next">
            <i class="bi bi-arrow-right"></i>
        </button>
    </div>
</section>

<script>
document.addEventListener("DOMContentLoaded", function () {
    const buttons = document.querySelectorAll('[data-target="product-scroll-featured"]');
    const container = document.getElementById('product-scroll-featured');

    if (!container) return;

    const step = () => Math.max(container.clientWidth * 0.8, 320);

    buttons.forEach(btn => {
        btn.addEventListener('click', () => {
            const direction = btn.dataset.direction === 'prev' ? -1 : 1;
            container.scrollBy({ left: step() * direction, behavior: 'smooth' });
        });
    });
});
</script>
