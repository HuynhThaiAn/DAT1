<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="model.Customer"%>
<%@page import="model.Address"%>
<%@page import="java.time.format.DateTimeFormatter"%>

<%
    // ===== CHECK LOGIN (BẮT BUỘC) =====
    Customer customer = (Customer) session.getAttribute("customer");
    if (customer == null) {
        response.sendRedirect(request.getContextPath() + "/Login");
        return;
    }

    Address defaultAddress = (Address) request.getAttribute("defaultAddress");

    String dobText = "Chưa cập nhật";
    if (customer.getDateOfBirth() != null) {
        dobText = customer.getDateOfBirth().format(DateTimeFormatter.ofPattern("dd/MM/yyyy"));
    }

    String genderText = "Unknown";
    if (customer.getGender() != null) {
        switch (customer.getGender()) {
            case 1: genderText = "Male"; break;
            case 2: genderText = "Female"; break;
            case 3: genderText = "Other"; break;
            default: genderText = "Unknown"; break;
        }
    }
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Profile - DATShop</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/Css/profile.css">
</head>
<body>
    <jsp:include page="/WEB-INF/views/customer/homePage/header.jsp" />

    <div class="container py-4">
        <div class="row justify-content-center">
            <div class="col-lg-9">

                <div class="card shadow-sm">
                    <div class="card-body">

                        <div class="d-flex align-items-center gap-3 mb-3">
                            <div class="rounded-circle bg-light d-flex align-items-center justify-content-center" style="width:64px;height:64px;">
                                <i class="bi bi-person-fill fs-2"></i>
                            </div>
                            <div>
                                <h5 class="mb-1"><%= customer.getFullName() %></h5>
                                <div class="text-muted">
                                    <i class="bi bi-envelope me-1"></i><%= customer.getEmail() %>
                                    <% if (customer.getPhone() != null && !customer.getPhone().isEmpty()) { %>
                                        <span class="mx-2">•</span>
                                        <i class="bi bi-telephone me-1"></i><%= customer.getPhone() %>
                                    <% } %>
                                </div>
                            </div>
                            <div class="ms-auto d-flex gap-2">
                                <a class="btn btn-outline-primary" href="<%=request.getContextPath()%>/Profile?action=edit">
                                    <i class="bi bi-pencil-square me-1"></i>Update Profile
                                </a>
                                <a class="btn btn-outline-secondary" href="<%=request.getContextPath()%>/Profile?action=changePasswordForm">
                                    <i class="bi bi-shield-lock me-1"></i>Change Password
                                </a>
                            </div>
                        </div>

                        <hr/>

                        <table class="table table-borderless mb-0">
                            <tr>
                                <th style="width: 220px;">Customer ID</th>
                                <td>#<%= customer.getCustomerID() %></td>
                            </tr>
                            <tr>
                                <th>Full Name</th>
                                <td><%= customer.getFullName() %></td>
                            </tr>
                            <tr>
                                <th>Email</th>
                                <td><%= customer.getEmail() %></td>
                            </tr>
                            <tr>
                                <th>Phone</th>
                                <td><%= (customer.getPhone() == null || customer.getPhone().isEmpty()) ? "Chưa cập nhật" : customer.getPhone() %></td>
                            </tr>
                            <tr>
                                <th>Date of Birth</th>
                                <td><%= dobText %></td>
                            </tr>
                            <tr>
                                <th>Gender</th>
                                <td><%= genderText %></td>
                            </tr>
                        </table>

                        <% if (defaultAddress != null) { %>
                            <hr/>
                            <h6 class="mb-2">Default Address</h6>
                            <div class="text-muted">
                                <div><b><%= defaultAddress.getRecipientName() %></b> - <%= defaultAddress.getPhone() %></div>
                                <div>
                                    <%= defaultAddress.getDetailAddress() %>,
                                    <%= defaultAddress.getWard() %>,
                                    <%= defaultAddress.getDistrict() %>,
                                    <%= defaultAddress.getProvince() %>
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
