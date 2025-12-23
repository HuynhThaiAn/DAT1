<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.*"%>
<%@page import="java.math.BigDecimal"%>
<%@page import="model.Customer"%>
<%@page import="model.CartViewItem"%>

<%
    // ====== CHECK LOGIN (theo yêu cầu của bạn) ======
    Customer customer = (Customer) session.getAttribute("customer");
    if (customer == null) {
        response.sendRedirect(request.getContextPath() + "/Login");
        return;
    }

    List<CartViewItem> cartItems = (List<CartViewItem>) request.getAttribute("cartItems");
    BigDecimal cartTotal = (BigDecimal) request.getAttribute("cartTotal");
    if (cartItems == null) cartItems = new ArrayList<>();
    if (cartTotal == null) cartTotal = BigDecimal.ZERO;
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>My Cart</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>

<div class="container py-4">
    <div class="row">
        <!-- Sidebar (nếu bạn muốn dùng chung sidebar customer) -->
        

        <div class="col-lg-9">
            <div class="d-flex justify-content-between align-items-center mb-3">
                <h3 class="mb-0">Giỏ hàng</h3>
                <a class="btn btn-outline-secondary" href="<%=request.getContextPath()%>/Home">Tiếp tục mua</a>
            </div>

            <% if (cartItems.isEmpty()) { %>
                <div class="alert alert-info">
                    Giỏ hàng đang trống.
                </div>
            <% } else { %>

            <div class="table-responsive">
                <table class="table table-bordered align-middle">
                    <thead class="table-light">
                    <tr>
                        <th>Sản phẩm</th>
                        <th>Variant</th>
                        <th class="text-end">Đơn giá</th>
                        <th style="width: 160px;">Số lượng</th>
                        <th class="text-end">Thành tiền</th>
                        <th style="width: 90px;" class="text-center">Xoá</th>
                    </tr>
                    </thead>
                    <tbody>
                    <%
                        for (CartViewItem item : cartItems) {
                            BigDecimal price = item.getPrice() == null ? BigDecimal.ZERO : item.getPrice();
                            int qty = item.getQuantity() == null ? 0 : item.getQuantity();
                            BigDecimal subTotal = price.multiply(BigDecimal.valueOf(qty));
                    %>
                    <tr>
                        <td>
                            <div class="fw-semibold"><%= item.getProductName() %></div>
                            <div class="text-muted small">ProductID: <%= item.getProductID() %></div>
                        </td>
                        <td>
                            <div><%= item.getVariantName() %></div>
                            <div class="text-muted small">SKU: <%= item.getSKU() %></div>
                            <div class="text-muted small">Stock: <%= item.getStockQuantity() %></div>
                        </td>
                        <td class="text-end"><%= price %></td>

                        <td>
                            <!-- Update qty -->
                            <form class="d-flex gap-2" method="post"
                                  action="<%=request.getContextPath()%>/Cart?action=update">
                                <input type="hidden" name="variantId" value="<%= item.getProductVariantID() %>">

                                <input type="number"
                                       class="form-control"
                                       name="qty"
                                       min="0"
                                       max="<%= item.getStockQuantity() %>"
                                       value="<%= qty %>">

                                <button type="submit" class="btn btn-primary btn-sm">Update</button>
                            </form>
                            <div class="text-muted small mt-1">* nhập 0 để xoá</div>
                        </td>

                        <td class="text-end"><%= subTotal %></td>

                        <td class="text-center">
                            <a class="btn btn-sm btn-danger"
                               href="<%=request.getContextPath()%>/Cart?action=remove&variantId=<%= item.getProductVariantID() %>"
                               onclick="return confirm('Xoá item này khỏi giỏ hàng?');">
                                Xoá
                            </a>
                        </td>
                    </tr>
                    <% } %>
                    </tbody>
                </table>
            </div>

            <div class="d-flex justify-content-end">
                <div class="card" style="min-width: 320px;">
                    <div class="card-body">
                        <div class="d-flex justify-content-between mb-2">
                            <span class="fw-semibold">Tổng cộng</span>
                            <span class="fw-semibold"><%= cartTotal %></span>
                        </div>
                        <a class="btn btn-success w-100"
                           href="<%=request.getContextPath()%>/Checkout">
                            Checkout
                        </a>
                    </div>
                </div>
            </div>

            <% } %>
        </div>
    </div>
</div>

</body>
</html>
