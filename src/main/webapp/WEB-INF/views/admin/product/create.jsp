<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="model.Category"%>
<%@page import="model.Brand"%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Create Product</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
<%
  String ctx = request.getContextPath();
  List<Category> categories = (List<Category>) request.getAttribute("categories");
  if (categories == null) categories = java.util.Collections.emptyList();

  List<Brand> brands = (List<Brand>) request.getAttribute("brands");
  if (brands == null) brands = java.util.Collections.emptyList();

  String err = (String) request.getAttribute("error");
  if (err == null) err = "";
%>

<div class="d-flex">
  <jsp:include page="/WEB-INF/views/admin/common/sideBar.jsp" />

  <main class="flex-grow-1 p-4">
    <h3>Create Product (Step 1)</h3>

    <div class="card shadow-sm mt-3" style="max-width: 920px;">
      <div class="card-body">
        <div class="text-danger mb-2"><%=err%></div>

        <form class="needs-validation" novalidate
              method="post"
              action="<%=ctx%>/Admin/Product"
              enctype="multipart/form-data">
          <input type="hidden" name="action" value="create"/>

          <div class="row g-3">
            <div class="col-md-6">
              <label class="form-label">Product Name</label>
              <input class="form-control" name="productName" required value="<%=request.getParameter("productName")==null?"":request.getParameter("productName")%>"/>
              <div class="invalid-feedback">Product name is required.</div>
            </div>

            <div class="col-md-3">
              <label class="form-label">Category</label>
              <select class="form-select" name="categoryId" required>
                <option value="">-- Select --</option>
                <% for (Category c : categories) { %>
                  <option value="<%=c.getCategoryID()%>"><%=c.getCategoryName()%></option>
                <% } %>
              </select>
              <div class="invalid-feedback">Category is required.</div>
            </div>

            <div class="col-md-3">
              <label class="form-label">Brand</label>
              <select class="form-select" name="brandId" required>
                <option value="">-- Select --</option>
                <% for (Brand b : brands) { %>
                  <option value="<%=b.getBrandID()%>"><%=b.getBrandName()%></option>
                <% } %>
              </select>
              <div class="invalid-feedback">Brand is required.</div>
            </div>

            <div class="col-12">
              <label class="form-label">Description</label>
              <textarea class="form-control" name="description" rows="4"><%=request.getParameter("description")==null?"":request.getParameter("description")%></textarea>
            </div>

            <div class="col-12">
              <label class="form-label">Main Image (required)</label>
              <input class="form-control" type="file" name="mainImage" accept="image/*" required />
              <div class="invalid-feedback">Main image is required.</div>
              <div class="form-text">Step 1: upload main image here. Step 2: add sub images after create.</div>
            </div>
          </div>

          <div class="d-flex gap-2 mt-4">
            <button class="btn btn-primary" type="submit">Save & Next</button>
            <a class="btn btn-secondary" href="<%=ctx%>/Admin/Product?action=list">Back</a>
          </div>
        </form>
      </div>
    </div>
  </main>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script>
(() => {
  const forms = document.querySelectorAll('.needs-validation');
  Array.from(forms).forEach(form => {
    form.addEventListener('submit', e => {
      if (!form.checkValidity()) { e.preventDefault(); e.stopPropagation(); }
      form.classList.add('was-validated');
    });
  });
})();
</script>
</body>
</html>
