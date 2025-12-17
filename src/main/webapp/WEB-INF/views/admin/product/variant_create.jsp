<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Create Variant</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
<%
  String ctx = request.getContextPath();
  String productId = request.getParameter("productId");
  if (productId == null) productId = (String) request.getAttribute("productId");
  String err = (String) request.getAttribute("error");
  if (err == null) err = "";
%>

<div class="d-flex">
  <jsp:include page="/WEB-INF/views/admin/common/sideBar.jsp" />

  <main class="flex-grow-1 p-4">
    <h3>Add Variant (Manual)</h3>
    <div class="text-muted">ProductID: <%=productId%></div>

    <div class="card shadow-sm mt-3" style="max-width: 980px;">
      <div class="card-body">
        <div class="text-danger mb-2"><%=err%></div>

        <form class="needs-validation" novalidate
              method="post"
              action="<%=ctx%>/Admin/Product">
          <input type="hidden" name="action" value="createVariant"/>
          <input type="hidden" name="productId" value="<%=productId%>"/>

          <!-- stock default = 0 -->
          <input type="hidden" name="stockQuantity" value="0"/>

          <div class="row g-3">
            <div class="col-md-4">
              <label class="form-label">SKU</label>
              <input class="form-control" name="sku" required />
              <div class="invalid-feedback">SKU is required.</div>
            </div>

            <div class="col-md-5">
              <label class="form-label">Variant Name</label>
              <input class="form-control" name="variantName" required />
              <div class="invalid-feedback">Variant name is required.</div>
            </div>

            <div class="col-md-3">
              <label class="form-label">Price</label>
              <input class="form-control" name="price" required type="number" min="0" step="0.01"/>
              <div class="invalid-feedback">Price is required (>= 0).</div>
            </div>

            <div class="col-md-3">
              <label class="form-label">Stock</label>
              <input class="form-control" value="0" disabled />
              <div class="form-text">Default stock is 0 when creating.</div>
            </div>

            <div class="col-md-3">
              <label class="form-label">Active</label>
              <div class="form-check mt-2">
                <input class="form-check-input" type="checkbox" name="isActive" value="1" checked>
                <label class="form-check-label">Enable selling</label>
              </div>
            </div>
          </div>

          <hr class="my-4"/>

          <div class="d-flex align-items-center justify-content-between">
            <h5 class="mb-0">Variant Attributes (manual)</h5>
            <button type="button" class="btn btn-outline-secondary btn-sm" onclick="addAttrRow()">+ Add Row</button>
          </div>

          <div class="table-responsive mt-3">
            <table class="table table-bordered align-middle" id="attrTable">
              <thead>
                <tr>
                  <th style="width:35%;">Attribute Name</th>
                  <th style="width:45%;">Attribute Value</th>
                  <th style="width:15%;">Unit</th>
                  <th style="width:5%;"></th>
                </tr>
              </thead>
              <tbody>
                <!-- 3 rows default -->
                <tr>
                  <td><input class="form-control" name="attributeName[]" placeholder="Color"></td>
                  <td><input class="form-control" name="attributeValue[]" placeholder="Black"></td>
                  <td><input class="form-control" name="unit[]" placeholder=""></td>
                  <td class="text-center"><button type="button" class="btn btn-sm btn-outline-danger" onclick="removeRow(this)">x</button></td>
                </tr>
                <tr>
                  <td><input class="form-control" name="attributeName[]" placeholder="Storage"></td>
                  <td><input class="form-control" name="attributeValue[]" placeholder="256GB"></td>
                  <td><input class="form-control" name="unit[]" placeholder=""></td>
                  <td class="text-center"><button type="button" class="btn btn-sm btn-outline-danger" onclick="removeRow(this)">x</button></td>
                </tr>
                <tr>
                  <td><input class="form-control" name="attributeName[]" placeholder="RAM"></td>
                  <td><input class="form-control" name="attributeValue[]" placeholder="8GB"></td>
                  <td><input class="form-control" name="unit[]" placeholder=""></td>
                  <td class="text-center"><button type="button" class="btn btn-sm btn-outline-danger" onclick="removeRow(this)">x</button></td>
                </tr>
              </tbody>
            </table>
          </div>

          <div class="d-flex gap-2 mt-3">
            <button class="btn btn-primary" type="submit">Save</button>
            <a class="btn btn-secondary"
               href="<%=ctx%>/Admin/Product?action=variants&productId=<%=productId%>">Back</a>
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

function addAttrRow() {
  const tbody = document.querySelector('#attrTable tbody');
  const tr = document.createElement('tr');
  tr.innerHTML = `
    <td><input class="form-control" name="attributeName[]" placeholder="Attribute"></td>
    <td><input class="form-control" name="attributeValue[]" placeholder="Value"></td>
    <td><input class="form-control" name="unit[]" placeholder=""></td>
    <td class="text-center"><button type="button" class="btn btn-sm btn-outline-danger" onclick="removeRow(this)">x</button></td>
  `;
  tbody.appendChild(tr);
}

function removeRow(btn) {
  const tr = btn.closest('tr');
  if (tr) tr.remove();
}
</script>
</body>
</html>
