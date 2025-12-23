<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.Staff"%>
<%@page import="java.util.List"%>
<%@page import="model.Category"%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Category Management</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
<%
  // ===== Admin login check (MUST be before any HTML output) =====
  Staff staff = (Staff) session.getAttribute("staff");
  if (staff == null || staff.getRole() == null || staff.getRole() != 2) {
      response.sendRedirect(request.getContextPath() + "/LoginAdmin");
      return;
  }

  String ctx = request.getContextPath();
  List<Category> categories = (List<Category>) request.getAttribute("categories");
  if (categories == null) categories = java.util.Collections.emptyList();
%>

<div class="d-flex">
  <jsp:include page="/WEB-INF/views/admin/common/sideBar.jsp" />

  <div class="flex-grow-1">
    <jsp:include page="/WEB-INF/views/admin/common/header.jsp" />

    <main class="p-4">
      <div class="d-flex align-items-center justify-content-between">
        <h3 class="mb-0">Category Management</h3>
        <a class="btn btn-primary" href="<%=ctx%>/Admin/CategoryManagement?action=create">+ Create Category</a>
      </div>

      <div class="text-danger mt-2"><%= request.getAttribute("error")==null?"":request.getAttribute("error") %></div>

      <div class="card shadow-sm mt-3">
        <div class="card-body">
          <div class="table-responsive">
            <table class="table table-hover align-middle">
              <thead>
                <tr>
                  <th style="width:90px;">ID</th>
                  <th>Name</th>
                  <th>Description</th>
                  <th style="width:200px;">Logo</th>
                  <th style="width:220px;" class="text-end">Actions</th>
                </tr>
              </thead>
              <tbody>
              <% if (categories.isEmpty()) { %>
                <tr><td colspan="5" class="text-center text-muted py-4">No categories found.</td></tr>
              <% } else { for (Category c : categories) { %>
                <tr>
                  <td><%=c.getCategoryID()%></td>
                  <td class="fw-semibold"><%=c.getCategoryName()%></td>
                  <td><%=c.getDescription()%></td>
                  <td>
                    <% if (c.getImgUrlLogo() != null && !c.getImgUrlLogo().trim().isEmpty()) { %>
                      <img src="<%=c.getImgUrlLogo()%>" style="height:40px;border-radius:6px;" alt="logo"/>
                    <% } else { %>
                      -
                    <% } %>
                  </td>
                  <td class="text-end">
                    <a class="btn btn-sm btn-outline-primary"
                       href="<%=ctx%>/Admin/CategoryManagement?action=update&id=<%=c.getCategoryID()%>">Edit</a>
                    <a class="btn btn-sm btn-outline-danger"
                       href="<%=ctx%>/Admin/CategoryManagement?action=delete&id=<%=c.getCategoryID()%>"
                       onclick="return confirm('Delete this category?');">Delete</a>
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
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
