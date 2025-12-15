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

    Locale localeVN = new Locale("vi", "VN");
    NumberFormat currencyVN = NumberFormat.getInstance(localeVN);
%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Products</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/Css/filterProduct.css">

        <style>
           
            .product-grid {
                display: grid;
                grid-template-columns: repeat(5, 1fr);
                gap: 14px;
                width: 100%;
            }

            .product-card {
                width: 100%;
                background-color: #ffffff;
                border-radius: 14px;
                padding: 10px 10px 12px;
                box-shadow: 0 6px 18px rgba(15, 23, 42, 0.07);
                transition: 0.18s ease;
                position: relative;
                overflow: hidden;
            }

            .product-card:hover {
                transform: translateY(-3px);
                box-shadow: 0 10px 26px rgba(15, 23, 42, 0.15);
            }

            .product-card a {
                text-decoration: none;
                color: inherit;
                display: block;
            }

            .product-image-wrapper {
                width: 100%;
                aspect-ratio: 4 / 3;
                display: flex;
                align-items: center;
                justify-content: center;
                margin-bottom: 6px;
            }

            .product-image {
                width: 100%;
                max-height: 100%;
                object-fit: contain;
            }

            .badge-installment {
                display: inline-flex;
                padding: 2px 8px;
                border-radius: 999px;
                font-size: 11px;
                font-weight: 600;
                color: #ffffff;
                background: linear-gradient(120deg, #1e88e5, #42a5f5);
                margin-bottom: 4px;
            }

            .product-name {
                font-size: 13px;
                font-weight: 500;
                color: #111827;
                line-height: 1.4;
                max-height: 3.2em;
                overflow: hidden;
                margin: 4px 0 6px;
            }

            .price-old-row {
                font-size: 12px;
                color: #98a2b3;
                margin: 0;
            }

            .price-old-row s {
                margin-right: 4px;
            }

            .price-old-row .discount-percent {
                color: #e11d48;
                font-weight: 600;
            }

            .price-new {
                font-size: 14px;
                font-weight: 700;
                color: #d92d20;
                margin: 4px 0 2px;
            }

            .price-save {
                font-size: 12px;
                color: #16a34a;
                margin: 0;
            }

            .no-result-text {
                font-size: 14px;
                color: #6b7280;
                padding: 8px 4px;
            }

            /* Responsive giống search nhưng chuyển sang grid */
            @media (max-width: 992px) {
                .product-grid {
                    grid-template-columns: repeat(3, 1fr);
                }
            }

            @media (max-width: 576px) {
                .product-grid {
                    grid-template-columns: repeat(2, 1fr);
                }
            }
        </style>
    </head>
    <body>

        <div class="product-grid">
            <%
                if (productList != null && !productList.isEmpty()) {
                    for (Product pro : productList) {
                        if (!pro.isIsActive()) {
                            continue;  
                        }

                        BigDecimal price = pro.getPrice();
                        String giaCuFormatted;
                        String giaMoiFormatted;
                        String giamFormatted;
                        int discount = pro.getDiscount();
            %>

            
            <div class="divProduct product-card">
                <a href="<%= request.getContextPath() %>/ProductDetail?productId=<%= pro.getProductId() %>&categoryId=<%= pro.getCategoryId() %>">
                    <div class="product-image-wrapper divHinh">
                        <img src="<%= pro.getImageUrl() %>" alt="product-image" class="product-image anhDienThoaiDocQuyen">
                    </div>

                    <div class="divTraGop">
                        <span class="badge-installment traGop">Trả góp 0%</span>
                    </div>

                    <p class="product-name productName"><%= pro.getProductName() %></p>

                    <%
                        if (discount != 0) {
                            oldPrice = price;
                            BigDecimal discountRate = BigDecimal.valueOf(discount)
                                                                 .divide(BigDecimal.valueOf(100));
                            newPrice = price.multiply(BigDecimal.ONE.subtract(discountRate));

                            BigDecimal giaCu = oldPrice;
                            BigDecimal giaMoi = newPrice;
                            BigDecimal giaDaGiam = giaCu.subtract(giaMoi);

                            giaCuFormatted = currencyVN.format(giaCu);
                            giaMoiFormatted = currencyVN.format(giaMoi);
                            giamFormatted = currencyVN.format(giaDaGiam);
                    %>
                    <p class="price-old-row giaCu">
                        <s><%= giaCuFormatted %> đ</s>
                        <span class="discount-percent">-<%= discount %>%</span>
                    </p>
                    <p class="price-new giaMoi"><%= giaMoiFormatted %> đ</p>
                    <p class="price-save giam">Giảm <%= giamFormatted %> đ</p>
                    <%
                        } else {
                            giaCuFormatted = currencyVN.format(price);
                    %>
                    <p class="price-new giaMoi"><%= giaCuFormatted %> đ</p>
                    <%
                        }
                    %>
                </a>
            </div>

            <%
                    } // end for
                } else {
            %>
            <p class="no-result-text">No matching products found.</p>
            <%
                }
            %>
        </div>

    </body>
</html>
