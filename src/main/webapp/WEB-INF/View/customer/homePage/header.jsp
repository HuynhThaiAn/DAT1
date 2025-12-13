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
<style>
    .user-dropdown {
        position: relative;
        display: inline-block;
    }

    .user-dropdown .btn {
        background: #f3f4f6;
        border-radius: 12px;
        height: 42px;
        padding: 0 16px;
        border: 1px solid #d1d5db;
        color: #374151;
        display: flex;
        align-items: center;
        gap: 8px;
        transition: 0.25s ease;
    }

    .user-dropdown .btn:hover {
        background: #e5e7eb;
        box-shadow: 0 2px 8px rgba(0,0,0,0.1);
    }

    /* DROPDOWN MENU */
    .user-dropdown-menu {
        position: absolute;
        right: 0;
        top: calc(100% + 3px);
        width: 240px;
        background: #ffffff;
        border: 1px solid #e5e7eb;
        border-radius: 14px;
        padding: 8px 0;
        box-shadow: 0 8px 28px rgba(0,0,0,0.18);
        display: none;
        opacity: 0;
        transform: translateY(-6px);
        transition: 0.18s ease;
        z-index: 9999;
    }

    /* MENU ITEMS */
    .user-dropdown-item {
        padding: 12px 18px;
        display: flex;
        align-items: center;
        gap: 12px;
        color: #374151;
        font-size: 14px;
        text-decoration: none;
        transition: all 0.2s ease;
    }

    .user-dropdown-item i {
        font-size: 18px;
        width: 24px;
        text-align: center;
        color: #6b7280;
    }

    .user-dropdown-item span {
        flex: 1;
    }

    /* HOVER EFFECT */
    .user-dropdown-item:hover {
        background: #f3f4f6;
        padding-left: 26px;
        color: #111827;
    }

    .user-dropdown-item:hover i {
        color: #111827;
    }

    /* DANGER OPTION */
    .user-dropdown-item.text-danger {
        color: #dc3545 !important;
    }

    .user-dropdown-item.text-danger i {
        color: #dc3545 !important;
    }

    .user-dropdown-item.text-danger:hover {
        background: #dc3545;
        color: #fff !important;
    }

    .user-dropdown-item.text-danger:hover i {
        color: #fff !important;
    }

    /* DIVIDER */
    .user-dropdown-divider {
        border-top: 1px solid #e5e7eb;
        margin: 6px 0;
    }

</style>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
<link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-icons/1.10.5/font/bootstrap-icons.min.css" rel="stylesheet">
<link rel="stylesheet" href="${pageContext.request.contextPath}/Css/header.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/Css/homepage.css">

<div class="main-header">
    <div class="header-top d-flex align-items-center justify-content-between">
        
        <div class="d-flex align-items-center gap-3">
            <!-- Logo -->
            <a href="${pageContext.request.contextPath}/Home" class="me-3">
                <img src="${pageContext.request.contextPath}/Logo/logo2.png" 

                     class="header-logo" 
                     style="height: 40px; object-fit: contain;" />
            </a>

           
            <div class="dropdown">
                <button class="category-btn"
                        type="button"
                        id="dropdownMenuButton"
                        data-bs-toggle="dropdown"
                        aria-expanded="false">
                    <i class="bi bi-list"></i> Categories
                </button>

                <ul class="dropdown-menu" aria-labelledby="dropdownMenuButton">

                    <% if (categoryList != null) {
                            for (Category cate : categoryList) {
                                if (cate.getIsActive()) {
                    %>
                    <li style="flex: 0 0 20%; text-align: center; list-style: none;">
                        <a class="dropdown-item" href="${pageContext.request.contextPath}/FilterProduct?categoryId=<%= cate.getCategoryId()%>">
                            <img src="<%= cate.getImgUrlLogo()%>" style="width: 50px; height: 50px; object-fit: contain;">
                            <p><%= cate.getCategoryName()%></p>
                        </a>
                    </li>
                    <% }
                            }
                        } %>
                </ul>
            </div>

        </div>

        
        <div class="search-wrapper mx-3 position-relative flex-grow-1">
            <form action="SearchProduct" method="get" class="search-bar position-relative">
                <input type="text"
                       name="keyword"
                       class="form-control"

                       style="padding-right: 40px;">
                <button type="submit"
                        class="search-btn btn btn-outline-secondary position-absolute top-50 end-0 translate-middle-y">
                    <i class="bi bi-search"></i>
                </button>
            </form>
        </div>

       
        <div class="header-right d-flex align-items-center gap-2">
            <% if (user == null) { %>
            <a style = "border-radius: 15px;" href="${pageContext.request.contextPath}/Login" class="btn btn-outline-dark me-2" title="Tài khoản">
                <i class="bi bi-person"></i>
            </a>
            <% } else {%>
           
            <div class="user-dropdown">
                <button type="button" style="border-radius: 15px;" class="btn btn-outline-dark me-2" title="Tài khoản">
                    <i class="bi bi-person"></i>
                </button>
                <ul class="user-dropdown-menu" aria-labelledby="userDropdown">
                    <li>
                        <a class="user-dropdown-item" href="${pageContext.request.contextPath}/ViewProfile">
                            <i class="bi bi-person-circle"></i>
                            <span>Profile</span>
                        </a>
                    </li>
                    <li>
                        <a class="user-dropdown-item" href="${pageContext.request.contextPath}/ViewOrderOfCustomer">
                            <i class="bi bi-cart"></i>
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
            <% }%>

            <a href="${pageContext.request.contextPath}/CartList?accountId=<%= user != null ? user.getAccountID() : 0%>" class="btn btn-outline-dark" title="Giỏ hàng">
                <i class="bi bi-cart"></i> 
            </a>
        </div>
    </div>
</div>


<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
document.addEventListener("DOMContentLoaded", function() {
    const userDropdown = document.querySelector(".user-dropdown");
    if (!userDropdown) return;

    const btn = userDropdown.querySelector(".btn");
    const menu = userDropdown.querySelector(".user-dropdown-menu");

    
    btn.addEventListener("click", function(e) {
        e.preventDefault();
        e.stopPropagation();
        
        const isOpen = menu.style.display === "block";
        
        if (isOpen) {
            
            menu.style.opacity = "0";
            menu.style.transform = "translateY(-6px)";
            setTimeout(() => {
                menu.style.display = "none";
            }, 180);
        } else {
            
            menu.style.display = "block";
            setTimeout(() => {
                menu.style.opacity = "1";
                menu.style.transform = "translateY(0)";
            }, 10);
        }
    });

    
    document.addEventListener("click", function(e) {
        if (!userDropdown.contains(e.target)) {
            menu.style.opacity = "0";
            menu.style.transform = "translateY(-6px)";
            setTimeout(() => {
                menu.style.display = "none";
            }, 180);
        }
    });
});
</script>