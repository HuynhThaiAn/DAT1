<%@page import="model.Account"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.text.NumberFormat, java.util.Locale"%>
<%
    Account acc = (Account) session.getAttribute("admin");
    if (acc == null || acc.getRoleID() != 1) {
        response.sendRedirect("LoginAdmin");
        return;
    }

    Integer totalStaff = (Integer) request.getAttribute("totalStaff");
    Integer totalProduct = (Integer) request.getAttribute("totalProduct");
    Long monthlyRevenue = (Long) request.getAttribute("monthlyRevenue");

    if (totalStaff == null) totalStaff = 0;
    if (totalProduct == null) totalProduct = 0;
    if (monthlyRevenue == null) monthlyRevenue = 0L;

    NumberFormat nf = NumberFormat.getInstance(new Locale("vi", "VN"));

    String adminEmail = acc.getEmail();
    String adminDisplay = adminEmail != null ? adminEmail : "Admin";
    String initials = "AD";
    if (adminEmail != null && !adminEmail.isEmpty()) {
        String[] parts = adminEmail.split("@")[0].split("\\.");
        StringBuilder sb = new StringBuilder();
        for (String p : parts) if (!p.isEmpty()) sb.append(Character.toUpperCase(p.charAt(0)));
        if (sb.length() > 0) initials = sb.toString();
    }
%>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1" />
        <title>Admin Dashboard - DAT</title>

        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css">
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet" />

        <link rel="stylesheet" href="${pageContext.request.contextPath}/Css/sidebar-admin.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/Css/adminDashboard.css">
    </head>

    <body class="admin-dashboard">
        <div class="admin-container">
            <jsp:include page="sideBar.jsp" />

            <main class="main-content">

                <!-- HEADER -->
                <header class="header">
                    <div class="header-left">
                        <div>
                            <h1 class="mb-1 fs-4">Admin Dashboard</h1>
                            <p class="mb-0 small text-muted">
                                System overview for DAT Shop operations
                            </p>
                        </div>
                    </div>

                    <div class="user-info">
                        <div class="user-avatar">
                            <span><%= initials %></span>
                        </div>

                        <div class="user-details">
                            <h3 title="<%= adminDisplay %>"><%= adminDisplay %></h3>
                            <p>Administrator</p>
                        </div>

                        <button class="logout-btn"
                                onclick="if (confirm('Are you sure you want to log out?'))
                                            window.location.href = 'Logout';">
                            <i class="fas fa-sign-out-alt"></i>
                            <span>Logout</span>
                        </button>
                    </div>
                </header>

                <!-- STATS -->
                <section class="stats-grid">

                    <!-- Staff -->
                    <article class="stat-card">
                        <div class="stat-header">
                            <span>Total Staff</span>
                            <div class="stat-icon">
                                <i class="fas fa-user-tie"></i>
                            </div>
                        </div>
                        <div class="stat-value"><%= totalStaff %></div>
                        <div class="stat-sub">Active staff accounts</div>
                    </article>

                    <!-- Products -->
                    <article class="stat-card">
                        <div class="stat-header">
                            <span>Total Products</span>
                            <div class="stat-icon">
                                <i class="fas fa-box"></i>
                            </div>
                        </div>
                        <div class="stat-value"><%= totalProduct %></div>
                        <div class="stat-sub">Products currently listed</div>
                    </article>

                    <!-- Revenue -->
                    <article class="stat-card">
                        <div class="stat-header">
                            <span>Revenue This Month</span>
                            <div class="stat-icon">
                                <i class="fas fa-chart-line"></i>
                            </div>
                        </div>
                        <div class="stat-value revenue">
                            <%= nf.format(monthlyRevenue) %> ₫
                        </div>
                        <div class="stat-sub">Total revenue (VND)</div>
                    </article>

                </section>

            </main>
        </div>
    </body>
</html>
