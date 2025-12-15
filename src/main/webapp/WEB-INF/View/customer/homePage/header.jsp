<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta charset="UTF-8">
<%@page import="model.Account"%>
<%@page import="model.Brand"%>
<%@page import="model.Category"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    List<Category> categoryList = (List<Category>) request.getAttribute("categoryList");
    List<Brand> brandList = (List<Brand>) request.getAttribute("brandList");
    Account user = (Account) session.getAttribute("user");
%>

<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
<link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-icons/1.10.5/font/bootstrap-icons.min.css" rel="stylesheet">


<link rel="stylesheet" href="${pageContext.request.contextPath}/Css/header.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/Css/homepage.css">

<style>
/* =========================
   HEADER WRAPPER
========================= */
.main-header{
    position: sticky;
    top: 0;
    z-index: 9990;
    background: rgba(255,255,255,0.86);
    backdrop-filter: blur(10px);
    border-bottom: 1px solid #e5e7eb;
}

.header-top{
    padding: 10px 18px;
    max-width: 1320px;
    margin: 0 auto;
}

/* =========================
   LOGO
========================= */
.header-logo{
    height: 42px !important;
    width: auto;
    object-fit: contain;
    display: block;
    transition: transform .18s ease;
}
.header-logo:hover{ transform: translateY(-1px); }

