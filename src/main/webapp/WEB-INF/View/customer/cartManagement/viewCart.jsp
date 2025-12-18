<%@page import="java.math.BigDecimal"%>
<%@page import="java.util.List"%>
<%@page import="model.CartItem"%>
<%@page import="model.Product"%>
<%@page import="model.Account"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta http-equiv="Cache-Control" content="no-cache, no-store, must-revalidate">
        <meta http-equiv="Pragma" content="no-cache">
        <meta http-equiv="Expires" content="0">
        <title>View Cart - DAT</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
        <style>
            /* Dùng lại token màu từ homepage */
            :root {
                --primary-500: #2563eb;
                --primary-400: #3b82f6;
                --primary-100: #dbeafe;
                --slate-900: #0f172a;
                --slate-700: #334155;
                --slate-500: #64748b;
                --slate-100: #f1f5f9;
                --white: #ffffff;
                --accent-amber: #f59e0b;
                --accent-green: #22c55e;
                --accent-pink: #ec4899;
                --radius-lg: 24px;
                --radius-md: 16px;
                --radius-sm: 12px;
                --shadow-soft: 0 20px 45px rgba(15, 23, 42, 0.08);
                --shadow-card: 0 12px 30px rgba(15, 23, 42, 0.08);
            }

            body {
                font-family: 'Inter', 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
                background: linear-gradient(180deg, #f8fbff 0%, #eef2ff 100%);
                color: var(--slate-900);
                margin: 0;
                padding: 0;
            }

            /* ====== CART LAYOUT WRAPPER ====== */
            .cart-wrapper {
                width: min(1240px, 94%);
                margin: 28px auto 40px;
                background: var(--white);
                border-radius: var(--radius-lg);
                box-shadow: var(--shadow-card);
                padding: 26px 24px 30px;
                border: 1px solid rgba(226, 232, 240, 0.9);
            }

            .cart-wrapper h2 {
                color: var(--slate-900);
                font-weight: 700;
                text-align: left;
                margin-bottom: 20px;
                font-size: 1.6rem;
                display: flex;
                align-items: center;
                gap: 10px;
            }

            .cart-wrapper h2::before {
                content: "\f07a";
                font-family: "Font Awesome 6 Free";
                font-weight: 900;
                font-size: 1.4rem;
                color: var(--primary-500);
            }

            /* ====== TABLE HEADER ACTIONS ====== */
            .cart-wrapper .table-header-actions {
                display: flex;
                justify-content: space-between;
                align-items: center;
                margin-bottom: 18px;
                padding: 12px 16px;
                background: var(--slate-100);
                border-radius: var(--radius-md);
                border: 1px solid rgba(226, 232, 240, 0.9);
            }

            .cart-wrapper .table-header-actions label {
                margin: 0;
                font-weight: 600;
                font-size: 0.9rem;
                color: var(--slate-700);
            }

            .cart-wrapper input[type="checkbox"] {
                width: 18px;
                height: 18px;
                accent-color: var(--primary-500);
                cursor: pointer;
            }

            .cart-wrapper .delete-selected-icon,
            .cart-wrapper .delete-icon {
                color: #ef4444;
                font-size: 1.2rem;
                padding: 8px;
                border-radius: 999px;
                transition: all 0.2s ease;
                cursor: pointer;
            }

            .cart-wrapper .delete-selected-icon:hover,
            .cart-wrapper .delete-icon:hover {
                background: rgba(248, 113, 113, 0.15);
                color: #b91c1c;
                transform: translateY(-1px) scale(1.05);
            }

            /* ====== CART TABLE ====== */
            .cart-wrapper .cart-table {
                background: var(--white);
                border-radius: var(--radius-md);
                overflow: hidden;
                box-shadow: 0 10px 26px rgba(15, 23, 42, 0.06);
                border: 1px solid rgba(226, 232, 240, 0.9);
                margin-bottom: 20px;
            }

            .cart-wrapper .cart-table thead {
                background: linear-gradient(135deg, var(--primary-500), var(--primary-400));
                color: var(--white);
            }

            .cart-wrapper .cart-table thead th {
                border: none;
                padding: 14px 12px;
                font-weight: 600;
                font-size: 0.85rem;
                text-transform: uppercase;
                letter-spacing: 0.04em;
                white-space: nowrap;
            }

            .cart-wrapper .cart-table tbody tr {
                transition: background 0.18s ease, transform 0.18s ease, box-shadow 0.18s ease;
                border-bottom: 1px solid rgba(226, 232, 240, 0.9);
            }

            .cart-wrapper .cart-table tbody tr:hover {
                background: rgba(37, 99, 235, 0.02);
                transform: translateY(-1px);
                box-shadow: 0 5px 16px rgba(15, 23, 42, 0.06);
            }

            .cart-wrapper .cart-table tbody td {
                padding: 14px 12px;
                vertical-align: middle;
                border: none;
                font-size: 0.95rem;
            }

            .cart-wrapper .cart-table img {
                width: 68px;
                height: 68px;
                object-fit: contain;
                border-radius: 14px;
                background: #f8fafc;
                padding: 4px;
                transition: transform 0.2s ease;
            }

            .cart-wrapper .cart-table img:hover {
                transform: scale(1.05);
            }

            .cart-wrapper .product-details {
                display: flex;
                align-items: center;
                gap: 14px;
            }

            .cart-wrapper .product-link {
                text-decoration: none;
                color: inherit;
                display: block;
            }

            .cart-wrapper .product-name {
                font-weight: 600;
                color: var(--slate-900);
                font-size: 0.96rem;
                transition: color 0.18s ease;
            }

            .cart-wrapper .product-link:hover .product-name {
                color: var(--primary-500);
            }

            .cart-wrapper .price {
                white-space: nowrap;
                font-weight: 600;
                color: var(--slate-900);
                font-size: 0.98rem;
            }

            .cart-wrapper .price small {
                font-size: 0.8rem;
            }

            /* ====== QUANTITY CONTROLS ====== */
            .cart-wrapper .quantity-container {
                display: inline-flex;
                align-items: center;
                gap: 6px;
                justify-content: center;
            }

            .cart-wrapper .quantity-btn {
                width: 32px;
                height: 32px;
                border-radius: 999px;
                border: 1px solid rgba(148, 163, 184, 0.9);
                background: var(--white);
                color: var(--slate-700);
                font-size: 1rem;
                font-weight: 600;
                cursor: pointer;
                transition: all 0.18s ease;
                display: flex;
                align-items: center;
                justify-content: center;
                padding: 0;
            }

            .cart-wrapper .quantity-btn:hover {
                border-color: var(--primary-500);
                background: var(--primary-100);
                color: var(--primary-500);
                transform: translateY(-1px);
                box-shadow: 0 4px 10px rgba(37, 99, 235, 0.25);
            }

            .cart-wrapper .quantity-btn:active {
                transform: scale(0.95);
            }

            .cart-wrapper .quantity-value {
                width: 64px;
                text-align: center;
                border-radius: 999px;
                border: 1px solid rgba(148, 163, 184, 0.9);
                padding: 7px 6px;
                font-weight: 600;
                color: var(--slate-900);
                font-size: 0.9rem;
                background: var(--white);
            }

            .cart-wrapper .quantity-value:focus {
                outline: none;
                border-color: var(--primary-500);
                box-shadow: 0 0 0 0.12rem rgba(37, 99, 235, 0.35);
            }

            .cart-wrapper .quantity-value::-webkit-outer-spin-button,
            .cart-wrapper .quantity-value::-webkit-inner-spin-button {
                -webkit-appearance: none;
                margin: 0;
            }
            .cart-wrapper .quantity-value {
                -moz-appearance: textfield;
            }

            /* ====== SUMMARY CARD ====== */
            .cart-wrapper .card {
                border-radius: var(--radius-md);
                border: 1px solid rgba(226, 232, 240, 0.9);
                box-shadow: 0 14px 34px rgba(15, 23, 42, 0.08);
            }

            .cart-wrapper .cart-total {
                font-size: 1.1rem;
                font-weight: 600;
                color: var(--slate-700);
            }

            .cart-wrapper #cartTotal {
                font-size: 1.25rem;
                font-weight: 700;
                color: var(--primary-500);
            }

            /* ====== BUTTONS (SCOPED) ====== */
            .cart-wrapper .btn {
                border-radius: 999px;
                padding: 10px 24px;
                font-weight: 600;
                font-size: 0.9rem;
                border: none;
                transition: transform 0.18s ease, box-shadow 0.18s ease, background 0.18s ease;
            }

            .cart-wrapper .btn-success {
                background: linear-gradient(135deg, var(--primary-500), var(--primary-400));
                color: var(--white);
                box-shadow: 0 14px 34px rgba(37, 99, 235, 0.35);
            }

            .cart-wrapper .btn-success:hover {
                transform: translateY(-1px);
                box-shadow: 0 18px 40px rgba(37, 99, 235, 0.5);
                color: var(--white);
            }

            .cart-wrapper .btn-secondary {
                background: var(--slate-100);
                color: var(--slate-900);
                border: 1px solid rgba(148, 163, 184, 0.9);
                box-shadow: 0 10px 24px rgba(15, 23, 42, 0.06);
            }

            .cart-wrapper .btn-secondary:hover {
                background: rgba(148, 163, 184, 0.18);
                transform: translateY(-1px);
            }

            .cart-wrapper .btn-primary {
                background: var(--primary-500);
                color: var(--white);
                box-shadow: 0 14px 34px rgba(37, 99, 235, 0.35);
                border: none;
            }

            .cart-wrapper .btn-primary:hover {
                background: var(--primary-400);
                transform: translateY(-1px);
            }

            /* ====== ALERT (SCOPED) ====== */
            .cart-wrapper .alert {
                border-radius: var(--radius-md);
                border: 1px solid rgba(148, 163, 184, 0.5);
                padding: 14px 16px;
                box-shadow: 0 10px 24px rgba(15, 23, 42, 0.08);
                background: rgba(219, 234, 254, 0.6);
                color: var(--slate-700);
            }

            .cart-wrapper .alert h4 {
                margin-bottom: 6px;
                font-size: 1.1rem;
                font-weight: 700;
            }

            /* ====== RESPONSIVE ====== */
            @media (max-width: 768px) {
                .cart-wrapper {
                    padding: 18px 14px 24px;
                    margin: 18px auto 28px;
                }

                .cart-wrapper .product-details {
                    flex-direction: column;
                    align-items: flex-start;
                }

                .cart-wrapper .cart-table img {
                    width: 56px;
                    height: 56px;
                }

                .cart-wrapper .table-header-actions {
                    flex-direction: column;
                    align-items: flex-start;
                    gap: 10px;
                }

                .cart-wrapper .cart-total {
                    flex-direction: column;
                    gap: 6px;
                }

                .cart-wrapper .btn {
                    width: 100%;
                    justify-content: center;
                }
            }
        </style>
    </head>
    <body>
        <jsp:include page="/WEB-INF/View/customer/homePage/header.jsp" />
        <div class="container cart-wrapper">
            <h2 class="mb-4">Your Shopping Cart</h2>

            <!-- Display notification -->
            <%
                String message = (String) session.getAttribute("message");
                if (message != null) {
            %>
            <div class="alert alert-info text-center">
                <%= message%>
            </div>
            <%
                    session.removeAttribute("message");
                }
            %>

            <!-- Cart Items Table -->
            <%
                List<CartItem> cartItems = (List<CartItem>) request.getAttribute("cartItems");
                if (cartItems != null && !cartItems.isEmpty()) {
            %>
            <form id="deleteForm" action="${pageContext.request.contextPath}/RemoveCartItem" method="post">
                <input type="hidden" name="action" value="deleteMultiple">
                <input type="hidden" name="accountId" value="<%= session.getAttribute("user") != null ? ((Account) session.getAttribute("user")).getAccountID() : 0%>">
                <input type="hidden" name="selectedItems" id="product_id">
                <div class="table-header-actions">
                    <div>
                        <input type="checkbox" id="selectAll" onclick="toggleSelectAll()">
                        <label for="selectAll" class="ms-2 fw-bold">Select All</label>
                    </div>
                    <a href="javascript:void(0);" class="delete-selected-icon" onclick="confirmDeleteMultiple()"><i class="fas fa-trash"></i></a>
                </div>
                <table class="table cart-table">
                    <thead>
                        <tr>
                            <th></th>
                            <th>Product</th>
                            <th>Price</th>
                            <th>Quantity</th>
                            <th>Total</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            for (CartItem item : cartItems) {
                                Product product = item.getProduct();
                                if (product == null) {
                                    System.out.println("Sản phẩm null cho cartItemId: " + item.getCartItemID());
                                    continue;
                                }
                                BigDecimal unitPrice = product.getPrice();
                                BigDecimal discount = BigDecimal.valueOf(product.getDiscount());
                                BigDecimal discountFactor = BigDecimal.ONE.subtract(
                                        discount.divide(BigDecimal.valueOf(100), 2, BigDecimal.ROUND_HALF_UP)
                                );
                                BigDecimal discountedPrice = unitPrice != null ? unitPrice.multiply(discountFactor) : BigDecimal.ZERO;
                                BigDecimal itemTotal = discountedPrice.multiply(BigDecimal.valueOf(item.getQuantity()));
                                if (itemTotal == null || discountedPrice == null) {
                                    System.out.println(
                                            "Tính giá không hợp lệ cho cartItemId: "
                                            + item.getCartItemID()
                                            + ", discountedPrice: " + discountedPrice
                                            + ", quantity: " + item.getQuantity()
                                    );
                                    itemTotal = BigDecimal.ZERO;
                                }
                        %>
                        <tr data-unit-price="<%= discountedPrice.setScale(0, BigDecimal.ROUND_HALF_UP).longValue()%>"
                            data-cart-item-id="<%= item.getCartItemID()%>"
                            data-item-total="<%= itemTotal.setScale(0, BigDecimal.ROUND_HALF_UP).longValue()%>">
                            <td>
                                <input type="checkbox"
                                       class="selectItem"
                                       data-item-total="<%= itemTotal.setScale(0, BigDecimal.ROUND_HALF_UP).longValue()%>"
                                       onclick="updateCartTotal(); saveSelectedItems();">
                            </td>
                            <td>
                                <a href="${pageContext.request.contextPath}/ProductDetail?productId=<%= product.getProductId()%>&categoryId=<%= product.getCategoryId()%>" class="product-link">
                                    <div class="product-details">
                                        <img src="<%= product.getImageUrl() != null ? product.getImageUrl() : "https://via.placeholder.com/80"%>" alt="<%= product.getProductName()%>">
                                        <div class="product-name"><%= product.getProductName()%></div>
                                    </div>
                                </a>
                            </td>
                            <td class="price">
                                <%= String.format("%,d", discountedPrice.setScale(0, BigDecimal.ROUND_HALF_UP).longValue())%> VND
                                <% if (discount.compareTo(BigDecimal.ZERO) > 0) {%>
                                <small class="text-muted">
                                    <del><%= String.format("%,d", unitPrice.setScale(0, BigDecimal.ROUND_HALF_UP).longValue())%> VND</del>
                                </small>
                                <% }%>
                            </td>
                            <td>
                                <!-- FORM UPDATE QUANTITY -->
                                <form method="post" id="quantityForm-<%= item.getCartItemID()%>" onsubmit="return false;">
                                    <input type="hidden" name="action" value="update">
                                    <input type="hidden" name="cartItemId" value="<%= item.getCartItemID()%>">
                                    <div class="quantity-container">
                                        <button type="button" class="quantity-btn"
                                                onclick="changeQuantity(this, -1)">−</button>
                                        <input type="number"
                                               id="quantity-<%= item.getCartItemID()%>"
                                               name="quantity"
                                               class="quantity-value"
                                               value="<%= item.getQuantity()%>"
                                               min="1"
                                               onchange="changeQuantity(this, 0)">

                                        <button type="button" class="quantity-btn"
                                                onclick="changeQuantity(this, 1)">+</button>
                                    </div>
                                </form>
                            </td>

                            <td class="price" id="total-<%= item.getCartItemID()%>">
                                <%= String.format("%,d", itemTotal.setScale(0, BigDecimal.ROUND_HALF_UP).longValue())%> VND
                            </td>
                            <td class="action-buttons">
                                <a href="javascript:void(0);" class="delete-icon"
                                   onclick="confirmDeleteCart(<%= item.getCartItemID()%>)">
                                    <i class="fas fa-trash"></i>
                                </a>
                            </td>
                        </tr>
                        <%
                            }
                        %>
                    </tbody>
                </table>
                <!-- Cart Summary -->
                <div class="card p-4 mb-4">
                    <div class="d-flex justify-content-between cart-total">
                        <span>Total:</span>
                        <span id="cartTotal">0 VND</span>
                    </div>
                    <div class="text-end mt-4">
                        <form id="checkoutForm" action="${pageContext.request.contextPath}/CheckoutServlet" method="get">
                            <input type="hidden" name="selectedCartItemIds" id="selectedCartItemIds">
                            <button type="submit" class="btn btn-success me-3" onclick="return prepareCheckout()">Proceed to Checkout</button>
                            <a href="${pageContext.request.contextPath}/Home" class="btn btn-secondary">Continue Shopping</a>
                        </form>
                    </div>
                </div>
            </form>
            <%
            } else {
            %>
            <div class="alert alert-info text-center">
                <h4>Your cart is empty</h4>
                <p class="mb-3">Looks like you haven't added any items to your cart yet.</p>
                <a href="${pageContext.request.contextPath}/Home" class="btn btn-primary">Start Shopping!</a>
            </div>
            <%
                }
            %>

            <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
            <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
                    integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
            crossorigin="anonymous"></script>
            <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

            <script>
                                const ACCOUNT_ID = '<%= session.getAttribute("user") != null ? ((Account) session.getAttribute("user")).getAccountID() : 0%>';

                                function confirmDeleteCart(cartItemId) {
                                    Swal.fire({
                                        title: 'Are you sure?',
                                        text: "This cart item will be deleted.",
                                        icon: 'warning',
                                        showCancelButton: true,
                                        confirmButtonColor: '#d33',
                                        cancelButtonColor: '#3085d6',
                                        confirmButtonText: 'Delete',
                                        cancelButtonText: 'Cancel'
                                    }).then((result) => {
                                        if (result.isConfirmed) {
                                            window.location.href = '${pageContext.request.contextPath}/RemoveCartItem?action=remove&id='
                                                    + cartItemId + '&accountId=' + ACCOUNT_ID;
                                        }
                                    });
                                }

                                function confirmDeleteMultiple() {
                                    const selected = Array.from(document.querySelectorAll('.selectItem:checked'))
                                            .map(item => item.closest('tr').getAttribute('data-cart-item-id'));
                                    if (selected.length === 0) {
                                        Swal.fire({
                                            icon: 'warning',
                                            title: 'No items selected',
                                            text: 'Please select at least one item to delete.',
                                            showConfirmButton: true
                                        });
                                        return;
                                    }
                                    Swal.fire({
                                        title: 'Are you sure?',
                                        text: `You are about to delete ${selected.length} item(s).`,
                                        icon: 'warning',
                                        showCancelButton: true,
                                        confirmButtonColor: '#d33',
                                        cancelButtonColor: '#3085d6',
                                        confirmButtonText: 'Delete',
                                        cancelButtonText: 'Cancel'
                                    }).then((result) => {
                                        if (result.isConfirmed) {
                                            document.getElementById('product_id').value = selected.join(',');
                                            document.getElementById('deleteForm').submit();
                                        }
                                    });
                                }

                                function formatNumber(number) {
                                    if (isNaN(number) || number === null || number === undefined) {
                                        return "0";
                                    }
                                    return Math.round(number)
                                            .toString()
                                            .replace(/\B(?=(\d{3})+(?!\d))/g, ",");
                                }

                                function updateCartTotal() {
                                    let total = 0;
                                    document.querySelectorAll('.selectItem:checked').forEach(cb => {
                                        const v = cb.getAttribute('data-item-total');
                                        total += parseInt(v || "0", 10);
                                    });
                                    document.getElementById('cartTotal').textContent = formatNumber(total) + ' VND';
                                }

                                function updateItemTotal(cartItemId) {
                                    const row = document.querySelector(`tr[data-cart-item-id="${cartItemId}"]`);
                                    if (!row) {
                                        console.error("Row not found for cartItemId:", cartItemId);
                                        return;
                                    }

                                    const unitPrice = parseInt(row.getAttribute('data-unit-price') || "0", 10);
                                    const quantityInput = document.getElementById(`quantity-${cartItemId}`);
                                    const quantity = parseInt(quantityInput?.value || "0", 10);

                                    const newTotal = unitPrice * quantity;

                                    // update UI
                                    const totalCell = document.getElementById(`total-${cartItemId}`);
                                    if (totalCell) {
                                        totalCell.textContent = formatNumber(newTotal) + ' VND';
                                    }

                                    // update data attributes for row + checkbox
                                    row.setAttribute('data-item-total', String(newTotal));
                                    const checkbox = row.querySelector('.selectItem');
                                    if (checkbox) {
                                        checkbox.setAttribute('data-item-total', String(newTotal));
                                    }

                                    // update tổng giỏ (chỉ các item đang tick)
                                    updateCartTotal();

                                    // optional: lưu lại selected items (nếu anh muốn giữ state)
                                    saveSelectedItems();
                                }


                                function saveSelectedItems() {
                                    const selected = Array.from(document.querySelectorAll('.selectItem:checked'))
                                            .map(item => item.closest('tr').getAttribute('data-cart-item-id'));
                                    $.ajax({
                                        url: '${pageContext.request.contextPath}/CartList',
                                        type: 'POST',
                                        data: {
                                            action: 'saveSelectedItems',
                                            selectedCartItemIds: selected.join(',')
                                        },
                                        success: function () {
                                            console.log('Selected items saved to session:', selected);
                                        },
                                        error: function (xhr, status, error) {
                                            console.error('Error saving selected items:', error);
                                        }
                                    });
                                }

                                function toggleSelectAll() {
                                    const selectAll = document.getElementById('selectAll');
                                    document.querySelectorAll('.selectItem').forEach(item => {
                                        item.checked = selectAll.checked;
                                    });
                                    updateCartTotal();
                                    saveSelectedItems();
                                }

                                function prepareCheckout() {
                                    const selected = Array.from(document.querySelectorAll('.selectItem:checked'))
                                            .map(item => item.closest('tr').getAttribute('data-cart-item-id'));
                                    if (selected.length === 0) {
                                        Swal.fire({
                                            icon: 'warning',
                                            title: 'No items selected',
                                            text: 'Please select at least one item to proceed to checkout.',
                                            showConfirmButton: true
                                        });
                                        event.preventDefault();
                                        return false;
                                    }
                                    document.getElementById('selectedCartItemIds').value = selected.join(',');
                                    return true;
                                }


                                function changeQuantity(elem, delta) {
                                    let form, input;

                                    if (elem.tagName === 'INPUT') {
                                        input = elem;
                                        form = elem.closest('form');
                                    } else {
                                        form = elem.closest('form');
                                        input = form.querySelector('input[name="quantity"]');
                                    }

                                    if (!form || !input) {
                                        console.error('Cannot find form/quantity input');
                                        return;
                                    }

                                    const cartItemId = form.querySelector('input[name="cartItemId"]').value;
                                    let currentQuantity = parseInt(input.value) || 1;

                                    // Nếu bấm "-" khi đang là 1 => hỏi có xoá item không
                                    if (delta === -1 && currentQuantity === 1) {
                                        Swal.fire({
                                            title: 'Remove this item?',
                                            text: 'Quantity is 1. Do you want to remove it from cart?',
                                            icon: 'warning',
                                            showCancelButton: true,
                                            confirmButtonColor: '#d33',
                                            cancelButtonColor: '#3085d6',
                                            confirmButtonText: 'Remove',
                                            cancelButtonText: 'Cancel'
                                        }).then((result) => {
                                            if (result.isConfirmed) {
                                                window.location.href =
                                                        '${pageContext.request.contextPath}/RemoveCartItem?action=remove&id='
                                                        + cartItemId + '&accountId=' + ACCOUNT_ID;
                                            }
                                        });
                                        return;
                                    }

                                    // Tính quantity mới
                                    let newQuantity = currentQuantity;
                                    if (delta !== 0)
                                        newQuantity += delta;
                                    if (newQuantity < 1)
                                        newQuantity = 1;

                                    // Cập nhật UI trước
                                    input.value = newQuantity;

                                    // Gọi server update
                                    $.ajax({
                                        url: "${pageContext.request.contextPath}/UpdateCart",
                                        type: "POST",
                                        data: {
                                            action: "update",
                                            cartItemId: cartItemId,
                                            quantity: newQuantity
                                        },
                                        success: function (res) {
                                            res = (res || "").trim();
                                            if (res === "success") {
                                                updateItemTotal(cartItemId);
                                            } else if (res === "out_of_stock") {
                                                Swal.fire("⚠ Out Of Stock", "Not enough quantity in warehouse", "warning");
                                                input.value = currentQuantity; // rollback
                                            } else {
                                                Swal.fire("❌ Failed to update");
                                                input.value = currentQuantity; // rollback
                                            }
                                        },
                                        error: function () {
                                            Swal.fire("❌ Failed to update");
                                            input.value = currentQuantity; // rollback
                                        }
                                    });

                                }

                                // Tự check item mới thêm vào cart
                                const lastAddedCartItemId = '<%= session.getAttribute("lastAddedCartItemId") != null ? session.getAttribute("lastAddedCartItemId") : "null"%>';
                                if (lastAddedCartItemId !== "null") {
                                    const checkbox = document.querySelector(`tr[data-cart-item-id="${lastAddedCartItemId}"] .selectItem`);
                                    if (checkbox) {
                                        checkbox.checked = true;
                                        updateCartTotal();
                                        saveSelectedItems();
                                    }
                                    // Xóa session attribute sau khi sử dụng
                                    fetch('${pageContext.request.contextPath}/ClearLastAddedCartItem', {
                                        method: 'POST'
                                    }).then(() => console.log('Cleared lastAddedCartItemId from session'));
                                }

                                // Optional: tính tổng ban đầu
                                document.addEventListener("DOMContentLoaded", function () {
                                    updateCartTotal();
                                });
            </script>
        </div>
        <jsp:include page="/WEB-INF/View/customer/homePage/footer.jsp" />
    </body>
</html>
