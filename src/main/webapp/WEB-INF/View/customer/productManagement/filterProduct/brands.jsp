<%@page import="model.Brand"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    List<Brand> brandList = (List<Brand>) request.getAttribute("brandList");
%>

<style>
    .brand-strip {
        display: flex;
        align-items: center;
        gap: 10px;
        width: 100%;
        margin: 10px 0 4px;
        overflow-x: auto;
        padding-bottom: 4px;
    }

    .brand-item {
        flex: 0 0 auto;
        min-width: 64px;
        max-width: 80px;
        padding: 6px 8px;
        border-radius: 999px;
        background-color: #f2f4f7;
        border: 1px solid #e5e7eb;
        display: flex;
        align-items: center;
        justify-content: center;
        cursor: pointer;
        transition: 0.18s ease;
    }

    .brand-item:hover {
        background-color: #e5efff;
        border-color: #c4d3ff;
        box-shadow: 0 4px 10px rgba(15, 23, 42, 0.12);
        transform: translateY(-1px);
    }

    .brand-logo {
        width: 100%;
        max-height: 36px;
        object-fit: contain;
        border-radius: 8px;
        display: block;
    }

    .brand-strip::-webkit-scrollbar {
        height: 6px;
    }

    .brand-strip::-webkit-scrollbar-track {
        background: transparent;
    }

    .brand-strip::-webkit-scrollbar-thumb {
        background: #d1d5db;
        border-radius: 999px;
    }

    @media (max-width: 768px) {
        .brand-item {
            min-width: 60px;
        }
    }
</style>

<div class="brand-strip">
    <%
        if (brandList != null && !brandList.isEmpty()) {
            for (Brand br : brandList) {
    %>
        <div class="brand-item">
            <a href="FilterProduct?categoryId=<%= br.getCategoryID() %>&brandId=<%= br.getBrandId() %>">
                <img class="brand-logo" src="<%= br.getImgUrlLogo() %>" alt="brand">
            </a>
        </div>
    <%
            }
        } else {
    %>
        <span style="font-size: 13px; color: #9ca3af;">No brand data</span>
    <%
        }
    %>
</div>
