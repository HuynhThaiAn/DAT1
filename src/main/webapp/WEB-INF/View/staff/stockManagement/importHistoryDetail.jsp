<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <title>Import Stock Detail</title>
        <meta charset="UTF-8">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/Css/supplierList5.css">
    </head>
    <body>
        <div class="app">
            <jsp:include page="../sideBar.jsp" />

            <main class="main-content">
                <jsp:include page="/WEB-INF/View/staff/header.jsp" />

                <div class="page">
                    <div class="page-head">
                        <div>
                            <h1 class="page-title">Import Stock Detail</h1>
                            <div class="page-sub">View import summary and product line items</div>
                        </div>

                        <a href="ImportStockHistory" class="btn-ghost">
                            <i class="fa-solid fa-arrow-left"></i> Back
                        </a>
                    </div>

                    <c:if test="${not empty error}">
                        <div class="alert alert-danger">${error}</div>
                    </c:if>

                    <!-- Summary card -->
                    <div class="card-table mb-3">
                        <div class="card-head">
                            <div class="card-head-title">
                                <i class="fa-solid fa-receipt"></i> Summary
                            </div>
                        </div>

                        <div class="table-responsive">
                            <table class="table table-hover align-middle mb-0" aria-label="Import summary table">
                                <thead>
                                    <tr>
                                        <th>Import ID</th>
                                        <th>Staff ID</th>
                                        <th>Staff Name</th>
                                        <th>Date</th>
                                        <th>Supplier</th>
                                        <th class="text-center">Amount</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr>
                                        <td class="fw-bold">${importStock.ioid}</td>
                                        <td>${importStock.staffId}</td>
                                        <td class="fw-bold">${importStock.fullName}</td>
                                        <td><fmt:formatDate value="${importStock.importDate}" pattern="yyyy-MM-dd HH:mm" /></td>
                                        <td>${importStock.supplier.name}</td>
                                        <td class="text-center fw-bold">
                                            <fmt:formatNumber value="${importStock.totalAmount}" type="currency"
                                                              currencySymbol="₫" groupingUsed="true" minFractionDigits="0"/>
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                    </div>

                    <!-- Details card -->
                    <div class="card-table">
                        <div class="card-head">
                            <div class="card-head-title">
                                <i class="fa-solid fa-list"></i> Details
                            </div>
                        </div>

                        <div class="table-responsive">
                            <table class="table table-hover align-middle mb-0" aria-label="Import detail items table">
                                <thead>
                                    <tr>
                                        <th style="width:120px;">Product ID</th>
                                        <th>Product Name</th>
                                        <th style="width:140px;">Quantity</th>
                                        <th class="text-center" style="width:180px;">Import Price</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach items="${details}" var="d">
                                        <tr>
                                            <td class="fw-bold">${d.product.productId}</td>
                                            <td>${d.product.productName}</td>
                                            <td class="fw-bold">${d.quantity}</td>
                                            <td class="text-center fw-bold">
                                                <fmt:formatNumber value="${d.unitPrice}" type="currency"
                                                                  currencySymbol="₫" groupingUsed="true" minFractionDigits="0"/>
                                            </td>
                                        </tr>
                                    </c:forEach>

                                    <c:if test="${empty details}">
                                        <tr>
                                            <td colspan="4" class="text-center text-muted py-4">No detail items found.</td>
                                        </tr>
                                    </c:if>
                                </tbody>
                            </table>
                        </div>

                        <div class="card-actions">
                            <a href="ImportStockHistory" class="btn-ghost">Back</a>
                        </div>
                    </div>
                </div>

            </main>
        </div>
    </body>
</html>
