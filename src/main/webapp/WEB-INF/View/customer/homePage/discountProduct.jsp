<%-- 
    Document   : newProduct
    Created on : Jun 16, 2025, 12:58:19 PM
    Author     : HP - Gia Khiêm
--%>

<%@page import="java.text.NumberFormat"%>
<%@page import="java.util.Locale"%>
<%@page import="java.math.BigDecimal"%>
<%@page import="model.Product"%>
<%@page import="java.util.List"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<style>
    .section-card {
        margin: 32px auto;
        padding: 28px 32px 32px;
        border-radius: 24px;
        background: radial-gradient(circle at top left, #ffe6f0, #fff5e6 40%, #ffffff 75%);
        box-shadow: 0 18px 45px rgba(15, 23, 42, 0.12);
        max-width: 1180px;
    }

    .section-heading {
        display: flex;
        align-items: flex-end;
        justify-content: space-between;
        gap: 16px;
        margin-bottom: 22px;
    }

    .section-eyebrow {
        font-size: 13px;
        font-weight: 600;
        letter-spacing: 0.16em;
        text-transform: uppercase;
        color: #f97316;
        display: inline-flex;
        align-items: center;
        gap: 6px;
        padding: 4px 10px;
        border-radius: 999px;
        background: rgba(248, 113, 22, 0.08);
    }

    .section-eyebrow::before {
        content: "";
        width: 6px;
        height: 6px;
        border-radius: 999px;
        background: #f97316;
        box-shadow: 0 0 0 4px rgba(248, 113, 22, 0.25);
    }

    .section-heading h2 {
        margin: 4px 0 4px;
        font-size: 24px;
        font-weight: 700;
        color: #0f172a;
    }

    .section-heading p {
        margin: 0;
        font-size: 14px;
        color: #64748b;
    }

    .section-link {
        font-size: 14px;
        font-weight: 600;
        color: #0f172a;
        padding: 8px 14px;
        border-radius: 999px;
        border: 1px solid rgba(148, 163, 184, 0.7);
        text-decoration: none;
        display: inline-flex;
        align-items: center;
        gap: 6px;
        background: #ffffff;
        transition: all 0.18s ease-out;
        white-space: nowrap;
    }

    .section-link::after {
        content: "→";
        font-size: 13px;
    }

    .section-link:hover {
        border-color: #f97316;
        background: #fffbeb;
        color: #c2410c;
        transform: translateY(-1px);
        box-shadow: 0 10px 24px rgba(248, 113, 22, 0.18);
    }

    .product-grid {
        display: grid;
        grid-template-columns: repeat(4, minmax(0, 1fr));
        gap: 18px;
        margin-top: 6px;
    }

    @media (max-width: 1024px) {
        .product-grid {
            grid-template-columns: repeat(3, minmax(0, 1fr));
        }
    }

    @media (max-width: 768px) {
        .section-card {
            margin: 20px 12px;
            padding: 20px 16px 22px;
            border-radius: 18px;
        }

        .section-heading {
            flex-direction: column;
            align-items: flex-start;
        }

        .product-grid {
            grid-template-columns: repeat(2, minmax(0, 1fr));
        }
    }

    @media (max-width: 480px) {
        .product-grid {
            grid-template-columns: repeat(1, minmax(0, 1fr));
        }
    }

    .product-card {
        position: relative;
        display: flex;
        flex-direction: column;
        gap: 8px;
        padding: 10px 11px 12px;
        border-radius: 18px;
        text-decoration: none;
        background: rgba(255, 255, 255, 0.98);
        box-shadow: 0 10px 28px rgba(15, 23, 42, 0.08);
        overflow: hidden;
        border: 1px solid rgba(226, 232, 240, 0.9);
        transition: transform 0.16s ease-out, box-shadow 0.16s ease-out, border-color 0.16s ease-out, background 0.16s ease-out;
    }

    .product-card::before {
        content: "";
        position: absolute;
        inset: 0;
        background: radial-gradient(120% 150% at top, rgba(248, 250, 252, 0.9), transparent 55%);
        opacity: 0;
        transition: opacity 0.2s ease-out;
        pointer-events: none;
    }

    .product-card:hover {
        transform: translateY(-6px);
        box-shadow: 0 18px 40px rgba(15, 23, 42, 0.16);
        border-color: #fecaca;
        background: #ffffff;
    }

    .product-card:hover::before {
        opacity: 1;
    }

    .product-card img {
        width: 100%;
        aspect-ratio: 4/3;
        object-fit: contain;
        background: #f8fafc;
        border-radius: 14px;
        padding: 10px;
        transition: transform 0.18s ease-out, filter 0.18s ease-out;
    }

    .product-card:hover img {
        transform: scale(1.03);
        filter: drop-shadow(0 10px 25px rgba(15, 23, 42, 0.15));
    }

    .badge-pill {
        position: absolute;
        top: 10px;
        left: 11px;
        display: inline-flex;
        align-items: center;
        gap: 4px;
        padding: 5px 10px;
        border-radius: 999px;
        font-size: 11px;
        font-weight: 600;
        background: linear-gradient(135deg, #f97316, #ea580c);
        color: #fff7ed;
        box-shadow: 0 10px 25px rgba(248, 113, 22, 0.55);
    }

    .badge-pill i {
        font-size: 12px;
    }

    .product-name {
        margin: 4px 0 0;
        font-size: 14px;
        font-weight: 600;
        color: #0f172a;
        min-height: 40px;
        display: -webkit-box;
        -webkit-line-clamp: 2;
        -webkit-box-orient: vertical;
        line-clamp: 2;
        overflow: hidden;
    }

    .price-row {
        display: flex;
        align-items: baseline;
        gap: 8px;
        margin-top: 4px;
    }

    .current-price {
        font-size: 15px;
        font-weight: 700;
        color: #dc2626;
    }

    .old-price {
        font-size: 12px;
        color: #9ca3af;
        text-decoration: line-through;
    }

    .discount-tag {
        position: absolute;
        top: 10px;
        right: 10px;
        padding: 4px 8px;
        border-radius: 999px;
        font-size: 11px;
        font-weight: 700;
        color: #b91c1c;
        background: #fee2e2;
        box-shadow: 0 6px 14px rgba(239, 68, 68, 0.35);
    }

    .saving-tag {
        margin: 4px 0 0;
        font-size: 12px;
        font-weight: 500;
        color: #16a34a;
        background: #ecfdf3;
        border-radius: 999px;
        padding: 4px 8px;
        display: inline-flex;
        align-items: center;
        gap: 4px;
    }

    .saving-tag::before {
        content: "↓";
        font-size: 11px;
    }
</style>

<%
    List<Product> productListDiscount = (List<Product>) request.getAttribute("productListDiscount");
    BigDecimal oldPrice;
    BigDecimal newPrice;
%>

<section class="section-card">
    <div class="section-heading">
        <div>
            <p class="section-eyebrow">Flash Sale</p>
            <h2>Massive Price Drops</h2>
            <p>Limited-time deals on top-rated brands. Grab them before they’re gone.</p>
        </div>
        <a class="section-link" href="${pageContext.request.contextPath}/FilterProduct?discount=true">
            View all offers
        </a>
    </div>

    <div class="product-grid">
        <% if (productListDiscount != null && !productListDiscount.isEmpty()) {
                for (Product pro : productListDiscount) {
                    if (!pro.isIsActive()) {
                        continue;
                    }

                    Locale localeVN = new Locale("vi", "VN");
                    NumberFormat currencyVN = NumberFormat.getInstance(localeVN);

                    String giaCuFormatted = currencyVN.format(pro.getPrice());

                    if (pro.getDiscount() != 0) {
                        oldPrice = pro.getPrice();
                        int discount = pro.getDiscount();
                        BigDecimal discountRate = BigDecimal.valueOf(discount).divide(BigDecimal.valueOf(100));
                        newPrice = pro.getPrice().multiply(BigDecimal.ONE.subtract(discountRate));
                        BigDecimal giaDaGiam = oldPrice.subtract(newPrice);
        %>

        <a class="product-card"
           href="<%= request.getContextPath()%>/ProductDetail?productId=<%= pro.getProductId()%>&categoryId=<%= pro.getCategoryId()%>">

            <span class="badge-pill"><i class="bi bi-fire"></i> Limited Deal</span>

            <img src="<%= pro.getImageUrl()%>" alt="<%= pro.getProductName()%>">

            <p class="product-name"><%= pro.getProductName()%></p>

            <div class="price-row">
                <span class="current-price"><%= currencyVN.format(newPrice)%> đ</span>
                <span class="old-price"><%= giaCuFormatted%></span>
            </div>

            <span class="discount-tag">-<%= discount%>%</span>
            <p class="saving-tag">Save <%= currencyVN.format(giaDaGiam)%> đ</p>

        </a>

        <% } else {%>

        <a class="product-card"
           href="<%= request.getContextPath()%>/ProductDetail?productId=<%= pro.getProductId()%>&categoryId=<%= pro.getCategoryId()%>">

            <span class="badge-pill"><i class="bi bi-fire"></i> Limited Deal</span>

            <img src="<%= pro.getImageUrl()%>" alt="<%= pro.getProductName()%>">

            <p class="product-name"><%= pro.getProductName()%></p>

            <div class="price-row">
                <span class="current-price"><%= giaCuFormatted%> đ</span>
            </div>

        </a>

        <% }
            }
        } else { %>

        <p>No discount campaigns are available at the moment.</p>

        <% }%>
    </div>
</section>