/* =========================
   CATEGORY BUTTON
========================= */
.category-btn{
    height: 44px;
    padding: 0 14px;
    border-radius: 14px;
    border: 1px solid #e5e7eb;
    background: #fff;
    font-weight: 800;
    color: #0f172a;
    display: inline-flex;
    align-items: center;
    gap: 10px;
    transition: .2s ease;
    box-shadow: 0 4px 14px rgba(15,23,42,0.06);
}
.category-btn:hover{
    background: #f9fafb;
    transform: translateY(-1px);
    box-shadow: 0 10px 24px rgba(15,23,42,0.10);
}
.category-btn i{ font-size: 18px; color: #2563eb; }

/* =========================
   ✅ CATEGORIES DROPDOWN 
========================= */
.dropdown-menu.cat-menu{
    width: min(860px, calc(100vw - 30px));
    padding: 14px;
    border-radius: 18px;
    border: 1px solid #e5e7eb;
    background: rgba(255,255,255,.98);
    backdrop-filter: blur(10px);
    box-shadow: 0 18px 40px rgba(0,0,0,0.12);
    margin-top: 10px !important;

    display: none;
    grid-template-columns: repeat(5, minmax(0,1fr));
    gap: 12px;

    z-index: 9999;
    overflow: hidden;
}

.dropdown-menu.cat-menu.show{
    display: grid;           
    opacity: 1;
    transform: translateY(0);
}

.dropdown-menu.cat-menu li{
    list-style: none !important;
    margin: 0;
    padding: 0;
}

.dropdown-menu.cat-menu a.dropdown-item{
    height: 112px;
    border-radius: 16px;
    border: 1px solid #f1f5f9;
    background: #fff;
    padding: 12px 10px;
    text-align: center;

    display: flex;
    flex-direction: column;
    align-items: center;
    justify-content: center;
    gap: 6px;

    transition: .18s ease;
    white-space: normal;
}

.dropdown-menu.cat-menu a.dropdown-item:hover{
    background: #eff6ff;
    border-color: #bfdbfe;
    transform: translateY(-2px);
    box-shadow: 0 14px 26px rgba(15,23,42,0.10);
}

.dropdown-menu.cat-menu a.dropdown-item img{
    width: 46px !important;
    height: 46px !important;
    object-fit: contain;
    margin: 0 !important;
    filter: drop-shadow(0 10px 18px rgba(15,23,42,.10));
}

.dropdown-menu.cat-menu a.dropdown-item p{
    margin: 0;
    font-size: 13px;
    font-weight: 900;
    color: #0f172a;
    max-width: 100%;
    overflow: hidden;
    text-overflow: ellipsis;
    white-space: nowrap;
}

/* responsive grid for categories */
@media (max-width: 992px){
    .dropdown-menu.cat-menu{ grid-template-columns: repeat(3, minmax(0,1fr)); }
}
@media (max-width: 576px){
    .dropdown-menu.cat-menu{ grid-template-columns: repeat(2, minmax(0,1fr)); }
}

/* =========================
   SEARCH BAR
========================= */
.search-wrapper{ max-width: 620px; }

.search-bar input.form-control{
    height: 44px;
    border-radius: 16px;
    border: 1px solid #e5e7eb;
    background: #fff;
    padding-left: 14px;
    padding-right: 46px !important;
    transition: .2s ease;
    box-shadow: 0 4px 14px rgba(15,23,42,0.06);
}
.search-bar input.form-control:focus{
    border-color: #93c5fd;
    box-shadow: 0 0 0 4px rgba(59,130,246,0.15);
}

.search-btn{
    height: 36px;
    width: 36px;
    border-radius: 12px !important;
    border: 1px solid #e5e7eb;
    background: #fff;
}
.search-btn:hover{ background: #f3f4f6; }

/* =========================
   RIGHT ICON BUTTONS
========================= */
.header-right .btn{
    height: 44px;
    border-radius: 14px !important;
    border: 1px solid #e5e7eb;
    background: #fff;
    display: inline-flex;
    align-items: center;
    justify-content: center;
    gap: 8px;
    box-shadow: 0 4px 14px rgba(15,23,42,0.06);
    transition: .2s ease;
}
.header-right .btn:hover{
    background: #f9fafb;
    transform: translateY(-1px);
    box-shadow: 0 10px 24px rgba(15,23,42,0.10);
}

/* =========================
   ✅ PROFILE DROPDOWN (custom)
========================= */
.user-dropdown{ position: relative; }

.user-dropdown .btn{
    width: 44px;
    padding: 0;
}

/* caret nhỏ */
.user-dropdown-menu::before{
    content:"";
    position:absolute;
    top:-6px;
    right: 14px;
    width: 12px;
    height: 12px;
    background: #fff;
    border-left: 1px solid #e5e7eb;
    border-top: 1px solid #e5e7eb;
    transform: rotate(45deg);
}

.user-dropdown-menu{
    position: absolute;
    right: 0;
    top: calc(100% + 10px);
    width: 250px;
    background: rgba(255,255,255,.98);
    backdrop-filter: blur(10px);
    border: 1px solid #e5e7eb;
    border-radius: 18px;
    padding: 8px;
    box-shadow: 0 18px 40px rgba(0,0,0,0.14);

    display: none;
    opacity: 0;
    transform: translateY(-10px);
    transition: 0.18s ease;
    z-index: 10000;
}

.user-dropdown-item{
    border-radius: 14px;
    padding: 12px 14px;
    display: flex;
    align-items: center;
    gap: 12px;
    color: #334155;
    font-size: 14px;
    font-weight: 800;
    text-decoration: none;
    transition: all 0.18s ease;
}
.user-dropdown-item i{
    font-size: 18px;
    width: 24px;
    text-align: center;
    color: #64748b;
}
.user-dropdown-item:hover{
    background: #f1f5f9;
    transform: translateY(-1px);
    color: #0f172a;
}
.user-dropdown-item:hover i{ color: #0f172a; }

.user-dropdown-divider{
    border: none;
    height: 1px;
    background: #e5e7eb;
    margin: 8px 6px;
}

.user-dropdown-item.text-danger{
    color: #dc2626 !important;
}
.user-dropdown-item.text-danger i{
    color: #dc2626 !important;
}
.user-dropdown-item.text-danger:hover{
    background: rgba(220,38,38,.12);
    color: #dc2626 !important;
}

/* =========================
   SMALL FIXES
========================= */
a{ text-decoration: none; }
</style>

<div class="main-header">
    <div class="header-top d-flex align-items-center justify-content-between">

        <!-- LEFT -->
        <div class="d-flex align-items-center gap-3">
            <!-- Logo -->
            <a href="${pageContext.request.contextPath}/Home" class="me-2">
                <img src="${pageContext.request.contextPath}/Logo/logo2.png"
                     class="header-logo"
                     alt="logo">
            </a>

            <!-- Categories -->
            <div class="dropdown">
                <button class="category-btn"
                        type="button"
                        id="dropdownMenuButton"
                        data-bs-toggle="dropdown"
                        aria-expanded="false">
                    <i class="bi bi-list"></i> Categories
                </button>

                <ul class="dropdown-menu cat-menu" aria-labelledby="dropdownMenuButton">
                    <% if (categoryList != null) {
                        for (Category cate : categoryList) {
                            if (cate.getIsActive()) { %>
                                <li>
                                    <a class="dropdown-item"
                                       href="${pageContext.request.contextPath}/FilterProduct?categoryId=<%= cate.getCategoryId()%>">
                                        <img src="<%= cate.getImgUrlLogo()%>" alt="cate">
                                        <p><%= cate.getCategoryName()%></p>
                                    </a>
                                </li>
                    <%      }
                        }
                    } %>
                </ul>
            </div>
        </div>

        <!-- CENTER SEARCH -->
        <div class="search-wrapper mx-3 position-relative flex-grow-1">
            <form action="SearchProduct" method="get" class="search-bar position-relative">
                <input type="text"
                       name="keyword"
                       class="form-control"
                       placeholder="Search Products">
                <button type="submit"
                        class="search-btn position-absolute top-50 end-0 translate-middle-y me-2">
                    <i class="bi bi-search"></i>
                </button>
            </form>
        </div>

        <!-- RIGHT -->
        <div class="header-right d-flex align-items-center gap-2">
            <% if (user == null) { %>
                <a href="${pageContext.request.contextPath}/Login"
                   class="btn btn-outline-dark"
                   title="Tài khoản">
                    <i class="bi bi-person"></i>
                </a>
            <% } else { %>
                <div class="user-dropdown">
                    <button type="button" class="btn btn-outline-dark" title="Tài khoản">
                        <i class="bi bi-person"></i>
                    </button>

                    <ul class="user-dropdown-menu">
                        <li>
                            <a class="user-dropdown-item" href="${pageContext.request.contextPath}/ViewProfile">
                                <i class="bi bi-person-circle"></i>
                                <span>Profile</span>
                            </a>
                        </li>

                        <li>
                            <a class="user-dropdown-item" href="${pageContext.request.contextPath}/ViewOrderOfCustomer">
                                <i class="bi bi-box-seam"></i>
                                <span>Order</span>
                            </a>
                        </li>

                        <li><hr class="user-dropdown-divider"></li>

                        <li>
                            <a class="user-dropdown-item text-danger" href="${pageContext.request.contextPath}/Logout">
                                <i class="bi bi-box-arrow-right"></i>
                                <span>Logout</span>
                            </a>
                        </li>
                    </ul>
                </div>
            <% } %>

            <a href="${pageContext.request.contextPath}/CartList?accountId=<%= user != null ? user.getAccountID() : 0%>"
               class="btn btn-outline-dark"
               title="Giỏ hàng">
                <i class="bi bi-cart3"></i>
            </a>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

<script>
document.addEventListener("DOMContentLoaded", function() {
    const userDropdown = document.querySelector(".user-dropdown");
    if (!userDropdown) return;

    const btn = userDropdown.querySelector(".btn");
    const menu = userDropdown.querySelector(".user-dropdown-menu");

    function openMenu(){
        menu.style.display = "block";
        setTimeout(() => {
            menu.style.opacity = "1";
            menu.style.transform = "translateY(0)";
        }, 10);
    }

    function closeMenu(){
        menu.style.opacity = "0";
        menu.style.transform = "translateY(-10px)";
        setTimeout(() => {
            menu.style.display = "none";
        }, 180);
    }

    btn.addEventListener("click", function(e) {
        e.preventDefault();
        e.stopPropagation();
        const isOpen = menu.style.display === "block";
        if (isOpen) closeMenu(); else openMenu();
    });

    document.addEventListener("click", function(e) {
        if (!userDropdown.contains(e.target)) closeMenu();
    });

    window.addEventListener("scroll", closeMenu);
});
</script>
