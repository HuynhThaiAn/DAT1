<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.Staff"%>
<%
    // Login check (admin + staff đều dùng session "staff")
    Staff staff = (Staff) session.getAttribute("staff");
    if (staff == null) {
        response.sendRedirect(request.getContextPath() + "/LoginAdmin");
        return;
    }

    String displayName = (staff.getFullName() != null && !staff.getFullName().trim().isEmpty())
            ? staff.getFullName()
            : staff.getEmail();

    String roleText = "";
    if (staff.getRole() != null) {
        if (staff.getRole() == 2) roleText = "Admin";
        else if (staff.getRole() == 1) roleText = "Staff";
        else roleText = "Role " + staff.getRole();
    }
%>

<header class="bg-white border-bottom">
    <div class="container-fluid px-4 py-3 d-flex align-items-center justify-content-between">
        <div class="d-flex align-items-center gap-3">
            <div class="rounded-circle d-flex align-items-center justify-content-center"
                 style="width:44px;height:44px;background:#3b82f6;color:#fff;font-weight:700;">
                <%= displayName.substring(0, 1).toUpperCase() %>
            </div>

            <div class="lh-sm">
                <div class="fw-semibold"><%= displayName %></div>
                <div class="text-muted" style="font-size:13px;"><%= roleText %></div>
            </div>
        </div>

        <div class="d-flex align-items-center gap-2">
            <%-- Staff được đổi mật khẩu. Admin cũng có thể đổi nếu bạn muốn. --%>
            <% if (staff.getRole() != null && (staff.getRole() == 1 || staff.getRole() == 2)) { %>
                <a class="btn btn-outline-secondary"
                   href="<%=request.getContextPath()%>/ChangePassword">
                    Change Password
                </a>
            <% } %>

            <a class="btn btn-danger d-flex align-items-center gap-2"
               href="<%=request.getContextPath()%>/Logout">
                <span style="display:inline-block;transform:translateY(-1px);">⎋</span>
                Logout
            </a>
        </div>
    </div>
</header>
