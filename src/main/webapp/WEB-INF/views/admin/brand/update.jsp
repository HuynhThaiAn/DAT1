<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Update Brand</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
  <div class="d-flex">
    <jsp:include page="/WEB-INF/views/admin/common/sideBar.jsp" />

    <main class="flex-grow-1 p-4">
      <h3>Update Brand</h3>

      <div class="card shadow-sm mt-3" style="max-width: 720px;">
        <div class="card-body">
          <div class="text-danger mb-2">${error}</div>

          <form method="post"
                action="${pageContext.request.contextPath}/Admin/BrandManagement"
                enctype="multipart/form-data">
            <input type="hidden" name="action" value="update"/>
            <input type="hidden" name="id" value="${brand.brandID}"/>
            <input type="hidden" name="oldLogoUrl" value="${brand.logoUrl}"/>

            <div class="mb-3">
              <label class="form-label">Brand Name</label>
              <input class="form-control" name="brandName" value="${brand.brandName}" required />
            </div>

            <div class="mb-3">
              <label class="form-label">Description</label>
              <textarea class="form-control" name="description" rows="4">${brand.description}</textarea>
            </div>

            <div class="mb-3">
              <label class="form-label">Current Logo</label>
              <div>
                <c:choose>
                  <c:when test="${not empty brand.logoUrl}">
                    <img src="${brand.logoUrl}" alt="logo" style="height:60px; max-width:220px; object-fit:contain;">
                  </c:when>
                  <c:otherwise>
                    <span class="text-muted">No logo</span>
                  </c:otherwise>
                </c:choose>
              </div>
            </div>

            <div class="mb-3">
              <label class="form-label">Logo (upload new - optional)</label>
              <input class="form-control" type="file" name="logoFile" accept="image/*" />
              <div class="form-text">If you don’t upload, the old logo will be kept.</div>
            </div>

            <div class="d-flex gap-2">
              <button class="btn btn-primary" type="submit">Update</button>
              <a class="btn btn-secondary"
                 href="${pageContext.request.contextPath}/Admin/BrandManagement?action=list">
                Back
              </a>
            </div>
          </form>
        </div>
      </div>
    </main>
  </div>

  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

  <%-- If bạn không dùng JSTL thì xóa block <c:choose> ở trên.
       Nếu bạn có JSTL thì thêm taglib này ở đầu file:
       <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
  --%>
</body>
</html>
