<%@page import="model.Voucher"%>
<%@page import="java.math.BigDecimal"%>
<%@page import="java.util.List"%>
<%@page import="model.CartItem"%>
<%@page import="model.Product"%>
<%@page import="model.Account"%>
<%@page import="model.Address"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
    String selectedCartItemIds = (String) session.getAttribute("selectedCartItemIds");
    
    if (selectedCartItemIds == null || selectedCartItemIds.trim().isEmpty()) {
        selectedCartItemIds = request.getParameter("selectedCartItemIds");
    }
    Address defaultAddress = (Address) request.getAttribute("defaultAddress");
    Long totalAmount = (Long) session.getAttribute("totalAmount");
    Long discountAmount = (Long) session.getAttribute("discountAmount");
    Long finalTotalAmount = (Long) session.getAttribute("finalTotalAmount");
    if (totalAmount == null) {
        totalAmount = 0L;
    }
    if (discountAmount == null) {
        discountAmount = 0L;
    }
    if (finalTotalAmount == null) {
        finalTotalAmount = totalAmount;
    }
%>
<html lang="en">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta http-equiv="Cache-Control" content="no-cache, no-store, must-revalidate">
        <meta http-equiv="Pragma" content="no-cache">
        <meta http-equiv="Expires" content="0">
        <title>Checkout - TShop</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" crossorigin="anonymous">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

        <style>
            
            :root {
                --primary-500: #2563eb;
                --primary-400: #3b82f6;
                --primary-100: #dbeafe;
                --slate-900: #0f172a;
                --slate-700: #334155;
                --slate-500: #64748b;
                --slate-100: #f1f5f9;
                --white: #ffffff;
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

            /* ====== WRAPPER====== */
            .checkout-wrapper {
                width: min(1240px, 94%);
                margin: 28px auto 40px;
                background: var(--white);
                border-radius: var(--radius-lg);
                box-shadow: var(--shadow-card);
                padding: 26px 24px 30px;
                border: 1px solid rgba(226, 232, 240, 0.9);
            }

            .checkout-wrapper h2 {
                color: var(--slate-900);
                font-weight: 700;
                margin-bottom: 18px;
                font-size: 1.7rem;
                display: flex;
                align-items: center;
                gap: 10px;
            }

            .checkout-wrapper h2::before {
                content: "\f09d";
                font-family: "Font Awesome 6 Free";
                font-weight: 900;
                font-size: 1.4rem;
                color: var(--primary-500);
            }

            .checkout-subtext {
                color: var(--slate-500);
                font-size: 0.9rem;
                margin-bottom: 20px;
            }

           
            .checkout-layout {
                display: grid;
                grid-template-columns: minmax(0, 1.7fr) minmax(0, 1fr);
                gap: 20px;
                margin-top: 10px;
            }

            .checkout-main {
                display: flex;
                flex-direction: column;
                gap: 16px;
            }

            /* ====== SECTION CARDS ====== */
            .product-section,
            .orderer-section,
            .address-section {
                padding: 18px 18px 16px;
                background: var(--white);
                border-radius: var(--radius-md);
                box-shadow: 0 10px 26px rgba(15, 23, 42, 0.06);
                border: 1px solid rgba(226, 232, 240, 0.9);
            }

            .checkout-wrapper h4 {
                color: var(--slate-900);
                font-weight: 600;
                font-size: 1.05rem;
                margin-bottom: 12px;
                display: flex;
                align-items: center;
                gap: 8px;
            }

            .checkout-wrapper h4::before {
                content: "";
                width: 6px;
                height: 18px;
                border-radius: 999px;
                background: var(--primary-500);
            }

            /* ====== CART TABLE ====== */
            .checkout-wrapper .cart-table {
                background: var(--white);
                border-radius: var(--radius-sm);
                overflow: hidden;
                border: 1px solid rgba(226, 232, 240, 0.9);
                margin-bottom: 0;
            }

            .checkout-wrapper .cart-table thead {
                background: linear-gradient(135deg, var(--primary-500), var(--primary-400));
                color: var(--white);
            }

            .checkout-wrapper .cart-table thead th {
                border: none;
                padding: 12px 10px;
                font-weight: 600;
                text-transform: uppercase;
                letter-spacing: 0.04em;
                font-size: 0.8rem;
            }

            .checkout-wrapper .cart-table tbody tr {
                border-bottom: 1px solid rgba(226, 232, 240, 0.9);
                transition: background 0.18s ease, transform 0.18s ease;
            }

            .checkout-wrapper .cart-table tbody tr:hover {
                background: rgba(37, 99, 235, 0.02);
                transform: translateY(-1px);
            }

            .checkout-wrapper .cart-table tbody td {
                padding: 12px 10px;
                vertical-align: middle;
                border: none;
                font-size: 0.9rem;
            }

            .checkout-wrapper .cart-table img {
                width: 64px;
                height: 64px;
                object-fit: contain;
                border-radius: 14px;
                background: #f8fafc;
                padding: 4px;
                transition: transform 0.18s ease;
            }

            .checkout-wrapper .cart-table img:hover {
                transform: scale(1.05);
            }

            .product-details {
                display: flex;
                align-items: center;
                gap: 12px;
            }

            .product-link {
                text-decoration: none;
                color: inherit;
                display: block;
            }

            .product-name {
                font-weight: 600;
                color: var(--slate-900);
                font-size: 0.95rem;
                transition: color 0.18s ease;
            }

            .product-link:hover .product-name {
                color: var(--primary-500);
            }

            .price {
                white-space: nowrap;
                font-weight: 600;
                color: var(--slate-900);
                font-size: 0.95rem;
            }

            .price small {
                font-size: 0.78rem;
            }

            /* ====== FORM CONTROL ====== */
            .checkout-wrapper .form-control {
                border-radius: 999px;
                border: 1px solid rgba(148, 163, 184, 0.8);
                padding: 9px 14px;
                font-size: 0.92rem;
                transition: border-color 0.18s ease, box-shadow 0.18s ease;
            }

            .checkout-wrapper .form-control:focus {
                border-color: var(--primary-500);
                box-shadow: 0 0 0 0.12rem rgba(37, 99, 235, 0.35);
                outline: none;
            }

            .error-message {
                color: #dc2626;
                font-size: 0.82rem;
                margin-top: 4px;
                display: none;
            }

            /* ====== ADDRESS ====== */
            .address-text {
                font-size: 0.92rem;
                color: var(--slate-700);
            }

            .address-text strong {
                color: var(--slate-900);
            }

            /* ====== ORDER SUMMARY====== */
            .info-section {
                padding: 18px 18px 20px;
                background: var(--white);
                border-radius: var(--radius-md);
                box-shadow: 0 16px 32px rgba(15, 23, 42, 0.12);
                border: 1px solid rgba(226, 232, 240, 0.9);
                position: sticky;
                top: 90px;
                align-self: flex-start;
            }

            .summary-row {
                display: flex;
                justify-content: space-between;
                align-items: center;
                margin-bottom: 6px;
                font-size: 0.92rem;
                color: var(--slate-700);
            }

            .summary-row strong {
                color: var(--slate-900);
            }

            .summary-row .price {
                font-size: 0.95rem;
            }

            .summary-divider {
                border-top: 1px dashed rgba(148, 163, 184, 0.7);
                margin: 8px 0 10px;
            }

            .summary-total {
                display: flex;
                justify-content: space-between;
                align-items: center;
                margin-top: 6px;
                margin-bottom: 4px;
                font-size: 1rem;
            }

            .summary-total strong:last-child {
                font-size: 1.15rem;
                color: var(--primary-500);
            }

            .info-section p small {
                color: var(--slate-500);
                font-size: 0.8rem;
            }

            /* ====== BUTTONS ====== */
            .btn-order,
            .btn-address,
            .btn-apply-voucher {
                border-radius: 999px;
                padding: 9px 20px;
                font-weight: 600;
                font-size: 0.9rem;
                border: none;
                transition: transform 0.18s ease, box-shadow 0.18s ease, background 0.18s ease;
                display: inline-flex;
                align-items: center;
                gap: 6px;
            }

            .btn-order {
                background: linear-gradient(135deg, var(--primary-500), var(--primary-400));
                color: var(--white);
                box-shadow: 0 14px 30px rgba(37, 99, 235, 0.4);
                width: 100%;
                justify-content: center;
                margin-top: 10px;
            }

            .btn-order:hover {
                transform: translateY(-1px);
                box-shadow: 0 18px 40px rgba(37, 99, 235, 0.55);
                color: var(--white);
            }

            .btn-address {
                background: var(--slate-100);
                color: var(--slate-900);
                border: 1px solid rgba(148, 163, 184, 0.8);
                box-shadow: 0 10px 24px rgba(15, 23, 42, 0.06);
                padding-inline: 18px;
            }

            .btn-address:hover {
                background: rgba(148, 163, 184, 0.18);
                transform: translateY(-1px);
            }

            .btn-apply-voucher {
                border: 1px solid rgba(148, 163, 184, 0.8);
                background: var(--white);
                color: var(--slate-700);
                padding-inline: 16px;
                box-shadow: 0 8px 20px rgba(15, 23, 42, 0.06);
            }

            .btn-apply-voucher:hover {
                background: var(--primary-100);
                color: var(--primary-500);
                transform: translateY(-1px);
            }

            .btn-order:disabled {
                opacity: 0.6;
                cursor: not-allowed;
                box-shadow: none;
                transform: none;
            }

            /* ====== ALERT ====== */
            .checkout-wrapper .alert {
                border-radius: var(--radius-md);
                border: 1px solid rgba(148, 163, 184, 0.5);
                padding: 12px 14px;
                margin-bottom: 16px;
                box-shadow: 0 10px 24px rgba(15, 23, 42, 0.08);
                background: rgba(219, 234, 254, 0.65);
                color: var(--slate-700);
            }

            .checkout-wrapper .alert-info h4 {
                margin-bottom: 6px;
                font-size: 1rem;
                font-weight: 700;
            }

            /* ====== RESPONSIVE ====== */
            @media (max-width: 992px) {
                .checkout-layout {
                    grid-template-columns: 1fr;
                }

                .info-section {
                    position: static;
                }
            }

            @media (max-width: 576px) {
                .checkout-wrapper {
                    padding: 18px 14px 24px;
                    margin: 18px auto 28px;
                }

                .product-details {
                    flex-direction: row;
                    align-items: flex-start;
                }

                .checkout-wrapper .cart-table img {
                    width: 56px;
                    height: 56px;
                }
            }
        </style>
    </head>
    <body>
        <jsp:include page="/WEB-INF/View/customer/homePage/header.jsp" />

        <div class="checkout-wrapper">
            <h2>Checkout</h2>
            <p class="checkout-subtext">Review your items, confirm address and place your order.</p>

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



            <form action="${pageContext.request.contextPath}/CheckoutServlet" method="post">
                <input type="hidden" name="selectedCartItemIds"
                       value="<%= selectedCartItemIds != null ? selectedCartItemIds
                                : request.getParameter("selectedCartItemIds") != null
                                    ? request.getParameter("selectedCartItemIds")
                                    : ""%>">

                <div class="checkout-layout">
                    <!-- LEFT SIDE: PRODUCT + ORDERER + ADDRESS -->
                    <div class="checkout-main">
                        <!-- Product Section -->
                        <div class="product-section">
                            <h4>Products</h4>
                            <%
                                List<CartItem> cartItems = (List<CartItem>) request.getAttribute("selectedItems");
                                if (cartItems != null && !cartItems.isEmpty()) {
                            %>
                            <table class="table cart-table">
                                <thead>
                                    <tr>
                                        <th>Product</th>
                                        <th>Price</th>
                                        <th>Qty</th>
                                        <th>Total</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <%
                                        for (CartItem item : cartItems) {
                                            Product product = item.getProduct();
                                            if (product != null) {
                                                BigDecimal unitPrice = product.getPrice();
                                                BigDecimal discount = BigDecimal.valueOf(product.getDiscount());
                                                BigDecimal discountFactor = BigDecimal.ONE.subtract(discount.divide(BigDecimal.valueOf(100), 2, BigDecimal.ROUND_HALF_UP));
                                                BigDecimal discountedPrice = unitPrice.multiply(discountFactor);
                                                BigDecimal itemTotal = discountedPrice.multiply(BigDecimal.valueOf(item.getQuantity()));
                                    %>
                                    <tr>
                                        <td>
                                            <a href="${pageContext.request.contextPath}/ProductDetail?productId=<%= product.getProductId()%>&categoryId=<%= product.getCategoryId()%>"
                                               class="product-link">
                                                <div class="product-details">
                                                    <img src="<%= product.getImageUrl() != null ? product.getImageUrl() : "https://via.placeholder.com/80"%>"
                                                         alt="<%= product.getProductName()%>">
                                                    <div class="product-name"><%= product.getProductName()%></div>
                                                </div>
                                            </a>
                                        </td>
                                        <td class="price">
                                            <%= String.format("%,d", discountedPrice.setScale(0, BigDecimal.ROUND_HALF_UP).longValue())%> VND
                                            <% if (discount.compareTo(BigDecimal.ZERO) > 0) {%>
                                            <br>
                                            <small class="text-muted">
                                                <del><%= String.format("%,d", unitPrice.setScale(0, BigDecimal.ROUND_HALF_UP).longValue())%> VND</del>
                                            </small>
                                            <% }%>
                                        </td>
                                        <td><%= item.getQuantity()%></td>
                                        <td class="price">
                                            <%= String.format("%,d", itemTotal.setScale(0, BigDecimal.ROUND_HALF_UP).longValue())%> VND
                                        </td>
                                    </tr>
                                    <%
                                            }
                                        }
                                    %>
                                </tbody>
                            </table>
                            <%
                            } else {
                            %>
                            <div class="alert alert-info text-center">
                                <h4>Your cart is empty</h4>
                                <p class="mb-3">Looks like you haven't added any items to your cart yet.</p>
                                <a href="${pageContext.request.contextPath}/Home" class="btn-order">Start Shopping!</a>
                            </div>
                            <%
                                }
                            %>
                        </div>

                        <!-- Orderer Section -->
                        <div class="orderer-section">
                            <h4>Orderer</h4>
                            <div class="mb-3">
                                <input type="text" name="fullName" id="fullName" class="form-control" placeholder="Full name" required>
                                <div id="fullNameError" class="error-message"></div>
                            </div>
                            <div class="mb-1">
                                <input type="text" name="phone" id="phone" class="form-control" placeholder="Phone number" required>
                                <div id="phoneError" class="error-message"></div>
                            </div>
                        </div>

                        <!-- Address Section -->
                        <div class="address-section">
                            <h4>Address</h4>
                            <%
                                if (defaultAddress != null) {
                                    String addressStr = defaultAddress.getProvinceName() + ", "
                                            + defaultAddress.getDistrictName() + ", "
                                            + defaultAddress.getWardName() + ", "
                                            + defaultAddress.getAddressDetails();
                            %>
                            <div class="mb-2 address-text">
                                <strong>Selected Address:</strong><br>
                                <span><%= addressStr%></span>
                                <input type="hidden" name="addressId" value="<%= defaultAddress.getAddressId()%>">
                            </div>
                            <%
                            } else {
                            %>
                            <div class="alert alert-info text-center mb-3">
                                <p class="mb-2">No address selected. Please create or select an address to proceed.</p>
                                <a href="${pageContext.request.contextPath}/AddAddress?fromCheckout=true&selectedCartItemIds=<%= selectedCartItemIds != null ? selectedCartItemIds : request.getParameter("selectedCartItemIds") != null ? request.getParameter("selectedCartItemIds") : ""%>"
                                   class="btn-address">
                                    Create New Address
                                </a>
                            </div>
                            <%
                                }
                            %>
                            <div>
                                <a href="${pageContext.request.contextPath}/AddressListServlet?fromCheckout=true&selectedCartItemIds=<%= selectedCartItemIds != null ? selectedCartItemIds : request.getParameter("selectedCartItemIds") != null ? request.getParameter("selectedCartItemIds") : ""%>"
                                   class="btn-address">
                                    Select Address
                                </a>
                            </div>
                        </div>
                    </div>

                    <!-- RIGHT SIDE: ORDER SUMMARY -->
                    <div class="info-section">
                        <h4>Order Summary</h4>
                        <div class="summary-row">
                            <span>Total amount:</span>
                            <span class="price"><%= String.format("%,d", totalAmount)%> VND</span>
                        </div>
                        <div class="summary-row">
                            <span>Total discount:</span>
                            <span class="price"><%= String.format("%,d", discountAmount)%> VND</span>
                        </div>
                        <div class="summary-row">
                            <span>After discount:</span>
                            <span class="price"><%= String.format("%,d", (totalAmount - discountAmount))%> VND</span>
                        </div>
                        <div class="summary-row">
                            <span>VAT (8%):</span>
                            <span class="price"><%= String.format("%,d", (finalTotalAmount - (totalAmount - discountAmount)))%> VND</span>
                        </div>

                        <div class="summary-divider"></div>

                        <div class="summary-total">
                            <strong>Payment required:</strong>
                            <strong class="price"><%= String.format("%,d", finalTotalAmount)%> VND</strong>
                        </div>
                        <p class="mb-1"><small>*Total includes 8% VAT</small></p>

                        <input type="hidden" name="totalAmount" value="<%= totalAmount%>">
                        <input type="hidden" name="totalPromotion" value="<%= discountAmount%>">
                        <input type="hidden" name="selectedCartItemIds"
                               value="<%= selectedCartItemIds != null ? selectedCartItemIds
                                        : request.getParameter("selectedCartItemIds") != null
                                            ? request.getParameter("selectedCartItemIds")
                                            : ""%>">

                        <button type="submit" id="submitBtn" class="btn-order" disabled>
                            Place Order
                        </button>
                    </div>
                </div>
            </form>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
        <jsp:include page="/WEB-INF/View/customer/homePage/footer.jsp" />

        <script>
            // Validation for Full Name
            const fullNameInput = document.getElementById("fullName");
            const fullNameError = document.getElementById("fullNameError");
            const submitBtn = document.getElementById("submitBtn");
            fullNameInput.addEventListener("blur", function () {
                let name = fullNameInput.value.trim();
                fullNameError.style.display = "none";
                submitBtn.disabled = false;
                // Replace multiple spaces with single space
                name = name.replace(/\s+/g, " ");
                fullNameInput.value = name;
                // Regex: Each word starts with uppercase, no numbers or special characters
                const namePattern = /^([A-ZÀ-Ỹ][a-zà-ỹ]+)(\s[A-ZÀ-Ỹ][a-zà-ỹ]+)*$/u;
                if (!namePattern.test(name) || name === "") {
                    fullNameError.textContent = "Full name must start with uppercase letters, contain no numbers or special characters, and have no extra spaces.";
                    fullNameError.style.display = "block";
                    submitBtn.disabled = true;
                }
            });
            fullNameInput.addEventListener("input", function () {
                fullNameError.style.display = "none";
                submitBtn.disabled = false;
            });

            // Validation for Phone Number
            const phoneInput = document.getElementById("phone");
            const phoneError = document.getElementById("phoneError");
            phoneInput.addEventListener("blur", function () {
                const phone = phoneInput.value.trim();
                phoneError.style.display = "none";
                submitBtn.disabled = false;
                // Regex: Must start with 0 and have exactly 10 digits
                const phonePattern = /^0\d{9}$/;
                if (!phonePattern.test(phone) || phone === "") {
                    phoneError.textContent = "Phone number must start with 0 and have exactly 10 digits.";
                    phoneError.style.display = "block";
                    submitBtn.disabled = true;
                }
            });
            phoneInput.addEventListener("input", function () {
                phoneError.style.display = "none";
                submitBtn.disabled = false;
            });
        </script>
    </body>
</html>
