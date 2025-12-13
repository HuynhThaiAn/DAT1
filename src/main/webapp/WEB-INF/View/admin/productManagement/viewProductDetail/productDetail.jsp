
<%@page import="model.Product"%>
<%@page import="model.ProductDetail"%>
<%@page import="model.CategoryDetail"%>
<%@page import="model.CategoryDetailGroup"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    List<CategoryDetailGroup> categoryDetailGroupList = (List<CategoryDetailGroup>) request.getAttribute("categoryGroupList");
    List<CategoryDetail>      categoryDetailList      = (List<CategoryDetail>)      request.getAttribute("categoryDetailList");
    List<ProductDetail>       productDetailList       = (List<ProductDetail>)       request.getAttribute("productDetailList");
    Product                   product                 = (Product)                   request.getAttribute("product");
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Product Detail</title>

    <!-- Nếu đã có CSS ngoài thì vẫn có thể giữ -->
    <%-- <link rel="stylesheet" href="Css/productDetail1.css"> --%>

    <style>
        body {
            background: #f4f6fb;
            font-family: system-ui, -apple-system, BlinkMacSystemFont, "Segoe UI", sans-serif;
        }

        .page-wrapper {
            max-width: 1200px;
            margin: 24px auto;
            padding: 0 16px;
        }

        /* Header trang */
        .page-header {
            display: flex;
            align-items: flex-end;
            gap: 12px;
            margin-bottom: 18px;
        }

        .page-header h1 {
            margin: 0;
            font-size: 32px;
            font-weight: 800;
            color: #111827;
            letter-spacing: .03em;
        }

        .page-header span {
            font-size: 14px;
            color: #6b7280;
            margin-bottom: 4px;
        }

        /* Card chứa bảng thuộc tính */
        .detail-card {
            background: #ffffff;
            border-radius: 16px;
            padding: 20px 22px;
            box-shadow: 0 6px 20px rgba(15, 23, 42, 0.08);
        }

        .product-title {
            margin: 0 0 8px;
            font-size: 20px;
            font-weight: 700;
            color: #111827;
        }

        .product-subtitle {
            margin: 0 0 18px;
            font-size: 13px;
            color: #6b7280;
        }

        /* ===== BẢNG TỔNG ===== */
        .category-table {
            width: 100%;
            border-collapse: separate;
            border-spacing: 0 10px; /* khoảng cách giữa các card */
            background-color: transparent;
            padding: 4px 0;
        }

        .category-table th,
        .category-table td {
            padding: 6px 16px;
            text-align: left;
            vertical-align: top;
            word-wrap: break-word;
            background-color: #ffffff;
            border: none;
            border-radius: 12px;
            font-size: 13px;
        }

        /* ===== NHÓM TIÊU ĐỀ (GROUP HEADER) ===== */
        .group-header {
            background-color: transparent;
            cursor: pointer;
        }

        .group-cell {
            padding: 0;
        }

        .group-header td {
            background: linear-gradient(90deg, #1d4ed8, #2563eb);
            border-radius: 14px;
            padding: 10px 18px;
            font-weight: 600;
            font-size: 15px;
            color: #f9fafb;
        }

        .group-header-content {
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .group-header h2 {
            margin: 0;
            font-size: 15px;
            font-weight: 600;
            color: #f9fafb;
            word-wrap: break-word;
            overflow-wrap: break-word;
            max-width: 80%;
        }

        .arrow-icon {
            font-size: 18px;
            color: #e5e7eb;
            transition: transform 0.3s ease, color 0.2s ease;
        }

        .group-header:hover td {
            filter: brightness(1.05);
        }

        .group-header:hover .arrow-icon {
            color: #ffffff;
        }

        /* Khi thu gọn: xoay mũi tên */
        .group-header.collapsed .arrow-icon {
            transform: rotate(-90deg);
        }

        /* ===== BODY HÀNG DETAIL (CARD) ===== */
        .group-details {
            transition: all 0.25s ease;
        }

        .group-details.hidden {
            display: none;
        }

        .category-table tr:not(.group-header) {
            box-shadow: 0 3px 10px rgba(15, 23, 42, 0.06);
            overflow: hidden;
            display: table;
            width: 100%;
            table-layout: fixed;
            border-radius: 12px;
            background-color: #ffffff;
            transition: transform 0.12s ease, box-shadow 0.2s ease, background-color 0.18s ease;
        }

        .category-table tr:not(.group-header):hover {
            transform: translateY(-1px);
            box-shadow: 0 6px 18px rgba(15, 23, 42, 0.14);
            background-color: #f9fafb;
        }

        .category-name {
            font-weight: 600;
            color: #111827;
            width: 28%;
            font-size: 13px;
            padding-top: 14px;
        }

        .attribute-values {
            color: #374151;
            display: flex;
            flex-wrap: wrap;
            gap: 8px;
            padding-top: 10px;
            flex: 1;
        }

        .attribute-item {
            background-color: #4b5563;
            color: #ffffff;
            border: none;
            border-radius: 999px;
            padding: 4px 10px;
            font-size: 12px;
            max-width: 100%;
            box-sizing: border-box;
            line-height: 1.4;
            user-select: none;
            display: inline-flex;
            align-items: center;
            gap: 4px;
        }

        .attribute-item::before {
            content: "";
            width: 6px;
            height: 6px;
            border-radius: 999px;
            background-color: #bbf7d0;
        }

        /* No data chip */
        .attribute-item.attribute-empty {
            background-color: #e5e7eb;
            color: #6b7280;
        }

        .attribute-item.attribute-empty::before {
            background-color: #9ca3af;
        }

        .no-data-message {
            text-align: center;
            padding: 18px;
            color: #9ca3af;
            font-style: italic;
            font-size: 14px;
            background-color: #f9fafb;
            border-radius: 10px;
        }

        /* Nút back / save nếu có dùng */
        .btn-back {
            color: #fff;
            background-color: #6c757d;
            border: 1px solid #6c757d;
            padding: 8px 16px;
            border-radius: 6px;
            font-size: 14px;
            cursor: pointer;
            transition: background-color 0.3s ease, box-shadow 0.2s ease;
        }

        .btn-back:hover {
            background-color: #5c636a;
            border-color: #565e64;
            box-shadow: 0 3px 10px rgba(148, 163, 184, 0.45);
        }

        @media (max-width: 768px) {
            .category-name {
                width: 100%;
                padding-top: 10px;
                margin-bottom: 4px;
            }

            .category-table tr:not(.group-header) {
                display: block;
            }

            .category-table td {
                display: block;
                width: 100%;
            }

            .attribute-values {
                padding-top: 4px;
            }
        }
    </style>

    <script>
        function toggleDetails(index) {
            const detailGroup = document.getElementById("detailGroup" + index);
            const headerRow  = document.getElementById("groupHeader" + index);

            const isHidden = detailGroup.classList.contains("hidden");

            if (isHidden) {
                detailGroup.classList.remove("hidden");
                headerRow.classList.remove("collapsed");
            } else {
                detailGroup.classList.add("hidden");
                headerRow.classList.add("collapsed");
            }
        }
    </script>
</head>

<body>
    <div class="page-wrapper">

        <!-- Header -->
        <div class="page-header">
            <h1>Product Management</h1>
            <span>View Product Detail</span>
        </div>

        <!-- Card chính -->
        <div class="detail-card">
            <h2 class="product-title"><%= product != null ? product.getProductName() : "Product Detail" %></h2>
            <p class="product-subtitle">Technical specifications & attributes</p>

            <table class="category-table">
                <%
                    if (categoryDetailGroupList != null) {
                        int groupIndex = 0;
                        for (CategoryDetailGroup cateGroup : categoryDetailGroupList) {
                %>
                <!-- Tên nhóm -->
                <tr class="group-header collapsed" id="groupHeader<%= groupIndex %>" onclick="toggleDetails(<%= groupIndex %>)">
                    <td colspan="2" class="group-cell">
                        <div class="group-header-content">
                            <h2><%= cateGroup.getNameCategoryDetailsGroup() %></h2>
                            <span class="arrow-icon">▼</span>
                        </div>
                    </td>
                </tr>

                <tbody id="detailGroup<%= groupIndex %>" class="group-details hidden">
                    <%
                        if (categoryDetailList != null && !categoryDetailList.isEmpty()) {
                            for (CategoryDetail cateList : categoryDetailList) {
                                if (cateList.getCategoryDetailsGroupID() == cateGroup.getCategoryDetailsGroupID()) {
                                    boolean hasValue = false;
                    %>
                    <tr>
                        <td class="category-name">
                            <%= cateList.getCategoryDatailName() %>
                        </td>
                        <td class="attribute-values">
                            <%
                                if (productDetailList != null) {
                                    for (ProductDetail proDetail : productDetailList) {
                                        if (proDetail.getCategoryDetailID() == cateList.getCategoryDetailID()) {
                                            hasValue = true;
                            %>
                            <div class="attribute-item"><%= proDetail.getAttributeValue() %></div>
                            <%
                                        }
                                    }
                                }
                                if (!hasValue) {
                            %>
                            <div class="attribute-item attribute-empty">No data</div>
                            <%
                                }
                            %>
                        </td>
                    </tr>
                    <%
                                }
                            }
                        }
                    %>
                </tbody>
                <%
                            groupIndex++;
                        }
                    } else {
                %>
                <tr><td colspan="2" class="no-data-message">No data</td></tr>
                <%
                    }
                %>
            </table>
        </div>
    </div>
</body>
</html>
