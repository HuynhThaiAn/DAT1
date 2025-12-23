<%
    String currentPage = (String) request.getAttribute("currentPage");
    if (currentPage == null) currentPage = "";
%>

<nav class="bg-dark text-white p-3" style="width:260px; min-height:100vh;">
    <div class="d-flex align-items-center mb-3">
        <span class="fw-bold fs-5">DAT Staff</span>
    </div>

    <div class="nav nav-pills flex-column gap-1">
        <a class="nav-link text-white <%= "StaffDashboard".equals(currentPage) ? "active" : "" %>"
           href="<%= request.getContextPath() %>/StaffDashboard">
            Dashboard
        </a>

        <a class="nav-link text-white <%= "StaffOrder".equals(currentPage) ? "active" : "" %>"
           href="<%= request.getContextPath() %>/stafforder">
            Order Management
        </a>

        <a class="nav-link text-white <%= "StaffStock".equals(currentPage) ? "active" : "" %>"
           href="<%= request.getContextPath() %>/staffstock">
            Stock / Inventory
        </a>

        <a class="nav-link text-white <%= "StaffCustomerManagement".equals(currentPage) ? "active" : "" %>"
           href="<%= request.getContextPath() %>/StaffCustomerManagement">
            Customer Management
        </a>
    </div>
</nav>

<style>
    .nav-pills .nav-link { border-radius: .375rem; }
    .nav-pills .nav-link:hover { background: rgba(255,255,255,.12); }
    .nav-pills .nav-link.active { background: rgba(255,255,255,.22); }
</style>
