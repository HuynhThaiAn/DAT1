<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Create Category</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
  <div class="d-flex">
    <jsp:include page="/WEB-INF/views/admin/common/sideBar.jsp" />

    <main class="flex-grow-1 p-4">
      <h3>Create Category</h3>

      <div class="card shadow-sm mt-3" style="max-width: 720px;">
        <div class="card-body">
          <div class="text-danger mb-2">${error}</div>

          <form method="post"
                action="${pageContext.request.contextPath}/Admin/CategoryManagement"
                enctype="multipart/form-data">
            <input type="hidden" name="action" value="create"/>

            <div class="mb-3">
              <label class="form-label">Category Name</label>
              <input class="form-control" name="categoryName" required />
            </div>

            <div class="mb-3">
              <label class="form-label">Description</label>
              <textarea class="form-control" name="description" rows="4"></textarea>
            </div>

            <div class="mb-3">
              <label class="form-label">Logo (upload)</label>
              <input class="form-control" type="file" name="logoFile" accept="image/*" />
            </div>

            <div class="d-flex gap-2">
              <button class="btn btn-primary" type="submit">Save</button>
              <a class="btn btn-secondary"
                 href="${pageContext.request.contextPath}/Admin/CategoryManagement?action=list">
                Back
              </a>
            </div>
          </form>
        </div>
      </div>
    </main>
  </div>

  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
