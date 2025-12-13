<%@page import="model.Brand"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    List<Brand> brandList = (List<Brand>) request.getAttribute("brandList");
%>

<style>
    .banner-container {
        display: flex;
        gap: 1%;
        width: 100%;
        margin: 10px 0;
    }

    .banner-box {
        width: 50%;
        border-radius: 14px;
        overflow: hidden;
        cursor: pointer;
        background: #fff;
        transition: .28s ease;
        position: relative;
    }

    .banner-box img {
        width: 100%;
        height: 100%;
        object-fit: cover;
        display:block;
        transition: .35s ease;
    }

    .banner-box:hover img {
        transform: scale(1.04);
        filter: brightness(1.05);
    }

    .banner-box::after{
        content:"";
        position:absolute;
        inset:0;
        background:linear-gradient(to bottom right,rgba(0,0,0,.0),rgba(0,0,0,.1));
        opacity:0;
        transition:.35s;
    }
    .banner-box:hover::after{
        opacity:1;
    }

    /* 📱 Responsive */
    @media(max-width:768px){
        .banner-container{
            flex-direction:column;
            gap:12px;
        }
        .banner-box{
            width:100%;
        }
    }
</style>


<%
    if(brandList != null && !brandList.isEmpty()) {
        String banner1="", banner2="";
        Brand br = brandList.get(0);

        switch (br.getCategoryID()) {
            case 1: banner1="https://cdnv2.tgdd.vn/mwg-static/dmx/Banner/fb/74/fb74632c62b3fa78b974fc4c3d737433.png";
                    banner2="https://cdnv2.tgdd.vn/mwg-static/dmx/Banner/ef/dd/efddab4db919e5f678367d599c64be42.png"; break;
            case 2: banner1="https://cdnv2.tgdd.vn/mwg-static/dmx/Banner/8f/fd/8ffd049e153449d4c64e748dd342d7f9.png";
                    banner2="https://cdnv2.tgdd.vn/mwg-static/dmx/Banner/cf/35/cf35c359dbbdc83e3c4337b9d2f0dec8.png"; break;
            case 3: banner1="https://cdnv2.tgdd.vn/mwg-static/dmx/Banner/f4/c5/f4c5f6d61359b32152a7012ecc6b5bf2.png";
                    banner2="https://cdnv2.tgdd.vn/mwg-static/dmx/Banner/5d/55/5d55b7c7b9671bf770c422de789c95ab.png"; break;
            case 4: banner1="https://cdnv2.tgdd.vn/mwg-static/dmx/Banner/e1/96/e1966ec7e26c50f7e721c47de654ff7b.png";
                    banner2="https://cdnv2.tgdd.vn/mwg-static/dmx/Banner/d2/d1/d2d17936e0d736c7e34c9bbc009666b4.png"; break;
            case 5: banner1="https://cdnv2.tgdd.vn/mwg-static/dmx/Banner/84/07/8407b345ec365ee66445938e8fe080ee.png";
                    banner2="https://cdnv2.tgdd.vn/mwg-static/dmx/Banner/d9/64/d96429099d3b2854a744430125ab360b.png"; break;
        }
%>

<div class="banner-container">
    <div class="banner-box">
        <img src="<%= banner1 %>">
    </div>

    <div class="banner-box">
        <img src="<%= banner2 %>">
    </div>
</div>

<% } %>
