<!-- My Orders History (Updated with unified CSS classes) -->
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Orders History</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" rel="stylesheet">
        <link href="${pageContext.request.contextPath}/Css/profile.css" rel="stylesheet">

        <style>
            /* UI tổng thể Order History */
            .profile-card {
                background: #ffffff;
                border-radius: 20px;
                box-shadow: 0 10px 32px rgba(0,0,0,.06);
                padding-bottom: 10px;
            }

            /* Khung card từng đơn hàng */
            .order-item {
                background: #fff;
                border-radius: 16px;
                padding: 22px 26px;
                margin-bottom: 24px;
                border: 1px solid rgba(0,0,0,.06);
                box-shadow: 0 4px 18px rgba(0,0,0,.07);
                transition: .25s ease;
            }
            .order-item:hover {
                transform: translateY(-3px);
                box-shadow: 0 12px 32px rgba(0,0,0,.10);
            }

            /* Header mỗi order */
            .order-header {
                display: flex;
                justify-content: space-between;
                align-items: center;
                margin-bottom: 14px;
            }

            /* Badge trạng thái */
            .badge {
                border-radius: 999px;
                padding: 9px 14px;
                font-weight: 600;
                font-size: 14px;
            }

            /* Status màu mới mềm hơn */
            .status-1 {
                background:#facc15;
                color:#111;
            }     /* Waiting */
            .status-2 {
                background:#3b82f6;
                color:#fff;
            }     /* Packaging */
            .status-3 {
                background:#6366f1;
                color:#fff;
            }     /* Wait for Delivery */
            .status-4 {
                background:#10b981;
                color:#fff;
            }     /* Delivered */
            .status-5 {
                background:#ef4444;
                color:#fff;
            }     /* Cancelled */

            /* Bảng thông tin đơn */
            .order-table th {
                width: 200px;
                font-weight:600;
                font-size:15.2px;
            }
            .order-table td {
                font-size:15px;
                color:#333;
            }

            /* Vùng cuộn */
            .scrollable-orders {
                max-height:650px;
                overflow-y:auto;
                padding-right:8px;
            }
            .scrollable-orders::-webkit-scrollbar{
                width:6px;
            }
            .scrollable-orders::-webkit-scrollbar-thumb{
                background:#b3bcc9;
                border-radius:10px;
            }

            /* Nút */
            .btn-update {
                background:linear-gradient(135deg,#2563eb,#3b82f6);
                border:none;
                color:#fff;
                font-weight:600;
                border-radius:10px;
                padding:10px 26px;
                font-size:14px;
                transition:.25s;
            }
            .btn-update:hover {
                transform:translateY(-2px);
                box-shadow:0 8px 20px rgba(37,99,235,.35);
            }

            .btn-cancel {
                background:linear-gradient(135deg,#ef4444,#f87171);
                border:none;
                color:white!important;
                padding:10px 24px;
                font-size:14px;
                border-radius:10px;
                transition:.25s;
            }
            .btn-cancel:hover {
                transform:translateY(-2px);
                box-shadow:0 8px 20px rgba(239,68,68,.35);
            }

        </style>

    </head>

    <body class="d-flex flex-column min-vh-100">
        <jsp:include page="/WEB-INF/View/customer/homePage/header.jsp" />
        <div class="main-account container-fluid">
            <!-- Sidebar -->
            <jsp:include page="/WEB-INF/View/customer/sideBar.jsp" />

            <!-- Main Content -->
            <div class="profile-card flex-grow-1">
                <div class="profile-header">
                    <h4><i class="bi bi-bag-check-fill me-2"></i> My Orders History</h4>
                </div>
                <div class="profile-body scrollable-orders">
                    <c:choose>
                        <c:when test="${not empty orderList}">
                            <c:forEach var="order" items="${orderList}">
                                <div class="order-item">
                                    <div class="order-header">
                                        <div class="fw-semibold fs-5">
                                            <i class="bi bi-receipt-cutoff me-2"></i>
                                            Order Date: <b>${fn:substringBefore(order.orderDate,' ')}</b>
                                        </div>

                                        <span class="badge status-${order.status}">
                                            <c:choose>
                                                <c:when test="${order.status==1}">Waiting</c:when>
                                                <c:when test="${order.status==2}">Packaging</c:when>
                                                <c:when test="${order.status==3}">Delivery Waiting</c:when>
                                                <c:when test="${order.status==4}">Delivered</c:when>
                                                <c:otherwise>Cancelled</c:otherwise>
                                            </c:choose>
                                        </span>
                                    </div>

                                    <table class="table order-table table-borderless">
                                        <tr><th><i class="bi bi-calendar-check me-2"></i>Order Date:</th> <td>${order.orderDate}</td></tr>
                                        <tr><th><i class="bi bi-clock-history me-2"></i>Last Update:</th> <td>${order.updatedDate}</td></tr>
                                        <tr><th><i class="bi bi-cash-stack me-2"></i>Total Amount:</th>
                                            <td><fmt:formatNumber value="${order.totalAmount}" groupingUsed="true"/> ₫</td></tr>
                                        <tr><th><i class="bi bi-person-lines-fill me-2"></i>Recipient:</th> <td>${order.fullName} — ${order.phone}</td></tr>
                                        <tr><th><i class="bi bi-geo-alt-fill me-2"></i>Address:</th> <td>${order.addressSnapshot}</td></tr>
                                    </table>

                                    <div class="d-flex gap-3 mt-2">
                                        <a href="CustomerOrderDetail?orderID=${order.orderID}" class="btn-update">
                                            <i class="bi bi-eye"></i> View Detail
                                        </a>

                                        <c:if test="${order.status==1 || order.status==2}">
                                            <form action="CancelOrder" method="POST">
                                                <input type="hidden" name="orderID" value="${order.orderID}"/>
                                                <button type="button" class="btn-cancel cancel-btn">
                                                    <i class="bi bi-x-circle"></i> Cancel Order
                                                </button>
                                            </form>
                                        </c:if>
                                    </div>
                                </div>

                            </c:forEach>
                        </c:when>
                        <c:otherwise>
                            <div class="alert alert-info mt-4">
                                <i class="bi bi-info-circle me-2"></i> You haven't placed any orders yet.
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </div>

        <jsp:include page="/WEB-INF/View/customer/homePage/footer.jsp" />

        <!-- Scripts -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
        <!-- SweetAlert for cancel confirmation -->
        <script>
            document.addEventListener('DOMContentLoaded', function () {
                document.querySelectorAll('.cancel-btn').forEach(function (button) {
                    button.addEventListener('click', function () {
                        const form = button.closest('form');
                        Swal.fire({
                            title: 'Are you sure?',
                            text: "Do you want to cancel this order?",
                            icon: 'warning',
                            showCancelButton: true,
                            confirmButtonColor: '#d33',
                            cancelButtonColor: '#3085d6',
                            confirmButtonText: 'Yes, cancel it!',
                            cancelButtonText: 'No'
                        }).then((result) => {
                            if (result.isConfirmed) {
                                form.submit();
                            }
                        });
                    });
                });
            });


        </script>


        <!-- SweetAlert for server response -->
        <c:if test="${not empty success || not empty error}">
            <script>
                window.onload = function () {
                <c:if test="${success == 'cancel'}">
                    Swal.fire({
                        icon: 'success',
                        title: 'Order Cancelled',
                        text: 'Order cancelled successfully.',
                        timer: 3000,
                        confirmButtonText: 'OK'
                    });
                </c:if>
                <c:if test="${error == 'not-cancelable'}">
                    Swal.fire({
                        icon: 'error',
                        title: 'Action Not Allowed',
                        text: 'Cannot cancel the order unless it is in Waiting or Packing status.',
                        timer: 3000,
                        confirmButtonText: 'Close'
                    });
                </c:if>

                    // Remove query params
                    const url = new URL(window.location);
                    url.searchParams.delete('success');
                    url.searchParams.delete('error');
                    window.history.replaceState({}, document.title, url.pathname);
                };
            </script>
        </c:if>
    </body>
</html>