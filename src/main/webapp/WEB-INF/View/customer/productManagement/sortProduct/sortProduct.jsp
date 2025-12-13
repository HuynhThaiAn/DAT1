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

            /* Gợi ý nhanh */
            .divGoiY {
                display: flex;
                flex-wrap: wrap;
                justify-content: center;
                gap: 6px;
                background-color: #EAECF0;
                padding: 6px 8px;
                border-radius: 10px;
                margin-bottom: 10px;
            }

            .p {
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
                margin: 0;
            }

            .p:hover {
                background: #d0e3ff;
                transform: translateY(-1px);
            }

            /* Breadcrumb + số lượng */
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

            .home {
                font-size: 13px;
                font-weight: 400;
                color: rgba(152, 162, 179, 1);
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

            .banner {
                margin-top: 6px;
                margin-bottom: 10px;
            }

            /* KHUNG TRẮNG CHỨA FILTER + BRAND + LIST */
            .product-container {
                background-color: #ffffff;
                border-radius: 20px;
                margin-top: 8px;
                padding: 14px 16px 18px;
                width: 100%;
                box-shadow: 0 10px 30px rgba(15, 23, 42, 0.06);
            }

            /* THANH FILTER + LOGO BRAND GIỐNG SEARCH */
            .filterAndBrand {
                display: flex;
                align-items: center;
                gap: 10px;
                background: #F9FAFB;
                border-radius: 999px;
                padding: 6px 10px;
                box-shadow: 0 3px 10px rgba(15, 23, 42, 0.06);
                margin-bottom: 10px;
            }

            .filter-wrapper {
                flex: 0 0 auto;
            }

            .brand-strip-wrapper {
                flex: 1 1 auto;
                overflow-x: auto;
            }

            .productList {
                width: 100%;
                margin-top: 4px;
            }

            @media (max-width: 992px) {
                .page-wrapper {
                    padding: 0 8px;
                }
                .product-container {
                    padding: 10px 10px 14px;
                }
                .filterAndBrand {
                    border-radius: 14px;
                    flex-wrap: wrap;
                }
            }
        </style>
    </head>

    <body>
        <jsp:include page="/WEB-INF/View/customer/homePage/header.jsp" />

        <div class="page-wrapper">
            <!-- Gợi ý nhanh -->
            <div class="divGoiY">
                <p class="p">Air Conditioning</p>
                <p class="p">Refrigerator</p>
                <p class="p">Television</p>
                <p class="p">Fridge</p>
                <p class="p">Rice Cookers</p>
            </div>

            <!-- Breadcrumb -->
            <div class="breadcrumb-bar">
                <a class="home" href="Home">Home</a>
                <span class="breadcrumb-separator">&gt;</span>
                <span class="breadcrumb-category"><%= categoryName %></span>
                <span class="breadcrumb-count">(<%= totalProducts %> products)</span>
            </div>

            <!-- Banner -->
            <div class="banner">
                <jsp:include page="/WEB-INF/View/customer/productManagement/sortProduct/banner.jsp" />
            </div>

            <!-- Khung filter + brand + list -->
            <div class="product-container">
                <div class="filterAndBrand">
                    <div class="filter-wrapper">
                        <jsp:include page="/WEB-INF/View/customer/productManagement/sortProduct/filterAndBrand.jsp" />
                    </div>
                    <div class="brand-strip-wrapper">
                        <jsp:include page="/WEB-INF/View/customer/productManagement/filterProduct/brands.jsp" />
                    </div>
                </div>

                <div class="productList">
                    <jsp:include page="/WEB-INF/View/customer/productManagement/sortProduct/productList.jsp" />
                </div>
            </div>
        </div>

        <jsp:include page="/WEB-INF/View/customer/homePage/footer.jsp" />
    </body>
</html>
