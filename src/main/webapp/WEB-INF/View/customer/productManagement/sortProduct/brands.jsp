<%@page import="java.util.List"%>
<%@page import="model.Brand"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    List<Brand> brandList = (List<Brand>) request.getAttribute("brandList");
%>


<style>
    .brand-scroll {
        display: flex;
        gap: 14px;
        padding: 10px 8px;
        overflow-x: auto;
        scrollbar-width: thin;
        scrollbar-color: #d1d5db transparent;
        scroll-behavior: smooth;
    }

    .brand-scroll::-webkit-scrollbar { height: 6px; }
    .brand-scroll::-webkit-scrollbar-thumb {
        background: #cfd3da;
        border-radius: 10px;
    }

    .brand-item {
        width: 72px;
        height: 72px;
        background: #f3f4f6;
        border-radius: 14px;
        border: 1px solid #e5e7eb;
        display: flex;
        align-items: center;
        justify-content: center;
        cursor: pointer;
        transition: .25s ease;
        flex-shrink: 0;
    }

    .brand-item:hover {
        transform: translateY(-3px);
        background: #eaf3ff;
        border-color: #3b82f6;
        box-shadow: 0 4px 12px rgba(0,0,0,0.08);
    }

    .brand-logo {
        width: 82%;
        height: 82%;
        object-fit: contain;
        border-radius: 8px;
        transition: .25s;
    }
</style>


<div class="brand-scroll">
    <% if (brandList != null) {
        for (Brand br : brandList) { %>

        <a href="FilterProduct?categoryId=<%=br.getCategoryID()%>&brandId=<%=br.getBrandId()%>" style="text-decoration:none;">
            <div class="brand-item">
                <img class="brand-logo" src="<%= br.getImgUrlLogo() %>" alt="Brand">
            </div>
        </a>

    <%  } } else { %>
        <p style="color:gray;">No brand list found.</p>
    <% } %>
</div>
