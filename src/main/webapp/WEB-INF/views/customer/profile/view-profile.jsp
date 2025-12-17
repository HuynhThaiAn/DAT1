<%@page import="model.Account"%>
<%@page import="model.Customer"%>
<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
    // Get customer from request, fallback to session if not available
    Customer sta = (Customer) request.getAttribute("cus");
    if (sta == null) {
        sta = (Customer) session.getAttribute("customer");
    } else {
        session.setAttribute("customer", sta);
    }

    Account acc = (Account) session.getAttribute("user");
    boolean hasPassword = false;
    if (acc != null && acc.getPasswordHash() != null && !acc.getPasswordHash().isEmpty()) {
        hasPassword = true;
    }
%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Profile - DAT</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/Css/profile.css">
    </head>
    <body>
        <jsp:include page="/WEB-INF/View/customer/homePage/header.jsp" />

        <!-- MAIN WRAPPER -->
        <div class="main-account container">
            <!-- SIDEBAR -->
            <jsp:include page="/WEB-INF/View/customer/sideBar.jsp" />

            <!-- PROFILE CARD -->
            <div class="profile-card">
                <div class="profile-header">
                    <h4>
                        <i class="bi bi-person-circle"></i>
                        Personal Information
                    </h4>
                </div>

                <!-- Avatar Section -->
                <div class="profile-avatar-section">
                    <div class="profile-avatar-large">
                        <i class="bi bi-person-fill"></i>
                    </div>
                    <div class="profile-avatar-info">
                        <h5>
                            <%= (sta != null && sta.getFullName() != null && !sta.getFullName().isEmpty())
                                    ? sta.getFullName()
                                    : "Guest User" %>
                        </h5>
                        <% if (sta != null) { %>
                        <p>
                            <i class="bi bi-envelope me-1"></i>
                            <%= sta.getEmail() != null ? sta.getEmail() : "No email available" %>
                        </p>
                        <% if (sta.getPhone() != null && !sta.getPhone().isEmpty()) { %>
                        <p class="mt-1">
                            <i class="bi bi-telephone me-1"></i>
                            <%= sta.getPhone() %>
                        </p>
                        <% } %>
                        <% } %>
                    </div>
                </div>

                <!-- View Profile -->
                <form method="get" action="ViewProfile?action=list">
                    <div class="profile-body">
                        <table class="table profile-table mb-0">
                            <!-- Customer ID -->
                            <tr>
                                <th><i class="bi bi-hash profile-icon"></i> Customer ID:</th>
                                <td>
                                    <div class="profile-info-item">
                                        <i class="bi bi-hash"></i>
                                        <span class="profile-value">
                                            #<%= (sta != null && sta.getId() != 0) ? sta.getId() : 0 %>
                                        </span>
                                    </div>
                                </td>
                            </tr>

                            <!-- Full Name -->
                            <tr>
                                <th><i class="bi bi-person profile-icon"></i> Full Name:</th>
                                <td>
                                    <div class="profile-info-item">
                                        <i class="bi bi-person"></i>
                                        <span class="profile-value">
                                            <%= (sta != null && sta.getFullName() != null && !sta.getFullName().isEmpty())
                                                    ? sta.getFullName()
                                                    : "Not updated yet" %>
                                        </span>
                                    </div>
                                </td>
                            </tr>

                            <!-- Phone -->
                            <tr>
                                <th><i class="bi bi-telephone profile-icon"></i> Phone Number:</th>
                                <td>
                                    <%
                                        String phone = (sta != null) ? sta.getPhone() : null;
                                    %>
                                    <%= (phone == null || phone.isEmpty())
                                            ? "<span class='error-message'><i class=\"bi bi-exclamation-triangle\"></i>Please update your phone number</span>"
                                            : "<div class='profile-info-item'><i class=\"bi bi-telephone\"></i><span class='profile-value'>" + phone + "</span></div>" %>
                                </td>
                            </tr>

                            <!-- Email -->
                            <tr>
                                <th><i class="bi bi-envelope profile-icon"></i> Email:</th>
                                <td>
                                    <div class="profile-info-item">
                                        <i class="bi bi-envelope"></i>
                                        <span class="profile-value">
                                            <%= (sta != null && sta.getEmail() != null && !sta.getEmail().isEmpty())
                                                    ? sta.getEmail()
                                                    : "Not updated yet" %>
                                        </span>
                                    </div>
                                </td>
                            </tr>

                            <!-- Date of Birth -->
                            <tr>
                                <th><i class="bi bi-calendar profile-icon"></i> Date of Birth:</th>
                                <td>
                                    <%
                                        String birth = (sta != null) ? sta.getBirthDay() : null;
                                        String birthFormatted = "";
                                        if (birth != null && !birth.isEmpty()) {
                                            try {
                                                java.text.SimpleDateFormat inputFormat = new java.text.SimpleDateFormat("yyyy-MM-dd");
                                                java.text.SimpleDateFormat outputFormat = new java.text.SimpleDateFormat("dd/MM/yyyy");
                                                java.util.Date birthDate = inputFormat.parse(birth);
                                                birthFormatted = outputFormat.format(birthDate);
                                            } catch (Exception e) {
                                                birthFormatted = "Invalid date of birth";
                                            }
                                        }
                                    %>
                                    <%= (birth == null || birth.isEmpty())
                                            ? "<span class='error-message'><i class=\"bi bi-exclamation-triangle\"></i>Please update your date of birth</span>"
                                            : "<div class='profile-info-item'><i class=\"bi bi-calendar\"></i><span class='profile-value'>" + birthFormatted + "</span></div>" %>
                                </td>
                            </tr>

                            <!-- Gender -->
                            <tr>
                                <th><i class="bi bi-gender-ambiguous profile-icon"></i> Gender:</th>
                                <td>
                                    <div class="gender-options">
                                        <label class="gender-option" for="male-view">
                                            <input type="radio" class="form-check-input" name="sex" value="male" id="male-view"
                                                   <%= (sta != null && "male".equalsIgnoreCase(sta.getGender())) ? "checked" : "" %> disabled />
                                            <span>Male</span>
                                        </label>
                                        <label class="gender-option" for="female-view">
                                            <input type="radio" class="form-check-input" name="sex" value="female" id="female-view"
                                                   <%= (sta != null && "female".equalsIgnoreCase(sta.getGender())) ? "checked" : "" %> disabled />
                                            <span>Female</span>
                                        </label>
                                    </div>
                                    <%
                                        String gender = (sta != null) ? sta.getGender() : null;
                                        if (gender == null || gender.trim().isEmpty()) {
                                    %>
                                    <div class="mt-2">
                                        <span class="error-message">
                                            <i class="bi bi-exclamation-triangle"></i>
                                            Please update your gender
                                        </span>
                                    </div>
                                    <% } else { %>
                                    <div class="mt-2">
                                        <span class="status-badge">
                                            <i class="bi bi-check-circle"></i>
                                            Information updated
                                        </span>
                                    </div>
                                    <% } %>
                                </td>
                            </tr>
                        </table>

                        <!-- Actions -->
                        <div class="profile-actions">
                            <% if (hasPassword) { %>
                            <a href="ChangePassword" class="btn-change-password">
                                <i class="bi bi-shield-lock"></i>
                                Change Password
                            </a>
                            <% } %>
                            <a href="UpdateProfile" class="btn-update">
                                <i class="bi bi-pencil-square"></i>
                                Update Profile
                            </a>
                        </div>
                    </div>
                </form>
            </div>
        </div>

        <jsp:include page="/WEB-INF/View/customer/homePage/footer.jsp" />
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>
