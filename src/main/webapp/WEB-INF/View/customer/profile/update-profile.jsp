<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="model.Customer"%>
<%@page import="model.Account"%>
<%@page import="model.Staff"%>

<%
    Customer cus = (Customer) request.getAttribute("cus");
    Integer accountId = (Integer) session.getAttribute("accountId");
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Update Profile</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/Css/profile.css">
</head>
<body>
    <jsp:include page="/WEB-INF/View/customer/homePage/header.jsp" />

    <div class="main-account container-fluid">

        <!-- Sidebar -->
        <jsp:include page="/WEB-INF/View/customer/sideBar.jsp" />
        
        <!-- Profile Editor -->
        <div class="profile-card">
            <div class="profile-header">
                <h4 class="mb-0 d-flex align-items-center gap-2">
                    <i class="bi bi-pencil-square"></i>
                    Update Profile
                </h4>
            </div>

            <div class="profile-body">
                <% if (cus == null) { %>
                    <div class="alert alert-danger">
                        <i class="bi bi-exclamation-triangle-fill me-2"></i>
                        Customer information not found.
                    </div>
                <% } else { %>
                <form method="post" action="UpdateProfile">
                    <input type="hidden" name="id" value="<%= cus.getId() %>">

                    <!-- Full Name -->
                    <div class="form-group">
                        <label class="form-label">
                            <i class="bi bi-person profile-icon"></i>
                            Full Name
                        </label>
                        <input type="text" name="fullname"
                               value="<%= cus.getFullName() != null ? cus.getFullName() : "" %>"
                               class="form-control"
                               placeholder="Enter your full name"
                               required>
                    </div>

                    <!-- Phone -->
                    <div class="form-group">
                        <label class="form-label">
                            <i class="bi bi-telephone profile-icon"></i>
                            Phone Number
                        </label>
                        <input type="tel" name="phone"
                               value="<%= cus.getPhone() != null ? cus.getPhone() : "" %>"
                               class="form-control"
                               pattern="[0-9]{10,11}"
                               placeholder="Enter phone number (10–11 digits)"
                               title="Phone number must contain 10–11 digits.">
                    </div>

                    <!-- Date of Birth -->
                    <div class="form-group">
                        <label class="form-label">
                            <i class="bi bi-calendar profile-icon"></i>
                            Date of Birth
                        </label>
                        <input type="date" name="dob"
                               value="<%= cus.getBirthDay() != null ? cus.getBirthDay() : "" %>"
                               class="form-control"
                               max="<%= new java.text.SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date()) %>">
                    </div>

                    <!-- Gender -->
                    <div class="form-group">
                        <label class="form-label">
                            <i class="bi bi-gender-ambiguous profile-icon"></i>
                            Gender
                        </label>
                        <div class="gender-options">
                            <label class="gender-option">
                                <input type="radio" class="form-check-input" name="gender" value="male"
                                       <%= "male".equalsIgnoreCase(cus.getGender()) ? "checked" : "" %>>
                                Male
                            </label>

                            <label class="gender-option">
                                <input type="radio" class="form-check-input" name="gender" value="female"
                                       <%= "female".equalsIgnoreCase(cus.getGender()) ? "checked" : "" %>>
                                Female
                            </label>
                        </div>
                    </div>

                    <!-- Actions -->
                    <div class="profile-actions">
                        <a href="ViewProfile" class="btn-cancel">
                            <i class="bi bi-x-circle me-1"></i> Back
                        </a>
                        <button type="submit" class="btn-update">
                            <i class="bi bi-check-circle me-1"></i> Save Changes
                        </button>
                    </div>
                </form>
                <% } %>
            </div>
        </div>
    </div>

    <jsp:include page="/WEB-INF/View/customer/homePage/footer.jsp" />
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
