<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="model.Customer"%>
<%@page import="model.Address"%>

<%
    // ===== CHECK LOGIN (BẮT BUỘC) =====
    Customer customer = (Customer) session.getAttribute("customer");
    if (customer == null) {
        response.sendRedirect(request.getContextPath() + "/Login");
        return;
    }

    Address address = (Address) request.getAttribute("address");
    if (address == null) {
        response.sendRedirect(request.getContextPath() + "/Address?action=list");
        return;
    }

    String err = (String) request.getAttribute("err");
    boolean isDefault = (address.getIsDefault() != null && address.getIsDefault());
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Update Shipping Address</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>

<jsp:include page="/WEB-INF/views/customer/homePage/header.jsp" />

<div class="container py-4" style="max-width: 720px;">
    <div class="d-flex align-items-center justify-content-between mb-3">
        <h4 class="mb-0">Update Address</h4>
        <a class="btn btn-outline-secondary" href="<%=request.getContextPath()%>/Address?action=list">Back</a>
    </div>

    <% if (err != null && !err.trim().isEmpty()) { %>
        <div class="alert alert-danger"><%= err %></div>
    <% } %>

    <form method="post" action="<%=request.getContextPath()%>/Address?action=update">
        <!-- BẮT BUỘC: hidden addressId -->
        <input type="hidden" name="addressId" value="<%= address.getAddressID() %>">

        <div class="card shadow-sm">
            <div class="card-body">
                <div class="row g-3">
                    <div class="col-md-6">
                        <label class="form-label">Recipient Name</label>
                        <input class="form-control" name="recipientName" required
                               value="<%= (address.getRecipientName() == null ? "" : address.getRecipientName()) %>">
                    </div>
                    <div class="col-md-6">
                        <label class="form-label">Phone</label>
                        <input class="form-control" name="phone" required
                               value="<%= (address.getPhone() == null ? "" : address.getPhone()) %>">
                    </div>

                    <div class="col-md-4">
                        <label class="form-label">Province</label>
                        <input class="form-control" name="province" required
                               value="<%= (address.getProvince() == null ? "" : address.getProvince()) %>">
                    </div>
                    <div class="col-md-4">
                        <label class="form-label">District</label>
                        <input class="form-control" name="district" required
                               value="<%= (address.getDistrict() == null ? "" : address.getDistrict()) %>">
                    </div>
                    <div class="col-md-4">
                        <label class="form-label">Ward</label>
                        <input class="form-control" name="ward" required
                               value="<%= (address.getWard() == null ? "" : address.getWard()) %>">
                    </div>

                    <div class="col-12">
                        <label class="form-label">Detail Address</label>
                        <input class="form-control" name="detailAddress" required
                               value="<%= (address.getDetailAddress() == null ? "" : address.getDetailAddress()) %>">
                    </div>

                    <div class="col-12">
                        <div class="form-check">
                            <input class="form-check-input" type="checkbox" id="isDefault" name="isDefault"
                                   <%= isDefault ? "checked" : "" %> >
                            <label class="form-check-label" for="isDefault">
                                Set as default address
                            </label>
                        </div>
                    </div>
                </div>

                <div class="d-flex justify-content-end gap-2 mt-4">
                    <a class="btn btn-outline-secondary" href="<%=request.getContextPath()%>/Address?action=list">Cancel</a>
                    <button class="btn btn-primary" type="submit">Update</button>
                </div>

            </div>
        </div>
    </form>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
