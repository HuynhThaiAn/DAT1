<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
    <head>
        <title>Stock Management</title>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/Css/supplierList6.css">

        <style>

            .charts-grid {
                display: grid;
                grid-template-columns: 1fr 1fr;
                gap: 32px;
                margin-bottom: 40px;
            }
            .chart-card {
                background: #fff;
                border-radius: 18px;
                box-shadow: 0 4px 20px rgba(0,0,0,0.08);
                padding: 28px 18px;
                display: flex;
                justify-content: center;
                align-items: center;
                height: 380px;
                min-width: 320px;
            }
            .btn-primary {
                margin-right: 8px;
                border: none;
                border-radius: 8px;
                padding: 10px 20px;
                font-weight: 500;
            }
            .btn-success, .btn-secondary {
                border: none;
                border-radius: 8px;
                padding: 10px 20px;
                font-weight: 500;
            }
            .form-control, .form-select {
                border-radius: 8px;
                border: 1px solid #ddd;
                padding: 10px 12px;
            }
            .form-control:focus, .form-select:focus {
                border-color: #667eea;
                box-shadow: 0 0 0 0.2rem rgba(102, 126, 234, 0.25);
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
                        <h1 class="page-title">Import Statistic</h1>
                        <div class="page-sub">Overview of import activity by day, month, supplier, and product</div>
                    </div>

                    <div class="page-actions">
                        <button class="btn-ghost" type="button" onclick="location.href='ImportStockHistory'">
                            <i class="fa-solid fa-clock-rotate-left"></i> Import History
                        </button>
                        <button class="btn-primary-solid" type="button" onclick="location.href='ImportStock'">
                            <i class="fa-solid fa-plus"></i> New Import
                        </button>
                    </div>
                </div>

                <div class="charts-grid">
                    <div class="chart-card">
                        <div class="chart-title">Daily Stock Import</div>
                        <div class="chart-canvas">
                            <canvas id="dailyStockChart"></canvas>
                        </div>
                    </div>

                    <div class="chart-card">
                        <div class="chart-title">Monthly Stock Import</div>
                        <div class="chart-canvas">
                            <canvas id="monthlyStockChart"></canvas>
                        </div>
                    </div>

                    <div class="chart-card">
                        <div class="chart-title">Stock Import by Supplier</div>
                        <div class="chart-canvas">
                            <canvas id="supplierStockChart"></canvas>
                        </div>
                    </div>

                    <div class="chart-card">
                        <div class="chart-title">Stock Import by Product</div>
                        <div class="chart-canvas">
                            <canvas id="productStockChart"></canvas>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Chart.js -->
            <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
            <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

            <script>
                // Daily Import
                const dailyLabels = [<c:forEach items="${dailyImport}" var="entry">"${entry.key}",</c:forEach>];
                const dailyData = [<c:forEach items="${dailyImport}" var="entry">${entry.value},</c:forEach>];

                // Monthly Import
                const monthlyLabels = [<c:forEach items="${monthlyImport}" var="entry">"${entry.key}",</c:forEach>];
                const monthlyData = [<c:forEach items="${monthlyImport}" var="entry">${entry.value},</c:forEach>];

                // Top Suppliers
                const supplierLabels = [<c:forEach items="${supplierImport}" var="entry">"${entry.key}",</c:forEach>];
                const supplierData = [<c:forEach items="${supplierImport}" var="entry">${entry.value},</c:forEach>];

                // Top Products
                const productLabels = [<c:forEach items="${topProductImportShort}" var="entry">"${entry.key}",</c:forEach>];
                const productData = [<c:forEach items="${topProductImportShort}" var="entry">${entry.value},</c:forEach>];

                const chartOpts = {
                    responsive: true,
                    maintainAspectRatio: false,
                    plugins: {
                        legend: { display: true, position: 'top' }
                    },
                    layout: { padding: 10 },
                    scales: {
                        y: { beginAtZero: true, ticks: { callback: (v) => v.toLocaleString() } }
                    }
                };

                new Chart(document.getElementById('dailyStockChart'), {
                    type: 'bar',
                    data: { labels: dailyLabels, datasets: [{ label: 'Import Order', data: dailyData, backgroundColor: '#61a5e8' }] },
                    options: { ...chartOpts }
                });

                new Chart(document.getElementById('monthlyStockChart'), {
                    type: 'bar',
                    data: { labels: monthlyLabels, datasets: [{ label: 'Import Order', data: monthlyData, backgroundColor: '#61a5e8' }] },
                    options: { ...chartOpts }
                });

                new Chart(document.getElementById('supplierStockChart'), {
                    type: 'pie',
                    data: {
                        labels: supplierLabels,
                        datasets: [{
                            data: supplierData,
                            backgroundColor: ['#61a5e8', '#f58787', '#ffcd56', '#77dd77', '#a4a1ff', '#ffb366']
                        }]
                    },
                    options: {
                        responsive: true,
                        maintainAspectRatio: false,
                        plugins: { legend: { display: true, position: 'top' } }
                    }
                });

                new Chart(document.getElementById('productStockChart'), {
                    type: 'bar',
                    data: { labels: productLabels, datasets: [{ label: 'Quantity', data: productData, backgroundColor: '#61a5e8' }] },
                    options: {
                        ...chartOpts,
                        scales: { y: { beginAtZero: true } }
                    }
                });
            </script>
        </main>
    </div>
</body>

</html>
