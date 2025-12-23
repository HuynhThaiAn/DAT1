<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.*"%>
<%@page import="java.math.BigDecimal"%>
<%@page import="model.Customer"%>
<%@page import="model.Address"%>
<%@page import="model.CartViewItem"%>

<%
    // ===== CHECK LOGIN (theo yêu cầu bạn) =====
    Customer customer = (Customer) session.getAttribute("customer");
    if (customer == null) {
        response.sendRedirect(request.getContextPath() + "/Login");
        return;
    }

    List<CartViewItem> cartItems = (List<CartViewItem>) request.getAttribute("cartItems");
    BigDecimal cartTotal = (BigDecimal) request.getAttribute("cartTotal");
    List<Address> addresses = (List<Address>) request.getAttribute("addresses");

    if (cartItems == null) cartItems = new ArrayList<>();
    if (cartTotal == null) cartTotal = BigDecimal.ZERO;
    if (addresses == null) addresses = new ArrayList<>();

    String error = (String) request.getAttribute("error");
%>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Checkout</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    </head>
    <body>

        <div class="container py-4">
            <div class="row">


                <div class="col-lg-9">
                    <div class="d-flex justify-content-between align-items-center mb-3">
                        <h3 class="mb-0">Checkout</h3>
                        <a class="btn btn-outline-secondary" href="<%=request.getContextPath()%>/Cart?action=view">Back to Cart</a>
                    </div>

                    <% if (error != null) { %>
                    <div class="alert alert-danger"><%= error %></div>
                    <% } %>

                    <% if (cartItems.isEmpty()) { %>
                    <div class="alert alert-info">
                        Giỏ hàng trống. Vui lòng thêm sản phẩm trước khi checkout.
                    </div>
                    <% } else { %>

                    <form method="post" action="<%=request.getContextPath()%>/Checkout?action=placeOrder">                        <div class="card mb-3">
                            <div class="card-header fw-semibold">Địa chỉ giao hàng</div>
                            <div class="card-body">

                                <% if (addresses.isEmpty()) { %>
                                <div class="alert alert-warning mb-0">
                                    Bạn chưa có địa chỉ. Hãy tạo địa chỉ trước khi đặt hàng.
                                </div>
                                <% } else { %>
                                <div class="list-group">
                                    <%
                                        for (int i = 0; i < addresses.size(); i++) {
                                            Address a = addresses.get(i);
                                            boolean checked = (i == 0) || a.getIsDefault();
                                    %>
                                    <label class="list-group-item d-flex gap-2 align-items-start">
                                        <input class="form-check-input mt-1" type="radio"
                                        name="addressId"
                                        value="<%= a.getAddressID() %>"
                                        <%= a.getIsDefault() ? "checked" : "" %>>

                                        <div>
                                            <div class="fw-semibold">
                                                <%= a.getRecipientName() %> - <%= a.getPhone() %>
                                            </div>
                                            <div class="text-muted small">
                                                <%= a.getDetailAddress() %>,
                                                <%= a.getWard() %>,
                                                <%= a.getDistrict() %>,
                                                <%= a.getProvince() %>
                                                <%= a.getIsDefault() ? "(Default)" : "" %>
                                            </div>
                                        </div>
                                    </label>

                                    <% } %>
                                </div>
                                <% } %>

                            </div>
                        </div>

                        <div class="card mb-3">
                            <div class="card-header fw-semibold">Thông tin người nhận</div>
                            <div class="card-body">
                                <div class="row g-3">
                                    <div class="col-md-6">
                                        <label class="form-label">Receiver Name</label>
                                        <input type="text" name="receiverName" class="form-control" required>
                                    </div>
                                    <div class="col-md-6">
                                        <label class="form-label">Phone</label>
                                        <input type="text" name="phone" class="form-control" required>
                                    </div>
                                    <div class="col-12">
                                        <label class="form-label">Note (optional)</label>
                                        <textarea name="note" class="form-control" rows="2"></textarea>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="card mb-3">
                            <div class="card-header fw-semibold">Order Summary</div>
                            <div class="card-body">
                                <div class="table-responsive">
                                    <table class="table table-bordered align-middle">
                                        <thead class="table-light">
                                            <tr>
                                                <th>Sản phẩm</th>
                                                <th>Variant</th>
                                                <th class="text-end">Đơn giá</th>
                                                <th class="text-end">Qty</th>
                                                <th class="text-end">Thành tiền</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <%
                                                for (CartViewItem item : cartItems) {
                                                    BigDecimal price = item.getPrice() == null ? BigDecimal.ZERO : item.getPrice();
                                                    int qty = item.getQuantity() == null ? 0 : item.getQuantity();
                                                    BigDecimal sub = price.multiply(BigDecimal.valueOf(qty));
                                            %>
                                            <tr>
                                                <td><%= item.getProductName() %></td>
                                                <td><%= item.getVariantName() %> (<%= item.getSKU() %>)</td>
                                                <td class="text-end"><%= price %></td>
                                                <td class="text-end"><%= qty %></td>
                                                <td class="text-end"><%= sub %></td>
                                            </tr>
                                            <% } %>
                                        </tbody>
                                    </table>
                                </div>

                                <div class="d-flex justify-content-end">
                                    <div class="fw-semibold fs-5">
                                        Total: <%= cartTotal %>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="card mb-3">
                            <div class="card-header fw-semibold">Phương thức thanh toán</div>
                            <div class="card-body">

                                <div class="form-check">
                                    <input class="form-check-input" type="radio" name="paymentMethod" value="1" checked>
                                    <label class="form-check-label">COD (Thanh toán khi nhận hàng)</label>
                                </div>

                                <div class="form-check">
                                    <input class="form-check-input" type="radio" name="paymentMethod" value="2">
                                    <label class="form-check-label">Chuyển khoản ngân hàng</label>
                                </div>

                                <div class="form-check">
                                    <input class="form-check-input" type="radio" name="paymentMethod" value="3">
                                    <label class="form-check-label">Thanh toán online</label>
                                </div>

                            </div>
                        </div>


                        <div class="d-flex gap-2 justify-content-end">
                            <a class="btn btn-outline-secondary" href="<%=request.getContextPath()%>/Cart?action=view">Back</a>
                            <button type="submit" class="btn btn-success"
                                    <%= addresses.isEmpty() ? "disabled" : "" %>>
                                Place Order
                            </button>
                        </div>
                    </form>

                    <% } %>
                </div>
            </div>
        </div>

    </body>
</html>
