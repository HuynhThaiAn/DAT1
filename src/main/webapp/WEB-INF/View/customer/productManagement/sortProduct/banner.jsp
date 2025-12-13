<%@page import="model.Brand"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    List<Brand> brandList = (List<Brand>) request.getAttribute("brandList");
    String banner1 = null;
    String banner2 = null;

    if (brandList != null && !brandList.isEmpty()) {
        Brand br = brandList.get(0);

        switch (br.getCategoryID()) {
            case 1:
                banner1 = "https://cdnv2.tgdd.vn/mwg-static/dmx/Banner/fb/74/fb74632c62b3fa78b974fc4c3d737433.png";
                banner2 = "https://cdnv2.tgdd.vn/mwg-static/dmx/Banner/ef/dd/efddab4db919e5f678367d599c64be42.png";
                break;
            case 2:
                banner1 = "https://cdnv2.tgdd.vn/mwg-static/dmx/Banner/8f/fd/8ffd049e153449d4c64e748dd342d7f9.png";
                banner2 = "https://cdnv2.tgdd.vn/mwg-static/dmx/Banner/cf/35/cf35c359dbbdc83e3c4337b9d2f0dec8.png";
                break;
            case 3:
                banner1 = "https://cdnv2.tgdd.vn/mwg-static/dmx/Banner/f4/c5/f4c5f6d61359b32152a7012ecc6b5bf2.png";
                banner2 = "https://cdnv2.tgdd.vn/mwg-static/dmx/Banner/5d/55/5d55b7c7b9671bf770c422de789c95ab.png";
                break;
            case 4:
                banner1 = "https://cdnv2.tgdd.vn/mwg-static/dmx/Banner/e1/96/e1966ec7e26c50f7e721c47de654ff7b.png";
                banner2 = "https://cdnv2.tgdd.vn/mwg-static/dmx/Banner/d2/d1/d2d17936e0d736c7e34c9bbc009666b4.png";
                break;
            case 5:
                banner1 = "https://cdnv2.tgdd.vn/mwg-static/dmx/Banner/84/07/8407b345ec365ee66445938e8fe080ee.png";
                banner2 = "https://cdnv2.tgdd.vn/mwg-static/dmx/Banner/d9/64/d96429099d3b2854a744430125ab360b.png";
                break;
        }
    }
%>

<style>
    .banner-row {
        width: 100%;
        display: flex;
        gap: 0.75%;
        margin: 8px 0 4px;
    }

    .banner-item {
        flex: 1;
        border-radius: 12px;
        overflow: hidden;
        position: relative;
        cursor: pointer;
        background: #f3f4f6;
        transition: 0.25s ease;
    }

    .banner-item img {
        width: 100%;
        height: 100%;
        object-fit: cover;
        display: block;
        transition: 0.35s ease;
    }

    .banner-item::after {
        content: "";
        position: absolute;
        inset: 0;
        background: linear-gradient(to bottom right, rgba(15,23,42,0), rgba(15,23,42,0.12));
        opacity: 0;
        transition: 0.25s ease;
    }

    .banner-item:hover img {
        transform: scale(1.03);
        filter: brightness(1.03);
    }

    .banner-item:hover::after {
        opacity: 1;
    }

    @media (max-width: 768px) {
        .banner-row {
            flex-direction: column;
            gap: 10px;
        }
        .banner-item {
            width: 100%;
        }
    }
</style>

<% if (banner1 != null && banner2 != null) { %>
<div class="banner-row">
    <div class="banner-item">
        <img src="<%= banner1 %>" alt="banner-1">
    </div>
    <div class="banner-item">
        <img src="<%= banner2 %>" alt="banner-2">
    </div>
</div>
<% } %>
