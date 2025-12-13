<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Create New Staff - Admin</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        /* ===== Layout chung ===== */
        body {
            background: linear-gradient(135deg, #e5edff 0%, #f9fafb 40%, #f4f6fb 100%);
            font-family: system-ui, -apple-system, BlinkMacSystemFont, "Segoe UI", sans-serif;
            min-height: 100vh;
        }

        .page-wrapper {
            min-height: 100vh;
            display: flex;
            align-items: flex-start;
            justify-content: center;
            padding: 32px 12px;
        }

        /* ===== Card chính ===== */
        .card {
            border-radius: 18px;
            box-shadow: 0 18px 45px rgba(15, 23, 42, 0.12);
            border: none;
            max-width: 900px;
            width: 100%;
            overflow: hidden;
        }

        /* Header */
        .card-header.create-header {
            border-radius: 18px 18px 0 0 !important;
            padding: 14px 20px;
            background: linear-gradient(120deg, #1d4ed8, #2563eb);
            color: #f9fafb;
            display: flex;
            align-items: center;
            justify-content: space-between;
            gap: 12px;
        }

        .header-main {
            display: flex;
            align-items: center;
            gap: 12px;
        }

        .header-icon {
            width: 38px;
            height: 38px;
            border-radius: 999px;
            background: rgba(15, 23, 42, 0.15);
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .header-icon i {
            font-size: 18px;
        }

        .header-text h4 {
            font-size: 1.2rem;
            font-weight: 700;
            margin: 0;
            letter-spacing: 0.04em;
            text-transform: uppercase;
        }

        .header-text .subtitle {
            font-size: 0.85rem;
            opacity: 0.9;
            margin: 0;
        }

        .header-meta {
            text-align: right;
            font-size: 0.8rem;
            opacity: 0.9;
        }

        .badge-soft {
            display: inline-flex;
            align-items: center;
            gap: 6px;
            padding: 4px 10px;
            border-radius: 999px;
            background: rgba(15, 23, 42, 0.2);
            font-size: 0.75rem;
        }

        .card-body {
            padding: 22px 22px 24px;
        }

        /* ===== Section ===== */
        .form-section {
            margin-bottom: 1.75rem;
            padding: 16px 16px 12px;
            border-radius: 12px;
            background: #f9fafb;
            border: 1px solid #e5e7eb;
        }

        .section-title {
            color: #111827;
            border-bottom: 1px solid #e5e7eb;
            padding-bottom: 0.6rem;
            margin-bottom: 1.1rem;
            font-weight: 700;
            font-size: 1rem;
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .section-title i {
            color: #2563eb;
            font-size: 1.05rem;
        }

        /* ===== Label + input ===== */
        .form-label {
            font-weight: 600;
            color: #111827;
            margin-bottom: 0.2rem;
            font-size: 0.9rem;
        }

        .form-control,
        .form-select {
            border-radius: 10px;
            padding: 0.5rem 0.75rem;
            border: 1px solid #d1d5db;
            font-size: 0.9rem;
            transition: border-color 0.18s, box-shadow 0.18s, background-color 0.18s;
        }

        .form-control::placeholder {
            color: #9ca3af;
            font-size: 0.85rem;
        }

        .form-control:focus,
        .form-select:focus {
            border-color: #2563eb;
            box-shadow: 0 0 0 0.15rem rgba(37, 99, 235, 0.25);
            background-color: #f9fafb;
        }

        /* ===== Alert ===== */
        .alert {
            border-radius: 10px;
            border: 1px solid #fecaca;
            background: #fef2f2;
            color: #b91c1c;
            font-size: 0.9rem;
            padding: 0.6rem 0.9rem;
            margin-bottom: 1rem;
        }

        .alert i {
            margin-right: 6px;
        }

        .text-danger {
            font-size: 0.8rem;
        }

        /* ===== Button ===== */
        .btn {
            border-radius: 999px;
            padding: 0.45rem 1.6rem;
            font-weight: 600;
            font-size: 0.9rem;
        }

        /* Primary = xanh lá (Create) */
        .btn-primary {
            background: linear-gradient(135deg, #22c55e, #16a34a);
            border: none;
            color: #ffffff;
            box-shadow: 0 4px 10px rgba(34, 197, 94, 0.35);
            display: inline-flex;
            align-items: center;
            gap: 6px;
        }

        .btn-primary i {
            font-size: 0.9rem;
        }

        .btn-primary:focus,
        .btn-primary:active,
        .btn-primary:hover {
            background: linear-gradient(135deg, #16a34a, #15803d) !important;
            border: none !important;
            color: #ffffff !important;
            box-shadow: 0 5px 14px rgba(22, 163, 74, 0.4) !important;
        }

        /* Secondary = xám cho Cancel */
        .btn-secondary {
            background-color: #e5e7eb;
            border-color: #e5e7eb;
            color: #111827;
        }

        .btn-secondary:hover {
            background-color: #d1d5db;
            border-color: #d1d5db;
            color: #111827;
        }

        .form-actions {
            border-top: 1px solid #e5e7eb;
            padding-top: 1rem;
            margin-top: 0.7rem;
        }

        /* ===== Responsive ===== */
        @media (max-width: 768px) {
            .card-body {
                padding: 16px 14px 20px;
            }

            .header-text h4 {
                font-size: 1.05rem;
            }

            .header-text .subtitle {
                font-size: 0.8rem;
            }

            .header-meta {
                display: none;
            }
        }
    </style>
</head>
<body>
<div class="page-wrapper">
    <div class="card">
        <div class="card-header create-header">
            <div class="header-main">
                <div class="header-icon">
                    <i class="fa-solid fa-user-plus"></i>
                </div>
                <div class="header-text">
                    <h4 class="mb-0">Create New Staff</h4>
                    <p class="subtitle mb-0">Add a new staff account to the system</p>
                </div>
            </div>
            <div class="header-meta">
                <div class="badge-soft">
                    <i class="fa-solid fa-shield-halved"></i>
                    <span>Admin Only</span>
                </div>
            </div>
        </div>

        <div class="card-body">
            <%
                String errorMessage = (String) request.getAttribute("errorMessage");
                if (errorMessage != null) {
            %>
            <div class="alert alert-danger" role="alert">
                <i class="fas fa-exclamation-circle"></i><%= errorMessage %>
            </div>
            <%
                }
            %>

            <form action="CreateStaffServlet" method="post" class="row g-3">
                <!-- Account Information -->
                <div class="col-12 form-section">
                    <h5 class="section-title">
                        <i class="fas fa-user-circle"></i>
                        <span>Account Information</span>
                    </h5>
                    <div class="row">
                        <div class="col-md-6 mb-3">
                            <label for="email" class="form-label">Email</label>
                            <input type="email" id="email" name="email" class="form-control"
                                   placeholder="example@gmail.com" required>
                            <div id="emailError" class="text-danger mt-1"></div>
                        </div>

                        <div class="col-md-6 mb-3">
                            <label for="password" class="form-label">Password</label>
                            <input type="password" id="password" name="password" class="form-control"
                                   placeholder="Enter password" required>
                        </div>
                    </div>
                </div>

                <!-- Staff Information -->
                <div class="col-12 form-section">
                    <h5 class="section-title">
                        <i class="fas fa-id-card"></i>
                        <span>Staff Information</span>
                    </h5>
                    <div class="row">
                        <div class="col-md-6 mb-3">
                            <label for="fullName" class="form-label">Full Name</label>
                            <input type="text" id="fullName" name="fullName" class="form-control"
                                   placeholder="Nguyen Van A" required>
                            <div id="fullNameError" class="text-danger mt-1"></div>
                        </div>

                        <div class="col-md-6 mb-3">
                            <label for="phoneNumber" class="form-label">Phone Number</label>
                            <input type="text" id="phoneNumber" name="phoneNumber" class="form-control"
                                   placeholder="0xxxxxxxxx">
                            <div id="phoneError" class="text-danger mt-1"></div>
                        </div>

                        <div class="col-md-6 mb-3">
                            <label for="birthDate" class="form-label">Birth Date</label>
                            <input type="date" id="birthDate" name="birthDate" class="form-control">
                            <div id="birthDateError" class="text-danger mt-1"></div>
                        </div>

                        <div class="col-md-6 mb-3">
                            <label for="gender" class="form-label">Gender</label>
                            <select id="gender" name="gender" class="form-select">
                                <option value="">Select Gender</option>
                                <option value="Male">Male</option>
                                <option value="Female">Female</option>
                                <option value="Other">Other</option>
                            </select>
                        </div>

                        <div class="col-md-6 mb-3">
                            <label for="position" class="form-label">Position</label>
                            <input type="text" id="position" name="position" class="form-control"
                                   placeholder="e.g. Sales Staff" required>
                        </div>

                        <div class="col-md-6 mb-3">
                            <label for="hiredDate" class="form-label">Hired Date</label>
                            <input type="date" id="hiredDate" name="hiredDate" class="form-control" required>
                        </div>
                    </div>
                </div>

                <!-- Actions -->
                <div class="col-12 mt-2 text-end form-actions">
                    <button type="submit" class="btn btn-primary me-2">
                        <i class="fa-solid fa-floppy-disk"></i>
                        <span>Create</span>
                    </button>
                    <a href="StaffList" class="btn btn-secondary">
                        Cancel
                    </a>
                </div>
            </form>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script>
    const emailInput = document.getElementById("email");
    const emailError = document.getElementById("emailError");
    const submitBtn = document.querySelector("button[type='submit']");

    emailInput.addEventListener("blur", function () {
        const email = emailInput.value.trim();
        const emailPattern = /^[a-zA-Z0-9._%+-]+@gmail\.com$/;
        emailError.textContent = "";
        submitBtn.disabled = false;

        if (!emailPattern.test(email)) {
            emailError.textContent = "Email must be a valid Gmail address.";
            submitBtn.disabled = true;
            return;
        }

        fetch("CheckEmailServlet?email=" + encodeURIComponent(email))
            .then(response => response.text())
            .then(data => {
                if (data === "EXISTS") {
                    emailError.textContent = "This email already exists.";
                    submitBtn.disabled = true;
                }
            })
            .catch(error => {
                emailError.textContent = "Error checking email.";
                submitBtn.disabled = true;
                console.error("Error:", error);
            });
    });

    emailInput.addEventListener("input", function () {
        emailError.textContent = "";
        submitBtn.disabled = false;
    });

    const phoneInput = document.getElementById("phoneNumber");
    const phoneError = document.getElementById("phoneError");

    phoneInput.addEventListener("blur", function () {
        const phone = phoneInput.value.trim();
        phoneError.textContent = "";
        submitBtn.disabled = false;

        const phonePattern = /^0\\d{9}$/;
        if (!phonePattern.test(phone)) {
            phoneError.textContent = "Phone must start with 0 and have exactly 10 digits.";
            submitBtn.disabled = true;
            return;
        }

        fetch("CheckPhoneServlet?phone=" + encodeURIComponent(phone))
            .then(response => response.text())
            .then(data => {
                if (data === "EXISTS") {
                    phoneError.textContent = "Phone number already exists.";
                    submitBtn.disabled = true;
                }
            })
            .catch(error => {
                phoneError.textContent = "Error checking phone.";
                submitBtn.disabled = true;
                console.error("Error:", error);
            });
    });

    phoneInput.addEventListener("input", function () {
        phoneError.textContent = "";
        submitBtn.disabled = false;
    });

    const birthInput = document.getElementById("birthDate");
    const birthError = document.getElementById("birthDateError");

    birthInput.addEventListener("blur", function () {
        const birthDate = new Date(this.value);
        const today = new Date();

        birthError.textContent = "";
        submitBtn.disabled = false;

        if (isNaN(birthDate.getTime())) return;

        let age = today.getFullYear() - birthDate.getFullYear();
        const m = today.getMonth() - birthDate.getMonth();

        if (m < 0 || (m === 0 && today.getDate() < birthDate.getDate())) {
            age--;
        }

        if (age < 18) {
            birthError.textContent = "Staff must be at least 18 years old.";
            submitBtn.disabled = true;
        }
    });

    const fullNameInput = document.getElementById("fullName");
    const fullNameError = document.getElementById("fullNameError");

    fullNameInput.addEventListener("blur", function () {
        let name = fullNameInput.value.trim();
        fullNameError.textContent = "";
        submitBtn.disabled = false;
        name = name.replace(/\\s+/g, " ");
        fullNameInput.value = name;

        const namePattern = /^([A-ZÀ-Ỹ][a-zà-ỹ]+)(\\s[A-ZÀ-Ỹ][a-zà-ỹ]+)*$/u;

        if (!namePattern.test(name)) {
            fullNameError.textContent = "Names must be initialed, contain no numbers or special characters, and have no spaces.";
            submitBtn.disabled = true;
        }
    });

    fullNameInput.addEventListener("input", function () {
        fullNameError.textContent = "";
        submitBtn.disabled = false;
    });
</script>
</body>
</html>
