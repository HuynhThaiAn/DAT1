<%@page import="model.Product"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%
    Product product = (Product) request.getAttribute("product");
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title><%= (product != null ? product.getProductName() : "Product") %> - Product Detail</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/Css/customerProductDetail.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

        <style>
            body {
                background-color: #F2F4F7;
                font-family: system-ui, -apple-system, BlinkMacSystemFont, "Segoe UI", sans-serif;
            }

            .fa-star.checked {
                color: #f59e0b;
            }

            /* ===== Layout tổng ===== */
            .product-detail-page {
                max-width: 1200px;
                margin: 28px auto 40px;
                padding: 0 16px;
            }

            .product-layout {
                display: flex;
                align-items: flex-start;
                gap: 24px;
            }

            .product-main {
                flex: 0 0 62%;
                display: flex;
                flex-direction: column;
                gap: 16px;
            }

            .product-sidebar {
                flex: 0 0 38%;
            }

            .card-block {
                background-color: #ffffff;
                border-radius: 14px;
                padding: 16px 18px;
                box-shadow: 0 10px 30px rgba(15, 23, 42, 0.06);
            }

            .customerDivImageDetail,
            .customerDivCommitted,
            .customerDivinfomationDetail,
            .customerDivaddToCartAndBuyNow {
                border-radius: 14px;
                background-color: #ffffff;
            }

            /* ===== Breadcrumb ===== */
            .product-breadcrumb {
                display: flex;
                align-items: center;
                flex-wrap: wrap;
                gap: 6px;
                font-size: 13px;
                color: #6b7280;
                margin-bottom: 8px;
            }

            .product-breadcrumb a {
                text-decoration: none;
                color: #3b82f6;
            }

            .product-breadcrumb a:hover {
                text-decoration: underline;
            }

            .product-breadcrumb .current {
                color: #111827;
                font-weight: 500;
            }

            /* ===== Title ===== */
            .product-title {
                font-size: 22px;
                font-weight: 700;
                margin-bottom: 16px;
                color: #111827;
            }

            /* ===== Feedback section ===== */
            .customerFeedbackSection {
                margin-top: 6px;
            }

            .feedback-section-card {
                border-radius: 14px;
                background-color: #ffffff;
                padding: 18px 18px 20px;
                box-shadow: 0 10px 30px rgba(15, 23, 42, 0.04);
            }

            .feedback-header {
                text-align: center;
                margin-bottom: 18px;
                position: relative;
            }

            .feedback-header-line {
                border: none;
                height: 1px;
                background: #e5e7eb;
                margin: 0;
            }

            .feedback-header-title {
                font-size: 18px;
                font-weight: 700;
                margin: -14px auto 0;
                background: #ffffff;
                display: inline-block;
                padding: 0 16px;
                color: #111827;
            }

            .feedback-empty {
                font-size: 14px;
                text-align: center;
                color: #9ca3af;
                margin-top: 8px;
            }

            .feedback-card {
                border-radius: 10px;
                border: 1px solid #e5e7eb;
                padding: 12px 14px;
                margin-bottom: 12px;
                background: #f9fafb;
            }

            .feedback-card-header {
                display: flex;
                justify-content: space-between;
                align-items: center;
                gap: 8px;
                font-size: 13px;
            }

            .feedback-card-header strong {
                color: #111827;
            }

            .feedback-card-header small {
                color: #9ca3af;
            }

            .feedback-stars {
                margin: 6px 0;
                font-size: 14px;
            }

            .feedback-stars .fa-star {
                margin-right: 2px;
                color: #d1d5db;
            }

            .feedback-stars .fa-star.checked {
                color: #f59e0b;
            }

            .feedback-comment {
                margin-top: 4px;
                font-size: 14px;
                color: #374151;
                line-height: 1.5;
            }

            .feedback-staff-wrapper {
                margin-top: 10px;
                padding: 9px 10px;
                border-radius: 8px;
                border: 1px solid #3b82f6;
                background-color: #eff6ff;
            }

            .staff-reply {
                margin-top: 8px;
                padding: 8px 10px;
                background: #e0f2fe;
                border-left: 4px solid #2563eb;
                border-radius: 6px;
            }

            .staff-reply:first-child {
                margin-top: 0;
            }

            .staff-reply-label {
                display: inline-block;
                font-size: 13px;
                font-weight: 600;
                color: #1d4ed8;
                margin-bottom: 2px;
            }

            .staff-reply-text {
                margin: 0;
                font-size: 13px;
                color: #1f2933;
            }

            /* ===== Sidebar sticky ===== */
            .sidebar-sticky {
                position: sticky;
                top: 90px;
            }

            /* ===== Responsive ===== */
            @media (max-width: 992px) {
                .product-layout {
                    flex-direction: column;
                }
                .product-main,
                .product-sidebar {
                    flex: 1 1 100%;
                }
                .sidebar-sticky {
                    position: static;
                }
            }

            @media (max-width: 576px) {
                .product-detail-page {
                    margin-top: 20px;
                    padding: 0 10px;
                }
                .product-title {
                    font-size: 19px;
                    margin-bottom: 12px;
                }
                .card-block {
                    padding: 14px 14px;
                }
            }
        </style>
    </head>

    <body>
        <jsp:include page="/WEB-INF/View/customer/homePage/header.jsp" />

        <div class="product-detail-page">
            <c:if test="${product == null}">
                <p>Product not found.</p>
            </c:if>

            <c:if test="${product != null}">
                <!-- Breadcrumb -->
                <div class="product-breadcrumb">
                    <a href="${pageContext.request.contextPath}/Home">Home</a>
                    <span>&gt;</span>
                    <a href="#">${product.categoryName}</a>
                    <span>&gt;</span>
                    <span class="current">${product.productName}</span>
                </div>

                <!-- Title -->
                <h1 class="product-title">${product.productName}</h1>

                <!-- Layout 2 cột -->
                <div class="product-layout">
                    <!-- LEFT -->
                    <div class="product-main">
                        <div class="customerDivImageDetail card-block">
                            <jsp:include page="/WEB-INF/View/customer/productManagement/productDetail/imageProduct.jsp" />
                        </div>

                        <div class="customerDivCommitted card-block">
                            <jsp:include page="/WEB-INF/View/customer/productManagement/productDetail/committed.jsp" />
                        </div>

                        <div class="customerDivinfomationDetail card-block">
                            <jsp:include page="/WEB-INF/View/customer/productManagement/productDetail/infomationDetail.jsp" />
                        </div>

                        <!-- Feedback -->
                        <div class="customerFeedbackSection">
                            <div class="feedback-section-card">
                                <div class="feedback-header">
                                    <hr class="feedback-header-line">
                                    <h2 class="feedback-header-title">Customer Feedback</h2>
                                </div>

                                <c:if test="${empty productRatings}">
                                    <p class="feedback-empty">No feedback available for this product.</p>
                                </c:if>

                                <c:forEach var="rating" items="${productRatings}">
                                    <div class="feedback-card">
                                        <div class="feedback-card-header">
                                            <strong>${rating.fullName}</strong>
                                            <small>${rating.createdDate}</small>
                                        </div>

                                        <div class="feedback-stars">
                                            <c:forEach begin="1" end="5" var="i">
                                                <c:choose>
                                                    <c:when test="${i <= rating.star}">
                                                        <i class="fa fa-star checked"></i>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <i class="fa fa-star"></i>
                                                    </c:otherwise>
                                                </c:choose>
                                            </c:forEach>
                                        </div>

                                        <p class="feedback-comment">${rating.comment}</p>

                                        <!-- Staff replies -->
                                        <c:if test="${not empty rating.replies}">
                                            <div class="feedback-staff-wrapper">
                                                <c:forEach var="reply" items="${rating.replies}">
                                                    <div class="staff-reply">
                                                        <span class="staff-reply-label">Staff Response</span>
                                                        <p class="staff-reply-text">${reply.answer}</p>
                                                    </div>
                                                </c:forEach>
                                            </div>
                                        </c:if>
                                    </div>
                                </c:forEach>
                            </div>
                        </div>
                    </div>

                    <!-- RIGHT -->
                    <div class="product-sidebar">
                        <div class="customerDivaddToCartAndBuyNow card-block sidebar-sticky">
                            <jsp:include page="/WEB-INF/View/customer/productManagement/productDetail/addToCartAndBuyNow.jsp" />
                        </div>
                    </div>
                </div>
            </c:if>
        </div>

        <jsp:include page="/WEB-INF/View/customer/homePage/footer.jsp" />

        <%
            String successcreate = request.getParameter("successcreate");
            String checkquantity = request.getParameter("checkquantity");
        %>

        <script>
            window.onload = function () {
                var success = '<%= successcreate%>';
                var error = '<%= checkquantity%>';

                if (success === '1') {
                    Swal.fire({
                        icon: 'success',
                        title: 'Success!',
                        text: 'Product has been added to cart.',
                        timer: 2000
                    });
                } else if (error === '1') {
                    Swal.fire({
                        icon: 'error',
                        title: 'Failed!',
                        text: 'The quantity of product in stock is not enough to order.',
                        timer: 2000
                    });
                }
            };
        </script>
    </body>
</html>
