<%@page import="java.util.List"%>
<%@page import="model.Category"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    List<Category> categoryList = (List<Category>) request.getAttribute("categoryList");
%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Category Management</title>

        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

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
                margin-left: 220px;
                min-height: 100vh;
                padding: 24px;
                box-sizing: border-box;
            }

            .page{
                max-width: 1400px;
                margin: 0 auto;
                padding: 20px 0;
            }

            /* ✅ Title chỉ đứng 1 mình */
            .page-head{
                margin-bottom: 10px;
            }

            .page-title{
                margin: 0;
                font-weight: 1000;
                letter-spacing: .2px;
            }

            /* ✅ Create nằm sát phải - phía trên bảng */
            .table-toolbar{
                width: 100%;
                display: flex;
                justify-content: flex-end;
                margin-bottom: 10px;
            }

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
                display:inline-flex;
                align-items:center;
                gap: 8px;
                white-space: nowrap;
            }
            .create-btn:hover{
                background:#16a34a;
                transform: translateY(-1px);
                box-shadow: 0 14px 26px rgba(34,197,94,.22);
            }

            /* ✅ table wrapper: nên để 100% cho chuẩn */
            .table-wrapper{
                width: 100%;
                margin-top: 0;
                overflow-x: auto;
            }

            table.category-table{
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

            table.category-table thead th{
                background: #f8fafc;
                color: #334155;
                font-weight: 900;
                font-size: 13px;
                padding: 12px;
                border-bottom: 1px solid var(--border);
                text-align: left;
                white-space: nowrap;
            }

            table.category-table tbody td{
                padding: 14px 12px;
                border-bottom: 1px solid rgba(15, 23, 42, .08);
                vertical-align: middle;
                text-align: left;
                color: var(--text);
            }

            table.category-table tbody tr:hover{
                background: #f6f9ff;
            }

            table.category-table thead th:last-child,
            table.category-table tbody td:last-child{
                text-align: right;
            }

            /* ✅ action nằm 1 hàng */
            .action-buttons{
                display:flex;
                justify-content:flex-end;
                gap: 8px;
                flex-wrap: nowrap; /* quan trọng */
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
                transition: transform .15s ease, box-shadow .15s ease, background .15s ease;
                white-space: nowrap;
            }

            .btn-action:hover{
                transform: translateY(-1px);
                box-shadow: 0 12px 22px rgba(0,0,0,.12);
            }

            .btn-blue{ background: var(--blue); color:#fff; }
            .btn-blue:hover{ background: var(--blueHover); }

            .btn-yellow{ background: var(--yellow); color:#111827; }
            .btn-yellow:hover{ background: var(--yellowHover); }

            .btn-red{ background:#ef4444; color:#fff; }
            .btn-red:hover{ background:#dc2626; }

            .empty{
                text-align:center;
                padding: 18px;
                font-weight: 800;
                color: #94a3b8;
                background: transparent;
            }

            @media (max-width: 992px){
                main.main-content{
                    margin-left: 0;
                }
                .create-btn{
                    width: 100%;
                    justify-content: center;
                }
                .table-toolbar{
                    justify-content: stretch;
                }
                .action-buttons{
                    justify-content:flex-start;
                    flex-wrap: wrap; /* mobile cho wrap lại để khỏi tràn */
                }
            }
        </style>
    </head>

    <body>

        <div class="wrapper">
            <jsp:include page="/WEB-INF/View/admin/categoryManagement/deleteCategory/deleteCategory.jsp" />

            <main class="main-content">
                <div class="page">

                    <!-- TITLE (không cùng hàng với Create) -->
                    <div class="page-head">
                        <h1 class="page-title">Category Management</h1>
                    </div>

                    <!-- CREATE sát phải, nằm trên bảng -->
                    <div class="table-toolbar">
                        <button class="create-btn" onclick="location.href='CreateCategory'">
                            <i class="bi bi-plus-circle"></i> Create
                        </button>
                    </div>

                    <div class="table-wrapper">
                        <% if (categoryList != null && !categoryList.isEmpty()) { %>
                        <table class="category-table" aria-label="Category table">
                            <thead>
                                <tr>
                                    <th>ID</th>
                                    <th>Category Name</th>
                                    <th>Description</th>
                                    <th>Created Date</th>
                                    <th>Action</th>
                                </tr>
                            </thead>

                            <tbody>
                                <%
                                    boolean hasRow = false;
                                    for (Category cate : categoryList) {
                                        if (cate != null && cate.getIsActive()) {
                                            hasRow = true;
                                %>
                                <tr>
                                    <td><%= cate.getCategoryId() %></td>
                                    <td><%= cate.getCategoryName() %></td>
                                    <td><%= cate.getDescriptionCategory() %></td>
                                    <td><%= cate.getCreatedAt() %></td>
                                    <td>
                                        <div class="action-buttons">
                                            <a class="btn-action btn-blue"
                                               href="CategoryDetail?categoryId=<%= cate.getCategoryId() %>">
                                                <i class="bi bi-eye"></i> Detail
                                            </a>

                                            <a class="btn-action btn-yellow"
                                               href="UpdateCategory?categoryId=<%= cate.getCategoryId() %>">
                                                <i class="bi bi-pencil-square"></i> Edit
                                            </a>

                                            <button type="button" class="btn-action btn-red"
                                                    onclick="confirmDelete(<%= cate.getCategoryId() %>)">
                                                <i class="bi bi-trash"></i> Delete
                                            </button>
                                        </div>
                                    </td>
                                </tr>
                                <%
                                        }
                                    }
                                    if (!hasRow) {
                                %>
                                <tr>
                                    <td colspan="5" class="empty">No active categories found.</td>
                                </tr>
                                <%
                                    }
                                %>
                            </tbody>
                        </table>
                        <% } else { %>
                        <div class="empty">No Data</div>
                        <% } %>
                    </div>

                </div>
            </main>
        </div>

        <%
            String success = request.getParameter("success");
            String error = request.getParameter("error");
        %>

        <script>
            window.onload = function () {
            <% if ("1".equals(success)) { %>
                Swal.fire({icon: 'success', title: 'Deleted!', text: 'The category has been hidden.', timer: 2000});
            <% } else if ("1".equals(error)) { %>
                Swal.fire({icon: 'error', title: 'Failed!', text: 'Could not hide the category.', timer: 2000});
            <% } %>
            };
        </script>

    </body>
</html>
