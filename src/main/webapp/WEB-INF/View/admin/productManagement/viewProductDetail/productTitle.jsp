<%@page import="model.Product"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    Product product = (Product) request.getAttribute("product");
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Product Detail</title>
</head>

<body style="background:#f8fafc;font-family:system-ui">

    <div style="width:100%;padding:32px 50px 10px">

        <!-- HEADER -->
        <div style="
            display:flex;
            align-items:flex-end;
            gap:14px;
            margin-bottom:18px;
        ">
            <h1 style="
                font-size:42px;
                font-weight:800;
                color:#1e293b;
                margin:0;
                letter-spacing:.5px;
            ">
                Product Management
            </h1>

            <span style="
                font-size:16px;
                color:#6b7280;
                margin-bottom:6px;
            ">
                ➤ View Product Detail
            </span>
        </div>

        <!-- PRODUCT NAME CARD -->
        <div style="
            background:white;
            border-radius:14px;
            padding:20px 26px;
            box-shadow:0 6px 24px rgba(0,0,0,.08);
            border-left:5px solid #2563eb;
            margin-bottom:16px;
        ">
            <h2 style="margin:0;font-weight:700;font-size:25px;color:#111827">
                <%= product.getProductName() %>
            </h2>

            <p style="margin:6px 0 0;font-size:14px;color:#6b7280">
                Product details overview
            </p>
        </div>

    </div>

</body>
</html>
