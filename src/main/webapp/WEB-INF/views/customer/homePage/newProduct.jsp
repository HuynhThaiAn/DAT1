<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.*"%>
<%@page import="model.Product"%>

<%
    List<Product> productList = (List<Product>) request.getAttribute("newProductList");
    if (productList == null) productList = java.util.Collections.emptyList();

    // Optional (nếu sau này bạn muốn set từ HomeServlet):
    // Map<ProductID, mainImageUrl>
    Map<Integer, String> mainImageByProductId =
            (Map<Integer, String>) request.getAttribute("mainImageByProductId");
    if (mainImageByProductId == null) mainImageByProductId = java.util.Collections.emptyMap();

    String ctx = request.getContextPath();
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
            <% if (!productList.isEmpty()) {
                   for (Product pro : productList) {

                       int productId = pro.getProductID();
                       int categoryId = pro.getCategoryID();

                       String imgUrl = mainImageByProductId.get(productId); // có thì dùng, không có thì để trống
                       String name = pro.getProductName();
                       String desc = pro.getDescription();
                       if (desc == null) desc = "";
            %>

            <a class="product-card"
               href="<%= ctx %>/ProductDetail?productId=<%= productId %>&categoryId=<%= categoryId %>">
                <span class="badge-pill"><i class="bi bi-lightning-charge-fill"></i> New Launch</span>

                <% if (imgUrl != null && !imgUrl.isBlank()) { %>
                    <img src="<%= imgUrl %>" alt="<%= name %>" onerror="this.style.display='none'">
                <% } else { %>
                    <!-- fallback khi chưa có ảnh -->
                    <div style="width:100%;aspect-ratio:1/1;background:#f3f4f6;border-radius:12px;"></div>
                <% } %>

                <p class="product-name"><%= name %></p>

                <% if (!desc.isBlank()) { %>
                    <p class="text-muted" style="margin:0;font-size:12px;line-height:1.3;max-height:2.6em;overflow:hidden;">
                        <%= desc %>
                    </p>
                <% } %>
            </a>

            <%   }
               } else { %>

            <p>New arrivals are being updated...</p>

            <% } %>
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
    if (!container) return;

    const step = () => Math.max(container.clientWidth * 0.8, 320);

    buttons.forEach(btn => {
        btn.addEventListener('click', () => {
            const direction = btn.dataset.direction === 'prev' ? -1 : 1;
            container.scrollBy({left: step() * direction, behavior: 'smooth'});
        });
    });
});
</script>
