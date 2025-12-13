<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="model.Product" %>
<%@ page import="model.Suppliers" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>


<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8" />
        <title>Import Stock</title>
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

body{ margin:0; background:var(--bg); font-family:"Segoe UI",system-ui,-apple-system,Arial,sans-serif; }
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

/* Table header đẹp hơn */
.table thead th{
  background:#f8fafc;
  border-bottom: 1px solid var(--border);
  font-weight: 900;
  font-size: 13px;
  color:#475569;
  white-space: nowrap;
}
.table tbody td{ font-size:14px; color:#0f172a; }

/* Responsive */
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
                                            <td class="fw-bold">${d.getProduct().getProductId()}</td>
                                            <td>${d.getProduct().getProductName()}</td>
                                            <td class="fw-bold">${d.getQuantity()}</td>
                                            <td class="fw-bold">
                                                <fmt:formatNumber value="${d.unitPrice}" type="number" groupingUsed="true" /> ₫
                                            </td>
                                            <td class="fw-bold">
                                                <fmt:formatNumber value="${d.quantity * d.unitPrice}" type="number" groupingUsed="true" /> ₫
                                            </td>
                                            <td class="text-center">
                                                <button class="btn btn-warning rounded-3 fw-semibold px-3 py-2 me-2 edit-product"
                                                        type="button"
                                                        data-id="${d.getProduct().getProductId()}"
                                                        data-name="${d.getProduct().getProductName()}"
                                                        data-quantity="${d.getQuantity()}"
                                                        data-price="${d.getUnitPrice()}"
                                                        data-saleprice="${d.getProduct().getPrice()}">
                                                    <i class="fa-regular fa-pen-to-square me-1"></i> Edit
                                                </button>

                                                <button class="btn btn-danger rounded-3 fw-semibold px-3 py-2 delete-product"
                                                        type="button"
                                                        data-id="${d.getProduct().getProductId()}">
                                                    <i class="fa-regular fa-trash-can me-1"></i> Delete
                                                </button>
                                            </td>
                                        </tr>
                                        <c:set var="sum" value="${sum + d.getQuantity() * d.getUnitPrice()}" scope="page"/>
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

                    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
                    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

                    <script>
                                document.addEventListener("DOMContentLoaded", function () {
                                    let totalAmountElement = document.getElementById("totalAmount");
                                    if (totalAmountElement) {
                                        let amount = parseFloat(totalAmountElement.innerText.replace(/[^\d.-]/g, ''));
                                        if (!isNaN(amount)) {
                                            totalAmountElement.innerText = amount.toLocaleString('vi-VN', {style: 'currency', currency: 'VND'});
                                        }
                                    }
                                });

                                document.getElementById("openModalBtn").addEventListener("click", function () {
                                    var myModal = new bootstrap.Modal(document.getElementById("createImportStock"));
                                    myModal.show();
                                });

                                document.getElementById("openProductModalBtn").addEventListener("click", function () {
                                    let productModal = new bootstrap.Modal(document.getElementById("selectProductModal"));
                                    productModal.show();
                                });

                                document.addEventListener("DOMContentLoaded", function () {
                                    const confirmBtn = document.getElementById("confirmSelection");
                                    const supplierIDInput = document.getElementById("selectedSupplierID");
                                    document.querySelectorAll(".select-supplier").forEach(button => {
                                        button.addEventListener("click", function () {
                                            const supplierID = this.dataset.id;
                                            const selectedRow = this.closest("tr");
                                            supplierIDInput.value = supplierID;
                                            document.querySelectorAll("#supplierListTable tbody tr").forEach(row => {
                                                row.classList.remove("table-success");
                                            });
                                            selectedRow.classList.add("table-success");
                                            confirmBtn.disabled = false;
                                        });
                                    });
                                });

                                document.addEventListener("DOMContentLoaded", function () {
                                    const confirmProductBtn = document.getElementById("confirmProductSelection");
                                    const productIdInput = document.getElementById("selectedProductId");
                                    const productQuantityInput = document.getElementById("selectedProductQuantity");
                                    const productPriceInput = document.getElementById("selectedProductPrice");
                                    function showInputError(input, message) {
                                        input.classList.add('is-invalid');
                                        const existingError = input.parentNode.querySelector('.invalid-feedback');
                                        if (existingError) {
                                            existingError.remove();
                                        }
                                        const errorDiv = document.createElement('div');
                                        errorDiv.className = 'invalid-feedback';
                                        errorDiv.textContent = message;
                                        input.parentNode.appendChild(errorDiv);
                                    }

                                    function clearInputError(input) {
                                        input.classList.remove('is-invalid');
                                        const errorDiv = input.parentNode.querySelector('.invalid-feedback');
                                        if (errorDiv) {
                                            errorDiv.remove();
                                        }
                                    }

                                    document.querySelectorAll('.product-quantity, .product-price').forEach(input => {
                                        input.addEventListener('input', function () {
                                            clearInputError(this);
                                        });
                                    });
                                    document.querySelectorAll(".select-product").forEach(button => {
                                        button.addEventListener("click", function () {
                                            const productId = this.dataset.id;
                                            const selectedRow = this.closest("tr");
                                            const quantityInput = selectedRow.querySelector(".product-quantity");
                                            const priceInput = selectedRow.querySelector(".product-price");
                                            const productQuantity = parseInt(quantityInput.value);
                                            const productPrice = parseFloat(priceInput.value);
                                            clearInputError(quantityInput);
                                            clearInputError(priceInput);
                                            let hasError = false;
                                            if (isNaN(productQuantity) || productQuantity < 1) {
                                                showInputError(quantityInput, 'Please enter a valid quantity (minimum: 1)');
                                                quantityInput.focus();
                                                hasError = true;
                                            }

                                            if (isNaN(productPrice) || productPrice < 1000) {
                                                showInputError(priceInput, 'Please enter a valid price (minimum: 1,000)');
                                                if (!hasError)
                                                    priceInput.focus();
                                                hasError = true;
                                            }

                                            if (hasError) {
                                                selectedRow.classList.remove("table-success");
                                                confirmProductBtn.disabled = true;
                                                return;
                                            }

                                            productQuantityInput.value = productQuantity;
                                            productPriceInput.value = productPrice;
                                            productIdInput.value = productId;
                                            document.querySelectorAll("#productListTable tbody tr").forEach(row => {
                                                row.classList.remove("table-success");
                                            });
                                            selectedRow.classList.add("table-success");
                                            confirmProductBtn.disabled = false;
                                        });
                                    });
                                });

                                document.addEventListener("DOMContentLoaded", function () {
                                    const editModal = new bootstrap.Modal(document.getElementById("editProductModal"));
                                    document.querySelectorAll(".edit-product").forEach(button => {
                                        button.addEventListener("click", function () {
                                            const productId = this.dataset.id;
                                            const productName = this.dataset.name;
                                            const quantity = this.dataset.quantity;
                                            const price = this.dataset.price;
                                            const salePrice = this.dataset.saleprice;
                                            document.getElementById("editProductId").value = productId;
                                            document.getElementById("editProductName").value = productName;
                                            document.getElementById("editProductQuantity").value = quantity;
                                            document.getElementById("editProductPrice").value = price;
                                            document.getElementById("editProductSalePrice").value = salePrice;
                                            editModal.show();
                                        });
                                    });
                                    document.getElementById("editProductPrice").addEventListener("input", function () {
                                        const importPrice = parseFloat(this.value);
                                        const salePrice = parseFloat(document.getElementById("editProductSalePrice").value);
                                        const submitBtn = document.querySelector("#editProductModal .create-btn");
                                        let errorDiv = this.parentNode.querySelector('.invalid-feedback');
                                        if (!errorDiv) {
                                            errorDiv = document.createElement('div');
                                            errorDiv.className = 'invalid-feedback';
                                            this.parentNode.appendChild(errorDiv);
                                        }
                                        if (!isNaN(importPrice) && !isNaN(salePrice) && importPrice >= salePrice * 0.9) {
                                            this.classList.add('is-invalid');
                                            errorDiv.textContent = 'Import price must be ≤ 90% of sale price (' + Math.floor(salePrice * 0.9).toLocaleString('vi-VN') + ' VND)';
                                            selectBtn.disabled = true;
                                            errorDiv.style.display = 'block';
                                        } else {
                                            this.classList.remove('is-invalid');
                                            errorDiv.textContent = '';
                                            selectBtn.disabled = false;
                                            errorDiv.style.display = 'none';
                                        }

                                    });
                                });

                                document.getElementById("searchSupplierInput").addEventListener("keyup", function () {
                                    let filter = this.value.toLowerCase();
                                    let rows = document.querySelectorAll("#supplierListTable tbody tr");
                                    rows.forEach(row => {
                                        let taxId = row.cells[0].textContent.toLowerCase();
                                        let companyName = row.cells[1].textContent.toLowerCase();
                                        let email = row.cells[2].textContent.toLowerCase();
                                        if (taxId.includes(filter) || companyName.includes(filter) || email.includes(filter)) {
                                            row.style.display = "";
                                        } else {
                                            row.style.display = "none";
                                        }
                                    });
                                });

                                document.getElementById("searchProductInput").addEventListener("keyup", function () {
                                    let filter = this.value.toLowerCase();
                                    let rows = document.querySelectorAll("#productListTable tbody tr");
                                    rows.forEach(row => {
                                        let id = row.cells[0].textContent.toLowerCase();
                                        let name = row.cells[1].textContent.toLowerCase();
                                        if (name.includes(filter) || id.includes(filter)) {
                                            row.style.display = "";
                                        } else {
                                            row.style.display = "none";
                                        }
                                    });
                                });

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

                    <script>
                        document.addEventListener("DOMContentLoaded", function () {
                            document.querySelectorAll(".delete-product").forEach(button => {
                                button.addEventListener("click", function () {
                                    const productId = this.dataset.id;
                                    Swal.fire({
                                        title: 'Are you sure?',
                                        text: "Remove this product from the import list?",
                                        icon: 'warning',
                                        showCancelButton: true,
                                        confirmButtonText: 'Yes, delete it!',
                                        cancelButtonText: 'Cancel'
                                    }).then((result) => {
                                        if (result.isConfirmed) {
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
                                        }
                                    });
                                });
                            });
                        });
                    </script>


                    <script>
                        document.addEventListener("DOMContentLoaded", function () {
                            document.querySelectorAll("#productListTable tbody tr").forEach(function (row) {
                                const priceInput = row.querySelector(".product-price");
                                const selectBtn = row.querySelector(".select-product");
                                const salePrice = parseFloat(priceInput.getAttribute("data-saleprice"));
                                priceInput.addEventListener("input", function () {
                                    const importPrice = parseFloat(this.value);
                                    const salePrice = parseFloat(priceInput.getAttribute("data-saleprice"));
                                    let errorDiv = this.parentNode.querySelector('.invalid-feedback');
                                    // Nếu chưa có thì tạo, nếu có thì chỉ update text
                                    if (!errorDiv) {
                                        errorDiv = document.createElement('div');
                                        errorDiv.className = 'invalid-feedback'; // Phải thêm dòng này!
                                        this.parentNode.appendChild(errorDiv);
                                    }
                                    const maxImportPrice = Math.round(salePrice * 0.9);
                                    if (!isNaN(importPrice) && !isNaN(salePrice) && importPrice >= maxImportPrice) {
                                        this.classList.add('is-invalid');
                                        errorDiv.textContent = 'Import price must be less than 90% of sale price (' + maxImportPrice.toLocaleString('vi-VN') + ' VND)';
                                        errorDiv.style.display = 'block';
                                        selectBtn.disabled = true;
                                    } else {
                                        this.classList.remove('is-invalid');
                                        errorDiv.textContent = '';
                                        errorDiv.style.display = 'none';
                                        selectBtn.disabled = false;
                                    }

                                });

                            });
                        });
                    </script>

                    <%
                        String success = request.getParameter("success");
                        String error = request.getParameter("error");
                    %>
                    <script>
                        window.onload = function () {
                        <% if ("imported".equals(success)) { %>
                            Swal.fire({
                                icon: 'success',
                                title: 'Import Successful!',
                                text: 'Stock has been successfully imported.',
                                showConfirmButton: true,
                                confirmButtonText: 'OK',
                                timer: 2500
                            });
                        <% } else if ("1".equals(error)) { %>
                            Swal.fire({
                                icon: 'error',
                                title: 'Import Failed!',
                                text: 'An error occurred during the import process.',
                                showConfirmButton: true,
                                confirmButtonText: 'Try Again'
                            });
                        <% }%>
                        };
                    </script>

                    <c:if test="${not empty sessionScope.error}">
                        <script>
                            window.onload = function () {
                                Swal.fire({
                                    icon: 'error',
                                    title: 'Import Error',
                                    text: '${sessionScope.error}',
                                    showConfirmButton: true,
                                    confirmButtonText: 'OK'
                                });
                            };
                        </script>
                        <c:remove var="error" scope="session"/>
                    </c:if>
                    </body>
                    </html>