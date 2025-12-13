<div class="sidebar-overlay" id="sidebarOverlay"></div>

<%
    String currentPage = (String) request.getAttribute("currentPage");
    if (currentPage == null) currentPage = "";
%>

<nav class="admin-sidebar" id="admin-sidebar">
    <div class="admin-sidebar-header">
        <h2><i class="fas fa-store"></i> <span>DAT Admin</span></h2>
    </div>

    <ul class="admin-nav">

        <li class="admin-nav-item">
            <a href="AdminDashboard"
               class="admin-nav-link <%= "AdminDashboard".equals(currentPage) ? "active" : "" %>">
               <i class="fas fa-tachometer-alt"></i><span>Dashboard</span>
            </a>
        </li>

        <li class="admin-nav-item">
            <a href="StaffList"
               class="admin-nav-link <%= "StaffList".equals(currentPage) ? "active" : "" %>">
               <i class="fas fa-user-tie"></i><span>Staff Management</span>
            </a>
        </li>

        <li class="admin-nav-item">
            <a href="AdminProduct"
               class="admin-nav-link <%= "AdminProduct".equals(currentPage) ? "active" : "" %>">
               <i class="fas fa-box"></i><span>Product Management</span>
            </a>
        </li>

        <li class="admin-nav-item">
            <a href="CategoryView"
               class="admin-nav-link <%= "CategoryView".equals(currentPage) ? "active" : "" %>">
               <i class="fas fa-tags"></i><span>Category Management</span>
            </a>
        </li>

        <li class="admin-nav-item">
            <a href="Voucher"
               class="admin-nav-link <%= "Voucher".equals(currentPage) ? "active" : "" %>">
               <i class="fas fa-ticket-alt"></i><span>Voucher Management</span>
            </a>
        </li>

        <li class="admin-nav-item">
            <a href="ViewSupplier"
               class="admin-nav-link <%= "ViewSupplier".equals(currentPage) ? "active" : "" %>">
               <i class="fas fa-truck"></i><span>Supplier Management</span>
            </a>
        </li>

        <li class="admin-nav-item">
            <a href="ManageStatistic"
               class="admin-nav-link <%= "ManageStatistic".equals(currentPage) ? "active" : "" %>">
               <i class="fa fa-bar-chart"></i><span>Statistics</span>
            </a>
        </li>

    </ul>
</nav>
