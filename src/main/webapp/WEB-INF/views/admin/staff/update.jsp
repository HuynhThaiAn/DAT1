<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Update Staff</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    </head>
    <body class="bg-light">
        <div class="d-flex">
            <jsp:include page="/WEB-INF/views/admin/common/sideBar.jsp" />

            <main class="flex-grow-1 p-4">
                <h3>Update Staff</h3>

                <div class="card shadow-sm mt-3" style="max-width: 820px;">
                    <div class="card-body">
                        <div class="text-danger mb-2">${error}</div>

                        <form class="needs-validation" novalidate
                              method="post"
                              action="${pageContext.request.contextPath}/Admin/StaffManagement">
                            <input type="hidden" name="action" value="update"/>
                            <input type="hidden" name="id" value="${staff.staffID}"/>

                            <!-- role default staff = 1 (giữ đúng yêu cầu) -->
                            <input type="hidden" name="role" value="1"/>

                            <div class="row g-3">
                                <div class="col-md-6">
                                    <label class="form-label">Email (@datshop.com)</label>
                                    <input class="form-control" name="email" required
                                           value="${staff.email}"
                                           pattern="^[A-Za-z0-9._%+-]+@datshop\\.com$"/>
                                    <div class="invalid-feedback">Email must end with @datshop.com</div>
                                </div>

                                <div class="col-md-6">
                                    <label class="form-label">Password (leave blank to keep)</label>
                                    <input class="form-control" type="password" name="password" minlength="6"
                                           placeholder="Min 6 characters (optional)"/>
                                    <div class="invalid-feedback">If entered, password must be at least 6 chars</div>
                                </div>

                                <div class="col-md-6">
                                    <label class="form-label">Full Name</label>
                                    <input class="form-control" name="fullName" required value="${staff.fullName}"/>
                                    <div class="invalid-feedback">Full name is required</div>
                                </div>

                                <div class="col-md-6">
                                    <label class="form-label">Phone</label>
                                    <input class="form-control" name="phone" value="${staff.phone}"
                                           pattern="^[0-9+\\-\\s]{8,15}$"/>
                                    <div class="invalid-feedback">Phone format is invalid</div>
                                </div>

                                <div class="col-md-6">
                                    <label class="form-label">Date of Birth</label>
                                    <input class="form-control" type="date" name="dateOfBirth" value="${staff.dateOfBirth}"/>
                                </div>

                                <div class="col-md-6">
                                    <label class="form-label">Gender</label>
                                    <select class="form-select" name="gender">
                                        <option value="" ${empty staff.gender ? "selected" : ""}>-- Select --</option>
                                        <option value="1" ${staff.gender == 1 ? "selected" : ""}>Male</option>
                                        <option value="0" ${staff.gender == 0 ? "selected" : ""}>Female</option>
                                        <option value="2" ${staff.gender == 2 ? "selected" : ""}>Other</option>
                                    </select>
                                </div>

                                <div class="col-md-6">
                                    <label class="form-label">Role</label>
                                    <input class="form-control" value="Staff" readonly/>
                                    <div class="form-text">Role is fixed to Staff.</div>
                                </div>
                            </div>

                            <div class="d-flex gap-2 mt-4">
                                <button class="btn btn-primary" type="submit">Update</button>
                                <a class="btn btn-secondary"
                                   href="${pageContext.request.contextPath}/Admin/StaffManagement?action=list">
                                    Back
                                </a>
                            </div>
                        </form>

                    </div>
                </div>
            </main>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
        <script>
            (() => {
                const forms = document.querySelectorAll('.needs-validation');
                Array.from(forms).forEach(form => {
                    form.addEventListener('submit', event => {
                        if (!form.checkValidity()) {
                            event.preventDefault();
                            event.stopPropagation();
                        }
                        form.classList.add('was-validated');
                    }, false);
                });
            })();
        </script>
    </body>
</html>
