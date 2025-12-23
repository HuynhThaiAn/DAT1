<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.*"%>
<%@page import="java.time.*"%>
<%@page import="java.time.format.DateTimeFormatter"%>
<%@page import="java.math.BigDecimal"%>
<%@page import="model.Staff"%>
<%@page import="dao.ImportDAO.ImportHistoryRow"%>

<%
    Staff staff = (Staff) session.getAttribute("staff");
    if (staff == null) { response.sendRedirect(request.getContextPath()+"/LoginAdmin"); return; }

    List<ImportHistoryRow> history = (List<ImportHistoryRow>) request.getAttribute("history");
    if (history == null) history = new ArrayList<>();

    LocalDate from = (LocalDate) request.getAttribute("from");
    LocalDate to = (LocalDate) request.getAttribute("to");
    String supplier = (String) request.getAttribute("supplier");

    DateTimeFormatter df = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm");
%>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>Import Stock History</title>
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    </head>
    <body>
        <div class="app">
            <jsp:include page="/WEB-INF/views/staff/common/sideBar.jsp" />
            <main class="main-content">
                <jsp:include page="/WEB-INF/views/staff/common/header.jsp" />

                <div class="page">
                    <div class="d-flex justify-content-between align-items-end mb-3">
                        <div>
                            <h1 class="fw-bold m-0">Import Stock History</h1>
                            <div class="text-muted">Filter theo ngày và SupplierName (text)</div>
                        </div>
                        <div class="d-flex gap-2">
                            <a class="btn btn-primary fw-bold" href="<%=request.getContextPath()%>/ImportStock"><i class="fa-solid fa-plus"></i> New Import</a>
                        </div>
                    </div>

                    <div class="card p-3 mb-3">
                        <form class="row g-2" method="get" action="<%=request.getContextPath()%>/ImportStockHistory">
                            <div class="col-md-3">
                                <label class="form-label fw-bold">From</label>
                                <input class="form-control" type="date" name="from" value="<%= from==null?"":from.toString() %>">
                            </div>
                            <div class="col-md-3">
                                <label class="form-label fw-bold">To</label>
                                <input class="form-control" type="date" name="to" value="<%= to==null?"":to.toString() %>">
                            </div>
                            <div class="col-md-4">
                                <label class="form-label fw-bold">Supplier Name contains</label>
                                <input class="form-control" name="supplier" value="<%= supplier==null?"":supplier %>" placeholder="VD: ABC">
                            </div>
                            <div class="col-md-2 d-grid">
                                <button class="btn btn-success fw-bold" type="submit" style="margin-top:32px;">Filter</button>
                            </div>
                        </form>
                    </div>

                    <div class="card">
                        <div class="table-responsive">
                            <table class="table table-hover align-middle mb-0">
                                <thead class="table-light">
                                    <tr>
                                        <th style="width:80px;">#</th>
                                        <th>CreatedAt</th>
                                        <th>SupplierName</th>
                                        <th>TotalCost</th>
                                        <th style="width:120px;" class="text-center">StaffID</th>
                                        <th style="width:140px;" class="text-center">Detail</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <% if (history.isEmpty()) { %>
                                    <tr><td colspan="6" class="text-center text-muted py-4">No import history.</td></tr>
                                    <% } else {
                                        int idx = 0;
                                        for (ImportHistoryRow r : history) {
                                            idx++;
                                    %>
                                    <tr>
                                        <td class="fw-bold"><%= idx %></td>
                                        <td><%= r.getCreatedAt()==null ? "N/A" : r.getCreatedAt().format(df) %></td>
                                        <td class="fw-bold"><%= r.getSupplierName()==null?"":r.getSupplierName() %></td>
                                        <td class="fw-bold"><%= r.getTotalCost()==null? "0" : r.getTotalCost().toPlainString() %></td>
                                        <td class="text-center"><%= r.getStaffID() %></td>
                                        <td class="text-center">
                                            <a class="btn btn-sm btn-outline-primary fw-bold"
                                               href="<%=request.getContextPath()%>/ImportHistoryDetail?id=<%=r.getImportID()%>">Detail</a>
                                        </td>
                                    </tr>
                                    <% } } %>
                                </tbody>
                            </table>
                        </div>
                    </div>

                </div>
            </main>
        </div>
    </body>
</html>
