<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <title>Import Stock</title>
    <meta name="viewport" content="width=device-width, initial-scale=1" />

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet" />

    <style>
        :root{
            --sidebar-w: 260px;
            --header-h: 78px;

            --bg:#f4f6fb;
            --card:#fff;
            --text:#111827;
            --muted:#6b7280;
            --border:rgba(15, 23, 42, 0.10);
            --shadow:0 12px 28px rgba(0,0,0,.08);
        }

        body{
            margin:0;
            background:var(--bg);
            font-family:"Segoe UI",system-ui,-apple-system,Arial,sans-serif;
        }
        .app{ min-height:100vh; }

        main.main-content{
            margin-left: var(--sidebar-w);
            width: calc(100% - var(--sidebar-w));
            padding: 24px;
            padding-top: calc(var(--header-h) + 18px);
        }

        .page{ max-width: 1200px; margin:0 auto; }
        .page-head{ margin-bottom: 14px; }
        .page-title{ margin:0; font-weight: 900; color:var(--text); }
        .page-sub{ color:var(--muted); font-size:13px; margin-top:4px; }

        .card-table{
            background: var(--card);
            border: 1px solid var(--border);
            border-radius: 18px;
            box-shadow: var(--shadow);
            overflow: hidden;
        }

        .card-head{
            padding: 14px 16px;
            display:flex;
            align-items:center;
            justify-content: space-between;
            gap: 10px;
            border-bottom: 1px solid var(--border);
            background: #f8fafc;
        }

        .card-head-title{
            font-weight: 900;
            color: #0f172a;
            display:flex;
            align-items:center;
            gap: 10px;
        }

        .card-actions{
            padding: 14px 16px;
            display:flex;
            justify-content:flex-end;
            gap: 10px;
            border-top: 1px solid var(--border);
            background: #fff;
        }

        .btn-detail{
            border: 1px solid rgba(99,102,241,.20);
            background:#eef2ff;
            color:#0f172a;
            border-radius: 14px;
            padding: 10px 12px;
            font-weight: 900;
            display:inline-flex;
            align-items:center;
            gap: 8px;
            text-decoration:none;
        }

        .btn-success-solid{
            border:none;
            border-radius: 14px;
            padding: 10px 14px;
            font-weight: 900;
            color:#fff;
            background: linear-gradient(135deg,#22c55e,#16a34a);
            box-shadow: 0 12px 22px rgba(34,197,94,.16);
        }

        .btn-ghost{
            border: 1px solid var(--border);
            background:#fff;
            color:#0f172a;
            border-radius: 14px;
            padding: 10px 14px;
            font-weight: 900;
        }

        .table thead th{
            background:#f8fafc;
            border-bottom: 1px solid var(--border);
            font-weight: 900;
            font-size: 13px;
            color:#475569;
            white-space: nowrap;
        }
        .table tbody td{ font-size:14px; color:#0f172a; }

        @media (max-width: 992px){
            main.main-content{ margin-left:0; width:100%; }
        }
    </style>
</head>

<body>
<div class="app">
    <jsp:include page="../sideBar.jsp" />

    <main class="main-content">
        <jsp:include page="/WEB-INF/View/staff/header.jsp" />

        <div class="page">
            <div class="page-head">
                <div>
                    <h1 class="page-title">Import Stock</h1>
                    <div class="page-sub">Select supplier, choose products, then import into inventory</div>
                </div>
            </div>

            <!-- Selected Supplier -->
            <c:set value="${sessionScope.supplier}" var="sup" />
            <div class="card-table mb-3">
                <div class="card-head">
                    <div class="card-head-title">
                        <i class="fa-solid fa-building"></i> Selected Supplier
                    </div>
                    <button id="openModalBtn" class="btn-detail" type="button">
                        <i class="fa-solid fa-hand-pointer"></i> Select Supplier
                    </button>
                </div>

                <div class="table-responsive">
                    <table class="table table-hover align-middle mb-0" aria-label="Selected Supplier">
                        <thead>
                        <tr>
                            <th>Tax ID</th>
                            <th>Company Name</th>
                            <th>Email</th>
                            <th>Phone</th>
                            <th>Address</th>
                        </tr>
                        </thead>
                        <tbody>
                        <tr>
                            <td>${sup.taxId}</td>
                            <td class="fw-bold">${sup.name}</td>
                            <td>${sup.email}</td>
                            <td>${sup.phoneNumber}</td>
                            <td>${sup.address}</td>
                        </tr>
                        </tbody>
                    </table>
                </div>
            </div>

            <!-- Selected Products -->
            <div class="card-table">
                <div class="card-head">
                    <div class="card-head-title">
                        <i class="fa-solid fa-boxes-stacked"></i> Selected Products
                    </div>
                    <button id="openProductModalBtn" class="btn-detail" type="button">
                        <i class="fa-solid fa-hand-pointer"></i> Select Product
                    </button>
                </div>

                <div class="table-responsive">
                    <table class="table table-hover align-middle mb-0" aria-label="Selected Products">
                        <thead>
                        <tr>
                            <th style="width:110px;">Product ID</th>
                            <th>Product Name</th>
                            <th style="width:140px;">Import Qty</th>
                            <th style="width:160px;">Import Price</th>
                            <th style="width:160px;">Total Price</th>
                            <th class="text-center" style="width:220px;">Action</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:set var="sum" value="0" />
                        <c:forEach items="${sessionScope.selectedProducts}" var="d">
                            <tr>
                                <td class="fw-bold">${d.product.productId}</td>
                                <td>${d.product.productName}</td>
                                <td class="fw-bold">${d.quantity}</td>
                                <td class="fw-bold">
                                    <fmt:formatNumber value="${d.unitPrice}" type="number" groupingUsed="true" /> ₫
                                </td>
                                <td class="fw-bold">
                                    <fmt:formatNumber value="${d.quantity * d.unitPrice}" type="number" groupingUsed="true" /> ₫
                                </td>
                                <td class="text-center">
                                    <button class="btn btn-warning rounded-3 fw-semibold px-3 py-2 me-2 edit-product"
                                            type="button"
                                            data-id="${d.product.productId}"
                                            data-name="${d.product.productName}"
                                            data-quantity="${d.quantity}"
                                            data-price="${d.unitPrice}"
                                            data-saleprice="${d.product.price}">
                                        <i class="fa-regular fa-pen-to-square me-1"></i> Edit
                                    </button>

                                    <button class="btn btn-danger rounded-3 fw-semibold px-3 py-2 delete-product"
                                            type="button"
                                            data-id="${d.product.productId}">
                                        <i class="fa-regular fa-trash-can me-1"></i> Delete
                                    </button>
                                </td>
                            </tr>
                            <c:set var="sum" value="${sum + d.quantity * d.unitPrice}" scope="page"/>
                        </c:forEach>

                        <tr class="table-light">
                            <td colspan="4"></td>
                            <td class="text-end fw-bold">Total:</td>
                            <td class="fw-bold text-center" id="totalAmount">
                                <fmt:formatNumber value="${sum}" type="number" groupingUsed="true" /> VND
                            </td>
                        </tr>
                        </tbody>
                    </table>
                </div>

                <div class="card-actions">
                    <button type="button" class="btn-success-solid" onclick="redirectToImport()">
                        <i class="fa-solid fa-truck-ramp-box"></i> Import
                    </button>
                    <button type="button" class="btn-ghost" onclick="cancelImportStock()">
                        Cancel
                    </button>
                </div>
            </div>

            <!-- NOTE: Các modal createImportStock / selectProductModal / editProductModal
                 anh giữ nguyên ở chỗ khác (include) miễn đúng id như JS -->
        </div>
    </main>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

<script>
document.addEventListener("DOMContentLoaded", function () {

  // ===== Helpers =====
  function showInputError(input, message) {
    if (!input) return;
    input.classList.add("is-invalid");
    let errorDiv = input.parentNode.querySelector(".invalid-feedback");
    if (!errorDiv) {
      errorDiv = document.createElement("div");
      errorDiv.className = "invalid-feedback";
      input.parentNode.appendChild(errorDiv);
    }
    errorDiv.textContent = message;
    errorDiv.style.display = "block";
  }

  function clearInputError(input) {
    if (!input) return;
    input.classList.remove("is-invalid");
    const errorDiv = input.parentNode.querySelector(".invalid-feedback");
    if (errorDiv) {
      errorDiv.textContent = "";
      errorDiv.style.display = "none";
    }
  }

  // ===== Format total amount =====
  const totalAmountElement = document.getElementById("totalAmount");
  if (totalAmountElement) {
    const amount = parseFloat(totalAmountElement.innerText.replace(/[^\d.-]/g, ""));
    if (!isNaN(amount)) {
      totalAmountElement.innerText = amount.toLocaleString("vi-VN", { style: "currency", currency: "VND" });
    }
  }

  // ===== Open modals =====
  const openModalBtn = document.getElementById("openModalBtn");
  if (openModalBtn) {
    openModalBtn.addEventListener("click", function () {
      const modalEl = document.getElementById("createImportStock");
      if (!modalEl) return;
      new bootstrap.Modal(modalEl).show();
    });
  }

  const openProductModalBtn = document.getElementById("openProductModalBtn");
  if (openProductModalBtn) {
    openProductModalBtn.addEventListener("click", function () {
      const modalEl = document.getElementById("selectProductModal");
      if (!modalEl) return;
      new bootstrap.Modal(modalEl).show();
    });
  }

  // ===== Supplier selection (trong modal supplier) =====
  const confirmBtn = document.getElementById("confirmSelection");
  const supplierIDInput = document.getElementById("selectedSupplierID");

  document.querySelectorAll(".select-supplier").forEach(button => {
    button.addEventListener("click", function () {
      const supplierID = this.dataset.id;
      const selectedRow = this.closest("tr");
      if (supplierIDInput) supplierIDInput.value = supplierID;

      document.querySelectorAll("#supplierListTable tbody tr").forEach(row => row.classList.remove("table-success"));
      if (selectedRow) selectedRow.classList.add("table-success");

      if (confirmBtn) confirmBtn.disabled = false;
    });
  });

  // ===== Product select validate (qty + price) =====
  const confirmProductBtn = document.getElementById("confirmProductSelection");
  const productIdInput = document.getElementById("selectedProductId");
  const productQuantityInput = document.getElementById("selectedProductQuantity");
  const productPriceInput = document.getElementById("selectedProductPrice");

  document.querySelectorAll(".product-quantity, .product-price").forEach(input => {
    input.addEventListener("input", function () { clearInputError(this); });
  });

  document.querySelectorAll(".select-product").forEach(button => {
    button.addEventListener("click", function () {
      const productId = this.dataset.id;
      const row = this.closest("tr");
      if (!row) return;

      const quantityInput = row.querySelector(".product-quantity");
      const priceInput = row.querySelector(".product-price");

      const q = parseInt(quantityInput?.value);
      const p = parseFloat(priceInput?.value);

      clearInputError(quantityInput);
      clearInputError(priceInput);

      let hasError = false;
      if (isNaN(q) || q < 1) { showInputError(quantityInput, "Please enter a valid quantity (minimum: 1)"); hasError = true; }
      if (isNaN(p) || p < 1000) { showInputError(priceInput, "Please enter a valid price (minimum: 1,000)"); hasError = true; }

      if (hasError) {
        if (confirmProductBtn) confirmProductBtn.disabled = true;
        row.classList.remove("table-success");
        return;
      }

      if (productQuantityInput) productQuantityInput.value = q;
      if (productPriceInput) productPriceInput.value = p;
      if (productIdInput) productIdInput.value = productId;

      document.querySelectorAll("#productListTable tbody tr").forEach(r => r.classList.remove("table-success"));
      row.classList.add("table-success");
      if (confirmProductBtn) confirmProductBtn.disabled = false;
    });
  });

  // ===== Validate import price < 90% sale price in product list modal =====
  document.querySelectorAll("#productListTable tbody tr").forEach(function (row) {
    const priceInput = row.querySelector(".product-price");
    const selectBtn = row.querySelector(".select-product");
    if (!priceInput || !selectBtn) return;

    priceInput.addEventListener("input", function () {
      const importPrice = parseFloat(this.value);
      const salePrice = parseFloat(this.getAttribute("data-saleprice"));
      const maxImportPrice = Math.round(salePrice * 0.9);

      if (!isNaN(importPrice) && !isNaN(salePrice) && importPrice >= maxImportPrice) {
        showInputError(this, "Import price must be less than 90% of sale price (" + maxImportPrice.toLocaleString("vi-VN") + " VND)");
        selectBtn.disabled = true;
      } else {
        clearInputError(this);
        selectBtn.disabled = false;
      }
    });
  });

  // ===== Edit modal fill =====
  const editModalEl = document.getElementById("editProductModal");
  const editModal = editModalEl ? new bootstrap.Modal(editModalEl) : null;

  document.querySelectorAll(".edit-product").forEach(button => {
    button.addEventListener("click", function () {
      const id = this.dataset.id || "";
      const name = this.dataset.name || "";
      const qty = this.dataset.quantity || "";
      const price = this.dataset.price || "";
      const sale = this.dataset.saleprice || "";

      const i1 = document.getElementById("editProductId");
      const i2 = document.getElementById("editProductName");
      const i3 = document.getElementById("editProductQuantity");
      const i4 = document.getElementById("editProductPrice");
      const i5 = document.getElementById("editProductSalePrice");

      if (i1) i1.value = id;
      if (i2) i2.value = name;
      if (i3) i3.value = qty;
      if (i4) i4.value = price;
      if (i5) i5.value = sale;

      if (editModal) editModal.show();
    });
  });

  // ===== Edit modal validate: price <= 90% sale price =====
  const editPriceInput = document.getElementById("editProductPrice");
  if (editPriceInput) {
    editPriceInput.addEventListener("input", function () {
      const importPrice = parseFloat(this.value);
      const salePrice = parseFloat(document.getElementById("editProductSalePrice")?.value);
      const saveBtn = document.querySelector("#editProductModal .create-btn"); // nút submit modal edit

      const maxImportPrice = Math.round(salePrice * 0.9);

      if (!isNaN(importPrice) && !isNaN(salePrice) && importPrice > maxImportPrice) {
        showInputError(this, "Import price must be ≤ 90% of sale price (" + maxImportPrice.toLocaleString("vi-VN") + " VND)");
        if (saveBtn) saveBtn.disabled = true;
      } else {
        clearInputError(this);
        if (saveBtn) saveBtn.disabled = false;
      }
    });
  }

  // ===== Delete product from selected list =====
  document.querySelectorAll(".delete-product").forEach(button => {
    button.addEventListener("click", function () {
      const productId = this.dataset.id;

      Swal.fire({
        title: "Are you sure?",
        text: "Remove this product from the import list?",
        icon: "warning",
        showCancelButton: true,
        confirmButtonText: "Yes, delete it!",
        cancelButtonText: "Cancel"
      }).then(result => {
        if (!result.isConfirmed) return;

        const form = document.createElement("form");
        form.method = "POST";
        form.action = "ImportStock";

        const input1 = document.createElement("input");
        input1.type = "hidden";
        input1.name = "action";
        input1.value = "delete";

        const input2 = document.createElement("input");
        input2.type = "hidden";
        input2.name = "productId";
        input2.value = productId;

        form.appendChild(input1);
        form.appendChild(input2);
        document.body.appendChild(form);
        form.submit();
      });
    });
  });

  // ===== Search supplier =====
  const searchSupplierInput = document.getElementById("searchSupplierInput");
  if (searchSupplierInput) {
    searchSupplierInput.addEventListener("keyup", function () {
      const filter = this.value.toLowerCase();
      document.querySelectorAll("#supplierListTable tbody tr").forEach(row => {
        const taxId = row.cells[0]?.textContent.toLowerCase() || "";
        const companyName = row.cells[1]?.textContent.toLowerCase() || "";
        const email = row.cells[2]?.textContent.toLowerCase() || "";
        row.style.display = (taxId.includes(filter) || companyName.includes(filter) || email.includes(filter)) ? "" : "none";
      });
    });
  }

  // ===== Search product =====
  const searchProductInput = document.getElementById("searchProductInput");
  if (searchProductInput) {
    searchProductInput.addEventListener("keyup", function () {
      const filter = this.value.toLowerCase();
      document.querySelectorAll("#productListTable tbody tr").forEach(row => {
        const id = row.cells[0]?.textContent.toLowerCase() || "";
        const name = row.cells[1]?.textContent.toLowerCase() || "";
        row.style.display = (name.includes(filter) || id.includes(filter)) ? "" : "none";
      });
    });
  }

});
</script>

<script>
  function cancelImportStock() {
    window.location.href = 'ImportStatistic';
  }

  function cancelEditImportStock() {
    window.location.href = 'ImportStock';
  }

  function redirectToImport() {
    const form = document.createElement("form");
    form.method = "POST";
    form.action = "ImportStock";
    document.body.appendChild(form);
    form.submit();
  }
</script>

<!-- Alerts (không dùng scriptlet) -->
<c:if test="${param.success == 'imported'}">
    <script>
        Swal.fire({
            icon: 'success',
            title: 'Import Successful!',
            text: 'Stock has been successfully imported.',
            showConfirmButton: true,
            confirmButtonText: 'OK',
            timer: 2500
        });
    </script>
</c:if>

<c:if test="${param.error == '1'}">
    <script>
        Swal.fire({
            icon: 'error',
            title: 'Import Failed!',
            text: 'An error occurred during the import process.',
            showConfirmButton: true,
            confirmButtonText: 'Try Again'
        });
    </script>
</c:if>

<c:if test="${not empty sessionScope.error}">
    <script>
        Swal.fire({
            icon: 'error',
            title: 'Import Error',
            text: '${sessionScope.error}',
            showConfirmButton: true,
            confirmButtonText: 'OK'
        });
    </script>
    <c:remove var="error" scope="session"/>
</c:if>

</body>
</html>
