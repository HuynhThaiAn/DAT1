<%
    String currentPage = (String) request.getAttribute("currentPage");
    if (currentPage == null) currentPage = "";
%>

<nav class="bg-dark text-white p-3" style="width:260px; min-height:100vh;">
    <div class="d-flex align-items-center mb-3">
        <span class="fw-bold fs-5">DAT Admin</span>
    </div>

    <div class="nav nav-pills flex-column gap-1">
        <a class="nav-link text-white <%= "AdminDashboard".equals(currentPage) ? "active" : "" %>"
           href="<%= request.getContextPath() %>/AdminDashboard">
            Dashboard
        </a>

        <a class="nav-link text-white <%= "StaffManagement".equals(currentPage) ? "active" : "" %>"
           href="<%= request.getContextPath() %>/Admin/StaffManagement">
            Staff Management
        </a>

        <a class="nav-link text-white <%= "AdminProduct".equals(currentPage) ? "active" : "" %>"
           href="<%= request.getContextPath() %>/Admin/Product">
            Product Management
        </a>

        <a class="nav-link text-white <%= "CategoryManagement".equals(currentPage) ? "active" : "" %>"
           href="<%= request.getContextPath() %>/Admin/CategoryManagement">
            Category Management
        </a>

        <a class="nav-link text-white <%= "BrandManagement".equals(currentPage) ? "active" : "" %>"
           href="<%= request.getContextPath() %>/Admin/BrandManagement">
            Brand Management
        </a>

        <a class="nav-link text-white <%= "ManageStatistic".equals(currentPage) ? "active" : "" %>"
           href="<%= request.getContextPath() %>/ManageStatistic">
            Statistics
        </a>
    </div>
</nav>

<style>
    /* Bootstrap default: .nav-link.active uses primary background.
       If you want "standard admin dark sidebar" feel: */
    .nav-pills .nav-link { border-radius: .375rem; }
    .nav-pills .nav-link:hover { background: rgba(255,255,255,.12); }
    .nav-pills .nav-link.active { background: rgba(255,255,255,.22); }
</style>
