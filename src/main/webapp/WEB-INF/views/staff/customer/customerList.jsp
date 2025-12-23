<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="java.time.format.DateTimeFormatter"%>
<%@page import="java.time.LocalDateTime"%>
<%@page import="model.Customer"%>
<%@page import="model.Staff"%>

<%
    // ===== Staff/Admin login check (MUST be before any HTML output) =====
    Staff staff = (Staff) session.getAttribute("staff");
    if (staff == null || staff.getRole() == null || (staff.getRole() != 1 && staff.getRole() != 2)) {
        response.sendRedirect(request.getContextPath() + "/LoginStaff");
        return;
    }

    String ctx = request.getContextPath();

    // Servlet should set: request.setAttribute("customers", List<Customer>)
    List<Customer> cusList = (List<Customer>) request.getAttribute("customers");

    // Keep old error attribute if your servlet sets it
    String error = (String) request.getAttribute("error");

    String keyword = request.getParameter("keyword");
    if (keyword == null) keyword = "";

    DateTimeFormatter df = DateTimeFormatter.ofPattern("dd-MM-yyyy");
%>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>Customer List</title>
        <meta name="viewport" content="width=device-width, initial-scale=1">

        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

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

            body{
                margin:0;
                background:var(--bg);
                font-family:"Segoe UI",system-ui,-apple-system,Arial,sans-serif;
            }
            .app{
                min-height:100vh;
            }

            main.main-content{
                margin-left: var(--sidebar-w);
                width: calc(100% - var(--sidebar-w));
                padding: 24px;
                padding-top: calc(var(--header-h) + 18px);
            }
            .page{
                max-width: 1200px;
                margin: 0 auto;
            }

            .page-head{
                display:flex;
                justify-content: space-between;
                align-items:flex-end;
                gap: 14px;
                margin-bottom: 14px;
            }
            .page-title{
                margin:0;
                font-weight: 900;
                color:var(--text);
            }
            .page-sub{
                color:var(--muted);
                font-size: 13px;
                margin-top: 4px;
            }
            .page-actions{
                display:flex;
                gap: 10px;
                align-items:center;
                flex-wrap: wrap;
            }

            .btn-ghost{
                text-decoration:none;
                border: 1px solid var(--border);
                background:#fff;
                color:#0f172a;
                border-radius: 14px;
                padding: 10px 14px;
                font-weight: 900;
                box-shadow: 0 10px 20px rgba(0,0,0,.06);
                display:inline-flex;
                align-items:center;
                gap: 8px;
            }

            .card-box, .card-table{
                background: var(--card);
                border: 1px solid var(--border);
                border-radius: 18px;
                box-shadow: var(--shadow);
                overflow:hidden;
            }
            .card-box{
                padding: 14px;
                margin-bottom: 14px;
            }

            .search-form{
                display:flex;
                gap: 10px;
                align-items:center;
                flex-wrap: wrap;
            }
            .search-form .form-control{
                border-radius: 14px;
                padding: 10px 12px;
                border: 1px solid var(--border);
                min-width: 260px;
                flex: 1;
            }
            .btn-search{
                border:none;
                border-radius: 14px;
                padding: 10px 14px;
                font-weight: 900;
                color:#fff;
                background: linear-gradient(135deg,#0d6efd,#2563eb);
                box-shadow: 0 12px 22px rgba(37,99,235,.16);
                display:inline-flex;
                align-items:center;
                gap: 8px;
            }

            .table thead th{
                background:#f8fafc;
                border-bottom: 1px solid var(--border);
                color:#475569;
                font-weight: 900;
                font-size: 13px;
                padding: 14px;
                white-space: nowrap;
            }
            .table tbody td{
                padding: 14px;
                color:#0f172a;
                font-size: 14px;
                vertical-align: middle;
            }

            .badge-status{
                padding: 6px 12px;
                border-radius: 999px;
                font-weight: 900;
                font-size: 12px;
                display:inline-flex;
                align-items:center;
                gap: 8px;
                border: 1px solid rgba(15,23,42,.08);
            }
            .badge-active{
                background:#ecfdf5;
                color:#065f46;
            }
            .badge-block{
                background:#fef2f2;
                color:#991b1b;
            }

            .action-wrap{
                display:flex;
                justify-content:flex-end;
                gap: 8px;
                flex-wrap: wrap;
            }
            .btn-mini{
                border-radius: 12px !important;
                font-weight: 900 !important;
                padding: 8px 10px !important;
            }

            @media (max-width: 992px){
                main.main-content{
                    margin-left:0;
                    width:100%;
                }
                .action-wrap{
                    justify-content:flex-start;
                }
            }
        </style>
    </head>

    <body>
        <div class="app">
            <div class="d-flex">
                <jsp:include page="/WEB-INF/views/staff/common/sideBar.jsp" />
                <div class="flex-grow-1">

                    <jsp:include page="/WEB-INF/views/staff/common/header.jsp" />

                    <main class="p-4">


                        <div class="page">
                            <div class="page-head">
                                <div>
                                    <h1 class="page-title">Customer List</h1>
                                    <div class="page-sub">Search customers, view detail, block/unblock</div>
                                </div>
                                <div class="page-actions">
                                    <a class="btn-ghost" href="<%=ctx%>/StaffCustomerManagement?action=list">
                                        <i class="fa-solid fa-rotate-right"></i> Reset
                                    </a>
                                </div>
                            </div>

                            <!-- Search -->
                            <div class="card-box">
                                <form class="search-form" action="<%=ctx%>/StaffCustomerManagement" method="get">
                                    <input type="hidden" name="action" value="list">
                                    <input type="text" name="keyword" value="<%=keyword%>" class="form-control" placeholder="Search customer by name or email">
                                    <button type="submit" class="btn-search">
                                        <i class="fa-solid fa-magnifying-glass"></i> Search
                                    </button>
                                </form>
                            </div>

                            <!-- Table -->
                            <div class="card-table">
                                <div class="table-responsive">
                                    <table class="table table-hover align-middle mb-0" aria-label="Customer table">
                                        <thead>
                                            <tr>
                                                <th style="width:80px;">ID</th>
                                                <th>Email</th>
                                                <th>Full Name</th>
                                                <th style="width:140px;">Phone</th>
                                                <th style="width:130px;">Created At</th>
                                                <th style="width:120px;">Status</th>
                                                <th class="text-end" style="width:320px;">Action</th>
                                            </tr>
                                        </thead>

                                        <tbody>
                                            <%
                                                if (cusList == null || cusList.isEmpty()) {
                                            %>
                                            <tr>
                                                <td colspan="7" class="text-center text-muted py-4">No customers found.</td>
                                            </tr>
                                            <%
                                                } else {
                                                    for (Customer cus : cusList) {
                                                        LocalDateTime createdAt = cus.getCreatedAt();
                                                        String formattedDate = (createdAt != null) ? createdAt.format(df) : "N/A";

                                                        boolean isBlocked = Boolean.TRUE.equals(cus.getIsBlocked());
                                                        boolean isActive = !isBlocked;

                                                        // Toggle target: if active -> block=1 ; if blocked -> block=0
                                                        int targetBlocked = isActive ? 1 : 0;
                                            %>
                                            <tr>
                                                <td class="fw-bold"><%= cus.getCustomerID() %></td>
                                                <td><%= cus.getEmail() %></td>
                                                <td class="fw-bold"><%= cus.getFullName() %></td>
                                                <td><%= (cus.getPhone() == null ? "" : cus.getPhone()) %></td>
                                                <td><%= formattedDate %></td>
                                                <td>
                                                    <% if (isActive) { %>
                                                    <span class="badge-status badge-active"><i class="fa-solid fa-circle-check"></i> Active</span>
                                                    <% } else { %>
                                                    <span class="badge-status badge-block"><i class="fa-solid fa-ban"></i> Block</span>
                                                    <% } %>
                                                </td>
                                                <td class="text-end">
                                                    <div class="action-wrap">
                                                        <a href="<%=ctx%>/StaffCustomerManagement?action=block&id=<%= cus.getCustomerID() %>&blocked=<%= targetBlocked %>"
                                                           class="btn btn-warning btn-mini">
                                                            <i class="fa-solid fa-shield-halved me-1"></i>
                                                            <%= isActive ? "Block" : "Unblock" %>
                                                        </a>

                                                        <a href="<%=ctx%>/StaffCustomerManagement?action=detail&id=<%= cus.getCustomerID() %>"
                                                           class="btn btn-primary btn-mini">
                                                            <i class="fa-regular fa-eye me-1"></i> Detail
                                                        </a>
                                                    </div>
                                                </td>
                                            </tr>
                                            <%
                                                    }
                                                }
                                            %>
                                        </tbody>
                                    </table>
                                </div>
                            </div>

                            <% if (error != null && !error.isEmpty()) { %>
                            <div class="alert alert-danger mt-3" role="alert"><%= error %></div>
                            <% } %>
                        </div>
                    </main>
                </div>
            </div>
        </div>

        <%
            String success = request.getParameter("success");
            if ("assigned".equals(success)) {
        %>
        <script>
            Swal.fire({
                icon: 'success',
                title: 'Assigned!',
                text: 'Voucher assigned successfully to customer.',
                confirmButtonText: 'OK'
            });
        </script>
        <%
            }
        %>

    </body>
</html>
