<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Order Detail</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" rel="stylesheet">
        <link href="${pageContext.request.contextPath}/Css/profile.css" rel="stylesheet">
        <style>
            /* ==== Order Detail Page Premium UI ==== */

            /* Card tổng */
            .profile-card {
                background:#fff;
                border-radius:20px;
                padding:0;
                box-shadow:0 10px 28px rgba(0,0,0,.06);
                overflow:hidden;
            }

            /* Header đơn */
            .profile-header{
                padding:22px 28px;
                border-bottom:1px solid rgba(0,0,0,.06);
            }
            .profile-header h4{
                font-weight:700;
                font-size:20px;
            }

            /* Thông tin đơn hàng */
            .order-info-box{
                background:#fff;
                padding:26px;
                border-radius:16px;
                margin:22px;
                box-shadow:0 4px 14px rgba(0,0,0,.08);
            }
            .order-info-box p{
                margin-bottom:6px;
                font-size:15px;
                color:#333;
            }
            .order-info-box p strong{
                font-weight:700;
            }

            /* Bảng sản phẩm */
            .detail-table{
                background:white;
                border-radius:14px;
                overflow:hidden;
                margin-top:18px;
            }
            .detail-table th{
                background:#2563eb;
                color:white;
                padding:12px;
            }
            .detail-table td{
                padding:12px 10px;
                font-size:15px;
                color:#333;
            }
            .detail-table tr:nth-child(even){
                background:#f8fbff;
            }

            /* Status badge */
            .badge{
                padding:9px 14px;
                border-radius:999px;
                font-weight:600;
                font-size:14px;
            }
            .status-1{
                background:#facc15;
                color:#111;
            } /* Waiting */
            .status-2{
                background:#3b82f6;
                color:white;
            } /* Packaging */
            .status-3{
                background:#6366f1;
                color:white;
            } /* Waiting for delivery */
            .status-4{
                background:#10b981;
                color:white;
            } /* Delivered */
            .status-5{
                background:#ef4444;
                color:white;
            } /* Cancelled */

            /* Button actions */
            .btn-outline-danger{
                border-radius:10px;
                padding:10px 22px;
                font-weight:600;
            }
            .btn-outline-primary{
                border-radius:10px;
                padding:8px 18px;
                font-weight:600;
                transition:.25s;
            }
            .btn-outline-primary:hover{
                transform:translateY(-2px);
                box-shadow:0 8px 20px rgba(37,99,235,.25);
            }

            /* Modal feedback */
            .modal-content{
                border-radius:14px;
                border:none;
                box-shadow:0 18px 40px rgba(0,0,0,.18);
            }
            .modal-header{
                background:#2563eb;
                color:white;
                border-radius:14px 14px 0 0;
            }
            .modal-footer .btn:first-child{
                background:#10b981;
                border:none;
                font-weight:600;
                padding:8px 18px;
            }
            .modal-footer .btn-secondary{
                border-radius:999px;
            }
            /* Back Button */
            .btn-back-orders{
                background:#e5e7eb;
                color:#111;
                font-weight:600;
                border:none;
                padding:10px 24px;
                border-radius:10px;
                text-decoration:none;
                transition:.25s;
            }
            .btn-back-orders:hover{
                background:#d1d5db;
                transform:translateY(-2px);
                box-shadow:0 8px 22px rgba(0,0,0,.12);
            }

        </style>
    </head>
    <body class="d-flex flex-column min-vh-100">
        <jsp:include page="/WEB-INF/View/customer/homePage/header.jsp" />

        <div class="main-account container-fluid">
            <jsp:include page="/WEB-INF/View/customer/sideBar.jsp" />
            <div class="profile-card flex-grow-1">

                <div class="profile-header">
                    <h4><i class="bi bi-receipt-cutoff me-2"></i>
                        Order Detail — <b>${fn:substringBefore(data.orderDate,' ')}</b>
                    </h4>
                </div>

                <div class="order-info-box">

                    <p><strong><i class="bi bi-calendar-date me-2"></i>Order Date:</strong> ${data.orderDate}</p>
                    <p><strong><i class="bi bi-pencil-square me-2"></i>Updated At:</strong> ${data.updatedDate}</p>
                    <p><strong><i class="bi bi-bar-chart-line me-2"></i>Status:</strong>
                        <span class="badge status-${data.status}">
                            <c:choose>
                                <c:when test="${data.status==1}">Waiting</c:when>
                                <c:when test="${data.status==2}">Packaging</c:when>
                                <c:when test="${data.status==3}">Delivery Pending</c:when>
                                <c:when test="${data.status==4}">Delivered</c:when>
                                <c:otherwise>Cancelled</c:otherwise>
                            </c:choose>
                        </span>
                    </p>
                    <p><strong><i class="bi bi-person-lines-fill me-2"></i>Recipient:</strong> ${data.fullName} — ${data.phone}</p>
                    <p><strong><i class="bi bi-geo-alt-fill me-2"></i>Address:</strong> ${data.addressSnapshot}</p>
                    <p><strong><i class="bi bi-currency-exchange me-2"></i>Total:</strong>
                        <fmt:formatNumber value="${data.totalAmount}" groupingUsed="true"/>₫
                    </p>

                    <h5 class="mt-4 mb-2"><i class="bi bi-box-seam me-1"></i>Product List</h5>

                    <table class="table table-bordered detail-table">
                        <thead>
                            <tr>
                                <th>#</th><th>Product</th><th>Category</th><th>Qty</th><th>Price</th><th>Total</th><th></th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="item" items="${dataDetail}" varStatus="loop">
                                <tr>
                                    <td>${loop.index+1}</td>
                                    <td>${item.productName}</td>
                                    <td>${item.category}</td>
                                    <td>${item.quantity}</td>
                                    <td><fmt:formatNumber value="${item.price}" groupingUsed="true"/>₫</td>
                                    <td><fmt:formatNumber value="${item.price*item.quantity}" groupingUsed="true"/>₫</td>
                                    <td>
                                        <c:if test="${data.status==4}">
                                            <button class="btn btn-outline-primary btn-sm"
                                                    onclick="openFeedbackModal('${item.productID}', '${fn:escapeXml(item.productName)}', '${data.orderID}')">
                                                <i class="bi bi-pencil-square"></i> Feedback
                                            </button>
                                        </c:if>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>

                    <div class="text-end mt-4">
                        <c:if test="${data.status != 4 and data.status != 5}">
                            <form action="CancelOrder" method="post" style="display:inline;">
                                <input type="hidden" name="orderID" value="${data.orderID}">
                                <button type="button" class="btn btn-outline-danger cancel-btn">
                                    <i class="bi bi-x-circle"></i> Cancel Order
                                </button>
                            </form>
                        </c:if>
                    </div>

                </div>

                <div class="text-end mt-4 mb-3" style="padding-right: 26px;">
                    <button type="button" class="btn-back-orders" onclick="history.back()">
                        <i class="bi bi-arrow-left-circle me-2"></i> Back
                    </button>
                </div>

            </div>

        </div>

        <jsp:include page="/WEB-INF/View/customer/homePage/footer.jsp" />
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>


        <!-- SweetAlert on success/error -->
        <c:if test="${not empty param.success || not empty param.error}">
            <script>
                        window.onload = function () {
                <c:if test="${param.success == 'feedback'}">
                            Swal.fire({
                                icon: 'success',
                                title: 'Feedback Submitted',
                                text: 'Your feedback has been submitted successfully!',
                                timer: 3000,
                                confirmButtonText: 'OK'
                            });
                </c:if>
                <c:if test="${param.error == 'feedback'}">
                            Swal.fire({
                                icon: 'error',
                                title: 'Feedback Failed',
                                text: 'There was a problem submitting your feedback. Please try again.',
                                timer: 3000,
                                confirmButtonText: 'Close'
                            });
                </c:if>

                            if (window.history.replaceState) {
                                const url = new URL(window.location);
                                url.searchParams.delete('success');
                                url.searchParams.delete('error');
                                window.history.replaceState({}, document.title, url.pathname + url.search);
                            }

                        };
            </script>

        </c:if>

        <c:if test="${param.error == 'alreadyRated'}">
            <script>
                Swal.fire({
                    icon: 'info',
                    title: 'Feedback Exists',
                    text: 'You have already rated this product for this order.'
                });
            </script>
        </c:if>


        <!-- SweetAlert cancel confirmation -->
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

        <script>
            function openFeedbackModal(productID, productName, orderID) {
                document.getElementById('feedbackProductID').value = productID;
                document.getElementById('feedbackProductName').value = productName;
                document.getElementById('feedbackOrderID').value = orderID;

                const modalElement = document.getElementById('feedbackModal');
                const modal = bootstrap.Modal.getOrCreateInstance(modalElement);
                modal.show();
            }
        </script>


    </body>
</html>