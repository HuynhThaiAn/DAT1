<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Product Management - DAT Admin</title>

        <!-- Bootstrap CSS (nếu anh đang dùng) -->
        <link rel="stylesheet"
              href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css">

        <!-- Font Awesome -->
        <link rel="stylesheet"
              href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

        <!-- CSS Admin Sidebar + Dashboard -->
        <link rel="stylesheet" href="${pageContext.request.contextPath}/Css/sidebar-admin.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/Css/adminDashboard.css">

        <style>
            /* Padding cho vùng content, KHÔNG đụng class .container của Bootstrap */
            .admin-page-container {
                padding-left: 47px;
                padding-right: 47px;
            }

            .admin-main-content {
                margin-left: 220px;        /* khớp với width .admin-sidebar */
                min-height: 100vh;
                padding-top: 24px;
                padding-bottom: 32px;
                background: #f3f4f6;
                box-sizing: border-box;
            }
        </style>
    </head>
    <body>
        <%-- SIDEBAR CỐ ĐỊNH BÊN TRÁI --%>
        <jsp:include page="../../sideBar.jsp" />

        <%-- VÙNG NỘI DUNG CHÍNH BÊN PHẢI --%>
        <main class="admin-main-content admin-page-container">
            <jsp:include page="/WEB-INF/View/admin/productManagement/viewProductList/fillterProductList.jsp" />
            <jsp:include page="/WEB-INF/View/admin/productManagement/viewProductList/productList.jsp" />
        </main>

        <!-- JS Bootstrap (nếu cần) -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
        <!-- SweetAlert2 (nếu productList.jsp dùng Swal) -->
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    </body>
</html>
