<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Category List</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    </head>
    <body class="bg-light">
        <div class="d-flex">
            <jsp:include page="/WEB-INF/views/admin/common/sideBar.jsp" />
            <jsp:include page="/WEB-INF/views/admin/common/header.jsp" />



            <main class="flex-grow-1 p-4">
                <div class="d-flex justify-content-between align-items-center mb-3">
                    <h3 class="mb-0">Category List</h3>
                    <a class="btn btn-primary"
                       href="${pageContext.request.contextPath}/Admin/CategoryManagement?action=create">
                        + Create
                    </a>
                </div>

                <div class="card shadow-sm">
                    <div class="card-body table-responsive">
                        <table class="table table-hover align-middle">
                            <thead class="table-dark">
                                <tr>
                                    <th style="width:80px;">ID</th>
                                    <th>Name</th>
                                    <th>Description</th>
                                    <th>Logo</th>
                                    <th style="width:170px;">Action</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach items="${categories}" var="c">
                                    <tr>
                                        <td>${c.categoryID}</td>
                                        <td class="fw-semibold">${c.categoryName}</td>
                                        <td>${c.description}</td>
                                        <td>
                                            <c:if test="${not empty c.imgUrlLogo}">
                                                <img src="${c.imgUrlLogo}" style="height:40px;border-radius:6px;" alt="logo"/>
                                            </c:if>
                                            <c:if test="${empty c.imgUrlLogo}">-</c:if>
                                            </td>
                                            <td>
                                                <a class="btn btn-sm btn-warning"
                                                   href="${pageContext.request.contextPath}/Admin/CategoryManagement?action=update&id=${c.categoryID}">
                                                Edit
                                            </a>
                                            <a class="btn btn-sm btn-danger"
                                               href="${pageContext.request.contextPath}/Admin/CategoryManagement?action=delete&id=${c.categoryID}"
                                               onclick="return confirm('Delete this category?');">
                                                Delete
                                            </a>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </div>

            </main>
        </div>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>
