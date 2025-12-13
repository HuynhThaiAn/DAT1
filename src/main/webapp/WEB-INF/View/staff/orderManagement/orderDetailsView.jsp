<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>Order Details</title>
        <meta name="viewport" content="width=device-width, initial-scale=1">

        <!-- Bootstrap & FontAwesome -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" />
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet" />

        <!-- Custom Styles -->
        
        <link rel="stylesheet" href="${pageContext.request.contextPath}/Css/supplierList5.css" />
        <style>
            body {
                background-color: #f4f6fb;
                font-family: 'Segoe UI', sans-serif;
            }

            .status-1 {
                background-color: #f59e0b;
            } /* Waiting */
            .status-2 {
                background-color: #0d6efd;
            } /* Packaging */
            .status-3 {
                background-color: #6366f1;
            } /* Waiting for Delivery */
            .status-4 {
                background-color: #22c55e;
            } /* Delivered */
            .status-5 {
                background-color: #ef4444;
            } /* Cancelled */

            .badge {
                padding: 6px 12px;
                border-radius: 999px;
                font-weight: 600;
                color: #fff;
                font-size: 14px;
            }

            .card h4 {
                font-weight: 700;
            }

            .form-select {
                border-radius: 8px;
            }

            .btn {
                border-radius: 8px;
                font-weight: 600;
            }
        </style>
    </head>
<body>

    <div class="app">
        <jsp:include page="../sideBar.jsp" />

        <main class="main-content">
            <jsp:include page="../header.jsp" />

            <div class="page">
                <div class="page-head">
                    <div>
                        <h1 class="page-title">Order Details</h1>
                        <div class="page-sub">View and update order status</div>
                    </div>

                    <a href="${pageContext.request.contextPath}/ViewOrderList" class="btn-back">
                        <i class="fa-solid fa-arrow-left"></i> Back to list
                    </a>
                </div>

                <div class="card-detail">
                    <div class="card-top">
                        <div class="card-top-title">
                            <i class="fa-solid fa-receipt"></i> Order Detail
                        </div>

                        <span class="badge status-${data.status}">
                            <c:choose>
                                <c:when test="${data.status == 1}">Waiting</c:when>
                                <c:when test="${data.status == 2}">Packaging</c:when>
                                <c:when test="${data.status == 3}">Waiting for Delivery</c:when>
                                <c:when test="${data.status == 4}">Delivered</c:when>
                                <c:when test="${data.status == 5}">Cancelled</c:when>
                            </c:choose>
                        </span>
                    </div>

                    <div class="card-body p-0">
                        <div class="section">
                            <div class="section-title">
                                <i class="fa-regular fa-file-lines"></i> Summary
                            </div>

                            <div class="info-grid">
                                <div class="info-row"><span>Order ID</span><b>#${data.orderID}</b></div>
                                <div class="info-row"><span>Order Date</span><b>${data.orderDate}</b></div>
                                <div class="info-row"><span>Total Amount</span>
                                    <b><fmt:formatNumber value="${data.totalAmount}" type="number" groupingUsed="true" />₫</b>
                                </div>
                                <div class="info-row"><span>Discount</span><b>${data.discount}</b></div>

                                <div class="info-row"><span>Customer</span><b>${data.fullName}</b></div>
                                <div class="info-row"><span>Phone</span><b>${data.phone}</b></div>
                                <div class="info-row info-row-full"><span>Address</span><b>${data.addressSnapshot}</b></div>
                            </div>
                        </div>

                        <div class="divider"></div>

                        <div class="section">
                            <div class="section-title">
                                <i class="fa-solid fa-box"></i> Order Items
                            </div>

                            <div class="items-list">
                                <c:forEach items="${dataDetail}" var="detail">
                                    <div class="item-row">
                                        <div class="item-name">
                                            <div class="fw-bold">${detail.productName}</div>
                                            <div class="item-sub">
                                                Qty: <b>${detail.quantity}</b>
                                            </div>
                                        </div>
                                        <div class="item-price">
                                            <fmt:formatNumber value="${detail.price}" type="number" groupingUsed="true" />₫
                                        </div>
                                    </div>
                                </c:forEach>
                            </div>
                        </div>

                        <div class="divider"></div>

                        <div class="section">
                            <div class="section-title">
                                <i class="fa-solid fa-cogs"></i> Manage Order
                            </div>

                            <c:if test="${not empty errorMessage}">
                                <div class="alert alert-danger mt-2">${errorMessage}</div>
                            </c:if>

                            <form action="${pageContext.request.contextPath}/UpdateOrder" method="POST"
                                  class="manage-form">
                                <input type="hidden" name="orderID" value="${data.orderID}" />

                                <div class="manage-left">
                                    <label class="manage-label" for="orderStatus">Order Status</label>
                                    <select id="orderStatus" name="update" class="form-select" onchange="disableOptions()">
                                        <option value="1" <c:if test="${data.status == 1}">selected</c:if>>Waiting</option>
                                        <option value="2" <c:if test="${data.status == 2}">selected</c:if>>Packaging</option>
                                        <option value="3" <c:if test="${data.status == 3}">selected</c:if>>Waiting for Delivery</option>
                                        <option value="4" <c:if test="${data.status == 4}">selected</c:if>>Delivered</option>
                                        <option value="5" <c:if test="${data.status == 5}">selected</c:if>>Cancelled</option>
                                    </select>
                                </div>

                                <div class="manage-actions">
                                    <button type="submit" class="btn-save">
                                        <i class="fa-regular fa-floppy-disk"></i> Save
                                    </button>
                                    <a href="${pageContext.request.contextPath}/ViewOrderList" class="btn-outline">
                                        Back
                                    </a>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>

            </div>
        </main>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

    <script>
        function disableOptions() {
            const select = document.getElementById('orderStatus');
            const status = select.value;
            const options = select.options;

            for (let i = 0; i < options.length; i++) options[i].disabled = false;

            if (status === '3') {
                options[0].disabled = true; // 1
                options[1].disabled = true; // 2
                options[4].disabled = true; // 5
            } else if (status === '2') {
                options[0].disabled = true; // 1
            } else if (status === '4') {
                options[0].disabled = true;
                options[1].disabled = true;
                options[2].disabled = true;
                options[4].disabled = true;
            } else if (status === '5') {
                options[0].disabled = true;
                options[1].disabled = true;
                options[2].disabled = true;
                options[3].disabled = true;
            }
        }
        disableOptions();
    </script>

</body>

</html>
