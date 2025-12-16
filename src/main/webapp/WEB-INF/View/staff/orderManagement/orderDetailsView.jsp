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
        <style>
            :root{
                --bg:#f4f6fb;
                --card:#ffffff;
                --text:#0f172a;
                --muted:#64748b;
                --line:#e2e8f0;
                --shadow: 0 14px 40px rgba(15, 23, 42, .08);
                --shadow2: 0 10px 22px rgba(15, 23, 42, .10);
                --brand:#2563eb;
                --brand2:#1d4ed8;
                --radius:16px;
            }

            body{
                background: var(--bg);
                font-family: 'Segoe UI', system-ui, -apple-system, sans-serif;
                color: var(--text);
            }

            /* ========== MAIN LAYOUT (match sidebar/header) ========== */
            .app{
                min-height: 100vh;
                display: flex;
            }

            .main-content{
                flex: 1;
                min-width: 0;
                padding: 22px 22px 28px;
            }

            .page{
                max-width: 1100px;
                margin: 0 auto;
            }

            /* ========== PAGE HEADER ========== */
            .page-head{
                display:flex;
                align-items:flex-start;
                justify-content:space-between;
                gap: 14px;
                margin: 6px 0 18px;
            }

            .page-title{
                font-weight: 800;
                letter-spacing: .2px;
                margin: 0;
                font-size: 28px;
            }

            .page-sub{
                color: var(--muted);
                margin-top: 4px;
                font-size: 14px;
            }

            .btn-back{
                display:inline-flex;
                align-items:center;
                gap: 10px;
                text-decoration:none;
                padding: 10px 14px;
                border-radius: 12px;
                border: 1px solid var(--line);
                background: rgba(255,255,255,.9);
                color: var(--text);
                font-weight: 700;
                box-shadow: 0 8px 18px rgba(15,23,42,.06);
                transition: .18s ease;
                white-space: nowrap;
            }
            .btn-back:hover{
                transform: translateY(-1px);
                box-shadow: var(--shadow2);
                border-color: rgba(37,99,235,.25);
                color: var(--brand2);
            }

            /* ========== STATUS BADGE ========== */
            .badge{
                padding: 7px 12px;
                border-radius: 999px;
                font-weight: 800;
                color: #fff;
                font-size: 13px;
                letter-spacing: .2px;
            }
            .status-1{
                background: #f59e0b;
            } /* Waiting */
            .status-2{
                background: #0d6efd;
            } /* Packaging */
            .status-3{
                background: #6366f1;
            } /* Waiting for Delivery */
            .status-4{
                background: #22c55e;
            } /* Delivered */
            .status-5{
                background: #ef4444;
            } /* Cancelled */

            /* ========== CARD ========== */
            .card-detail{
                background: var(--card);
                border: 1px solid rgba(226,232,240,.9);
                border-radius: var(--radius);
                overflow: hidden;
                box-shadow: var(--shadow);
            }

            .card-top{
                padding: 16px 18px;
                border-bottom: 1px solid var(--line);
                display:flex;
                align-items:center;
                justify-content:space-between;
                gap: 12px;
                background: linear-gradient(180deg, rgba(37,99,235,.06), rgba(255,255,255,1));
            }

            .card-top-title{
                font-weight: 900;
                display:flex;
                align-items:center;
                gap: 10px;
                font-size: 16px;
            }
            .card-top-title i{
                width: 34px;
                height: 34px;
                display:grid;
                place-items:center;
                border-radius: 12px;
                color: var(--brand);
                background: rgba(37,99,235,.10);
                border: 1px solid rgba(37,99,235,.18);
            }

            /* ========== SECTIONS ========== */
            .section{
                padding: 18px 18px 16px;
            }

            .section-title{
                font-weight: 900;
                display:flex;
                align-items:center;
                gap: 10px;
                margin-bottom: 12px;
                font-size: 15px;
            }

            .section-title i{
                color: var(--muted);
            }

            .divider{
                height: 1px;
                background: var(--line);
                margin: 0;
            }

            /* ========== SUMMARY GRID ========== */
            .info-grid{
                display:grid;
                grid-template-columns: repeat(2, minmax(0, 1fr));
                gap: 10px 14px;
            }

            .info-row{
                display:flex;
                align-items:center;
                justify-content:space-between;
                gap: 12px;
                padding: 10px 12px;
                border: 1px solid rgba(226,232,240,.9);
                border-radius: 14px;
                background: #fff;
            }

            .info-row span{
                color: var(--muted);
                font-weight: 700;
                font-size: 13px;
            }

            .info-row b{
                font-weight: 900;
                font-size: 13.5px;
                color: var(--text);
                text-align: right;
            }

            .info-row-full{
                grid-column: 1 / -1;
                justify-content:flex-start;
            }
            .info-row-full b{
                margin-left: auto;
                max-width: 72%;
                text-align: right;
                overflow: hidden;
                text-overflow: ellipsis;
                white-space: nowrap;
            }

            /* ========== ORDER ITEMS ========== */
            .items-list{
                display:flex;
                flex-direction:column;
                gap: 10px;
            }

            .item-row{
                display:flex;
                align-items:flex-start;
                justify-content:space-between;
                gap: 16px;
                padding: 12px 14px;
                border: 1px solid rgba(226,232,240,.9);
                border-radius: 14px;
                background: #fff;
                transition: .15s ease;
            }
            .item-row:hover{
                transform: translateY(-1px);
                box-shadow: 0 10px 22px rgba(15,23,42,.08);
                border-color: rgba(37,99,235,.18);
            }

            .item-sub{
                color: var(--muted);
                font-size: 13px;
                margin-top: 2px;
            }

            .item-price{
                font-weight: 900;
                white-space: nowrap;
            }

            /* ========== MANAGE FORM ========== */
            .manage-form{
                display:flex;
                align-items:flex-end;
                justify-content:space-between;
                gap: 14px;
                flex-wrap: wrap;
                padding-top: 4px;
            }

            .manage-left{
                min-width: 260px;
                flex: 1;
            }

            .manage-label{
                font-weight: 900;
                margin-bottom: 8px;
                display:block;
                color: var(--muted);
                font-size: 13px;
            }

            .form-select{
                border-radius: 14px;
                padding: 10px 12px;
                border: 1px solid rgba(226,232,240,.95);
                box-shadow: none;
            }
            .form-select:focus{
                border-color: rgba(37,99,235,.5);
                box-shadow: 0 0 0 .2rem rgba(37,99,235,.15);
            }

            .manage-actions{
                display:flex;
                align-items:center;
                gap: 10px;
                flex-wrap: wrap;
                justify-content:flex-end;
            }

            .btn-save{
                border: 0;
                border-radius: 14px;
                padding: 10px 14px;
                font-weight: 900;
                color: #fff;
                background: linear-gradient(135deg, var(--brand), var(--brand2));
                box-shadow: 0 12px 26px rgba(37,99,235,.28);
                transition: .18s ease;
                display:inline-flex;
                align-items:center;
                gap: 10px;
            }
            .btn-save:hover{
                transform: translateY(-1px);
                box-shadow: 0 16px 30px rgba(37,99,235,.33);
            }

            .btn-outline{
                display:inline-flex;
                align-items:center;
                justify-content:center;
                gap: 10px;
                padding: 10px 14px;
                border-radius: 14px;
                border: 1px solid rgba(226,232,240,.95);
                background: #fff;
                text-decoration:none;
                color: var(--text);
                font-weight: 900;
                transition: .18s ease;
            }
            .btn-outline:hover{
                border-color: rgba(37,99,235,.25);
                color: var(--brand2);
                transform: translateY(-1px);
                box-shadow: 0 10px 20px rgba(15,23,42,.08);
            }

            /* ========== RESPONSIVE ========== */
            @media (max-width: 768px){
                .main-content{
                    padding: 14px;
                }
                .page-title{
                    font-size: 24px;
                }
                .info-grid{
                    grid-template-columns: 1fr;
                }
                .info-row-full b{
                    max-width: 60%;
                }
                .manage-left{
                    min-width: 100%;
                }
                .manage-actions{
                    width: 100%;
                    justify-content: stretch;
                }
                .btn-save, .btn-outline{
                    width: 100%;
                    justify-content: center;
                }
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

                                                for (let i = 0; i < options.length; i++)
                                                    options[i].disabled = false;

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
