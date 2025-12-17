<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="model.Product"%>
<%@page import="model.ProductImage"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Product Images</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    </head>
    <body class="bg-light">
        <%
          String ctx = request.getContextPath();
          Product product = (Product) request.getAttribute("product");
          List<ProductImage> images = (List<ProductImage>) request.getAttribute("images");
          if (images == null) images = java.util.Collections.emptyList();

          int productId = (product == null) ? 0 : product.getProductID();
        %>

        <div class="d-flex">
            <jsp:include page="/WEB-INF/views/admin/common/sideBar.jsp" />

            <main class="flex-grow-1 p-4">
                <div class="d-flex align-items-center justify-content-between">
                    <div>
                        <h3 class="mb-1">Product Images (Step 2)</h3>
                        <div class="text-muted">ProductID: <%=productId%> - <%=product==null?"":product.getProductName()%></div>
                    </div>

                    <div class="d-flex gap-2">
                        <a class="btn btn-outline-primary"
                           href="<%=ctx%>/Admin/Product?action=variants&productId=<%=productId%>">Go to Variants</a>
                        <a class="btn btn-secondary" href="<%=ctx%>/Admin/Product?action=list">Back</a>
                    </div>
                </div>

                <div class="text-danger mt-2"><%= request.getAttribute("error")==null?"":request.getAttribute("error") %></div>

                <div class="card shadow-sm mt-3" style="max-width: 980px;">
                    <div class="card-body">
                        <form method="post"
                              action="<%=ctx%>/Admin/Product"
                              enctype="multipart/form-data">
                            <input type="hidden" name="action" value="addImages"/>
                            <input type="hidden" name="productId" value="<%=productId%>"/>

                            <div class="mb-3">
                                <label class="form-label">Upload Sub Images (multiple)</label>
                                <input class="form-control" type="file" name="subImages" accept="image/*" multiple />
                                <div class="form-text">These will be saved as sub images (IsMain = 0).</div>
                            </div>

                            <button class="btn btn-primary" type="submit">Upload</button>
                        </form>

                        <hr/>

                        <h5 class="mb-3">Current Images</h5>
                        <div class="table-responsive">
                            <table class="table table-hover align-middle">
                                <thead>
                                    <tr>
                                        <th style="width:90px;">ID</th>
                                        <th style="width:190px;">Preview</th>
                                        <th>Url</th>
                                        <th style="width:110px;">IsMain</th>
                                        <th style="width:220px;" class="text-end">Actions</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <% if (images.isEmpty()) { %>
                                    <tr><td colspan="5" class="text-center text-muted py-4">No images.</td></tr>
                                    <% } else { for (ProductImage img : images) { %>
                                    <tr>
                                        <td><%=img.getImageID()%></td>
                                        <td>
                                            <img src="<%=img.getImageUrl()%>" style="height:56px; max-width:170px; object-fit:contain;" alt="img">
                                        </td>
                                        <td style="max-width:420px;">
                                            <div class="text-truncate" style="max-width:420px;"><%=img.getImageUrl()%></div>
                                        </td>
                                        <td><%= Boolean.TRUE.equals(img.getIsMain()) ? "Yes" : "No" %></td>

                                        <td class="text-end">
                                            <a class="btn btn-sm btn-outline-secondary"
                                               href="<%=ctx%>/Admin/Product?action=setMainImage&productId=<%=productId%>&imageId=<%=img.getImageID()%>">
                                                Set Main
                                            </a>
                                            <a class="btn btn-sm btn-outline-danger"
                                               href="<%=ctx%>/Admin/Product?action=deleteImage&productId=<%=productId%>&imageId=<%=img.getImageID()%>"
                                               onclick="return confirm('Delete this image?');">
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
