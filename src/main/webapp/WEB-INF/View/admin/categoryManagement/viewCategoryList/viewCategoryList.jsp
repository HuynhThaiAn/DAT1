<html>
    <head>
        <title>Category View</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/Css/supplierList5.css">
        
        <link rel="stylesheet"
              href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css">

        
        <link rel="stylesheet"
              href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

       
        <link rel="stylesheet" href="${pageContext.request.contextPath}/Css/sidebar-admin.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/Css/adminDashboard.css">
    </head>
    <body>
        <div class="container">
           
            <div class="sidebar">
                <jsp:include page="../../sideBar.jsp" />
            </div>

            <div>
                <jsp:include page="/WEB-INF/View/admin/categoryManagement/viewCategoryList/CategoryView.jsp" />
            </div>
        </div>
    </body>
</html>