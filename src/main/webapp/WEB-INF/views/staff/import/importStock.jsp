<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.*"%>
<%@page import="java.math.BigDecimal"%>
<%@page import="model.Staff"%>
<%@page import="model.ImportCartItem"%>

<%
    Staff staff = (Staff) session.getAttribute("staff");
    if (staff == null) {
        response.sendRedirect(request.getContextPath() + "/LoginAdmin"); // đổi theo route login của bạn
        return;
    }

    List<ImportCartItem> variantList = (List<ImportCartItem>) request.getAttribute("variantList");
    if (variantList == null) variantList = new ArrayList<>();

    List<ImportCartItem> cart = (List<ImportCartItem>) session.getAttribute("importCart");
    if (cart == null) cart = new ArrayList<>();

    String importError = (String) session.getAttribute("importError");
    if (importError != null) session.removeAttribute("importError");

    BigDecimal sum = BigDecimal.ZERO;
    for (ImportCartItem it : cart) {
        if (it.getUnitCost() != null && it.getQuantity() != null) {
            sum = sum.add(it.getUnitCost().multiply(BigDecimal.valueOf(it.getQuantity())));
        }
    }
%>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8" />
        <title>Import Stock</title>
        <meta name="viewport" content="width=device-width, initial-scale=1"/>

        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet" />

        <style>
            :root{
                --sidebar-w:260px;
                --header-h:78px;
                --bg:#f4f6fb;
                --card:#fff;
                --text:#111827;
                --muted:#6b7280;
                --border:rgba(15,23,42,.10);
                --shadow:0 12px 28px rgba(0,0,0,.08);
            }
            body{
                margin:0;
                background:var(--bg);
                font-family:"Segoe UI",system-ui,-apple-system,Arial,sans-serif;
            }
            .app{
                min-height:100vh;
            }
            main.main-content{
                margin-left:var(--sidebar-w);
                width:calc(100% - var(--sidebar-w));
                padding:24px;
                padding-top:calc(var(--header-h) + 18px);
            }
            .page{
                max-width:1200px;
                margin:0 auto;
            }
            .page-title{
                margin:0;
                font-weight:900;
                color:var(--text);
            }
            .page-sub{
                color:var(--muted);
                font-size:13px;
                margin-top:4px;
            }

            .card-table{
                background:var(--card);
                border:1px solid var(--border);
                border-radius:18px;
                box-shadow:var(--shadow);
                overflow:hidden;
            }
            .card-head{
                padding:14px 16px;
                display:flex;
                align-items:center;
                justify-content:space-between;
                gap:10px;
                border-bottom:1px solid var(--border);
                background:#f8fafc;
            }
            .card-head-title{
                font-weight:900;
                color:#0f172a;
                display:flex;
                align-items:center;
                gap:10px;
            }
            .card-actions{
                padding:14px 16px;
                display:flex;
                justify-content:flex-end;
                gap:10px;
                border-top:1px solid var(--border);
                background:#fff;
            }

            .btn-detail{
                border:1px solid rgba(99,102,241,.20);
                background:#eef2ff;
                color:#0f172a;
                border-radius:14px;
                padding:10px 12px;
                font-weight:900;
                display:inline-flex;
                align-items:center;
                gap:8px;
                text-decoration:none;
            }
            .btn-success-solid{
                border:none;
                border-radius:14px;
                padding:10px 14px;
                font-weight:900;
                color:#fff;
                background:linear-gradient(135deg,#22c55e,#16a34a);
                box-shadow:0 12px 22px rgba(34,197,94,.16);
            }
            .btn-ghost{
                border:1px solid var(--border);
                background:#fff;
                color:#0f172a;
                border-radius:14px;
                padding:10px 14px;
                font-weight:900;
            }

            .table thead th{
                background:#f8fafc;
                border-bottom:1px solid var(--border);
                font-weight:900;
                font-size:13px;
                color:#475569;
                white-space:nowrap;
            }
            .table tbody td{
                font-size:14px;
                color:#0f172a;
                vertical-align:middle;
            }

            @media (max-width:992px){
                main.main-content{
                    margin-left:0;
                    width:100%;
                }
            }
        </style>
    </head>

    <body>
        <div class="app">
            <jsp:include page="/WEB-INF/views/staff/common/sideBar.jsp" />
            <main class="main-content">
                <jsp:include page="/WEB-INF/views/staff/common/header.jsp" />

                <div class="page">
                    <div class="mb-3">
                        <h1 class="page-title">Import Stock</h1>
                        <div class="page-sub">Nhập SupplierName (text) + chọn ProductVariant để nhập kho</div>
                    </div>

                    <% if (importError != null && !importError.isBlank()) { %>
                    <div class="alert alert-danger"><%= importError %></div>
                    <% } %>

                    <!-- Supplier input -->
                    <div class="card-table mb-3">
                        <div class="card-head">
                            <div class="card-head-title"><i class="fa-solid fa-building"></i> Supplier</div>
                        </div>
                        <div class="p-3">
                            <div class="row g-2">
                                <div class="col-md-6">
                                    <label class="form-label fw-bold">Supplier Name</label>
                                    <input class="form-control" form="submitImportForm" name="supplierName" placeholder="VD: Công ty ABC (chỉ lưu text)" />
                                </div>
                                <div class="col-md-6">
                                    <label class="form-label fw-bold">Note</label>
                                    <input class="form-control" form="submitImportForm" name="note" placeholder="Ghi chú (tuỳ chọn)" />
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Selected variants -->
                    <div class="card-table mb-3">
                        <div class="card-head">
                            <div class="card-head-title"><i class="fa-solid fa-boxes-stacked"></i> Selected Product Variants</div>
                            <button class="btn-detail" type="button" data-bs-toggle="modal" data-bs-target="#variantModal">
                                <i class="fa-solid fa-hand-pointer"></i> Select ProductVariant
                            </button>
                        </div>

                        <div class="table-responsive">
                            <table class="table table-hover align-middle mb-0">
                                <thead>
                                    <tr>
                                        <th style="width:90px;">VariantID</th>
                                        <th style="width:140px;">SKU</th>
                                        <th>Product</th>
                                        <th>Variant</th>
                                        <th style="width:120px;">Qty</th>
                                        <th style="width:160px;">Unit Cost</th>
                                        <th style="width:160px;">Line Total</th>
                                        <th class="text-center" style="width:180px;">Action</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <% if (cart.isEmpty()) { %>
                                    <tr><td colspan="8" class="text-center text-muted py-4">Chưa chọn ProductVariant nào.</td></tr>
                                    <% } else { %>
                                    <% for (ImportCartItem it : cart) {
                                        BigDecimal line = (it.getUnitCost()==null || it.getQuantity()==null) ? BigDecimal.ZERO
                                                : it.getUnitCost().multiply(BigDecimal.valueOf(it.getQuantity()));
                                    %>
                                    <tr>
                                        <td class="fw-bold"><%= it.getProductVariantID() %></td>
                                        <td><%= it.getSKU() %></td>
                                        <td class="fw-bold"><%= it.getProductName() %></td>
                                        <td><%= it.getVariantName() %></td>

                                        <td>
                                            <form class="d-flex gap-2" method="post" action="<%=request.getContextPath()%>/ImportStock">
                                                <input type="hidden" name="action" value="update"/>
                                                <input type="hidden" name="variantId" value="<%=it.getProductVariantID()%>"/>
                                                <input class="form-control" type="number" min="1" name="quantity" value="<%=it.getQuantity()%>" style="max-width:110px"/>
                                        </td>
                                        <td>
                                            <input class="form-control" type="number" min="0" name="unitCost" value="<%=it.getUnitCost()%>" step="1000" style="max-width:150px"/>
                                        </td>
                                        <td class="fw-bold"><%= line.toPlainString() %></td>
                                        <td class="text-center">
                                            <button class="btn btn-warning fw-bold me-2" type="submit">Update</button>
                                            </form>

                                            <form method="post" action="<%=request.getContextPath()%>/ImportStock" style="display:inline">
                                                <input type="hidden" name="action" value="delete"/>
                                                <input type="hidden" name="variantId" value="<%=it.getProductVariantID()%>"/>
                                                <button class="btn btn-danger fw-bold" type="submit">Delete</button>
                                            </form>
                                        </td>
                                    </tr>
                                    <% } %>

                                    <tr class="table-light">
                                        <td colspan="6" class="text-end fw-bold">Total:</td>
                                        <td class="fw-bold"><%= sum.toPlainString() %></td>
                                        <td></td>
                                    </tr>
                                    <% } %>
                                </tbody>
                            </table>
                        </div>

                        <div class="card-actions">
                            <form id="submitImportForm" method="post" action="<%=request.getContextPath()%>/ImportStock" class="d-flex gap-2">
                                <input type="hidden" name="action" value="submit"/>
                                <button type="submit" class="btn-success-solid">
                                    <i class="fa-solid fa-truck-ramp-box"></i> Import
                                </button>
                            </form>

                            <form method="post" action="<%=request.getContextPath()%>/ImportStock">
                                <input type="hidden" name="action" value="clear"/>
                                <button type="submit" class="btn-ghost">Clear</button>
                            </form>

                            <a class="btn-ghost" href="<%=request.getContextPath()%>/ImportStockHistory">History</a>
                        </div>
                    </div>
                </div>
            </main>
        </div>

        <!-- Variant Modal -->
        <div class="modal fade" id="variantModal" tabindex="-1" aria-hidden="true">
            <div class="modal-dialog modal-xl modal-dialog-scrollable">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title fw-bold">Select ProductVariant</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                    </div>

                    <div class="modal-body">
                        <form class="row g-2 mb-3" method="get" action="<%=request.getContextPath()%>/ImportStock">
                            <div class="col-md-10">
                                <input class="form-control" name="keyword" placeholder="Search by ProductName / SKU / VariantName" value="<%= request.getParameter("keyword")==null?"":request.getParameter("keyword") %>"/>
                            </div>
                            <div class="col-md-2 d-grid">
                                <button class="btn btn-primary fw-bold" type="submit">Search</button>
                            </div>
                        </form>

                        <div class="table-responsive">
                            <table class="table table-hover align-middle" id="variantTable">
                                <thead>
                                    <tr>
                                        <th style="width:90px;">VariantID</th>
                                        <th style="width:140px;">SKU</th>
                                        <th>Product</th>
                                        <th>Variant</th>
                                        <th style="width:130px;">In Stock</th>
                                        <th style="width:150px;">Sale Price</th>
                                        <th style="width:120px;">Qty</th>
                                        <th style="width:160px;">Unit Cost</th>
                                        <th style="width:120px;">Add</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <% if (variantList.isEmpty()) { %>
                                    <tr><td colspan="9" class="text-center text-muted py-4">No variants found.</td></tr>
                                    <% } else { %>
                                    <% for (ImportCartItem v : variantList) { %>
                                    <tr>
                                        <td class="fw-bold"><%= v.getProductVariantID() %></td>
                                        <td><%= v.getSKU() %></td>
                                        <td class="fw-bold"><%= v.getProductName() %></td>
                                        <td><%= v.getVariantName() %></td>
                                        <td><%= v.getStockQuantity() %></td>
                                        <td><%= v.getSalePrice() %></td>
                                        <td colspan="4">
                                            <form class="d-flex gap-2" method="post" action="<%=request.getContextPath()%>/ImportStock">
                                                <input type="hidden" name="action" value="add"/>
                                                <input type="hidden" name="variantId" value="<%= v.getProductVariantID() %>"/>
                                                <input class="form-control" type="number" min="1" name="quantity" value="1" style="max-width:110px"/>
                                                <input class="form-control" type="number" min="0" name="unitCost" step="1000" value="<%= v.getSalePrice() %>" style="max-width:170px"/>
                                                <button class="btn btn-success fw-bold" type="submit">Add</button>
                                            </form>
                                        </td>
                                    </tr>
                                    <% } %>
                                    <% } %>
                                </tbody>
                            </table>
                        </div>
                    </div>

                    <div class="modal-footer">
                        <button class="btn btn-secondary fw-bold" type="button" data-bs-dismiss="modal">Close</button>
                    </div>
                </div>
            </div>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>
