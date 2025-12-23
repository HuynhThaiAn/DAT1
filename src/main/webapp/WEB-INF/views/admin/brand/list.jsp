<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.Staff"%>
<%@page import="java.util.List"%>
<%@page import="model.Brand"%>

<%
  // ===== Admin login check (MUST be before any HTML output) =====
  Staff staff = (Staff) session.getAttribute("staff");
  if (staff == null || staff.getRole() == null || staff.getRole() != 2) {
      response.sendRedirect(request.getContextPath() + "/LoginAdmin");
      return;
  }

  String ctx = request.getContextPath();
  List<Brand> brands = (List<Brand>) request.getAttribute("brands");
  if (brands == null) brands = java.util.Collections.emptyList();
%>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Brand Management</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    </head>
    <body class="bg-light">

        <div class="d-flex">
            <jsp:include page="/WEB-INF/views/admin/common/sideBar.jsp" />

            <div class="flex-grow-1">
                <jsp:include page="/WEB-INF/views/admin/common/header.jsp" />

                <main class="p-4">
                    <div class="d-flex align-items-center justify-content-between">
                        <h3 class="mb-0">Brand Management</h3>
                        <a class="btn btn-primary" href="<%=ctx%>/Admin/BrandManagement?action=create">+ Create Brand</a>
                    </div>

                    <div class="text-danger mt-2"><%= request.getAttribute("error")==null?"":request.getAttribute("error") %></div>

                    <div class="card shadow-sm mt-3">
                        <div class="card-body">
                            <div class="table-responsive">
                                <table class="table table-hover align-middle">
                                    <thead>
                                        <tr>
                                            <th style="width:90px;">ID</th>
                                            <th style="width:180px;">Logo</th>
                                            <th>Brand Name</th>
                                            <th>Description</th>
                                            <th style="width:220px;" class="text-end">Actions</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <% if (brands.isEmpty()) { %>
                                        <tr><td colspan="5" class="text-center text-muted py-4">No brands found.</td></tr>
                                        <% } else { for (Brand b : brands) {
                                              String logo = b.getLogoUrl();
                                        %>
                                        <tr>
                                            <td><%= b.getBrandID() %></td>
                                            <td>
                                                <% if (logo != null && !logo.trim().isEmpty()) { %>
                                                <img src="<%= logo %>" alt="logo"
                                                     style="height:44px; max-width:160px; object-fit:contain;">
                                                <% } else { %>
                                                <span class="text-muted">No logo</span>
                                                <% } %>
                                            </td>
                                            <td class="fw-semibold"><%= b.getBrandName() %></td>
                                            <td style="max-width:520px;">
                                                <div class="text-truncate" style="max-width:520px;">
                                                    <%= (b.getDescription() == null ? "" : b.getDescription()) %>
                                                </div>
                                            </td>
                                            <td class="text-end">
                                                <a class="btn btn-sm btn-outline-primary"
                                                   href="<%=ctx%>/Admin/BrandManagement?action=update&id=<%= b.getBrandID() %>">Update</a>
                                                <a class="btn btn-sm btn-outline-danger"
                                                   href="<%=ctx%>/Admin/BrandManagement?action=delete&id=<%= b.getBrandID() %>"
                                                   onclick="return confirm('Delete this brand?');">Delete</a>
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
