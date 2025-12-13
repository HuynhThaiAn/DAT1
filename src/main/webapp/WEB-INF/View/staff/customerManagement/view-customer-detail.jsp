<%@page import="model.Customer"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    Customer custo = (Customer) request.getAttribute("data");
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Customer Detail</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

    <style>
        :root{
            --sidebar-w: 260px;
            --header-h: 78px;

            --bg:#f4f6fb;
            --card:#fff;
            --text:#111827;
            --muted:#6b7280;
            --border:rgba(15, 23, 42, 0.10);
            --shadow:0 12px 28px rgba(0,0,0,.08);
        }

        body{ margin:0; background:var(--bg); font-family:"Segoe UI",system-ui,-apple-system,Arial,sans-serif; }
        .app{ min-height:100vh; }

        main.main-content{
            margin-left: var(--sidebar-w);
            width: calc(100% - var(--sidebar-w));
            padding: 24px;
            padding-top: calc(var(--header-h) + 18px);
        }

        .page{ max-width: 1100px; margin: 0 auto; }

        .page-head{
            display:flex;
            justify-content: space-between;
            align-items:flex-end;
            gap: 14px;
            margin-bottom: 14px;
        }
        .page-title{ margin:0; font-weight: 900; color:var(--text); }
        .page-sub{ color:var(--muted); font-size: 13px; margin-top: 4px; }

        .btn-ghost{
            text-decoration:none;
            display:inline-flex;
            align-items:center;
            gap: 8px;
            padding: 10px 14px;
            border-radius: 14px;
            font-weight: 900;
            color:#0f172a;
            background:#fff;
            border: 1px solid var(--border);
            box-shadow: 0 10px 20px rgba(0,0,0,.06);
        }
        .btn-ghost:hover{ transform: translateY(-1px); }

        .card-detail{
            background: var(--card);
            border: 1px solid var(--border);
            border-radius: 18px;
            box-shadow: var(--shadow);
            overflow:hidden;
        }

        .card-top{
            padding: 16px 18px;
            background: linear-gradient(135deg, #1d4ed8, #2563eb);
            color: #fff;
            display:flex;
            justify-content: space-between;
            align-items:center;
            gap: 12px;
        }

        .card-top-title{
            font-weight: 900;
            display:flex;
            align-items:center;
            gap: 10px;
            margin:0;
        }

        /* status pill */
        .pill{
            padding: 7px 12px;
            border-radius: 999px;
            font-weight: 900;
            font-size: 12px;
            color: #fff;
            white-space: nowrap;
            border: 1px solid rgba(255,255,255,0.25);
            background: rgba(255,255,255,0.18);
        }
        .pill[data-status="active"]{
            background: rgba(34,197,94,.22);
            border-color: rgba(34,197,94,.35);
        }
        .pill[data-status="blocked"]{
            background: rgba(239,68,68,.22);
            border-color: rgba(239,68,68,.35);
        }

        .info-grid{
            display:grid;
            grid-template-columns: repeat(2, minmax(0, 1fr));
            gap: 10px 18px;
            padding: 18px;
        }

        .info-row{
            display:flex;
            justify-content: space-between;
            gap: 14px;
            padding: 10px 12px;
            border: 1px solid rgba(15, 23, 42, 0.08);
            border-radius: 14px;
            background: #fbfdff;
        }

        .info-row span{ color: var(--muted); font-weight: 800; }
        .info-row b{ color: var(--text); font-weight: 900; text-align:right; }

        .info-row-full{ grid-column: 1 / -1; }

        @media (max-width: 992px){
            main.main-content{ margin-left:0; width:100%; }
        }
        @media (max-width: 768px){
            .info-grid{ grid-template-columns: 1fr; }
        }
    </style>
</head>

<body>
<div class="app">
    <jsp:include page="../sideBar.jsp" />

    <main class="main-content">
        <jsp:include page="../header.jsp" />

        <div class="page">
            <div class="page-head">
                <div>
                    <h1 class="page-title">Customer Detail</h1>
                    <div class="page-sub">View customer profile information</div>
                </div>

                <!-- CHỈ GIỮ 1 NÚT BACK Ở ĐÂY -->
                <a href="CustomerList" class="btn-ghost">
                    <i class="fa-solid fa-arrow-left"></i> Back to list
                </a>
            </div>

            <% if (custo == null) { %>
                <div class="alert alert-warning">
                    There is no customer with that id
                </div>
            <% } else { %>

            <div class="card-detail">
                <div class="card-top">
                    <h4 class="card-top-title">
                        <i class="fa-solid fa-user"></i> Customer Detail
                    </h4>

                    <div class="pill"
                         id="statusPill"
                         data-status="<%= custo.isActive() ? "active" : "blocked" %>">
                        <%= custo.isActive() ? "Active" : "Blocked" %>
                    </div>
                </div>

                <div class="info-grid">
                    <div class="info-row"><span>Customer ID</span><b><%= custo.getId() %></b></div>
                    <div class="info-row"><span>Full Name</span><b><%= custo.getFullName() %></b></div>

                    <div class="info-row"><span>Phone</span><b><%= custo.getPhone() %></b></div>
                    <div class="info-row"><span>Email</span><b><%= custo.getEmail() %></b></div>

                    <div class="info-row"><span>Date of Birth</span><b><%= custo.getBirthDay() %></b></div>
                    <div class="info-row"><span>Sex</span>
                        <b>
                            <%= "male".equalsIgnoreCase(custo.getGender()) ? "Male" :
                                ("female".equalsIgnoreCase(custo.getGender()) ? "Female" : "N/A") %>
                        </b>
                    </div>

                    <div class="info-row info-row-full">
                        <span>Status</span>
                        <b><%= custo.isActive() ? "Active" : "Blocked" %></b>
                    </div>
                </div>
            </div>

            <% } %>
        </div>
    </main>
</div>

<script>
    
    document.addEventListener("visibilitychange", function () {
        if (!document.hidden) location.reload();
    });
</script>

</body>
</html>
