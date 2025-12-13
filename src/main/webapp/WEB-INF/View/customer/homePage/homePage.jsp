<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>DAT - Home</title>
    </head>
    <body class="homepage-shell">
        <jsp:include page="/WEB-INF/View/customer/homePage/header.jsp" />
        <main class="homepage-main">
            <div class="homepage-container">
                <jsp:include page="/WEB-INF/View/customer/homePage/section.jsp" />
                <jsp:include page="/WEB-INF/View/customer/homePage/banner.jsp" />
                <jsp:include page="/WEB-INF/View/customer/homePage/newProduct.jsp" />
                <jsp:include page="/WEB-INF/View/customer/homePage/bestSellerProduct.jsp" />
                <jsp:include page="/WEB-INF/View/customer/homePage/discountProduct.jsp" />
                <jsp:include page="/WEB-INF/View/customer/homePage/featuredProduct.jsp" />
            </div>
        </main>
        <jsp:include page="/WEB-INF/View/customer/homePage/footer.jsp" />
    </body>
</html>
