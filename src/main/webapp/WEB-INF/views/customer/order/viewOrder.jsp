<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.util.*"%>
<%@page import="java.time.format.DateTimeFormatter"%>
<%@page import="model.Customer"%>
<%@page import="model.Order"%>

<%
    // ===== CHECK LOGIN (BẮT BUỘC) =====
    Customer customer = (Customer) session.getAttribute("customer");
    if (customer == null) {
        response.sendRedirect(request.getContextPath() + "/Login");
        return;
    }

    List<Order> orders = (List<Order>) request.getAttribute("orders");
    if (orders == null) orders = new ArrayList<>();

    DateTimeFormatter fmt = DateTimeFormatter.ofPattern("dd/MM/yyyy HH:mm");
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>My Orders</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>

    <jsp:include page="/WEB-INF/views/customer/homePage/header.jsp" />

    <div class="container py-4">
        <div class="d-flex align-items-center justify-content-between mb-3">
            <h4 class="mb-0">Order History</h4>
            <a class="btn btn-outline-secondary" href="<%=request.getContextPath()%>/Home">Back to Home</a>
        </div>

        <% if (orders.isEmpty()) { %>
            <div class="alert alert-info">You have no orders yet.</div>
        <% } else { %>
            <div class="table-responsive">
                <table class="table table-hover align-middle">
                    <thead class="table-light">
                        <tr>
                            <th style="width: 120px;">Order ID</th>
                            <th style="width: 200px;">Ordered At</th>
                            <th>Receiver</th>
                            <th style="width: 150px;">Total</th>
                            <th style="width: 140px;">Status</th>
                            <th style="width: 140px;" class="text-end">Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            for (Order o : orders) {
                                int st = (o.getStatus() == null) ? -1 : o.getStatus();
                                String statusStr;
                                switch (st) {
                                    case 0: statusStr = "Pending"; break;
                                    case 1: statusStr = "Paid"; break;
                                    case 2: statusStr = "Shipped"; break;
                                    case 3: statusStr = "Delivered"; break;
                                    case 4: statusStr = "Cancelled"; break;
                                    default: statusStr = "Unknown"; break;
                                }
                        %>
                        <tr>
                            <td>#<%= o.getOrderID() %></td>

                            <td>
                                <%= (o.getOrderedAt() == null) ? "-" : o.getOrderedAt().format(fmt) %>
                            </td>

                            <td>
                                <div class="fw-semibold"><%= (o.getReceiverName() == null ? "-" : o.getReceiverName()) %></div>
                                <div class="text-muted small"><%= (o.getPhone() == null ? "" : o.getPhone()) %></div>
                            </td>

                            <td>
                                <%= (o.getTotalAmount() == null) ? "0" : o.getTotalAmount().toPlainString() %>
                            </td>

                            <td>
                                <span class="badge text-bg-secondary"><%= statusStr %></span>
                            </td>

                            <td class="text-end">
                                <a class="btn btn-sm btn-outline-primary"
                                   href="<%=request.getContextPath()%>/Order?action=detail&orderId=<%= o.getOrderID() %>">
                                    View Detail
                                </a>
                            </td>
                        </tr>
                        <% } %>
                    </tbody>
                </table>
            </div>
        <% } %>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
