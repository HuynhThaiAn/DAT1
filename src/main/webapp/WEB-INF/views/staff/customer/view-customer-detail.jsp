<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.Staff"%>
<%@page import="model.Customer"%>
<%@page import="java.time.format.DateTimeFormatter"%>

<%
    // ===== Staff/Admin login check (MUST be before any HTML output) =====
    Staff staff = (Staff) session.getAttribute("staff");
    if (staff == null || staff.getRole() == null || (staff.getRole() != 1 && staff.getRole() != 2)) {
        response.sendRedirect(request.getContextPath() + "/LoginStaff");
        return;
    }

    String ctx = request.getContextPath();

    Customer custo = (Customer) request.getAttribute("customer");

    DateTimeFormatter df = DateTimeFormatter.ofPattern("dd-MM-yyyy");

    boolean blocked = false;
    String statusKey = "active";
    String statusText = "Active";
    String dobText = "N/A";
    String genderText = "N/A";

    if (custo != null) {
        blocked = Boolean.TRUE.equals(custo.getIsBlocked());
        statusKey = blocked ? "blocked" : "active";
        statusText = blocked ? "Blocked" : "Active";

        if (custo.getDateOfBirth() != null) {
            dobText = df.format(custo.getDateOfBirth());
        }

        Integer g = custo.getGender();
        if (g == null) genderText = "N/A";
        else if (g == 1) genderText = "Male";
        else if (g == 2) genderText = "Female";
        else if (g == 3) genderText = "Other";
        else genderText = "Unknown";
    }
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
            --bg:#f4f6fb;
            --card:#fff;
            --text:#111827;
            --muted:#6b7280;
            --border:rgba(15, 23, 42, 0.10);
            --shadow:0 12px 28px rgba(0,0,0,.08);
        }

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

        @media (max-width: 768px){
            .info-grid{ grid-template-columns: 1fr; }
        }
    </style>
</head>

<body class="bg-light">
<div class="d-flex">
    <jsp:include page="/WEB-INF/views/staff/common/sideBar.jsp" />

    <div class="flex-grow-1">
        <jsp:include page="/WEB-INF/views/admin/common/header.jsp" />

        <main class="p-4">
            <div class="d-flex justify-content-between align-items-end mb-3">
                <div>
                    <h3 class="mb-1">Customer Detail</h3>
                    <div class="text-muted" style="font-size:13px;">View customer profile information</div>
                </div>

                <a href="<%=ctx%>/staffcustomermanagement?action=list" class="btn-ghost">
                    <i class="fa-solid fa-arrow-left"></i> Back to list
                </a>
            </div>

            <% if (custo == null) { %>
                <div class="alert alert-warning">There is no customer with that id</div>
            <% } else { %>

            <div class="card-detail">
                <div class="card-top">
                    <h4 class="m-0 fw-bold">
                        <i class="fa-solid fa-user me-2"></i> Customer Detail
                    </h4>

                    <div class="pill" data-status="<%=statusKey%>"><%=statusText%></div>
                </div>

                <div class="info-grid">
                    <div class="info-row"><span>Customer ID</span><b><%= custo.getCustomerID() %></b></div>
                    <div class="info-row"><span>Full Name</span><b><%= custo.getFullName() %></b></div>

                    <div class="info-row"><span>Phone</span><b><%= custo.getPhone() == null ? "" : custo.getPhone() %></b></div>
                    <div class="info-row"><span>Email</span><b><%= custo.getEmail() %></b></div>

                    <div class="info-row"><span>Date of Birth</span><b><%= dobText %></b></div>
                    <div class="info-row"><span>Gender</span><b><%= genderText %></b></div>

                    <div class="info-row info-row-full">
                        <span>Status</span>
                        <b><%= statusText %></b>
                    </div>
                </div>
            </div>

            <% } %>
        </main>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
