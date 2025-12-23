<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="model.Customer"%>

<%
    // ===== CHECK LOGIN =====
    Customer customer = (Customer) session.getAttribute("customer");
    if (customer == null) {
        response.sendRedirect(request.getContextPath() + "/Login");
        return;
    }

    String error = (String) request.getAttribute("error");
    String success = (String) request.getAttribute("success");
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Change Password</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/Css/profile.css">
</head>

<body>
    <jsp:include page="/WEB-INF/views/customer/homePage/header.jsp" />

    <div class="container py-4">
        <div class="row justify-content-center">
            <div class="col-lg-6">
                <div class="card shadow-sm">
                    <div class="card-body">
                        <h5 class="mb-3">Change Password</h5>

                        <% if (error != null) { %>
                            <div class="alert alert-danger"><%= error %></div>
                        <% } %>
                        <% if (success != null) { %>
                            <div class="alert alert-success"><%= success %></div>
                        <% } %>

                        <form method="post" action="<%=request.getContextPath()%>/Profile?action=changePassword" id="changePasswordForm">
                            <div class="mb-3">
                                <label class="form-label">Current Password</label>
                                <input type="password" class="form-control" name="currentPassword" required>
                            </div>

                            <div class="mb-3">
                                <label class="form-label">New Password</label>
                                <input type="password" class="form-control" name="newPassword" id="newPassword" required>
                            </div>

                            <div class="mb-3">
                                <label class="form-label">Confirm New Password</label>
                                <input type="password" class="form-control" name="confirmPassword" id="confirmPassword" required>
                                <div class="small text-muted mt-1" id="pwHint"></div>
                            </div>

                            <div class="d-flex justify-content-end gap-2">
                                <a class="btn btn-light" href="<%=request.getContextPath()%>/Profile?action=view">Cancel</a>
                                <button class="btn btn-primary" type="submit">Update</button>
                            </div>
                        </form>

                    </div>
                </div>
            </div>
        </div>
    </div>

    <script>
        const newPw = document.getElementById("newPassword");
        const cfPw = document.getElementById("confirmPassword");
        const hint = document.getElementById("pwHint");
        function validate() {
            if (!newPw.value || !cfPw.value) { hint.textContent = ""; return; }
            hint.textContent = (newPw.value === cfPw.value) ? "Passwords match" : "Passwords do not match";
        }
        newPw.addEventListener("input", validate);
        cfPw.addEventListener("input", validate);
    </script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
