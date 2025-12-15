<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.*"%>
<%@page import="model.InventoryStatistic"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Manage Statistics</title>

    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet"/>

    <link rel="stylesheet" href="${pageContext.request.contextPath}/Css/sidebar-admin.css">

    <style>
        :root{
            --bg: #f4f6fb;
            --card: #ffffff;
            --text: #0f172a;
            --muted: #64748b;
            --border: rgba(15, 23, 42, .10);
            --shadow: 0 12px 28px rgba(0,0,0,.08);

            --blue: #0d6efd;
            --blueHover: #0b5ed7;
            --yellow: #ffc107;
            --yellowHover: #ffb300;
        }

        body{
            background: var(--bg);
            font-family: "Segoe UI", system-ui, -apple-system, Arial, sans-serif;
            color: var(--text);
        }

        main.main-content{
            flex: 1;
            margin-left: 220px;
            min-height: 100vh;
            box-sizing: border-box;
            padding: 24px;
        }

        .page{
            max-width: 1400px;
            margin: 0 auto;
            padding: 20px 0;
        }

        .page-head{
            display:flex;
            align-items:flex-end;
            justify-content: space-between;
            gap: 12px;
            flex-wrap: wrap;
            margin-bottom: 10px;
        }

        .page-title{
            margin: 0;
            font-weight: 1000;
            letter-spacing: .2px;
        }

       
        .switch-bar{
            display:flex;
            justify-content:flex-end;
            gap: 8px;
            flex-wrap: wrap;
            margin: 10px 0 12px;
        }

        .btn-switch{
            border: none;
            padding: 9px 12px;
            border-radius: 12px;
            font-weight: 900;
            font-size: 12.5px;
            display:inline-flex;
            align-items:center;
            gap: 6px;
            cursor:pointer;
            text-decoration:none !important;
            box-shadow: 0 8px 16px rgba(0,0,0,.08);
            transition: transform .15s ease, box-shadow .15s ease, background .15s ease;
            white-space: nowrap;
        }
        .btn-switch:hover{
            transform: translateY(-1px);
            box-shadow: 0 12px 22px rgba(0,0,0,.12);
        }

        .btn-blue{ background: var(--blue); color:#fff; }
        .btn-blue:hover{ background: var(--blueHover); }

        .btn-yellow{ background: var(--yellow); color:#111827; }
        .btn-yellow:hover{ background: var(--yellowHover); }

       
        .search-form{
            display:flex;
            gap: 10px;
            margin: 0 0 14px;
            flex-wrap: wrap;
        }

        .search-form input[type="text"]{
            flex: 1;
            min-width: 260px;
            padding: 10px 14px;
            border-radius: 12px;
            border: 1px solid var(--border);
            font-size: 14px;
            outline: none;
            background:#fff;
        }
        .search-form input[type="text"]:focus{
            border-color:#93c5fd;
            box-shadow: 0 0 0 3px rgba(59,130,246,.18);
        }

        .search-btn{
            border: none;
            padding: 10px 16px;
            border-radius: 12px;
            font-weight: 900;
            color:#fff;
            background: var(--blue);
            cursor:pointer;
            box-shadow: 0 10px 20px rgba(37,99,235,.18);
            transition: transform .15s ease, box-shadow .15s ease, background .15s ease;
            white-space: nowrap;
        }
        .search-btn:hover{
            background: var(--blueHover);
            transform: translateY(-1px);
            box-shadow: 0 14px 26px rgba(37,99,235,.22);
        }

       
        .table-wrapper{
            width: 100%;
            margin-top: 8px;
            overflow-x: auto;
        }

        table.stat-table{
            width: 100%;
            border-collapse: separate;
            border-spacing: 0;
            border-radius: 18px;
            overflow: hidden;
            background: var(--card);
            border: 1px solid var(--border);
            box-shadow: var(--shadow);
            font-size: 14px;
        }

        table.stat-table thead th{
            background: #f8fafc;
            color: #334155;
            font-weight: 900;
            font-size: 13px;
            padding: 12px;
            border-bottom: 1px solid var(--border);
            text-align: left;
            white-space: nowrap;
        }

        table.stat-table tbody td{
            padding: 14px 12px;
            border-bottom: 1px solid rgba(15, 23, 42, .08);
            vertical-align: middle;
            text-align: left;
        }

        table.stat-table tbody tr:hover{
            background: #f6f9ff;
        }

   
        th.product-id-col, td.product-id-col{
            width: 90px;
            text-align: left;
            white-space: nowrap;
        }
        th.status-col, td.status-col{
            width: 170px;
            text-align: right; 
            white-space: nowrap;
        }

        
        .status-tag{
            padding: 6px 12px;
            border-radius: 999px;
            font-size: 12.5px;
            font-weight: 900;
            display: inline-flex;
            align-items: center;
            gap: 8px;
            border: 1px solid rgba(15,23,42,.08);
        }
        .status-tag .dot{
            width: 8px;
            height: 8px;
            border-radius: 50%;
            background: currentColor;
        }

        .status-warning{
            background: #fff7ed;
            color: #c2410c;
        }
        .status-inactive{
            background: #fee2e2;
            color: #b91c1c;
        }
        .status-active{
            background: #e7f8ef;
            color: #067647;
        }

        @media (max-width: 992px){
            main.main-content{
                margin-left: 0;
            }
            .switch-bar{
                justify-content: stretch;
            }
            .btn-switch, .search-btn{
                width: 100%;
                justify-content: center;
            }
        }
    </style>
</head>

<body>
<div class="container">
    <jsp:include page="../sideBar.jsp" />
    <div class="wrapper">
        <main class="main-content">
            <div class="page">

                <div class="page-head">
                    <h1 class="page-title">Manage Statistics</h1>
                </div>

                <!-- INVENTORY / REVENUE -->
                <div class="switch-bar">
                    <a href="InventoryStatistic" class="btn-switch btn-blue">
                        <i class="fa-solid fa-boxes-stacked"></i> INVENTORY
                    </a>
                    <a href="RevenueStatistic" class="btn-switch btn-yellow">
                        <i class="fa-solid fa-chart-line"></i> REVENUE
                    </a>
                </div>

                <!-- SEARCH -->
                <form class="search-form" action="ManageStatistic" method="get" autocomplete="off">
                    <input type="text" name="keyword" placeholder="Search product..." />
                    <button type="submit" class="search-btn">
                        <i class="fa-solid fa-magnifying-glass"></i> Search
                    </button>
                </form>

                <%
                    String message = (String) request.getAttribute("message");
                    ArrayList<InventoryStatistic> stats = (ArrayList<InventoryStatistic>) request.getAttribute("inventoryStatistics");
                    if (message != null) {
                %>
                <div class="alert alert-danger text-center my-3"><%= message%></div>
                <% } %>

                <div class="table-wrapper">
                    <table class="stat-table" aria-label="Inventory statistics table">
                        <thead>
                            <tr>
                                <th class="product-id-col">Product ID</th>
                                <th>Product Name</th>
                                <th>Category</th>
                                <th>Quantity</th>
                                <th>Price</th>
                                <th class="status-col">Status</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%
                                if (stats != null && !stats.isEmpty()) {
                                    for (InventoryStatistic item : stats) {
                                        int qty = item.getStockQuantity();
                                        String statusClass = qty == 0 ? "status-inactive"
                                                : (qty <= 5 ? "status-warning" : "status-active");
                                        String statusText = qty == 0 ? "OUT OF STOCK"
                                                : (qty <= 5 ? "LOW STOCK" : "IN STOCK");
                            %>
                            <tr>
                                <td class="product-id-col"><%= item.getProductId()%></td>
                                <td><%= item.getFullName()%></td>
                                <td><%= item.getCategoryName()%></td>
                                <td><%= item.getStockQuantity()%></td>
                                <td>
                                    <%= item.getProductImportPrice() != null
                                            ? String.format("%,d", item.getProductImportPrice().intValue())
                                            : "-"%>
                                </td>
                                <td class="status-col">
                                    <span class="status-tag <%= statusClass%>">
                                        <span class="dot"></span>
                                        <%= statusText%>
                                    </span>
                                </td>
                            </tr>
                            <%
                                    }
                                } else {
                            %>
                            <tr>
                                <td colspan="6" class="text-center p-4 fw-bold text-muted">No data found.</td>
                            </tr>
                            <% }%>
                        </tbody>
                    </table>
                </div>

            </div>
        </main>
    </div>
</div>
</body>
</html>
