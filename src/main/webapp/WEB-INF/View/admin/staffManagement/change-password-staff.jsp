<%-- 
    Document   : change-password-staff
    Created on : Jul 30, 2025, 5:04:04 PM
    Author     : pc
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Reset Staff Password</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <link rel="stylesheet"
          href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">

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

        /* ===== Card ===== */
        .card-reset {
            border-radius: 18px;
            box-shadow: 0 18px 45px rgba(15, 23, 42, 0.12);
            border: none;
            max-width: 640px;
            width: 100%;
            overflow: hidden;
        }

        .card-header.reset-header {
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
            width: 40px;
            height: 40px;
            border-radius: 999px;
            background: rgba(15, 23, 42, 0.18);
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .header-icon i {
            font-size: 1.1rem;
        }

        .header-text h4 {
            font-size: 1.15rem;
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

        .card-body {
            padding: 22px 22px 20px;
        }

        /* ===== Alert ===== */
        .alert {
            border-radius: 10px;
            font-size: 0.9rem;
            padding: 0.6rem 0.9rem;
        }

        /* ===== Table form ===== */
        .table-reset {
            margin: 0;
        }

        .table-reset th,
        .table-reset td {
            padding: 8px 4px;
            font-size: 0.92rem;
            vertical-align: middle;
        }

        .table-reset th {
            width: 40%;
            color: #6b7280;
            font-weight: 600;
        }

        .table-reset td {
            color: #111827;
        }

        .form-control {
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

        .form-control:focus {
            border-color: #2563eb;
            box-shadow: 0 0 0 0.15rem rgba(37, 99, 235, 0.25);
            background-color: #f9fafb;
        }

        /* ===== Buttons ===== */
        .reset-actions {
            border-top: 1px solid #e5e7eb;
            margin-top: 18px;
            padding-top: 12px;
        }

        .btn {
            border-radius: 999px;
            font-weight: 600;
            font-size: 0.9rem;
            padding: 0.45rem 1.4rem;
        }

        .btn-back {
            border-radius: 999px;
        }

        .btn-reset {
            background: linear-gradient(135deg, #f97316, #ea580c);
            border: none;
            color: #ffffff;
            box-shadow: 0 4px 10px rgba(249, 115, 22, 0.35);
            display: inline-flex;
            align-items: center;
            gap: 6px;
        }

        .btn-reset:hover {
            background: linear-gradient(135deg, #ea580c, #c2410c);
            color: #ffffff;
        }

        @media (max-width: 768px) {
            .card-body {
                padding: 18px 14px 18px;
            }

            .table-reset th,
            .table-reset td {
                display: block;
                width: 100%;
            }

            .table-reset th {
                margin-top: 6px;
            }

            .table-reset tr td {
                padding-bottom: 10px;
            }
        }
    </style>
</head>
<body>
<div class="page-wrapper">
    <div class="card card-reset">
        <div class="card-header reset-header">
            <div class="header-main">
                <div class="header-icon">
                    <i class="bi bi-shield-lock-fill"></i>
                </div>
                <div class="header-text">
                    <h4 class="mb-0">Reset Staff Password</h4>
                    <p class="subtitle mb-0">Set a new password for the staff account</p>
                </div>
            </div>
        </div>

        <div class="card-body">
            <!-- Thông báo -->
            <c:if test="${not empty success}">
                <div class="alert alert-success text-center mb-3">
                    ${success}
                </div>
            </c:if>
            <c:if test="${not empty error}">
                <div class="alert alert-danger text-center mb-3">
                    ${error}
                </div>
            </c:if>

            <!-- Form đổi mật khẩu -->
            <form action="${pageContext.request.contextPath}/ChangePasswordStaff" method="post">
                <table class="table table-borderless table-reset">
                    <tr>
                        <th>New Password</th>
                        <td>
                            <input type="password"
                                   id="newPassword"
                                   name="newPassword"
                                   class="form-control"
                                   placeholder="Enter new password"
                                   required>
                        </td>
                    </tr>
                    <tr>
                        <th>Confirm New Password</th>
                        <td>
                            <input type="password"
                                   id="confirmPassword"
                                   name="confirmPassword"
                                   class="form-control"
                                   placeholder="Re-enter new password"
                                   required>
                        </td>
                    </tr>
                </table>

                <div class="d-flex justify-content-between align-items-center reset-actions">
                    <a href="${pageContext.request.contextPath}/StaffList" class="btn btn-outline-primary btn-back">
                        <i class="bi bi-arrow-return-left me-1"></i>Back to list
                    </a>
                    <button type="submit" class="btn btn-reset">
                        <i class="bi bi-arrow-repeat"></i>
                        <span>Reset Password</span>
                    </button>
                </div>
            </form>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
        crossorigin="anonymous"></script>
</body>
</html>
