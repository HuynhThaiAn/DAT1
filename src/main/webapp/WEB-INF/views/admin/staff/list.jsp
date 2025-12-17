<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="model.Staff"%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Staff Management</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
<%
  List<Staff> staffs = (List<Staff>) request.getAttribute("staffs");
  if (staffs == null) staffs = java.util.Collections.emptyList();
  String ctx = request.getContextPath();
%>

<div class="d-flex">
  <jsp:include page="/WEB-INF/views/admin/common/sideBar.jsp" />
  <jsp:include page="/WEB-INF/views/admin/common/header.jsp" />


  <main class="flex-grow-1 p-4">
    <div class="d-flex align-items-center justify-content-between">
      <h3 class="mb-0">Staff Management</h3>
      <a class="btn btn-primary" href="<%=ctx%>/Admin/StaffManagement?action=create">+ Create Staff</a>
    </div>

    <div class="card shadow-sm mt-3">
      <div class="card-body">
        <div class="text-danger mb-2">
          <%= (request.getAttribute("error") == null ? "" : request.getAttribute("error")) %>
        </div>

        <div class="table-responsive">
          <table class="table table-hover align-middle">
            <thead>
              <tr>
                <th style="width:80px;">ID</th>
                <th>Email</th>
                <th>Full Name</th>
                <th style="width:140px;">Phone</th>
                <th style="width:140px;">DOB</th>
                <th style="width:110px;">Gender</th>
                <th style="width:110px;">Role</th>
                <th style="width:220px;" class="text-end">Actions</th>
              </tr>
            </thead>
            <tbody>
            <% if (staffs.isEmpty()) { %>
              <tr>
                <td colspan="8" class="text-center text-muted py-4">No staff found.</td>
              </tr>
            <% } else { 
                 for (Staff s : staffs) {
                   String genderText = "";
                   if (s.getGender() == null) genderText = "";
                   else if (s.getGender() == 1) genderText = "Male";
                   else if (s.getGender() == 0) genderText = "Female";
                   else genderText = "Other";

                   String roleText = "";
                   if (s.getRole() == null) roleText = "";
                   else if (s.getRole() == 1) roleText = "Staff";
                   else if (s.getRole() == 2) roleText = "Admin";
                   else roleText = "Role " + s.getRole();
            %>
              <tr>
                <td><%= s.getStaffID() %></td>
                <td><%= s.getEmail() %></td>
                <td><%= s.getFullName() %></td>
                <td><%= (s.getPhone() == null ? "" : s.getPhone()) %></td>
                <td><%= (s.getDateOfBirth() == null ? "" : s.getDateOfBirth().toString()) %></td>
                <td><%= genderText %></td>
                <td><%= roleText %></td>
                <td class="text-end">
                  <a class="btn btn-sm btn-outline-primary"
                     href="<%=ctx%>/Admin/StaffManagement?action=update&id=<%=s.getStaffID()%>">
                    Update
                  </a>
                  <a class="btn btn-sm btn-outline-danger"
                     href="<%=ctx%>/Admin/StaffManagement?action=delete&id=<%=s.getStaffID()%>"
                     onclick="return confirm('Delete this staff?');">
                    Delete
                  </a>
                </td>
              </tr>
            <% } } %>
            </tbody>
          </table>
        </div>
      </div>
    </div>
  </main>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
