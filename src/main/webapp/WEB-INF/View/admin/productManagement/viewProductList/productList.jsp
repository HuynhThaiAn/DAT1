<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.text.NumberFormat"%>
<%@page import="java.util.Locale"%>
<%@page import="java.util.List"%>
<%@page import="model.Product"%>

<%
    List<Product> productList = (List<Product>) request.getAttribute("productList");

    String success = request.getParameter("success");
    String error = request.getParameter("error");
    String successpro = request.getParameter("successpro");

    Locale localeVN = new Locale("vi", "VN");
    NumberFormat currencyVN = NumberFormat.getInstance(localeVN);
%>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>Product List</title>

        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
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

            /* ====== CENTER + SMALL WIDTH ====== */
            .page{
                max-width: 1400px;
                margin: 0 auto;
                padding: 20px 0;
            }

            .product-table-wrapper{
                width: 100%;
                margin-top: 8px;
                overflow-x: auto;
            }

            .product-table{
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

            .product-table thead th{
                background: #f8fafc;
                color: #334155;
                font-weight: 900;
                font-size: 13px;
                padding: 12px;
                border-bottom: 1px solid var(--border);
                text-align: left;
            }

            .product-table tbody td{
                padding: 14px 12px;
                border-bottom: 1px solid rgba(15, 23, 42, .08);
                vertical-align: middle;
                text-align: left;
            }

            .product-table tbody tr:hover{
                background: #f6f9ff;
            }

            .product-table thead th:last-child,
            .product-table tbody td:last-child{
                text-align: right;
            }

            .product-table img{
                width: 52px;
                height: 52px;
                object-fit: cover;
                border-radius: 12px;
                border: 1px solid var(--border);
                box-shadow: 0 6px 14px rgba(0,0,0,.06);
            }

            .no-image{
                color:#94a3b8;
                font-weight: 700;
            }

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
        </style>
    </head>

    <body>

        <jsp:include page="/WEB-INF/View/admin/productManagement/deleteProduct/adminDeleteProduct.jsp"/>

        <div class="page">
            <div class="product-table-wrapper">

                <% if (productList != null && !productList.isEmpty()) { %>
                <table class="product-table">
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Product Name</th>
                            <th>Price (VND)</th>
                            <th>Category</th>
                            <th>Brand</th>
                            <th>Status</th>
                            <th>Image</th>
                            <th>Action</th>
                        </tr>
                    </thead>

                    <tbody>
                        <% for (Product product : productList) {
                               if (product == null) continue;

                               String giaFormatted = product.getPrice() != null
                                    ? currencyVN.format(product.getPrice())
                                    : "______";
                        %>
                        <tr>
                            <td><%= product.getProductId() %></td>
                            <td><%= product.getProductName() %></td>
                            <td><%= giaFormatted %></td>
                            <td><%= product.getCategoryName() %></td>
                            <td><%= product.getBrandName() %></td>
                            <td>
                                <% if (product.isIsActive()) { %>
                                <span class="badge bg-success">Active</span>
                                <% } else { %>
                                <span class="badge bg-secondary">Inactive</span>
                                <% } %>
                            </td>
                            <td>
                                <% if (product.getImageUrl() != null && !product.getImageUrl().trim().isEmpty()) { %>
                                <img src="<%= product.getImageUrl() %>">
                                <% } else { %>
                                <span class="no-image">No image</span>
                                <% } %>
                            </td>

                            <td>
                                <div class="action-buttons">
                                    <a class="btn-action btn-blue"
                                       href="AdminViewProductDetail?productId=<%= product.getProductId() %>">
                                        <i class="bi bi-eye"></i> Detail
                                    </a>

                                    <a class="btn-action btn-yellow"
                                       href="AdminUpdateProduct?productId=<%= product.getProductId() %>">
                                        <i class="bi bi-pencil-square"></i> Edit
                                    </a>

                                    <% if (product.isIsActive()) { %>
                                    <button class="btn-action btn-red"
                                            onclick="confirmDelete(<%= product.getProductId() %>)">
                                        <i class="bi bi-trash"></i> Hide
                                    </button>
                                    <% } else { %>
                                    <a class="btn-action btn-blue"
                                       href="AdminRestoreProduct?productId=<%= product.getProductId() %>">
                                        <i class="bi bi-arrow-clockwise"></i> Restore
                                    </a>
                                    <% } %>
                                </div>
                            </td>
                        </tr>
                        <% } %>
                    </tbody>
                </table>

                <% } else { %>
                <div class="text-center p-4 fw-bold text-muted">No Data</div>
                <% } %>

            </div>
        </div>

        <script>
            function confirmDelete(productId) {
                Swal.fire({
                    title: 'Are you sure?',
                    text: "This product will be hidden.",
                    icon: 'warning',
                    showCancelButton: true,
                    confirmButtonColor: '#d33',
                    cancelButtonColor: '#3085d6',
                    confirmButtonText: 'Yes, hide it',
                    cancelButtonText: 'Cancel'
                }).then((result) => {
                    if (result.isConfirmed) {
                        window.location.href = 'AdminDeleteProduct?productId=' + productId;
                    }
                });
            }
        </script>

    </body>
</html>
