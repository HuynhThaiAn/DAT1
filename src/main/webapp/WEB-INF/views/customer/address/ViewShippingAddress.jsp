<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.util.*"%>
<%@page import="model.Customer"%>
<%@page import="model.Address"%>

<%
    // ===== CHECK LOGIN (BẮT BUỘC) =====
    Customer customer = (Customer) session.getAttribute("customer");
    if (customer == null) {
        response.sendRedirect(request.getContextPath() + "/Login");
        return;
    }

    List<Address> addresses = (List<Address>) request.getAttribute("addresses");
    if (addresses == null) addresses = new ArrayList<>();

    String msg = (String) request.getAttribute("msg");
    String err = (String) request.getAttribute("err");
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>My Shipping Addresses</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>

<jsp:include page="/WEB-INF/views/customer/homePage/header.jsp" />

<div class="container py-4">

    <div class="d-flex align-items-center justify-content-between mb-3">
        <div>
            <h4 class="mb-0">Shipping Addresses</h4>
            <div class="text-muted">Manage your delivery addresses</div>
        </div>
        <div class="d-flex gap-2">
            <a class="btn btn-outline-secondary" href="<%=request.getContextPath()%>/Profile?action=view">Back Profile</a>
            <a class="btn btn-primary" href="<%=request.getContextPath()%>/Address?action=addForm">+ Add Address</a>
        </div>
    </div>

    <% if (msg != null && !msg.trim().isEmpty()) { %>
        <div class="alert alert-success"><%= msg %></div>
    <% } %>
    <% if (err != null && !err.trim().isEmpty()) { %>
        <div class="alert alert-danger"><%= err %></div>
    <% } %>

    <% if (addresses.isEmpty()) { %>
        <div class="alert alert-info">You don't have any active address yet.</div>
    <% } else { %>
        <div class="row g-3">
            <%
                for (Address a : addresses) {
                    boolean isDefault = (a.getIsDefault() != null && a.getIsDefault());
            %>
            <div class="col-md-6 col-lg-4">
                <div class="card shadow-sm h-100">
                    <div class="card-body">
                        <div class="d-flex justify-content-between align-items-start">
                            <div>
                                <div class="fw-semibold">
                                    <%= (a.getRecipientName() == null ? "-" : a.getRecipientName()) %>
                                </div>
                                <div class="text-muted small">
                                    <%= (a.getPhone() == null ? "-" : a.getPhone()) %>
                                </div>
                            </div>

                            <% if (isDefault) { %>
                                <span class="badge text-bg-success">Default</span>
                            <% } else { %>
                                <span class="badge text-bg-secondary">Normal</span>
                            <% } %>
                        </div>

                        <hr/>

                        <div class="small">
                            <%= (a.getDetailAddress() == null ? "-" : a.getDetailAddress()) %><br/>
                            <%= (a.getWard() == null ? "" : a.getWard()) %>
                            <%= (a.getDistrict() == null ? "" : (", " + a.getDistrict())) %>
                            <%= (a.getProvince() == null ? "" : (", " + a.getProvince())) %>
                        </div>

                        <div class="d-flex gap-2 mt-3">
                            <a class="btn btn-sm btn-outline-primary"
                               href="<%=request.getContextPath()%>/Address?action=editForm&addressId=<%= a.getAddressID() %>">
                                Edit
                            </a>

                            <% if (!isDefault) { %>
                                <a class="btn btn-sm btn-outline-success"
                                   href="<%=request.getContextPath()%>/Address?action=setDefault&addressId=<%= a.getAddressID() %>">
                                    Set Default
                                </a>
                            <% } %>

                            <a class="btn btn-sm btn-outline-danger ms-auto"
                               href="<%=request.getContextPath()%>/Address?action=delete&addressId=<%= a.getAddressID() %>"
                               onclick="return confirm('Delete this address?');">
                                Delete
                            </a>
                        </div>

                    </div>
                </div>
            </div>
            <% } %>
        </div>
    <% } %>

</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
