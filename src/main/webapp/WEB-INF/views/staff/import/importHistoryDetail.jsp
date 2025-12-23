<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.*"%>
<%@page import="java.time.format.DateTimeFormatter"%>
<%@page import="java.math.BigDecimal"%>
<%@page import="model.Staff"%>
<%@page import="model.ImportCartItem"%>
<%@page import="dao.ImportDAO.ImportHistoryRow"%>

<%
    Staff staff = (Staff) session.getAttribute("staff");
    if (staff == null) { response.sendRedirect(request.getContextPath()+"/LoginAdmin"); return; }

    ImportHistoryRow header = (ImportHistoryRow) request.getAttribute("header");
    List<ImportCartItem> details = (List<ImportCartItem>) request.getAttribute("details");
    if (details == null) details = new ArrayList<>();

    DateTimeFormatter df = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm");
%>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Import Detail</title>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css">
    </head>
    <body>
        <div class="app">
            <jsp:include page="/WEB-INF/views/staff/common/sideBar.jsp" />
            <main class="main-content">
                <jsp:include page="/WEB-INF/views/staff/common/header.jsp" />

                <div class="page">
                    <div class="d-flex justify-content-between align-items-end mb-3">
                        <div>
                            <h1 class="fw-bold m-0">Import Detail</h1>
                            <div class="text-muted">Import + ImportDetail theo ProductVariant</div>
                        </div>
                        <a class="btn btn-outline-secondary fw-bold" href="<%=request.getContextPath()%>/ImportStockHistory">Back</a>
                    </div>

                    <% if (header == null) { %>
                    <div class="alert alert-danger">Import not found.</div>
                    <% } else { %>
                    <div class="card mb-3">
                        <div class="card-header fw-bold">Summary</div>
                        <div class="table-responsive">
                            <table class="table mb-0">
                                <thead class="table-light">
                                    <tr>
                                        <th>ImportID</th>
                                        <th>StaffID</th>
                                        <th>StaffName</th>
                                        <th>CreatedAt</th>
                                        <th>SupplierName</th>
                                        <th>TotalCost</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr>
                                        <td class="fw-bold"><%= header.getImportID() %></td>
                                        <td><%= header.getStaffID() %></td>
                                        <td class="fw-bold"><%= header.getStaffName() %></td>
                                        <td><%= header.getCreatedAt()==null?"N/A":header.getCreatedAt().format(df) %></td>
                                        <td><%= header.getSupplierName()==null?"":header.getSupplierName() %></td>
                                        <td class="fw-bold"><%= header.getTotalCost()==null?"0":header.getTotalCost().toPlainString() %></td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                    </div>

                    <div class="card">
                        <div class="card-header fw-bold">Details</div>
                        <div class="table-responsive">
                            <table class="table table-hover align-middle mb-0">
                                <thead class="table-light">
                                    <tr>
                                        <th style="width:90px;">VariantID</th>
                                        <th style="width:140px;">SKU</th>
                                        <th>Product</th>
                                        <th>Variant</th>
                                        <th style="width:120px;">Qty</th>
                                        <th style="width:160px;">UnitCost</th>
                                        <th style="width:160px;">LineTotal</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <% if (details.isEmpty()) { %>
                                    <tr><td colspan="7" class="text-center text-muted py-4">No details.</td></tr>
                                    <% } else {
                                        for (ImportCartItem it : details) {
                                            BigDecimal line = (it.getUnitCost()==null||it.getQuantity()==null) ? BigDecimal.ZERO
                                                : it.getUnitCost().multiply(BigDecimal.valueOf(it.getQuantity()));
                                    %>
                                    <tr>
                                        <td class="fw-bold"><%= it.getProductVariantID() %></td>
                                        <td><%= it.getSKU() %></td>
                                        <td class="fw-bold"><%= it.getProductName() %></td>
                                        <td><%= it.getVariantName() %></td>
                                        <td class="fw-bold"><%= it.getQuantity() %></td>
                                        <td class="fw-bold"><%= it.getUnitCost() %></td>
                                        <td class="fw-bold"><%= line.toPlainString() %></td>
                                    </tr>
                                    <% } } %>
                                </tbody>
                            </table>
                        </div>
                    </div>
                    <% } %>
                </div>
            </main>
        </div>
    </body>
</html>
