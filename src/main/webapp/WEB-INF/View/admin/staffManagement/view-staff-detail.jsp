<%-- 
    Document   : view-staff-detail
    Created on : Jun 12, 2025, 10:01:59 PM
    Author     : pc
--%>

<%@page import="model.Staff"%>
<%
    Staff sta = (Staff) request.getAttribute("data");
%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Staff Detail</title>
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

        .detail-wrapper {
            min-height: 100vh;
            display: flex;
            align-items: flex-start;
            justify-content: center;
            padding: 32px 12px;
        }

        /* ===== Card ===== */
        .card-detail {
            border-radius: 18px;
            box-shadow: 0 18px 45px rgba(15, 23, 42, 0.12);
            border: none;
            max-width: 780px;
            width: 100%;
            overflow: hidden;
        }

        .card-header.detail-header {
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
            padding: 22px 22px 20px;
        }

        /* ===== Table detail ===== */
        .table-detail {
            margin: 0;
        }

        .table-detail th,
        .table-detail td {
            padding: 8px 4px;
            font-size: 0.92rem;
            vertical-align: middle;
        }

        .table-detail th {
            width: 30%;
            color: #6b7280;
            font-weight: 600;
            text-transform: none;
        }

        .table-detail td {
            color: #111827;
            font-weight: 500;
        }

        .table-detail tr:nth-child(odd) td {
            background-color: #f9fafb;
        }

        .table-detail tr:nth-child(even) td {
            background-color: #f3f4f6;
        }

        .table-detail tr:last-child td {
            border-bottom: none;
        }

        /* ===== Radio gender ===== */
        .gender-option {
            display: inline-flex;
            align-items: center;
            margin-right: 16px;
            font-size: 0.9rem;
        }

        .gender-option input {
            margin-right: 6px;
        }

        /* ===== Actions ===== */
        .detail-actions {
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

        .btn-reset {
            background-color: #e5e7eb;
            color: #111827;
            border: none;
        }

        .btn-reset:hover {
            background-color: #d1d5db;
            color: #111827;
        }

        .btn-back {
            border-radius: 999px;
        }

        .btn-update {
            background: linear-gradient(135deg, #22c55e, #16a34a);
            border: none;
            color: #ffffff;
            box-shadow: 0 4px 10px rgba(34, 197, 94, 0.35);
        }

        .btn-update:hover {
            background: linear-gradient(135deg, #16a34a, #15803d);
            color: #ffffff;
        }

        .btn-delete {
            background: #fee2e2;
            border: none;
            color: #b91c1c;
        }

        .btn-delete:hover {
            background: #fecaca;
            color: #991b1b;
        }

        /* ===== Empty state ===== */
        .empty-state {
            min-height: 100vh;
        }

        @media (max-width: 768px) {
            .card-body {
                padding: 18px 14px 18px;
            }

            .header-meta {
                display: none;
            }

            .table-detail th,
            .table-detail td {
                display: block;
                width: 100%;
            }

            .table-detail th {
                margin-top: 6px;
            }

            .table-detail tr:nth-child(odd) td,
            .table-detail tr:nth-child(even) td {
                background-color: transparent;
                border-bottom: 1px solid #e5e7eb;
            }
        }
    </style>
</head>
<body>
<% if (sta == null) { %>
    <div class="d-flex align-items-center justify-content-center empty-state">
        <div class="alert alert-warning shadow-sm mb-0" role="alert">
            No staff found with this ID.
        </div>
    </div>
<% } else { %>
    <div class="detail-wrapper">
        <div class="card card-detail">
            <div class="card-header detail-header">
                <div class="header-main">
                    <div class="header-icon">
                        <i class="bi bi-person-badge-fill"></i>
                    </div>
                    <div class="header-text">
                        <h4 class="mb-0">Staff Detail</h4>
                        <p class="subtitle mb-0">View information of staff ID #<%= sta.getStaffID() %></p>
                    </div>
                </div>
                <div class="header-meta">
                    <div class="badge-soft">
                        <i class="bi bi-shield-lock"></i>
                        <span>Read Only</span>
                    </div>
                </div>
            </div>

            <div class="card-body">
                <form method="post" action="CustomerList?action=detail">
                    <table class="table table-borderless table-detail">
                        <tr>
                            <th>Staff ID</th>
                            <td><%= sta.getStaffID() %></td>
                        </tr>
                        <tr>
                            <th>Full Name</th>
                            <td><%= sta.getFullName() %></td>
                        </tr>
                        <tr>
                            <th>Phone Number</th>
                            <td><%= sta.getPhone() %></td>
                        </tr>
                        <tr>
                            <th>Email</th>
                            <td><%= sta.getEmail() %></td>
                        </tr>
                        <tr>
                            <th>Position</th>
                            <td><%= sta.getPosition() %></td>
                        </tr>
                        <tr>
                            <th>Date of Birth</th>
                            <td><%= sta.getBirthDay() %></td>
                        </tr>
                        <tr>
                            <th>Hired Date</th>
                            <td><%= sta.getHiredDate() %></td>
                        </tr>
                        <tr>
                            <th>Gender</th>
                            <td>
                                <label class="gender-option">
                                    <input type="radio" class="form-check-input" name="sex" value="male"
                                           <%= ("male".equalsIgnoreCase(sta.getGender()) ? "checked" : "") %> disabled>
                                    Male
                                </label>
                                <label class="gender-option">
                                    <input type="radio" class="form-check-input" name="sex" value="female"
                                           <%= ("female".equalsIgnoreCase(sta.getGender()) ? "checked" : "") %> disabled>
                                    Female
                                </label>
                            </td>
                        </tr>
                    </table>

                    <div class="d-flex justify-content-between align-items-center detail-actions">
                        <div class="d-flex flex-wrap gap-2">
                            <a href="ChangePasswordStaff" class="btn btn-reset">
                                <i class="bi bi-tools me-1"></i>Reset Password
                            </a>
                            <a href="StaffList" class="btn btn-outline-primary btn-back">
                                <i class="bi bi-arrow-return-left me-1"></i>Back to list
                            </a>
                        </div>
                        <div class="d-flex flex-wrap gap-2">
                            <a href="UpdateStaffServlet?action=update&id=<%= sta.getStaffID() %>" class="btn btn-update">
                                <i class="bi bi-pencil-square me-1"></i>Update
                            </a>
                            <a href="DeleteStaffServlet?action=delete&id=<%= sta.getStaffID() %>" class="btn btn-delete">
                                <i class="bi bi-trash3-fill me-1"></i>Delete
                            </a>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>
<% } %>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
        crossorigin="anonymous"></script>
</body>
</html>
