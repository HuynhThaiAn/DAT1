<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.*"%>
<%@page import="model.Product"%>

<%
    String ctx = request.getContextPath();

    List<Product> productList =
            (List<Product>) request.getAttribute("productList");
    if (productList == null) productList = Collections.emptyList();

    Integer selectedCategory =
            (Integer) request.getAttribute("selectedCategory");

    Integer selectedBrand =
            (Integer) request.getAttribute("selectedBrand");

    String keyword =
            (String) request.getAttribute("keyword");
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Products</title>
    <link rel="stylesheet" href="<%=ctx%>/assets/css/product.css">
</head>

<body>

<jsp:include page="/WEB-INF/views/customer/homePage/header.jsp"/>

<div class="container mt-4">

    <!-- ===== FILTER BAR ===== -->
    <form action="<%=ctx%>/Product" method="get" class="row g-3 mb-4">
        <input type="hidden" name="action" value="filter"/>

        <!-- Category -->
        <div class="col-md-3">
            <select name="categoryId" class="form-select">
                <option value="">All Categories</option>
                <%
                    List<?> categoryList =
                        (List<?>) request.getAttribute("categoryList");
                    if (categoryList != null) {
                        for (Object obj : categoryList) {
                            model.Category c = (model.Category) obj;
                %>
                <option value="<%=c.getCategoryID()%>"
                    <%= (selectedCategory != null &&
                         selectedCategory.equals(c.getCategoryID()))
                         ? "selected" : "" %>>
                    <%= c.getCategoryName() %>
                </option>
                <% }} %>
            </select>
        </div>

        <!-- Brand -->
        <div class="col-md-3">
            <select name="brandId" class="form-select">
                <option value="">All Brands</option>
                <%
                    List<?> brandList =
                        (List<?>) request.getAttribute("brandList");
                    if (brandList != null) {
                        for (Object obj : brandList) {
                            model.Brand b = (model.Brand) obj;
                %>
                <option value="<%=b.getBrandID()%>"
                    <%= (selectedBrand != null &&
                         selectedBrand.equals(b.getBrandID()))
                         ? "selected" : "" %>>
                    <%= b.getBrandName() %>
                </option>
                <% }} %>
            </select>
        </div>

        <!-- Keyword -->
        <div class="col-md-4">
            <input type="text"
                   name="keyword"
                   value="<%= keyword == null ? "" : keyword %>"
                   class="form-control"
                   placeholder="Search product...">
        </div>

        <div class="col-md-2">
            <button class="btn btn-dark w-100">Filter</button>
        </div>
    </form>

    <!-- ===== PRODUCT LIST ===== -->
    <div class="row">

        <% if (productList.isEmpty()) { %>
            <div class="col-12 text-center text-muted">
                No products found.
            </div>
        <% } else {
            for (Product p : productList) {
        %>

        <div class="col-md-3 mb-4">
            <a href="<%=ctx%>/ProductDetail?id=<%=p.getProductID()%>"
               class="text-decoration-none text-dark">

                <div class="card h-100">
                    <img src="<%=ctx%>/Image/no-image.png"
                         class="card-img-top"
                         alt="product">

                    <div class="card-body">
                        <h6 class="card-title">
                            <%= p.getProductName() %>
                        </h6>

                        <p class="card-text text-muted small">
                            <%= p.getDescription() == null
                                    ? ""
                                    : p.getDescription() %>
                        </p>
                    </div>
                </div>

            </a>
        </div>

        <% }} %>

    </div>
</div>

</body>
</html>
