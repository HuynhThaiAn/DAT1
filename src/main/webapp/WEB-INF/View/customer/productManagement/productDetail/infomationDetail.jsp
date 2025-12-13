
<%@page import="model.Product"%>
<%@page import="model.ProductDetail"%>
<%@page import="model.CategoryDetail"%>
<%@page import="model.CategoryDetailGroup"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    List<CategoryDetailGroup> categoryDetailGroupList = (List<CategoryDetailGroup>) request.getAttribute("cateGroupList");
    List<CategoryDetail> categoryDetailList = (List<CategoryDetail>) request.getAttribute("cateDetailList");
    List<ProductDetail> productDetailList = (List<ProductDetail>) request.getAttribute("productDetailList");
    Product product = (Product) request.getAttribute("product");
%>

<style>
    .spec-section {
        padding: 16px 16px 10px;
    }

    .spec-title {
        font-size: 18px;
        font-weight: 700;
        text-align: center;
        margin-bottom: 12px;
        color: #111827;
    }

    .spec-subtitle {
        font-size: 13px;
        text-align: center;
        color: #6b7280;
        margin-top: -4px;
        margin-bottom: 14px;
    }

    .spec-table {
        width: 100%;
        border-collapse: collapse;
        font-size: 13.5px;
        background-color: #ffffff;
    }

    .spec-table tr:nth-child(even) .category-name,
    .spec-table tr:nth-child(even) .attribute-values {
        background-color: #f9fafb;
    }

    .category-name,
    .attribute-values {
        border-top: 1px solid #e5e7eb;
        padding: 8px 10px;
        vertical-align: top;
    }

    .category-name {
        width: 32%;
        font-weight: 500;
        color: #111827;
    }

    .attribute-values {
        color: #374151;
    }

    .attribute-item {
        margin-bottom: 4px;
    }

    .attribute-item:last-child {
        margin-bottom: 0;
    }

    .no-data-message {
        text-align: center;
        padding: 10px;
        color: #9ca3af;
        font-size: 13px;
    }

    /* Group header (accordion) */
    .group-header {
        background: #f3f4ff;
        cursor: pointer;
        user-select: none;
    }

    .group-cell {
        padding: 8px 10px;
        border-top: 1px solid #e5e7eb;
    }

    .group-header-content {
        display: flex;
        justify-content: space-between;
        align-items: center;
        gap: 8px;
    }

    .group-name {
        font-size: 14px;
        font-weight: 600;
        color: #111827;
        max-width: 70%;
        word-wrap: break-word;
        margin: 0;
    }

    .arrow-icon {
        font-size: 13px;
        color: #4b5563;
        transition: transform 0.16s ease;
    }

    .arrow-icon.open {
        transform: rotate(180deg);
    }

    .hidden {
        display: none;
    }

    @media (max-width: 768px) {
        .category-name,
        .attribute-values {
            padding: 7px 8px;
        }

        .spec-title {
            font-size: 16px;
        }
    }
</style>

<div class="spec-section">
    <h2 class="spec-title">Specifications</h2>
    <p class="spec-subtitle">Technical details and configuration of the product.</p>

    <table class="spec-table">
        <%
            if (categoryDetailGroupList != null && !categoryDetailGroupList.isEmpty()) {
                int groupIndex = 0;
                for (CategoryDetailGroup cateGroup : categoryDetailGroupList) {
        %>
        <!-- Group header -->
        <tr class="group-header" onclick="toggleDetails(<%= groupIndex %>)">
            <td colspan="2" class="group-cell">
                <div class="group-header-content">
                    <h3 class="group-name"><%= cateGroup.getNameCategoryDetailsGroup() %></h3>
                    <span class="arrow-icon" id="arrow<%= groupIndex %>">▼</span>
                </div>
            </td>
        </tr>

        <!-- Group details -->
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
                        if (productDetailList != null && !productDetailList.isEmpty()) {
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
                    <div class="attribute-item">No data</div>
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
        <tr>
            <td colspan="2" class="no-data-message">No specification data available.</td>
        </tr>
        <%
            }
        %>
    </table>
</div>

<script>
    function toggleDetails(index) {
        const detailGroup = document.getElementById("detailGroup" + index);
        const arrowIcon = document.getElementById("arrow" + index);

        if (!detailGroup || !arrowIcon) return;

        if (detailGroup.classList.contains("hidden")) {
            detailGroup.classList.remove("hidden");
            arrowIcon.classList.add("open");
        } else {
            detailGroup.classList.add("hidden");
            arrowIcon.classList.remove("open");
        }
    }
</script>
