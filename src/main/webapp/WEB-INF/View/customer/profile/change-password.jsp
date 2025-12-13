
<%@page import="model.Customer"%>
<%@page import="model.Account"%>
<%@page import="model.Staff"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%
    Integer accountId = (Integer) session.getAttribute("accountId");
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Change Password</title>
        <meta name="viewport" content="width=device-width, initial-scale=1">

        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
        <!-- CSS chung (profile layout) -->
        <link rel="stylesheet" href="${pageContext.request.contextPath}/Css/profile.css">

        <style>
            .password-hint {
                font-size: 0.85rem;
                color: #64748b;
                margin-top: 4px;
            }
            .error-message {
                margin-top: 6px;
            }
            .toggle-password {
                position: absolute;
                right: 12px;
                top: 50%;
                transform: translateY(-50%);
                cursor: pointer;
                color: #94a3b8;
                font-size: 0.9rem;
            }
            .password-wrapper {
                position: relative;
            }
        </style>
    </head>
    <body>
        <jsp:include page="/WEB-INF/View/customer/homePage/header.jsp" />

        <div class="main-account container-fluid">
            <!-- Sidebar -->
            <jsp:include page="/WEB-INF/View/customer/sideBar.jsp" />

            <!-- Card ??i m?t kh?u -->
            <div class="profile-card">
                <div class="profile-header">
                    <h4 class="mb-0 d-flex align-items-center gap-2">
                        <i class="bi bi-shield-lock"></i>
                        Change Password
                    </h4>
                </div>

                <div class="profile-body">
                    <!-- Thông báo server-side -->
                    <c:if test="${not empty success}">
                        <div class="alert alert-success" role="alert">
                            <i class="bi bi-check-circle me-2"></i>${success}
                        </div>
                    </c:if>

                    <c:if test="${not empty error}">
                        <div class="alert alert-danger" role="alert">
                            <i class="bi bi-exclamation-triangle me-2"></i>${error}
                        </div>
                    </c:if>

                    <p class="mb-3" style="font-size:0.9rem; color:#64748b;">
                        For your account security, please use a strong password that you have not used before.
                    </p>

                    <form method="post" action="ChangePassword" id="changePasswordForm">
                        <!-- Old password -->
                        <div class="form-group">
                            <label for="oldPassword" class="form-label">
                                <i class="bi bi-lock me-2 profile-icon"></i>Old Password
                            </label>
                            <div class="password-wrapper">
                                <input type="password"
                                       class="form-control"
                                       name="oldPassword"
                                       id="oldPassword"
                                       required
                                       placeholder="Enter your current password">
                                <span class="toggle-password" data-target="oldPassword">
                                    <i class="bi bi-eye-slash"></i>
                                </span>
                            </div>
                        </div>

                        <!-- New password -->
                        <div class="form-group">
                            <label for="newPassword" class="form-label">
                                <i class="bi bi-key me-2 profile-icon"></i>New Password
                            </label>
                            <div class="password-wrapper">
                                <input type="password"
                                       class="form-control"
                                       name="newPassword"
                                       id="newPassword"
                                       required
                                       placeholder="Enter your new password">
                                <span class="toggle-password" data-target="newPassword">
                                    <i class="bi bi-eye-slash"></i>
                                </span>
                            </div>
                            <div class="password-hint">
                                Minimum 8 characters, include letters and numbers.
                            </div>
                            <div id="newPasswordError" class="error-message" style="display:none;"></div>
                        </div>

                        <!-- Confirm new password -->
                        <div class="form-group">
                            <label for="confirmPassword" class="form-label">
                                <i class="bi bi-key-fill me-2 profile-icon"></i>Confirm New Password
                            </label>
                            <div class="password-wrapper">
                                <input type="password"
                                       class="form-control"
                                       name="confirmPassword"
                                       id="confirmPassword"
                                       required
                                       placeholder="Confirm your new password">
                                <span class="toggle-password" data-target="confirmPassword">
                                    <i class="bi bi-eye-slash"></i>
                                </span>
                            </div>
                            <div id="confirmPasswordError" class="error-message" style="display:none;"></div>
                        </div>

                        <!-- Actions -->
                        <div class="profile-actions">
                            <a href="ViewProfile" class="btn-cancel">
                                <i class="bi bi-arrow-left me-1"></i>Back
                            </a>
                            <button type="submit" class="btn-update">
                                <i class="bi bi-shield-check me-2"></i>
                                Change Password
                            </button>
                        </div>
                    </form>
                </div>
            </div>
        </div>

        <jsp:include page="/WEB-INF/View/customer/homePage/footer.jsp" />

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
        <script>
            // Toggle show/hide password
            document.querySelectorAll('.toggle-password').forEach(function (toggle) {
                toggle.addEventListener('click', function () {
                    const targetId = this.getAttribute('data-target');
                    const input = document.getElementById(targetId);
                    const icon = this.querySelector('i');

                    if (input.type === 'password') {
                        input.type = 'text';
                        icon.classList.remove('bi-eye-slash');
                        icon.classList.add('bi-eye');
                    } else {
                        input.type = 'password';
                        icon.classList.remove('bi-eye');
                        icon.classList.add('bi-eye-slash');
                    }
                });
            });

            // Simple client-side validation
            const form = document.getElementById('changePasswordForm');
            const newPassword = document.getElementById('newPassword');
            const confirmPassword = document.getElementById('confirmPassword');
            const newPasswordError = document.getElementById('newPasswordError');
            const confirmPasswordError = document.getElementById('confirmPasswordError');

            form.addEventListener('submit', function (e) {
                let valid = true;
                newPasswordError.style.display = 'none';
                confirmPasswordError.style.display = 'none';

                const newPw = newPassword.value.trim();
                const confirmPw = confirmPassword.value.trim();

                if (newPw.length < 8) {
                    newPasswordError.textContent = 'Password must be at least 8 characters.';
                    newPasswordError.style.display = 'block';
                    valid = false;
                }

                if (newPw !== confirmPw) {
                    confirmPasswordError.textContent = 'New password and confirmation do not match.';
                    confirmPasswordError.style.display = 'block';
                    valid = false;
                }

                if (!valid) {
                    e.preventDefault();
                }
            });
        </script>
    </body>
</html>
