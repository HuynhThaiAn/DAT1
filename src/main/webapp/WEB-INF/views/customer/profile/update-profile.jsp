<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="model.Customer"%>

<%
    // ===== CHECK LOGIN =====
    Customer customer = (Customer) session.getAttribute("customer");
    if (customer == null) {
        response.sendRedirect(request.getContextPath() + "/Login");
        return;
    }

    // nếu servlet set cus/customer để edit thì ưu tiên lấy request
    Customer cus = (Customer) request.getAttribute("cus");
    if (cus == null) cus = (Customer) request.getAttribute("customer");
    if (cus == null) cus = customer;

    String dobVal = "";
    if (cus.getDateOfBirth() != null) {
        dobVal = cus.getDateOfBirth().toString(); // yyyy-MM-dd cho input type=date
    }

    String error = (String) request.getAttribute("error");
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Update Profile</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/Css/profile.css">
</head>

<body>
    <jsp:include page="/WEB-INF/views/customer/homePage/header.jsp" />

    <div class="container py-4">
        <div class="row justify-content-center">
            <div class="col-lg-7">
                <div class="card shadow-sm">
                    <div class="card-body">
                        <h5 class="mb-3">Update Profile</h5>

                        <% if (error != null) { %>
                            <div class="alert alert-danger"><%= error %></div>
                        <% } %>

                        <form method="post" action="<%=request.getContextPath()%>/Profile?action=update">
                            <input type="hidden" name="customerId" value="<%= cus.getCustomerID() %>"/>

                            <div class="mb-3">
                                <label class="form-label">Full Name</label>
                                <input type="text" class="form-control" name="fullName"
                                       value="<%= cus.getFullName() %>" required>
                            </div>

                            <div class="mb-3">
                                <label class="form-label">Phone</label>
                                <input type="text" class="form-control" name="phone"
                                       value="<%= (cus.getPhone() == null ? "" : cus.getPhone()) %>">
                            </div>

                            <div class="mb-3">
                                <label class="form-label">Date of Birth</label>
                                <input type="date" class="form-control" name="dateOfBirth" value="<%= dobVal %>">
                            </div>

                            <div class="mb-3">
                                <label class="form-label">Gender</label>
                                <select class="form-select" name="gender">
                                    <%
                                        Integer g = cus.getGender();
                                        int gv = (g == null) ? 0 : g;
                                    %>
                                    <option value="0" <%= (gv==0?"selected":"") %>>Unknown</option>
                                    <option value="1" <%= (gv==1?"selected":"") %>>Male</option>
                                    <option value="2" <%= (gv==2?"selected":"") %>>Female</option>
                                    <option value="3" <%= (gv==3?"selected":"") %>>Other</option>
                                </select>
                            </div>

                            <div class="d-flex justify-content-end gap-2">
                                <a class="btn btn-light" href="<%=request.getContextPath()%>/Profile?action=view">Cancel</a>
                                <button class="btn btn-primary" type="submit">Save</button>
                            </div>
                        </form>

                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
