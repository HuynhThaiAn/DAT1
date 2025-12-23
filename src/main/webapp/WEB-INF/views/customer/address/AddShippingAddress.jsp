<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="model.Customer"%>

<%
    // ===== CHECK LOGIN (BẮT BUỘC) =====
    Customer customer = (Customer) session.getAttribute("customer");
    if (customer == null) {
        response.sendRedirect(request.getContextPath() + "/Login");
        return;
    }

    String err = (String) request.getAttribute("err");

    // fail-safe giữ lại input khi forward lại
    String recipientName = request.getParameter("recipientName");
    String phone = request.getParameter("phone");
    String province = request.getParameter("province");
    String district = request.getParameter("district");
    String ward = request.getParameter("ward");
    String detailAddress = request.getParameter("detailAddress");
    boolean isDefault = (request.getParameter("isDefault") != null);
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Add Shipping Address</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>

<jsp:include page="/WEB-INF/views/customer/homePage/header.jsp" />

<div class="container py-4" style="max-width: 720px;">
    <div class="d-flex align-items-center justify-content-between mb-3">
        <h4 class="mb-0">Add Address</h4>
        <a class="btn btn-outline-secondary" href="<%=request.getContextPath()%>/Address?action=list">Back</a>
    </div>

    <% if (err != null && !err.trim().isEmpty()) { %>
        <div class="alert alert-danger"><%= err %></div>
    <% } %>

    <form method="post" action="<%=request.getContextPath()%>/Address?action=add">
        <div class="card shadow-sm">
            <div class="card-body">
                <div class="row g-3">
                    <div class="col-md-6">
                        <label class="form-label">Recipient Name</label>
                        <input class="form-control" name="recipientName" required
                               value="<%= (recipientName == null ? "" : recipientName) %>">
                    </div>
                    <div class="col-md-6">
                        <label class="form-label">Phone</label>
                        <input class="form-control" name="phone" required
                               value="<%= (phone == null ? "" : phone) %>">
                    </div>

                    <div class="col-md-4">
                        <label class="form-label">Province</label>
                        <input class="form-control" name="province" required
                               value="<%= (province == null ? "" : province) %>">
                    </div>
                    <div class="col-md-4">
                        <label class="form-label">District</label>
                        <input class="form-control" name="district" required
                               value="<%= (district == null ? "" : district) %>">
                    </div>
                    <div class="col-md-4">
                        <label class="form-label">Ward</label>
                        <input class="form-control" name="ward" required
                               value="<%= (ward == null ? "" : ward) %>">
                    </div>

                    <div class="col-12">
                        <label class="form-label">Detail Address</label>
                        <input class="form-control" name="detailAddress" required
                               value="<%= (detailAddress == null ? "" : detailAddress) %>">
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
                    <button class="btn btn-primary" type="submit">Save</button>
                </div>

            </div>
        </div>
    </form>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
