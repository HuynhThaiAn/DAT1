
<%@page import="model.ProductDetail"%>
<%@page import="java.util.List"%>
<%@page import="model.Product"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    Product product = (Product) request.getAttribute("product");
    List<ProductDetail> productDetail = (List<ProductDetail>) request.getAttribute("productDetailList");
%>

<style>
    .pd-image-wrapper {
        display: flex;
        flex-direction: column;
        gap: 10px;
    }

    /* Ảnh lớn */
    .pd-main-image-card {
        border-radius: 14px;
        background: #f9fafb;
        padding: 10px;
        display: flex;
        align-items: center;
        justify-content: center;
    }

    .pd-main-image {
        max-width: 100%;
        max-height: 420px;
        object-fit: contain;
        transition: transform 0.2s ease;
    }

    .pd-main-image-card:hover .pd-main-image {
        transform: scale(1.02);
    }

    /* Dải thumbnail */
    .pd-thumb-list {
        display: flex;
        flex-wrap: nowrap;
        gap: 8px;
        margin-top: 4px;
        overflow-x: auto;
        padding-bottom: 4px;
    }

    .pd-thumb-item {
        flex: 0 0 auto;
        width: 70px;
        height: 70px;
        border-radius: 10px;
        border: 1px solid #e5e7eb;
        background: #ffffff;
        display: flex;
        align-items: center;
        justify-content: center;
        cursor: pointer;
        transition: 0.18s ease;
    }

    .pd-thumb-item:hover {
        box-shadow: 0 4px 10px rgba(15, 23, 42, 0.12);
        transform: translateY(-1px);
    }

    .pd-thumb-img {
        max-width: 100%;
        max-height: 100%;
        object-fit: contain;
        border-radius: 8px;
        transition: 0.18s ease;
    }

    .pd-thumb-img.active-thumb {
        outline: 2px solid #2563eb;
        outline-offset: 0;
        box-shadow: 0 0 0 1px #bfdbfe;
    }

    @media (max-width: 768px) {
        .pd-main-image-card {
            padding: 6px;
        }
        .pd-thumb-item {
            width: 62px;
            height: 62px;
        }
    }
</style>

<%
    if (product != null) {

        ProductDetail proDetail = null;
        if (productDetail != null && !productDetail.isEmpty()) {
            proDetail = productDetail.get(0);
        }
%>

<div class="pd-image-wrapper">

    <!-- Ảnh chính -->
    <div class="pd-main-image-card">
        <img id="mainImage" src="<%= product.getImageUrl()%>" alt="product image" class="pd-main-image">
    </div>

    <!-- Thumbnail -->
    <%
        if (proDetail != null) {
    %>
    <div class="pd-thumb-list">

        <!-- Ảnh gốc (product.getImageUrl) -->
        <div class="pd-thumb-item">
            <img src="<%= product.getImageUrl()%>"
                 class="pd-thumb-img active-thumb"
                 onclick="changeMainImage(this.src, this)">
        </div>

        <% if (proDetail != null) { %>

        <%-- Ảnh 1 --%>
        <% if (proDetail.getImageUrl1() != null && !proDetail.getImageUrl1().isEmpty()) {%>
        <div class="pd-thumb-item">
            <img src="<%= proDetail.getImageUrl1()%>"
                 class="pd-thumb-img"
                 onclick="changeMainImage(this.src, this)">
        </div>
        <% } %>

        <%-- Ảnh 2 --%>
        <% if (proDetail.getImageUrl2() != null && !proDetail.getImageUrl2().isEmpty()) {%>
        <div class="pd-thumb-item">
            <img src="<%= proDetail.getImageUrl2()%>"
                 class="pd-thumb-img"
                 onclick="changeMainImage(this.src, this)">
        </div>
        <% } %>

        <%-- Ảnh 3 --%>
        <% if (proDetail.getImageUrl3() != null && !proDetail.getImageUrl3().isEmpty()) {%>
        <div class="pd-thumb-item">
            <img src="<%= proDetail.getImageUrl3()%>"
                 class="pd-thumb-img"
                 onclick="changeMainImage(this.src, this)">
        </div>
        <% } %>

        <%-- Ảnh 4 --%>
        <% if (proDetail.getImageUrl4() != null && !proDetail.getImageUrl4().isEmpty()) {%>
        <div class="pd-thumb-item">
            <img src="<%= proDetail.getImageUrl4()%>"
                 class="pd-thumb-img"
                 onclick="changeMainImage(this.src, this)">
        </div>
        <% } %>

        <% } %>

    </div>
    <%
        } // end if proDetail != null
    %>

</div>

<script>
    function changeMainImage(src, thumb) {
        const main = document.getElementById("mainImage");
        if (main) {
            main.src = src;
        }
        const thumbs = document.querySelectorAll(".pd-thumb-img");
        thumbs.forEach(function (img) {
            img.classList.remove("active-thumb");
        });
        if (thumb) {
            thumb.classList.add("active-thumb");
        }
    }
</script>

<%
} else {
%>
<div>Product data not available.</div>
<%
    }
%>
