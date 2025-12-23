<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.util.*"%>
<%@page import="java.math.BigDecimal"%>
<%@page import="java.time.format.DateTimeFormatter"%>
<%@page import="model.Customer"%>
<%@page import="model.Order"%>
<%@page import="model.OrderDetail"%>
<%@page import="model.Payment"%>
<%@page import="model.Address"%>

<%
    // ===== CHECK LOGIN (BẮT BUỘC) =====
    Customer customer = (Customer) session.getAttribute("customer");
    if (customer == null) {
        response.sendRedirect(request.getContextPath() + "/Login");
        return;
    }

    Order order = (Order) request.getAttribute("order");
    List<OrderDetail> details = (List<OrderDetail>) request.getAttribute("details");
    Payment payment = (Payment) request.getAttribute("payment");
    Address address = (Address) request.getAttribute("address");

    if (details == null) details = new ArrayList<>();

    // fail-safe: nếu servlet không set order thì quay lại list
    if (order == null) {
        response.sendRedirect(request.getContextPath() + "/Order?action=list");
        return;
    }

    DateTimeFormatter fmt = DateTimeFormatter.ofPattern("dd/MM/yyyy HH:mm");

    // ===== build status string (ORDER) =====
    int orderStatus = (order.getStatus() == null) ? -1 : order.getStatus();
    String orderStatusStr;
    switch (orderStatus) {
        case 0: orderStatusStr = "Pending"; break;
        case 1: orderStatusStr = "Paid"; break;
        case 2: orderStatusStr = "Shipped"; break;
        case 3: orderStatusStr = "Delivered"; break;
        case 4: orderStatusStr = "Cancelled"; break;
        default: orderStatusStr = "Unknown"; break;
    }

    // ===== payment strings =====
    String payMethodStr = "Unknown";
    String payStatusStr = "Unknown";

    if (payment != null) {
        Integer m = payment.getMethod();
        if (m != null) {
            switch (m) {
                case 1: payMethodStr = "COD"; break;
                case 2: payMethodStr = "Bank"; break;
                case 3: payMethodStr = "Online"; break;
                default: payMethodStr = "Unknown"; break;
            }
        }

        Integer ps = payment.getStatus();
        if (ps != null) {
            switch (ps) {
                case 0: payStatusStr = "Pending"; break;
                case 1: payStatusStr = "Paid"; break;
                case 2: payStatusStr = "Failed"; break;
                default: payStatusStr = "Unknown"; break;
            }
        }
    }
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Order Detail</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>

    <jsp:include page="/WEB-INF/views/customer/homePage/header.jsp" />

    <div class="container py-4">

        <div class="d-flex align-items-center justify-content-between mb-3">
            <div>
                <h4 class="mb-0">Order #<%= order.getOrderID() %></h4>
                <div class="text-muted">
                    Ordered at:
                    <%= (order.getOrderedAt() == null) ? "-" : order.getOrderedAt().format(fmt) %>
                </div>
            </div>
            <a class="btn btn-outline-secondary" href="<%=request.getContextPath()%>/Order?action=list">Back</a>
        </div>

        <div class="row g-3">
            <!-- Order Info -->
            <div class="col-lg-6">
                <div class="card shadow-sm">
                    <div class="card-body">
                        <h6 class="mb-3">Order Info</h6>

                        <div class="mb-2"><b>Status:</b>
                            <span class="badge text-bg-secondary"><%= orderStatusStr %></span>
                        </div>

                        <div class="mb-2"><b>Receiver:</b> <%= (order.getReceiverName() == null ? "-" : order.getReceiverName()) %></div>
                        <div class="mb-2"><b>Phone:</b> <%= (order.getPhone() == null ? "-" : order.getPhone()) %></div>

                        <% if (order.getNote() != null && !order.getNote().trim().isEmpty()) { %>
                            <div class="mb-2"><b>Note:</b> <%= order.getNote() %></div>
                        <% } %>

                        <hr/>
                        <div class="mb-2"><b>Paid At:</b> <%= (order.getPaidAt() == null ? "-" : order.getPaidAt().format(fmt)) %></div>
                        <div class="mb-2"><b>Shipped At:</b> <%= (order.getShippedAt() == null ? "-" : order.getShippedAt().format(fmt)) %></div>
                        <div class="mb-2"><b>Delivered At:</b> <%= (order.getDeliveredAt() == null ? "-" : order.getDeliveredAt().format(fmt)) %></div>
                        <div class="mb-2"><b>Cancelled At:</b> <%= (order.getCancelledAt() == null ? "-" : order.getCancelledAt().format(fmt)) %></div>
                    </div>
                </div>
            </div>

            <!-- Shipping Address -->
            <div class="col-lg-6">
                <div class="card shadow-sm">
                    <div class="card-body">
                        <h6 class="mb-3">Shipping Address</h6>

                        <% if (address == null) { %>
                            <div class="text-muted">No address data.</div>
                        <% } else { %>
                            <div class="fw-semibold"><%= (address.getRecipientName() == null ? "-" : address.getRecipientName()) %></div>
                            <div class="text-muted mb-2"><%= (address.getPhone() == null ? "-" : address.getPhone()) %></div>
                            <div>
                                <%= address.getDetailAddress() %>,
                                <%= address.getWard() %>,
                                <%= address.getDistrict() %>,
                                <%= address.getProvince() %>
                            </div>
                        <% } %>
                    </div>
                </div>
            </div>

            <!-- Payment -->
            <div class="col-12">
                <div class="card shadow-sm">
                    <div class="card-body">
                        <h6 class="mb-3">Payment</h6>

                        <% if (payment == null) { %>
                            <div class="text-muted">No payment record.</div>
                        <% } else { %>
                            <div class="row">
                                <div class="col-md-4 mb-2"><b>Method:</b> <%= payMethodStr %></div>
                                <div class="col-md-4 mb-2"><b>Status:</b> <%= payStatusStr %></div>
                                <div class="col-md-4 mb-2"><b>Amount:</b> <%= (payment.getAmount() == null ? "0" : payment.getAmount().toPlainString()) %></div>
                            </div>
                            <div class="row">
                                <div class="col-md-4 mb-2"><b>Transaction Code:</b> <%= (payment.getTransactionCode() == null ? "-" : payment.getTransactionCode()) %></div>
                                <div class="col-md-4 mb-2"><b>Paid At:</b> <%= (payment.getPaidAt() == null ? "-" : payment.getPaidAt().format(fmt)) %></div>
                                <div class="col-md-4 mb-2"><b>Created At:</b> <%= (payment.getCreatedAt() == null ? "-" : payment.getCreatedAt().format(fmt)) %></div>
                            </div>
                        <% } %>
                    </div>
                </div>
            </div>

            <!-- Items -->
            <div class="col-12">
                <div class="card shadow-sm">
                    <div class="card-body">
                        <h6 class="mb-3">Items</h6>

                        <% if (details.isEmpty()) { %>
                            <div class="text-muted">No items.</div>
                        <% } else { %>
                            <div class="table-responsive">
                                <table class="table align-middle">
                                    <thead class="table-light">
                                        <tr>
                                            <th style="width: 160px;">Variant ID</th>
                                            <th style="width: 160px;">Unit Price</th>
                                            <th style="width: 120px;">Quantity</th>
                                            <th style="width: 180px;">Subtotal</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <%
                                            BigDecimal sum = BigDecimal.ZERO;

                                            for (OrderDetail item : details) {
                                                BigDecimal price = (item.getUnitPrice() == null) ? BigDecimal.ZERO : item.getUnitPrice();
                                                int qty = (item.getQuantity() == null) ? 0 : item.getQuantity();
                                                BigDecimal sub = price.multiply(BigDecimal.valueOf(qty));
                                                sum = sum.add(sub);
                                        %>
                                        <tr>
                                            <td><%= item.getProductVariantID() %></td>
                                            <td><%= (item.getUnitPrice() == null ? "0" : item.getUnitPrice().toPlainString()) %></td>
                                            <td><%= (item.getQuantity() == null ? 0 : item.getQuantity()) %></td>
                                            <td><%= sub.toPlainString() %></td>
                                        </tr>
                                        <% } %>
                                    </tbody>
                                </table>
                            </div>

                            <div class="d-flex justify-content-end">
                                <div style="min-width: 320px;">
                                    <div class="d-flex justify-content-between">
                                        <span class="text-muted">Items Total</span>
                                        <b><%= sum.toPlainString() %></b>
                                    </div>
                                    <div class="d-flex justify-content-between mt-1">
                                        <span class="text-muted">Order Total</span>
                                        <b><%= (order.getTotalAmount() == null ? "0" : order.getTotalAmount().toPlainString()) %></b>
                                    </div>
                                </div>
                            </div>
                        <% } %>

                    </div>
                </div>
            </div>
        </div>

    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
