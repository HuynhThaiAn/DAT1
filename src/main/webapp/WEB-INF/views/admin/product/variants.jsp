<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="model.Product"%>
<%@page import="model.ProductVariant"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Product Variants</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    </head>
    <body class="bg-light">
        <%
          String ctx = request.getContextPath();
          Product product = (Product) request.getAttribute("product");
          List<ProductVariant> variants = (List<ProductVariant>) request.getAttribute("variants");
          if (variants == null) variants = java.util.Collections.emptyList();
          int productId = (product == null) ? Integer.parseInt(request.getParameter("productId")) : product.getProductID();
        %>

        <div class="d-flex">
            <jsp:include page="/WEB-INF/views/admin/common/sideBar.jsp" />

            <main class="flex-grow-1 p-4">
                <div class="d-flex align-items-center justify-content-between">
                    <div>
                        <h3 class="mb-1">Variants</h3>
                        <div class="text-muted">ProductID: <%=productId%> - <%=product==null?"":product.getProductName()%></div>
                    </div>

                    <div class="d-flex gap-2">
                        <a class="btn btn-primary"
                           href="<%=ctx%>/Admin/Product?action=createVariant&productId=<%=productId%>">+ Add Variant</a>
                        <a class="btn btn-outline-secondary"
                           href="<%=ctx%>/Admin/Product?action=images&productId=<%=productId%>">Images</a>
                        <a class="btn btn-secondary" href="<%=ctx%>/Admin/Product?action=list">Back</a>
                    </div>
                </div>

                <div class="text-danger mt-2"><%= request.getAttribute("error")==null?"":request.getAttribute("error") %></div>

                <div class="card shadow-sm mt-3">
                    <div class="card-body">
                        <div class="table-responsive">
                            <table class="table table-hover align-middle">
                                <thead>
                                    <tr>
                                        <th style="width:90px;">ID</th>
                                        <th style="width:160px;">SKU</th>
                                        <th>Variant Name</th>
                                        <th style="width:140px;">Price</th>
                                        <th style="width:120px;">Stock</th>
                                        <th style="width:120px;">Active</th>
                                        <th style="width:220px;" class="text-end">Actions</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <% if (variants.isEmpty()) { %>
                                    <tr><td colspan="7" class="text-center text-muted py-4">No variants.</td></tr>
                                    <% } else { for (ProductVariant v : variants) { %>
                                    <tr>
                                        <td><%=v.getProductVariantID()%></td>
                                        <td><%=v.getSKU()%></td>
                                        <td><%=v.getVariantName()%></td>
                                        <td><%=v.getPrice()%></td>
                                        <td><%=v.getStockQuantity()%></td>
                                        <%= Boolean.TRUE.equals(v.getIsActive()) ? "Yes" : "No" %>

                                        <td class="text-end">
                                            <a class="btn btn-sm btn-outline-primary"
                                               href="<%=ctx%>/Admin/Product?action=editVariant&variantId=<%=v.getProductVariantID()%>&productId=<%=productId%>">
                                                Update
                                            </a>
                                            <a class="btn btn-sm btn-outline-secondary"
                                               href="<%=ctx%>/Admin/Product?action=toggleVariant&variantId=<%=v.getProductVariantID()%>&productId=<%=productId%>&active=<%= Boolean.TRUE.equals(v.getIsActive()) ? "0" : "1" %>">
                                                <%= Boolean.TRUE.equals(v.getIsActive()) ? "Disable" : "Enable" %>
                                            </a>

                                        </td>
                                    </tr>
                                    <% } } %>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>

            </main>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>
