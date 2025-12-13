<%@page import="model.Product"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    List<Product> productList = (List<Product>) request.getAttribute("productList");
    int totalProducts = (productList != null) ? productList.size() : 0;
    String categoryName = (productList != null && !productList.isEmpty())
            ? productList.get(0).getCategoryName()
            : "Products";
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title><%= categoryName %> - DAT</title>

        <style>
            body {
                background-color: #F2F4F7 !important;
                padding: 0 !important;
                margin: 0;
                font-family: system-ui, -apple-system, BlinkMacSystemFont, "Segoe UI", sans-serif;
            }

            .page-wrapper {
                max-width: 1200px;
                margin: 16px auto 32px;
                padding: 0 12px;
            }

            /* 🔹 Hàng gợi ý nhanh */
            .suggest-row {
                display: flex;
                flex-wrap: wrap;
                justify-content: center;
                gap: 6px;
                background-color: #EAECF0;
                padding: 6px 8px;
                border-radius: 10px;
                margin-bottom: 10px;
            }

            .suggest-chip {
                font-size: 13px;
                padding: 4px 10px;
                border-radius: 999px;
                color: #0567da;
                background: #E0EDFF;
                border: 1px solid #C4DAFF;
                display: inline-flex;
                align-items: center;
                justify-content: center;
                white-space: nowrap;
                cursor: pointer;
                transition: 0.18s ease;
            }

            .suggest-chip:hover {
                background: #d0e3ff;
                transform: translateY(-1px);
            }

            /* 🔹 Breadcrumb + số lượng */
            .breadcrumb-bar {
                display: flex;
                flex-wrap: wrap;
                align-items: center;
                gap: 4px;
                font-size: 13px;
                margin: 8px 0 10px;
            }

            .breadcrumb-bar a {
                text-decoration: none;
            }

            .breadcrumb-home {
                color: #98A2B3;
            }

            .breadcrumb-separator {
                color: #D0D5DD;
            }

            .breadcrumb-category {
                color: #344054;
                font-weight: 500;
            }

            .breadcrumb-count {
                color: #667085;
                margin-left: 6px;
            }

            /* 🔹 Banner block */
            .banner {
                margin-top: 6px;
                margin-bottom: 10px;
            }

            /* 🔹 Khung chứa danh sách sản phẩm */
            .product-container {
                background-color: #ffffff;
                border-radius: 14px;
                padding: 12px 12px 16px;
                margin-top: 8px;
                box-shadow: 0 10px 30px rgba(15, 23, 42, 0.06);
            }

            .productList {
                width: 100%;
                margin-top: 4px;
            }

            @media (max-width: 768px) {
                .page-wrapper {
                    padding: 0 8px;
                }
                .product-container {
                    padding: 10px 8px 14px;
                }
            }
        </style>
    </head>

    <body>
        <jsp:include page="/WEB-INF/View/customer/homePage/header.jsp" />

        <div class="page-wrapper">

            <!-- Gợi ý nhanh -->
            <div class="suggest-row">
                <span class="suggest-chip">Air Conditioning</span>
                <span class="suggest-chip">Refrigerator</span>
                <span class="suggest-chip">Television</span>
                <span class="suggest-chip">Fridge</span>
                <span class="suggest-chip">Rice Cookers</span>
            </div>

            <!-- Breadcrumb + số sản phẩm -->
            <div class="breadcrumb-bar">
                <a class="breadcrumb-home" href="Home">Home</a>
                <span class="breadcrumb-separator">&gt;</span>
                <span class="breadcrumb-category"><%= categoryName %></span>
                <span class="breadcrumb-count">(<%= totalProducts %> products)</span>
            </div>

            <!-- Banner -->
            <div class="banner">
                <jsp:include page="/WEB-INF/View/customer/productManagement/filterProduct/banner.jsp" />
            </div>

            <!-- Khung danh sách sản phẩm -->
            <div class="product-container container-fluid">
                <div class="productList">
                    <jsp:include page="/WEB-INF/View/customer/productManagement/filterProduct/productList.jsp" />
                </div>
            </div>
        </div>

        <jsp:include page="/WEB-INF/View/customer/homePage/footer.jsp" />
    </body>
</html>
