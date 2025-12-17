<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.Staff"%>
<%@page import="java.util.List"%>
<%@page import="model.Product"%>

<%
  // ===== Admin login check (MUST be before any HTML output) =====
  Staff staff = (Staff) session.getAttribute("staff");
  if (staff == null || staff.getRole() == null || staff.getRole() != 2) {
      response.sendRedirect(request.getContextPath() + "/LoginAdmin");
      return;
  }
%>

<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Product Management</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
<%
  String ctx = request.getContextPath();
  List<Product> products = (List<Product>) request.getAttribute("products");
  if (products == null) products = java.util.Collections.emptyList();
%>

<div class="d-flex">
  <jsp:include page="/WEB-INF/views/admin/common/sideBar.jsp" />

  <div class="flex-grow-1">
    <jsp:include page="/WEB-INF/views/admin/common/header.jsp" />

    <main class="p-4">
      <div class="d-flex align-items-center justify-content-between">
        <h3 class="mb-0">Product Management</h3>
        <a class="btn btn-primary" href="<%=ctx%>/Admin/Product?action=create">+ Create Product</a>
      </div>

      <div class="text-danger mt-2"><%= request.getAttribute("error")==null?"":request.getAttribute("error") %></div>

      <div class="card shadow-sm mt-3">
        <div class="card-body">
          <div class="table-responsive">
            <table class="table table-hover align-middle">
              <thead>
                <tr>
                  <th style="width:90px;">ID</th>
                  <th>Product Name</th>
                  <th style="width:120px;">CategoryID</th>
                  <th style="width:120px;">BrandID</th>
                  <th style="width:260px;" class="text-end">Actions</th>
                </tr>
              </thead>
              <tbody>
              <% if (products.isEmpty()) { %>
                <tr><td colspan="5" class="text-center text-muted py-4">No products found.</td></tr>
              <% } else { for (Product p : products) { %>
                <tr>
                  <td><%=p.getProductID()%></td>
                  <td><%=p.getProductName()%></td>
                  <td><%=p.getCategoryID()%></td>
                  <td><%=p.getBrandID()==null?"":p.getBrandID()%></td>
                  <td class="text-end">
                    <a class="btn btn-sm btn-outline-secondary"
                       href="<%=ctx%>/Admin/Product?action=images&productId=<%=p.getProductID()%>">Images</a>
                    <a class="btn btn-sm btn-outline-primary"
                       href="<%=ctx%>/Admin/Product?action=variants&productId=<%=p.getProductID()%>">Variants</a>
                    <a class="btn btn-sm btn-outline-danger"
                       href="<%=ctx%>/Admin/Product?action=delete&productId=<%=p.getProductID()%>"
                       onclick="return confirm('Delete this product?');">Delete</a>
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
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
