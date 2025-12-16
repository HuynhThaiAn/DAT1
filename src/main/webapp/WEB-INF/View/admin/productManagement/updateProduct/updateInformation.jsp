<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.ProductDetail"%>

<%@page import="model.Brand"%>
<%@page import="model.Category"%>
<%@page import="java.util.List"%>
<%@page import="java.text.NumberFormat"%>
<%@page import="java.util.Locale"%>
<%@page import="java.math.BigDecimal"%>
<%@page import="model.Product"%>

<%
    String success = request.getParameter("success");
    String error = request.getParameter("error");

    Product product = (Product) request.getAttribute("product");
    List<Category> categoryList = (List<Category>) request.getAttribute("categoryList");
    List<Brand> brandList = (List<Brand>) request.getAttribute("brandList");
    
    List<ProductDetail> productDetailList = (List<ProductDetail>) request.getAttribute("productDetailList");
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Update Product</title>
    <link rel="stylesheet" href="Css/staffUpdateProduct1.css">
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
</head>

<body>

<% if (product != null) { %>

<div class="form-wrapper">

    <div class="mb-3">
        <label class="form-label">ID</label>
        <input type="text" class="form-control" name="id" value="<%= product.getProductId()%>" readonly/>
    </div>

    <div class="mb-3">
        <label class="form-label">Product Name</label>
        <input type="text" class="form-control" name="productName" value="<%= product.getProductName()%>" required/>
    </div>

    <%
        String priceFormatted = "";
        if (product.getPrice() != null) {
            Locale localeVN = new Locale("vi", "VN");
            NumberFormat currencyVN = NumberFormat.getInstance(localeVN);
            priceFormatted = currencyVN.format(product.getPrice());
        }
    %>

    <div class="mb-3">
        <label class="form-label">Price</label>
        <input type="text" class="form-control" name="price" value="<%= priceFormatted%>" required/>
    </div>

    

    <div class="form-check mb-2">
        <input class="form-check-input" type="checkbox" id="isActive" name="isActive"
               <%= product.isIsActive() ? "checked" : ""%>>
        <label class="form-check-label" for="isActive">Is Active</label>
    </div>

</div>

<% } else { %>
    <h3>Product not found</h3>
<% } %>

</body>
</html>
