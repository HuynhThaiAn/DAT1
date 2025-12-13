<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <title>Import Stock History</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

    <style>
        :root{
            --sidebar-w: 260px;
            --header-h: 78px;

            --bg:#f4f6fb;
            --card:#ffffff;
            --text:#111827;
            --muted:#6b7280;
            --border:rgba(15, 23, 42, 0.10);
            --shadow:0 12px 28px rgba(0,0,0,.08);
        }

        body{ margin:0; background:var(--bg); font-family:"Segoe UI",system-ui,-apple-system,Arial,sans-serif; }
        .app{ min-height:100vh; }

        main.main-content{
            margin-left: var(--sidebar-w);
            width: calc(100% - var(--sidebar-w));
            padding: 24px;
            padding-top: calc(var(--header-h) + 18px);
        }

        .page{ max-width: 1200px; margin: 0 auto; }

        .page-head{
            display:flex;
            justify-content: space-between;
            align-items:flex-end;
            gap: 14px;
            margin-bottom: 14px;
        }
        .page-title{ margin:0; font-weight: 900; color:var(--text); }
        .page-sub{ color:var(--muted); font-size: 13px; margin-top: 4px; }
        .page-actions{ display:flex; gap: 10px; align-items:center; flex-wrap: wrap; }

        .btn-primary-solid{
            border:none;
            border-radius: 14px;
            padding: 10px 14px;
            font-weight: 900;
            color:#fff;
            background: linear-gradient(135deg,#1d4ed8,#2563eb);
            box-shadow: 0 12px 22px rgba(37,99,235,.18);
            display:inline-flex;
            align-items:center;
            gap: 8px;
            transition: transform .15s ease, box-shadow .15s ease;
        }
        .btn-primary-solid:hover{ transform: translateY(-1px); box-shadow: 0 16px 28px rgba(37,99,235,.24); }

        .btn-ghost{
            text-decoration:none;
            border: 1px solid var(--border);
            background:#fff;
            color:#0f172a;
            border-radius: 14px;
            padding: 10px 14px;
            font-weight: 900;
            box-shadow: 0 10px 20px rgba(0,0,0,.06);
            display:inline-flex;
            align-items:center;
            gap: 8px;
        }
        .btn-ghost:hover{ transform: translateY(-1px); }

        .card-box, .card-table{
            background: var(--card);
            border: 1px solid var(--border);
            border-radius: 18px;
            box-shadow: var(--shadow);
            overflow:hidden;
        }
        .card-box{ padding: 14px; margin-bottom: 14px; }

        /* Filter */
        .filter-form{
            display:grid;
            grid-template-columns: repeat(3, minmax(0, 1fr)) auto;
            gap: 12px;
            align-items:end;
        }
        .field label{
            display:block;
            font-weight: 900;
            color: var(--text);
            font-size: 13px;
            margin-bottom: 6px;
        }
        .field input, .field select{
            width: 100%;
            border: 1px solid var(--border);
            border-radius: 14px;
            padding: 10px 12px;
            outline: none;
            background:#fff;
        }
        .field.actions{
            display:flex;
            gap: 10px;
            justify-content:flex-end;
        }
        .btn-filter{
            border:none;
            padding: 10px 14px;
            border-radius: 14px;
            font-weight: 900;
            color:#fff;
            background: linear-gradient(135deg,#0d6efd,#2563eb);
            box-shadow: 0 12px 22px rgba(37,99,235,.16);
            display:inline-flex;
            align-items:center;
            gap: 8px;
        }
        .btn-excel{
            border:none;
            padding: 10px 14px;
            border-radius: 14px;
            font-weight: 900;
            color:#fff;
            background: linear-gradient(135deg,#22c55e,#16a34a);
            box-shadow: 0 12px 22px rgba(34,197,94,.16);
            display:inline-flex;
            align-items:center;
            gap: 8px;
        }
        .btn-filter:hover, .btn-excel:hover{ transform: translateY(-1px); }

        /* Table */
        .table thead th{
            background:#f8fafc;
            border-bottom: 1px solid var(--border);
            color:#475569;
            font-weight: 900;
            font-size: 13px;
            padding: 14px;
            white-space: nowrap;
        }
        .table tbody td{
            padding: 14px;
            color:#0f172a;
            font-size: 14px;
        }
        .btn-detail{
            text-decoration:none;
            display:inline-flex;
            align-items:center;
            gap: 8px;
            padding: 9px 12px;
            border-radius: 12px;
            font-weight: 900;
            color: #0f172a;
            background: #eef2ff;
            border: 1px solid rgba(99,102,241,.20);
        }
        .btn-detail:hover{ transform: translateY(-1px); }

        /* Empty */
        .empty-state{ padding: 44px 18px; text-align:center; }
        .empty-icon{ font-size: 34px; color:#94a3b8; margin-bottom: 10px; }
        .empty-title{ font-weight: 900; color: var(--text); }
        .empty-sub{ color: var(--muted); font-size: 13px; margin-top: 4px; }

        /* Swal */
        .swal2-confirm-green { background-color:#28a745 !important; color:#fff !important; border:none !important; box-shadow:none !important; }
        .swal2-confirm-green:focus, .swal2-confirm-green:hover { background-color:#218838 !important; }

        /* Responsive */
        @media (max-width: 992px){
            main.main-content{ margin-left:0; width:100%; }
            .page-head{ flex-direction: column; align-items: stretch; }
            .filter-form{ grid-template-columns: 1fr; }
            .field.actions{ justify-content:flex-start; flex-wrap: wrap; }
        }
    </style>
</head>

<body>
<div class="app">
    <jsp:include page="/WEB-INF/View/staff/sideBar.jsp" />

    <main class="main-content">
        <jsp:include page="/WEB-INF/View/staff/header.jsp" />

        <div class="page">
            <div class="page-head">
                <div>
                    <h1 class="page-title">Import Stock History</h1>
                    <div class="page-sub">Track import logs and export to Excel</div>
                </div>

                <div class="page-actions">
                    <button class="btn-primary-solid" type="button" onclick="location.href='ImportStock'">
                        <i class="fa-solid fa-plus"></i> New Import
                    </button>

                    <a href="ImportStatistic" class="btn-ghost">
                        <i class="fa-solid fa-arrow-left"></i> Back
                    </a>
                </div>
            </div>

            <div class="card-box">
                <form class="filter-form" method="get" action="ImportStockHistory">
                    <div class="field">
                        <label>From</label>
                        <input type="date" name="from" value="${from != null ? from : ''}" />
                    </div>

                    <div class="field">
                        <label>To</label>
                        <input type="date" name="to" value="${to != null ? to : ''}" />
                    </div>

                    <div class="field">
                        <label>Supplier</label>
                        <select name="supplierId">
                            <option value="">-- All Suppliers --</option>
                            <c:forEach items="${suppliers}" var="s">
                                <option value="${s.supplierID}"
                                        <c:if test="${supplierId != null && supplierId == s.supplierID}">selected</c:if>>
                                    ${s.name}
                                </option>
                            </c:forEach>
                        </select>
                    </div>

                    <div class="field actions">
                        <button type="submit" class="btn-filter" name="action" value="filter">
                            <i class="fa-solid fa-filter"></i> Filter
                        </button>

                        <button type="submit" id="exportExcelBtn" class="btn-excel"
                                name="action" value="export"
                                formaction="ExportToFileExcelServlet" formmethod="post">
                            <i class="fa-solid fa-file-excel"></i> Export Excel
                        </button>
                    </div>
                </form>
            </div>

            <div class="card-table">
                <c:if test="${not empty importHistory}">
                    <div class="table-responsive">
                        <table class="table table-hover align-middle mb-0">
                            <thead>
                            <tr>
                                <th style="width:70px;">#</th>
                                <th>Import Date</th>
                                <th>Supplier</th>
                                <th>Total Amount</th>
                                <th class="text-center" style="width:120px;">Staff ID</th>
                                <th class="text-center" style="width:140px;">Detail</th>
                            </tr>
                            </thead>
                            <tbody>
                            <c:forEach items="${importHistory}" var="imp" varStatus="loop">
                                <tr>
                                    <td class="fw-bold">${loop.index + 1}</td>
                                    <td><fmt:formatDate value="${imp.importDate}" pattern="yyyy-MM-dd HH:mm" /></td>
                                    <td>${imp.supplier.name}</td>
                                    <td class="fw-bold">
                                        <fmt:formatNumber value="${imp.totalAmount}" type="number" groupingUsed="true"/> ₫
                                    </td>
                                    <td class="text-center">${imp.staffId}</td>
                                    <td class="text-center">
                                        <a href="ImportHistoryDetail?id=${imp.ioid}" class="btn-detail">
                                            <i class="fa-regular fa-eye"></i> Detail
                                        </a>
                                    </td>
                                </tr>
                            </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </c:if>

                <c:if test="${empty importHistory}">
                    <div class="empty-state">
                        <div class="empty-icon"><i class="fa-regular fa-folder-open"></i></div>
                        <div class="empty-title">No import history found</div>
                        <div class="empty-sub">Try changing date range or supplier.</div>
                    </div>
                </c:if>
            </div>

        </div>
    </main>
</div>

<script>
    document.getElementById('exportExcelBtn').onclick = function (e) {
        e.preventDefault();

        Swal.fire({
            icon: 'question',
            title: 'Export Excel',
            text: 'Do you want to export the import stock history to Excel?',
            showCancelButton: true,
            confirmButtonText: 'Yes, export',
            cancelButtonText: 'Cancel',
            customClass: { confirmButton: 'swal2-confirm-green' }
        }).then((result) => {
            if (result.isConfirmed) {
                const exportForm = document.createElement('form');
                exportForm.method = 'post';
                exportForm.action = 'ExportToFileExcelServlet';

                const originalForm = this.form;
                const inputs = originalForm.querySelectorAll('input, select');

                inputs.forEach(input => {
                    if (input.name && input.value) {
                        const hiddenInput = document.createElement('input');
                        hiddenInput.type = 'hidden';
                        hiddenInput.name = input.name;
                        hiddenInput.value = input.value;
                        exportForm.appendChild(hiddenInput);
                    }
                });

                const actionInput = document.createElement('input');
                actionInput.type = 'hidden';
                actionInput.name = 'action';
                actionInput.value = 'export';
                exportForm.appendChild(actionInput);

                document.body.appendChild(exportForm);
                exportForm.submit();
                document.body.removeChild(exportForm);
            }
        });

        return false;
    }
</script>

</body>
</html>
