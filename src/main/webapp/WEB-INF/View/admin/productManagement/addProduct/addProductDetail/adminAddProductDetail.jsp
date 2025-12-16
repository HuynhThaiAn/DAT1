<%@page import="model.Product"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    Integer categoryIdObj = (Integer) request.getAttribute("categoryId");
    Product product = (Product) request.getAttribute("product");

    if (categoryIdObj == null || product == null) {
%>
<h3 style="color:red;">Missing product/category. Please create product again.</h3>
<%
        return;
    }
    int categoryId = categoryIdObj;
%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Add Product Detail</title>
        <style>
            /* ===============================
              ADD PRODUCT DETAIL – ADMIN UI
           ================================ */

            .add-product-wrapper {
                width: 70%;
                display: flex;
                gap: 20px;
                background: #f8fafc;
                border: 1px solid #e5e7eb;
                border-top: none;
                padding: 20px;
                box-sizing: border-box;
            }

            /* ===== LEFT: IMAGE ===== */
            .left-panel {
                width: 38%;
            }

            /* ===== RIGHT: DETAIL ===== */
            .right-panel {
                width: 62%;
                background: #ffffff;
                border-radius: 14px;
                padding: 16px 18px;
                box-shadow: 0 6px 22px rgba(15, 23, 42, 0.08);
            }

            /* ===============================
               IMAGE PANEL
            ================================ */
            .image-panel {
                background: #ffffff;
                padding: 16px;
                border-radius: 14px;
                box-shadow: 0 6px 22px rgba(15, 23, 42, 0.08);
            }

            .main-image-wrapper {
                width: 100%;
                border-radius: 12px;
                overflow: hidden;
                background: #020617;
            }

            .main-image-wrapper img {
                width: 100%;
                max-height: 360px;
                object-fit: cover;
                border-radius: 12px;
                cursor: pointer;
                transition: transform .25s ease;
            }

            .main-image-wrapper img:hover {
                transform: scale(1.015);
            }

            /* THUMB GRID */
            .thumb-grid {
                display: grid;
                grid-template-columns: repeat(2, 1fr);
                gap: 12px;
                margin-top: 12px;
            }

            .thumb-card {
                border-radius: 10px;
                overflow: hidden;
                border: 1px dashed #cbd5f5;
                background: #f8fafc;
                cursor: pointer;
                transition: border-color .2s ease, box-shadow .2s ease;
            }

            .thumb-card:hover {
                border-color: #2563eb;
                box-shadow: 0 4px 14px rgba(37, 99, 235, 0.2);
            }

            .thumb-card img {
                width: 100%;
                height: 120px;
                object-fit: cover;
            }

            /* ===============================
               PRODUCT DETAIL TABLE
            ================================ */
            .category-table {
                width: 100%;
                border-collapse: collapse;
                font-size: 14px;
            }

            .group-header {
                background: linear-gradient(90deg, #2563eb, #1d4ed8);
                color: white;
                cursor: pointer;
            }

            .group-cell {
                padding: 12px 14px;
            }

            .group-header-content {
                display: flex;
                justify-content: space-between;
                align-items: center;
            }

            .group-header h2 {
                font-size: 15px;
                margin: 0;
                font-weight: 600;
            }

            .arrow-icon {
                font-size: 14px;
            }

            /* DETAIL ROW */
            .group-details tr {
                border-bottom: 1px solid #e5e7eb;
            }

            .category-name {
                width: 40%;
                padding: 10px 12px;
                font-weight: 500;
                color: #334155;
            }

            .attribute-values {
                padding: 8px 12px;
            }

            .attribute-input {
                width: 100%;
                padding: 7px 10px;
                border-radius: 8px;
                border: 1px solid #cbd5e1;
                font-size: 14px;
            }

            .attribute-input:focus {
                outline: none;
                border-color: #2563eb;
                box-shadow: 0 0 0 2px rgba(37, 99, 235, 0.2);
            }

            /* HIDDEN */
            .hidden {
                display: none;
            }

            /* ===============================
               BUTTON BAR
            ================================ */
            .btn-success {
                background: #22c55e;
                border: none;
                color: white;
                padding: 8px 18px;
                border-radius: 8px;
                font-weight: 600;
                cursor: pointer;
            }

            .btn-success:hover {
                background: #16a34a;
            }

            .btn-back {
                background: #64748b;
                color: white;
                padding: 8px 18px;
                border-radius: 8px;
                text-decoration: none;
                margin-left: 8px;
            }

            .btn-back:hover {
                background: #475569;
            }

        </style>
    </head>
    <body>
        <div style="width:100%">
            <form action="<%= request.getContextPath() %>/AdminAddProductDetail"
                  method="post"
                  enctype="multipart/form-data"
                  style="display:flex; flex-direction:column; align-items:center;">


                <input type="hidden" name="categoryId" value="<%= categoryId %>">
                <input type="hidden" name="productId" value="<%= product.getProductId() %>">

                <div style="margin-top:5%; width:68.4%; margin-bottom:-0.2%; background:#0D6EFD; border:0.5px solid gray; padding:0.8%; border-top-left-radius:12px; border-top-right-radius:12px;">
                    <h4 style="color:white; margin:0; text-align:left;">Add Product</h4>
                </div>

                <div class="add-product-wrapper">

                    <div class="left-panel">
                        <jsp:include page="/WEB-INF/View/admin/productManagement/addProduct/addProductDetail/imgProductDetail.jsp" />
                    </div>

                    <div class="right-panel">
                        <jsp:include page="/WEB-INF/View/admin/productManagement/addProduct/addProductDetail/productDetail.jsp" />
                    </div>

                </div>
                <div style="text-align:right; width:67%; border:0.5px solid gray; padding:1.5%; border-top:none; border-bottom-left-radius:12px; border-bottom-right-radius:12px;">
                    <button class="btn-success" type="submit">Create</button>
                    <a href="AdminCreateProduct" class="btn-back">Cancel</a>
                </div>

            </form>
        </div>
    </body>
</html>
