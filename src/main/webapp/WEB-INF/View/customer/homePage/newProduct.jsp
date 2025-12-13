<%@page import="java.text.NumberFormat"%>
<%@page import="java.util.Locale"%>
<%@page import="java.math.BigDecimal"%>
<%@page import="model.Product"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    List<Product> productList = (List<Product>) request.getAttribute("productList");
    BigDecimal oldPrice;
    BigDecimal newPrice;
%>

<section class="section-card">
    <div class="section-heading">
        <div>
            <p class="section-eyebrow">New Arrival</p>
            <h2>Freshly Launched Products</h2>
            <p>Stay ahead with the latest releases and limited-time launch deals.</p>
        </div>
        <a class="section-link" href="${pageContext.request.contextPath}/SortProduct?sort=latest">View All</a>
    </div>

    <div class="product-scroll-wrapper">
        <button class="carousel-btn prev" data-target="product-scroll-new" data-direction="prev">
            <i class="bi bi-arrow-left"></i>
        </button>

        <div class="product-scroll-container" id="product-scroll-new">
            <% if (productList != null && !productList.isEmpty()) {
                    for (Product pro : productList) {
                        if (!pro.isIsActive()) {
                            continue;
                        }

                        Locale localeVN = new Locale("vi", "VN");
                        NumberFormat currencyVN = NumberFormat.getInstance(localeVN);
                        String formattedOriginalPrice = currencyVN.format(pro.getPrice());

                        if (pro.getDiscount() != 0) {
                            oldPrice = pro.getPrice();
                            BigDecimal price = pro.getPrice();
                            int discount = pro.getDiscount();
                            BigDecimal discountRate = BigDecimal.valueOf(discount).divide(BigDecimal.valueOf(100));
                            newPrice = price.multiply(BigDecimal.ONE.subtract(discountRate));
                            BigDecimal amountSaved = oldPrice.subtract(newPrice);
            %>

            <a class="product-card" 
               href="<%= request.getContextPath()%>/ProductDetail?productId=<%= pro.getProductId()%>&categoryId=<%= pro.getCategoryId()%>">
                <span class="badge-pill"><i class="bi bi-lightning-charge-fill"></i> 0% Installment</span>
                <img src="<%= pro.getImageUrl()%>" alt="<%= pro.getProductName()%>">
                <p class="product-name"><%= pro.getProductName()%></p>

                <div class="price-row">
                    <span class="current-price"><%= currencyVN.format(newPrice)%> đ</span>
                    <span class="old-price"><%= formattedOriginalPrice%></span>
                </div>

                <span class="discount-tag">-<%= discount%>%</span>
                <p class="saving-tag">Save <%= currencyVN.format(amountSaved)%> đ</p>
            </a>

            <%  } else {%>

            <a class="product-card" 
               href="<%= request.getContextPath()%>/ProductDetail?productId=<%= pro.getProductId()%>&categoryId=<%= pro.getCategoryId()%>">
                <span class="badge-pill"><i class="bi bi-lightning-charge-fill"></i> New Launch</span>
                <img src="<%= pro.getImageUrl()%>" alt="<%= pro.getProductName()%>">
                <p class="product-name"><%= pro.getProductName()%></p>

                <div class="price-row">
                    <span class="current-price"><%= formattedOriginalPrice%> đ</span>
                </div>
            </a>

            <%  }
                }
            } else { %>

            <p>New arrivals are being updated...</p>

            <% }%>
        </div>

        <button class="carousel-btn next" data-target="product-scroll-new" data-direction="next">
            <i class="bi bi-arrow-right"></i>
        </button>
    </div>
</section>

<script>
    document.addEventListener("DOMContentLoaded", function () {
        const buttons = document.querySelectorAll('[data-target="product-scroll-new"]');
        const container = document.getElementById('product-scroll-new');

        if (!container)
            return;

        const step = () => Math.max(container.clientWidth * 0.8, 320);

        buttons.forEach(btn => {
            btn.addEventListener('click', () => {
                const direction = btn.dataset.direction === 'prev' ? -1 : 1;
                container.scrollBy({left: step() * direction, behavior: 'smooth'});
            });
        });
    });
</script>
