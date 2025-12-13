<%@page import="java.text.NumberFormat"%>
<%@page import="java.util.Locale"%>
<%@page import="java.util.List"%>
<%@page import="model.Product"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    List<Product> productList = (List<Product>) request.getAttribute("productList");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Product List</title>

    <!-- Nếu trang cha đã import rồi thì có thể bỏ bớt phần dưới -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

    <style>
        .product-table-wrapper {
            margin-top: 8px;
            width: 100%;
            overflow-x: auto;
        }

        .product-table {
            width: 100%;
            border-collapse: separate;
            border-spacing: 0;
            border-radius: 16px;
            overflow: hidden;
            box-shadow: 0 6px 20px rgba(15, 23, 42, 0.08);
            font-size: 14px;
            background: #ffffff;
        }

        .product-table th,
        .product-table td {
            text-align: center;
            vertical-align: middle;
            padding: 9px 12px;
        }

        .product-table thead th {
            background: linear-gradient(90deg, #1d4ed8, #2563eb);
            color: #e5e7eb;
            font-weight: 700;
            font-size: 12px;
            text-transform: uppercase;
            letter-spacing: 0.08em;
            border-bottom: 1px solid #1d4ed8;
            white-space: nowrap;
        }

        .product-table thead th:first-child {
            border-top-left-radius: 16px;
        }

        .product-table thead th:last-child {
            border-top-right-radius: 16px;
            min-width: 260px;
        }

        .product-table tbody tr:nth-child(even) {
            background: #f9fafb;
        }

        .product-table tbody tr:last-child td {
            border-bottom: none;
        }

        .product-table tbody tr {
            transition: background-color 0.18s ease, transform 0.08s ease, box-shadow 0.18s ease;
        }

        .product-table tbody tr:hover {
            background: #eff6ff;
            transform: translateY(-1px);
            box-shadow: 0 4px 10px rgba(148, 163, 184, 0.35);
        }

        .product-table img {
            max-width: 60px;
            max-height: 60px;
            object-fit: cover;
            border-radius: 8px;
            display: block;
            margin: 0 auto;
        }

        .action-buttons {
            display: flex;
            justify-content: center;
            gap: 8px;
            flex-wrap: wrap;
        }

        /* Nút Detail / Edit / Delete theo style module Staff */
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
    </style>
</head>
<body>
    <!-- Modal / script delete có thể nằm trong file include -->
    <jsp:include page="/WEB-INF/View/admin/productManagement/deleteProduct/adminDeleteProduct.jsp"/>

    <div class="product-table-wrapper">
        <% if (productList != null && !productList.isEmpty()) { %>
        <table class="product-table" aria-label="Product table">
            <thead>
            <tr>
                <th>ID</th>
                <th>Product Name</th>
                <th>Price (VND)</th>
                <th>Category</th>
                <th>Brand</th>
                <th>Image</th>
                <th>Action</th>
            </tr>
            </thead>
            <tbody>
            <%
                Locale localeVN = new Locale("vi", "VN");
                NumberFormat currencyVN = NumberFormat.getInstance(localeVN);
                for (Product product : productList) {
                    if (product != null) {
                        String giaFormatted = "______";
                        if (product.getPrice() != null) {
                            giaFormatted = currencyVN.format(product.getPrice());
                        }
            %>
            <tr>
                <td><%= product.getProductId() %></td>
                <td><%= product.getProductName() %></td>
                <td><%= giaFormatted %></td>
                <td><%= product.getCategoryName() %></td>
                <td><%= product.getBrandName() %></td>
                <td>
                    <img src="<%= (product.getImageUrl() != null) ? product.getImageUrl() : "" %>"
                         alt="Product Image">
                </td>
                <td>
                    <div class="action-buttons">
                        <a href="AdminViewProductDetail?productId=<%= product.getProductId() %>" class="btn-detail">
                            Detail
                        </a>
                        <a href="AdminUpdateProduct?productId=<%= product.getProductId() %>" class="btn-edit">
                            Edit
                        </a>
                        <button type="button" class="btn-delete"
                                onclick="confirmDelete(<%= product.getProductId() %>)">
                            Delete
                        </button>
                    </div>
                </td>
            </tr>
            <%
                    }
                }
            %>
            </tbody>
        </table>
        <% } else { %>
        <div style="padding: 16px; text-align: center;">No Data!</div>
        <% } %>
    </div>

    <%
        String success = request.getParameter("success");     // delete/hide
        String successpro = request.getParameter("successpro"); // set promotion
        String error = request.getParameter("error");
    %>

    <script>
        // confirmDelete product (giả sử hàm này chưa được define ở file include)
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

        window.onload = function () {
            <% if ("1".equals(success)) { %>
            Swal.fire({
                icon: 'success',
                title: 'Deleted!',
                text: 'The product has been hidden.',
                timer: 2000
            });
            <% } else if ("1".equals(error)) { %>
            Swal.fire({
                icon: 'error',
                title: 'Failed!',
                text: 'Could not hide the product.',
                timer: 2000
            });
            <% } %>

            <% if ("1".equals(successpro)) { %>
            Swal.fire({
                icon: 'success',
                title: 'Successful!',
                text: 'Set promotion successful.',
                timer: 2000
            });
            <% } %>
        };
    </script>
</body>
</html>
