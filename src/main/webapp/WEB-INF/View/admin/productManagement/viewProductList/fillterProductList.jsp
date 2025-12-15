<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    String selectedFilter = (String) request.getAttribute("selectedFilter");
    if (selectedFilter == null) {
        selectedFilter = "All";
    }
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Product Management</title>

        <link rel="stylesheet" href="${pageContext.request.contextPath}/Css/supplierList5.css">

        <style>
            :root{
                --bg: #f4f6fb;
                --card: #ffffff;
                --text: #0f172a;
                --muted: #64748b;
                --border: rgba(15, 23, 42, .10);
                --shadow: 0 12px 28px rgba(0,0,0,.08);

                --blue: #0d6efd;
                --blueHover:#0b5ed7;

                --green: #22c55e;
                --greenHover:#16a34a;
            }

            body{
                background: var(--bg);
                font-family: "Segoe UI", system-ui, -apple-system, Arial, sans-serif;
                color: var(--text);
            }

            /* ===== TITLE ===== */
            .wrapper{
                max-width: 980px;
                margin: 0 auto;
                padding: 18px 0 6px;
            }
            .wrapper h1{
                margin: 0;
                font-weight: 1000;
                font-size: 40px;
                line-height: 1.05;
            }

            /* ===== SEARCH ===== */
            .search-form{
                max-width: 980px;
                margin: 12px auto;
                background: var(--card);
                border: 1px solid var(--border);
                border-radius: 16px;
                box-shadow: var(--shadow);
                padding: 12px;
                display:flex;
                align-items:center;
                gap: 12px;
                flex-wrap: wrap;
            }

            .search-form input[type="text"]{
                flex: 1;
                min-width: 260px;
                border: 1px solid rgba(15,23,42,.10);
                border-radius: 12px;
                padding: 12px 14px;
                font-size: 14px;
                outline: none;
            }

            .search-btn{
                border: none;
                padding: 10px 14px;
                border-radius: 12px;
                font-weight: 900;
                color:#fff;
                background: var(--blue);
                cursor:pointer;
                box-shadow: 0 12px 22px rgba(13,110,253,.18);
            }
            .search-btn:hover{
                background: var(--blueHover);
            }

            /* ===== FILTER + CREATE (CÙNG HÀNG) ===== */
            .filter-bar{
                max-width: 980px;
                margin: 12px auto;
                background: var(--card);
                border: 1px solid var(--border);
                border-radius: 16px;
                box-shadow: var(--shadow);
                padding: 12px 14px;
                display:flex;
                align-items:center;
                gap: 14px;
            }

            .filter-left{
                display:flex;
                align-items:center;
                gap: 14px;
                flex-wrap: wrap;
            }

            .filter-left label{
                font-weight: 900;
                font-size: 14px;
            }

            .filter-left select{
                border-radius: 12px;
                padding: 10px 14px;
                font-size: 14px;
                border: 1px solid rgba(15,23,42,.10);
                background: #fff;
                min-width: 220px;
            }

            /* đẩy Create sang phải */
            .filter-right{
                margin-left: auto;
            }

            .create-btn{
                border: none;
                padding: 10px 18px;
                border-radius: 14px;
                font-weight: 900;
                font-size: 14px;
                color: #fff;
                text-decoration: none;

                display: inline-flex;
                align-items: center;
                gap: 8px;

                background: linear-gradient(135deg, #22c55e, #16a34a);
                box-shadow: 0 12px 22px rgba(34,197,94,.18);

                min-width: 130px;
                justify-content: center;

                transition: transform .15s ease, box-shadow .15s ease, background .15s ease;
            }

            .create-btn i{
                font-size: 16px;
            }

            .create-btn:hover{
                background:#16a34a;
                transform: translateY(-1px);
                box-shadow: 0 14px 26px rgba(34,197,94,.22);
            }

            /* responsive */
            @media (max-width: 992px){
                .wrapper, .search-form, .filter-bar{
                    max-width: 100%;
                    padding-left: 14px;
                    padding-right: 14px;
                }
                .filter-bar{
                    flex-direction: column;
                    align-items: stretch;
                }
                .filter-right{
                    margin-left: 0;
                }
                .create-btn, .search-btn{
                    width: 100%;
                }
            }
        </style>
    </head>

    <body>

        <!-- TITLE -->
        <div class="wrapper">
            <h1>Product Management</h1>
        </div>

        <!-- SEARCH -->
        <form class="search-form" method="get" action="AdminProduct">
            <input
                type="text"
                name="keyword"
                placeholder="Find by name ..."
                value="<%= request.getParameter("keyword") != null ? request.getParameter("keyword") : "" %>"
                />
            <button type="submit" class="search-btn">Search</button>
        </form>


        <form class="filter-bar" action="AdminProduct" method="get">
            <div class="filter-left">
                <label for="filter">Filter product:</label>
                <select name="filter" id="filter" onchange="this.form.submit()">
                    <option value="All" <%= "All".equals(selectedFilter) ? "selected" : "" %>>All products</option>
                    <option value="Active" <%= "Active".equals(selectedFilter) ? "selected" : "" %>>Active</option>
                    <option value="Hidden" <%= "Hidden".equals(selectedFilter) ? "selected" : "" %>>Hidden</option>
                    <option value="Featured" <%= "Featured".equals(selectedFilter) ? "selected" : "" %>>Featured</option>
                    <option value="Bestseller" <%= "Bestseller".equals(selectedFilter) ? "selected" : "" %>>Bestseller</option>
                    <option value="New" <%= "New".equals(selectedFilter) ? "selected" : "" %>>New</option>
                    <option value="Discount" <%= "Discount".equals(selectedFilter) ? "selected" : "" %>>Discounted</option>
                </select>
            </div>

            <div class="filter-right">
                <a href="AdminCreateProduct" class="create-btn">
                    <i class="bi bi-plus-circle"></i>
                    Create
                </a>
            </div>
        </form>

    </body>
</html>
