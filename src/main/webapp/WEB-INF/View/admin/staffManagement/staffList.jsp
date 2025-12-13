<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="model.Staff"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>Staff List</title>
        <!-- Bootstrap CDN -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"
              integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
        <!-- Fontawesome CDN -->
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet"/>
        <!-- Sidebar CSS -->
        <link rel="stylesheet" href="${pageContext.request.contextPath}/Css/sidebar-admin.css">
        <!-- SweetAlert -->
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

        <style>
            
            body {
                background: #f4f6fb;
                font-family: system-ui, -apple-system, BlinkMacSystemFont, "Segoe UI", sans-serif;
                line-height: 1.5;
            }

            main.main-content {
                flex: 1;
                margin-left: 220px; 
                min-height: 100vh;
                box-sizing: border-box;
                padding: 24px 28px;
            }

            .wrapper {
                width: 100%;
                max-width: 100%;
                margin: 0 auto;
                background: transparent;
            }

           
            h1 {
                color: #111827;
                margin-top: 4px;
                margin-bottom: 4px;
                font-weight: 800;
                font-size: 1.9rem;
                letter-spacing: 0.04em;
            }

            .page-subtitle {
                color: #6b7280;
                font-size: 0.95rem;
                margin-bottom: 18px;
            }

            
            .top-bar {
                display: flex;
                justify-content: space-between;
                align-items: center;
                margin-bottom: 14px;
                gap: 12px;
                flex-wrap: wrap;
            }

            
            button.create-btn {
                background: linear-gradient(135deg, #22c55e, #16a34a);
                color: #fff;
                padding: 9px 18px;
                font-weight: 700;
                font-size: 14px;
                border-radius: 999px;
                border: 1.5px solid #16a34a;
                cursor: pointer;
                min-width: 130px;
                transition: all 0.18s ease;
                box-shadow: 0 4px 10px rgba(34, 197, 94, 0.3);
            }

            button.create-btn:hover {
                background: linear-gradient(135deg, #16a34a, #15803d);
                transform: translateY(-1px);
                box-shadow: 0 6px 14px rgba(34, 197, 94, 0.35);
            }

            
            form.search-form {
                display: flex;
                gap: 10px;
                margin-bottom: 0;
                flex: 1;
            }

            .search-form input[type="text"] {
                flex: 1;
                padding: 9px 13px;
                font-size: 14px;
                border-radius: 999px;
                border: 1.5px solid #d1d5db;
                background: #fff;
                transition: border-color 0.2s, box-shadow 0.2s, background-color 0.2s;
            }

            .search-form input[type="text"]::placeholder {
                color: #9ca3af;
                font-size: 13px;
            }

            .search-form input[type="text"]:focus {
                border-color: #2563eb;
                outline: none;
                background-color: #f9fafb;
                box-shadow: 0 0 0 3px rgba(37, 99, 235, 0.18);
            }

            .action-btn,
            .search-btn,
            .create-btn {
                font-weight: 700;
                border-radius: 8px;
                cursor: pointer;
            }

            button.search-btn {
                padding: 8px 16px;
                font-size: 13px;
                border: none;
                background: #2563eb;
                color: #fff;
                min-width: 90px;
                text-transform: uppercase;
                letter-spacing: 0.05em;
                transition: background 0.18s, transform 0.1s, box-shadow 0.18s;
                box-shadow: 0 3px 8px rgba(37, 99, 235, 0.35);
            }

            button.search-btn:hover {
                background: #1d4ed8;
                transform: translateY(-1px);
                box-shadow: 0 5px 12px rgba(37, 99, 235, 0.4);
            }

           
            .table-wrapper {
                margin-top: 8px;
            }

            table {
                width: 100%;
                border-collapse: separate;
                border-spacing: 0;
                font-size: 14px;
                background: #fff;
                border-radius: 16px;
                box-shadow: 0 6px 20px rgba(15, 23, 42, 0.08);
                overflow: hidden;
            }

            th {
                padding: 11px 13px;
                background: linear-gradient(90deg, #1d4ed8, #2563eb);
                color: #e5e7eb;
                font-weight: 700;
                font-size: 12px;
                text-transform: uppercase;
                letter-spacing: 0.08em;
                border-bottom: 1px solid #1d4ed8;
                white-space: nowrap;
            }

            th:first-child {
                border-top-left-radius: 16px;
            }

            th:last-child {
                border-top-right-radius: 16px;
                min-width: 260px;
                text-align: center;
            }

            td {
                padding: 9px 13px;
                border-bottom: 1px solid #e5e7eb;
                text-align: left;
                word-wrap: break-word;
                vertical-align: middle;
                color: #111827;
            }

            tbody tr:nth-child(even) {
                background: #f9fafb;
            }

            tbody tr:last-child td {
                border-bottom: none;
            }

            tbody tr {
                transition: background-color 0.18s ease, transform 0.08s ease, box-shadow 0.18s ease;
            }

            tbody tr:hover {
                background: #eff6ff;
                transform: translateY(-1px);
                box-shadow: 0 4px 10px rgba(148, 163, 184, 0.35);
            }

        
            td.action-col {
                display: flex;
                gap: 8px;
                align-items: center;
                justify-content: center;
                padding: 8px 10px;
                min-width: 260px;
                white-space: nowrap;
            }

            td.action-col form {
                margin: 0;
            }

            
            .btn-detail,
            .btn-edit,
            .btn-delete {
                min-width: 86px;
                text-align: center;
                border: none;
                padding: 7px 14px;
                border-radius: 999px;
                font-weight: 700;
                cursor: pointer;
                display: inline-block;
                text-decoration: none !important;
                font-size: 12px;
                transition: all 0.18s ease;
                box-sizing: border-box;
                text-transform: uppercase;
                letter-spacing: 0.06em;
            }

            .btn-detail {
                background: #e0f2fe;
                color: #0369a1;
            }

            .btn-detail:hover {
                background: #bae6fd;
                box-shadow: 0 3px 8px rgba(59, 130, 246, 0.35);
            }

            .btn-edit {
                background: #fff7ed;
                color: #c2410c;
            }

            .btn-edit:hover {
                background: #ffedd5;
                box-shadow: 0 3px 8px rgba(249, 115, 22, 0.35);
            }

            .btn-delete {
                background: #fee2e2;
                color: #b91c1c;
            }

            .btn-delete:hover {
                background: #fecaca;
                box-shadow: 0 3px 8px rgba(248, 113, 113, 0.35);
            }

            .text-center {
                text-align: center;
            }

            @media (max-width: 992px) {
                main.main-content {
                    margin-left: 0;
                    padding: 16px;
                }

                .top-bar {
                    flex-direction: column-reverse;
                    align-items: stretch;
                }

                button.create-btn {
                    align-self: stretch;
                    width: 100%;
                }

                td.action-col {
                    flex-wrap: wrap;
                }
            }
        </style>
    </head>
    <body>
        <div class="container-fluid">
            <jsp:include page="../sideBar.jsp"/>
            <div class="wrapper">
                <main class="main-content">
                    <h1>Staff List</h1>
                    <!-- <p class="page-subtitle">Manage staff accounts in the system</p> -->

                    <div class="top-bar">
                        <!-- Search Form -->
                        <form class="search-form" action="StaffList" method="get">
                            <input type="hidden" name="action" value="search">
                            <input type="text" name="keyword" placeholder="Search staff by name">
                            <button type="submit" class="search-btn">Search</button>
                        </form>

                        <!-- Create button -->
                        <button type="button" class="create-btn" onclick="location.href = 'CreateStaffServlet'">
                            <i class="fa-solid fa-user-plus me-1"></i>Create
                        </button>
                    </div>

                    <!-- Staff Table -->
                    <div class="table-wrapper">
                        <table aria-label="Staff table">
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
                                    <td class="action-col">
                                        <a href="StaffList?action=detail&id=<%= sta.getStaffID()%>" class="btn-detail">
                                            Detail
                                        </a>
                                        <a href="UpdateStaffServlet?action=update&id=<%= sta.getStaffID()%>" class="btn-edit">
                                            Edit
                                        </a>
                                        <button type="button" class="btn-delete"
                                                onclick="confirmDeleteStaff(<%= sta.getStaffID()%>)">
                                            Delete
                                        </button>
                                    </td>
                                </tr>
                                <%
                                    }
                                } else {
                                %>
                                <tr>
                                    <td colspan="5" class="text-center">No staff found!</td>
                                </tr>
                                <%
                                    }
                                %>
                            </tbody>
                        </table>
                    </div>

                    <!-- Optional message -->
                    <%
                        String mes = (String) request.getAttribute("message");
                        if (mes != null) {
                    %>
                    <div class="alert alert-info mt-3"><%= mes%></div>
                    <%
                        }
                    %>
                </main>
            </div>
        </div>

        <!-- Bootstrap JS -->
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
                                                        Swal.fire({
                                                            icon: 'success',
                                                            title: 'Deleted!',
                                                            text: 'The staff has been deleted.',
                                                            timer: 2000
                                                        });
            <% } else if ("1".equals(errordelete)) { %>
                                                        Swal.fire({
                                                            icon: 'error',
                                                            title: 'Failed!',
                                                            text: 'Could not delete the staff.',
                                                            timer: 2000
                                                        });
            <% } %>

            <% if ("1".equals(successedit)) { %>
                                                        Swal.fire({
                                                            icon: 'success',
                                                            title: 'Edited!',
                                                            text: 'The staff has been edited.',
                                                            timer: 2000
                                                        });
            <% } else if ("1".equals(erroredit)) { %>
                                                        Swal.fire({
                                                            icon: 'error',
                                                            title: 'Failed!',
                                                            text: 'Could not edit the staff.',
                                                            timer: 2000
                                                        });
            <% } %>

            <% if ("1".equals(successcreate)) { %>
                                                        Swal.fire({
                                                            icon: 'success',
                                                            title: 'Created!',
                                                            text: 'The staff has been created.',
                                                            timer: 2000
                                                        });
            <% } else if ("1".equals(errorcreate)) { %>
                                                        Swal.fire({
                                                            icon: 'error',
                                                            title: 'Failed!',
                                                            text: 'Could not create the staff.',
                                                            timer: 2000
                                                        });
            <% }%>
                                                    };
        </script>
    </body>
</html>
