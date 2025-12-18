<%@page import="model.CategoryDetailGroup"%>
<%@page import="model.CategoryDetail"%>
<%@page import="java.util.List"%>
<%@page import="model.Category"%>
<%@page contentType="text/html; charset=UTF-8"%>
<%
    List<CategoryDetail> categoryDetailList = (List<CategoryDetail>) request.getAttribute("categoryDetailList");
    List<Category> categoryList = (List<Category>) request.getAttribute("categoryList");
    List<CategoryDetailGroup> categoryDetailGroup = (List<CategoryDetailGroup>) request.getAttribute("categoryDetaiGrouplList");
    int categoryId = (int) request.getAttribute("categoryId");
%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>Category Detail</title>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/Css/sidebar-admin.css">
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
        <style>
            body {
                background-color: #f4f6f9;
                font-family: 'Segoe UI', Tahoma, sans-serif;
                margin: 0;
                padding: 0;
            }

            .container {
                width: 88%;
                margin: 40px auto;
            }

            /* ===== HEADER ===== */
            .header {
                display: flex;
                align-items: center;
                margin-bottom: 30px;
            }

            .header h1 {
                font-size: 34px;
                font-weight: 700;
                color: #212529;
            }

            /* ===== CATEGORY CARD ===== */
            .category-card {
                display: flex;
                gap: 18px;
                margin-bottom: 40px;
                overflow-x: auto;
                padding-bottom: 10px;
            }

            .category-card::-webkit-scrollbar {
                height: 6px;
            }

            .category-card::-webkit-scrollbar-thumb {
                background: #ccc;
                border-radius: 10px;
            }

            .category-card .card {
                min-width: 160px;
                background: #fff;
                border-radius: 16px;
                padding: 18px;
                text-align: center;
                box-shadow: 0 6px 18px rgba(0, 0, 0, 0.08);
                transition: all 0.3s ease;
                cursor: pointer;
            }

            .category-card .card:hover {
                transform: translateY(-4px);
                box-shadow: 0 10px 24px rgba(0, 0, 0, 0.15);
            }

            .category-card .card.active {
                border: 2px solid #0d6efd;
                background: #eef4ff;
            }

            .category-card img {
                height: 90px;
                object-fit: contain;
            }

            .category-card h2 {
                font-size: 16px;
                margin-top: 12px;
                font-weight: 600;
                color: #333;
            }

            /* ===== TECHNICAL SPECS ===== */
            .technical-specs {
                background: #ffffff;
                border-radius: 18px;
                padding: 25px;
                box-shadow: 0 8px 24px rgba(0, 0, 0, 0.08);
            }

            .technical-specs h2 {
                font-size: 22px;
                font-weight: 700;
                margin-bottom: 15px;
                color: #212529;
            }

            /* ===== TABLE ===== */
            .category-table {
                width: 100%;
                border-collapse: separate;
                border-spacing: 0;
                overflow: hidden;
                border-radius: 12px;
            }

            .category-table th,
            .category-table td {
                padding: 14px 16px;
                font-size: 14px;
                border-bottom: 1px solid #e9ecef;
            }

            /* ===== GROUP HEADER ===== */
            .group-header {
                background: linear-gradient(135deg, #f8f9fa, #eef1f5);
                cursor: pointer;
                transition: background 0.3s ease;
            }

            .group-header:hover {
                background: #e9ecef;
            }

            .group-header h2 {
                font-size: 16px;
                font-weight: 600;
                color: #343a40;
            }

            .arrow-icon {
                font-size: 16px;
                font-weight: bold;
                color: #0d6efd;
            }

            /* ===== GROUP DETAIL ===== */
            .group-details td {
                background: #ffffff;
                padding-left: 35px;
                color: #495057;
            }

            .group-details:hover td {
                background: #f8f9fa;
            }

            /* ===== UTIL ===== */
            .hidden {
                display: none !important;
            }

            .no-data-message {
                text-align: center;
                color: #6c757d;
                font-style: italic;
                padding: 20px;
            }
        </style>
    </head>
    <body>
        <div class="container">
            <div class="header">
                <h1>Category Detail</h1>
            </div>

            <!-- Category Cards -->
            <div class="category-card">
                <%
                    if (categoryList != null) {
                        for (Category cate : categoryList) {
                            if (cate.getIsActive()) {
                                boolean check = (cate.getCategoryId() == categoryId);
                %>
                <div class="card <%= check ? "active" : "" %>">
                    <img src="<%= cate.getImgUrlLogo() %>" alt="Category Logo">
                    <h2><%= cate.getCategoryName() %></h2>
                </div>
                <%      }
                        }
                    }
                %>
            </div>

            <!-- Technical Specifications -->
            <div class="technical-specs">
                <h2>Technical Specifications</h2>
                <table class="category-table">
                    <tbody>
                        <%
                            if (categoryDetailGroup != null) {
                                int groupIndex = 0;
                                for (CategoryDetailGroup cateGroup : categoryDetailGroup) {
                        %>
                        <!-- Group Header Row -->
                        <tr class="group-header" onclick="toggleDetails(<%= groupIndex %>)">
                            <td colspan="2">
                                <div style="display: flex; justify-content: space-between; align-items: center;">
                                    <h2><%= cateGroup.getNameCategoryDetailsGroup() %></h2>
                                    <span class="arrow-icon" id="arrow<%= groupIndex %>">▼</span>
                                </div>
                            </td>
                        </tr>

                        <!-- Group Detail Rows -->
                        <%
                            if (categoryDetailList != null && !categoryDetailList.isEmpty()) {
                                for (CategoryDetail cateList : categoryDetailList) {
                                    if (cateList.getCategoryDetailsGroupID() == cateGroup.getCategoryDetailsGroupID()) {
                        %>
                        <tr class="hidden group-details detailGroup<%= groupIndex %>">
                            <td class="category-name"><%= cateList.getCategoryDatailName() %></td>
                            <td></td>
                        </tr>
                        <%
                                    }
                                }
                            }
                            groupIndex++;
                        }
                    } else {
                        %>
                        <tr><td colspan="2" class="no-data-message">No data</td></tr>
                        <%
                            }
                        %>
                    </tbody>
                </table>
                    
            </div>
                    <a style = "margin-left: 81%;" href="CategoryView" class="btn btn-secondary" id="back"><i class="bi bi-arrow-return-left"></i> Back</a>
        </div>

        <script>
            function toggleDetails(index) {
                const rows = document.querySelectorAll('.detailGroup' + index);
                const arrowIcon = document.getElementById('arrow' + index);

                rows.forEach(row => {
                    row.classList.toggle('hidden');
                });

                arrowIcon.innerText = arrowIcon.innerText === '▼' ? '▲' : '▼';
            }
        </script>
    </body>
</html>
