<%@page import="model.Brand"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    List<Brand> brandList = (List<Brand>) request.getAttribute("brandList");
%>

<style>
    .banner-row {
        display: flex;
        gap: 0.8%;
        width: 100%;
        margin: 10px 0 18px;
    }

    .banner-box {
        width: 50%;
        border-radius: 14px;
        overflow: hidden;
        cursor: pointer;
        transition: .25s ease;
        background: #fff;
    }

    .banner-box:hover {
        transform: scale(1.015);
        box-shadow: 0 8px 28px rgba(0,0,0,.10);
    }

    .banner-img {
        width: 100%;
        height: 100%;
        object-fit: cover;
        display: block;
    }

    /* Mobile responsive */
    @media(max-width: 768px){
        .banner-row{
            flex-direction: column;
            gap: 12px;
        }
        .banner-box{
            width: 100%;
        }
    }
</style>


<% if(brandList != null){ 
    String banner1="", banner2="";
    Brand br = brandList.get(0);

    switch(br.getCategoryID()){
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

<div class="banner-row">
    <div class="banner-box"><img class="banner-img" src="<%=banner1%>"></div>
    <div class="banner-box"><img class="banner-img" src="<%=banner2%>"></div>
</div>

<% } %>
