<%@page import="model.Staff"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>Staff Management</title>

        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet"/>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/Css/sidebar-admin.css">
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

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
                margin-left: 220px; /* match sidebar */
                min-height: 100vh;
                box-sizing: border-box;
                padding: 24px;
            }

            /* giống Product: container page */
            .page{
                max-width: 1400px;
                margin: 0 auto;
                padding: 20px 0;
            }

            /* heading đơn giản */
            .page-head{
                display:flex;
                align-items:flex-end;
                justify-content: space-between;
                gap: 12px;
                flex-wrap: wrap;
                margin-bottom: 12px;
            }

            .page-title{
                margin: 0;
                font-weight: 1000;
                letter-spacing: .2px;
            }

            /* top actions: search + create */
            .top-bar{
                display:flex;
                align-items:center;
                justify-content: space-between;
                gap: 12px;
                flex-wrap: wrap;
                margin: 12px 0 14px;
            }

            .search-form{
                display:flex;
                gap: 10px;
                flex: 1;
                min-width: 320px;
            }

            .search-form input{
                flex: 1;
                padding: 10px 14px;
                border-radius: 12px;
                border: 1px solid var(--border);
                font-size: 14px;
                outline: none;
                background: #fff;
            }
            .search-form input:focus{
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

            /* create giống button style solid */
            .create-btn{
                border: none;
                padding: 10px 16px;
                border-radius: 12px;
                font-weight: 900;
                color:#fff;
                background: #22c55e;
                cursor:pointer;
                box-shadow: 0 10px 20px rgba(34,197,94,.18);
                transition: transform .15s ease, box-shadow .15s ease, background .15s ease;
                white-space: nowrap;
                display:inline-flex;
                align-items:center;
                gap: 8px;
            }
            .create-btn:hover{
                background:#16a34a;
                transform: translateY(-1px);
                box-shadow: 0 14px 26px rgba(34,197,94,.22);
            }

            /* table card giống Product */
            .table-wrapper{
                width: 100%;
                margin-top: 8px;
                overflow-x: auto;
            }

            table.staff-table{
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

            table.staff-table thead th{
                background: #f8fafc;
                color: #334155;
                font-weight: 900;
                font-size: 13px;
                padding: 12px;
                border-bottom: 1px solid var(--border);
                text-align: left;
                white-space: nowrap;
            }

            table.staff-table tbody td{
                padding: 14px 12px;
                border-bottom: 1px solid rgba(15, 23, 42, .08);
                vertical-align: middle;
                text-align: left;
            }

            table.staff-table tbody tr:hover{
                background: #f6f9ff;
            }

            table.staff-table thead th:last-child,
            table.staff-table tbody td:last-child{
                text-align: right;
            }

            /* action buttons y chang product */
            .action-buttons{
                display:flex;
                justify-content:flex-end;
                gap: 8px;
                flex-wrap: wrap;
            }

            .btn-action{
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
                transition: transform .15s ease, box-shadow .15s ease;
                white-space: nowrap;
            }
            .btn-action:hover{
                transform: translateY(-1px);
                box-shadow: 0 12px 22px rgba(0,0,0,.12);
            }

            .btn-blue{
                background: var(--blue);
                color:#fff;
            }
            .btn-blue:hover{
                background: var(--blueHover);
            }

            .btn-yellow{
                background: var(--yellow);
                color:#111827;
            }
            .btn-yellow:hover{
                background: var(--yellowHover);
            }

            .btn-red{
                background:#ef4444;
                color:#fff;
            }
            .btn-red:hover{
                background:#dc2626;
            }

            @media (max-width: 992px){
                main.main-content{
                    margin-left: 0;
                }
                .top-bar{
                    flex-direction: column;
                    align-items: stretch;
                }
                .search-form{
                    min-width: 100%;
                }
                .search-btn, .create-btn{
                    width: 100%;
                    justify-content: center;
                }
            }
        </style>
    </head>

    <body>
        <div class="container-fluid">
            <jsp:include page="../sideBar.jsp"/>
            <main class="main-content">
                <div class="page">

                    <div class="page-head">
                        <h1 class="page-title">Staff List</h1>
                    </div>

                    <div class="top-bar">
                        <!-- Search -->
                        <form class="search-form" action="StaffList" method="get">
                            <input type="hidden" name="action" value="search">
                            <input type="text" name="keyword" placeholder="Search staff by name">
                            <button type="submit" class="search-btn">
                                <i class="fa-solid fa-magnifying-glass"></i> Search
                            </button>
                        </form>

                        <!-- Create -->
                        <button type="button" class="create-btn" onclick="location.href = 'CreateStaffServlet'">
                            <i class="fa-solid fa-user-plus"></i> Create
                        </button>
                    </div>

                    <!-- Table -->
                    <div class="table-wrapper">
                        <table class="staff-table" aria-label="Staff table">
                            <thead>
                                <tr>
                                    <th>Staff ID</th>
                                    <th>Email</th>
                                    <th>Full Name</th>
                                    <th>Hired Date</th>
                                    <th>Action</th>
                                </tr>
                            </thead>

                            <tbody>
                                <%
                                    List<Staff> staList = (List<Staff>) request.getAttribute("staff");
                                    if (staList != null && !staList.isEmpty()) {
                                        for (Staff sta : staList) {
                                %>
                                <tr>
                                    <td><%= sta.getStaffID()%></td>
                                    <td><%= sta.getEmail()%></td>
                                    <td><%= sta.getFullName()%></td>
                                    <td><%= sta.getHiredDate()%></td>

                                    <td>
                                        <div class="action-buttons">
                                            <a class="btn-action btn-blue"
                                               href="StaffList?action=detail&id=<%= sta.getStaffID()%>">
                                                <i class="fa-regular fa-eye"></i> Detail
                                            </a>

                                            <a class="btn-action btn-yellow"
                                               href="UpdateStaffServlet?action=update&id=<%= sta.getStaffID()%>">
                                                <i class="fa-regular fa-pen-to-square"></i> Edit
                                            </a>

                                            <button type="button" class="btn-action btn-red"
                                                    onclick="confirmDeleteStaff(<%= sta.getStaffID()%>)">
                                                <i class="fa-regular fa-trash-can"></i> Delete
                                            </button>
                                        </div>
                                    </td>
                                </tr>
                                <%
                                        }
                                    } else {
                                %>
                                <tr>
                                    <td colspan="5" class="text-center p-4 fw-bold text-muted">No staff found!</td>
                                </tr>
                                <%
                                    }
                                %>
                            </tbody>
                        </table>
                    </div>

                    <%
                        String mes = (String) request.getAttribute("message");
                        if (mes != null) {
                    %>
                    <div class="alert alert-info mt-3"><%= mes%></div>
                    <%
                        }
                    %>

                </div>
            </main>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

        <%
            String successdelete = request.getParameter("successdelete");
            String errordelete = request.getParameter("errordelete");
            String successedit = request.getParameter("successedit");
            String erroredit = request.getParameter("erroredit");
            String successcreate = request.getParameter("successcreate");
            String errorcreate = request.getParameter("errorcreate");
        %>

        <script>
                                                        function confirmDeleteStaff(staffID) {
                                                            Swal.fire({
                                                                title: 'Are you sure?',
                                                                text: "This staff will be deleted.",
                                                                icon: 'warning',
                                                                showCancelButton: true,
                                                                confirmButtonColor: '#d33',
                                                                cancelButtonColor: '#3085d6',
                                                                confirmButtonText: 'Delete',
                                                                cancelButtonText: 'Cancel'
                                                            }).then((result) => {
                                                                if (result.isConfirmed) {
                                                                    window.location.href = 'DeleteStaffServlet?action=delete&id=' + staffID;
                                                                }
                                                            });
                                                        }

                                                        window.onload = function () {
            <% if ("1".equals(successdelete)) { %>
                                                            Swal.fire({icon: 'success', title: 'Deleted!', text: 'The staff has been deleted.', timer: 2000});
            <% } else if ("1".equals(errordelete)) { %>
                                                            Swal.fire({icon: 'error', title: 'Failed!', text: 'Could not delete the staff.', timer: 2000});
            <% } %>

            <% if ("1".equals(successedit)) { %>
                                                            Swal.fire({icon: 'success', title: 'Edited!', text: 'The staff has been updated.', timer: 2000});
            <% } else if ("1".equals(erroredit)) { %>
                                                            Swal.fire({icon: 'error', title: 'Failed!', text: 'Could not update the staff.', timer: 2000});
            <% } %>

            <% if ("1".equals(successcreate)) { %>
                                                            Swal.fire({icon: 'success', title: 'Created!', text: 'The staff has been created.', timer: 2000});
            <% } else if ("1".equals(errorcreate)) { %>
                                                            Swal.fire({icon: 'error', title: 'Failed!', text: 'Could not create the staff.', timer: 2000});
            <% } %>
                                                        };
        </script>

    </body>
</html>
