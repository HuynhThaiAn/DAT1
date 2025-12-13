<%@page import="model.Brand"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    List<Brand> brandList = (List<Brand>) request.getAttribute("brandList");
    int brandIdOld = 0;
    int categoryId = 0;

    if (request.getAttribute("brandIdOld") != null) {
        brandIdOld = (int) request.getAttribute("brandIdOld");
    }
    if (brandList != null && !brandList.isEmpty()) {
        categoryId = brandList.get(0).getCategoryID();
    }
%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Filter & Brand</title>
        <link rel="stylesheet"
              href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css"/>

        <style>
            .filter-bar {
                display: flex;
                gap: 10px;
                align-items: center;
            }

            /* Nút Filter */
            .filter-btn {
                border-radius: 999px;
                padding: 8px 16px;
                font-size: 14px;
                color: #fff;
                background: linear-gradient(120deg, #1e88e5, #42a5f5);
                border: none;
                cursor: pointer;
                font-weight: 600;
                display: inline-flex;
                align-items: center;
                gap: 6px;
                box-shadow: 0 3px 12px rgba(66, 165, 245, 0.45);
                transition: 0.2s ease;
                white-space: nowrap;
            }

            .filter-btn i {
                font-size: 14px;
            }

            .filter-btn:hover {
                background: linear-gradient(120deg, #1976d2, #2196f3);
                transform: translateY(-1px);
                box-shadow: 0 4px 16px rgba(37, 99, 235, 0.5);
            }

            /* Overlay modal */
            #filterModal {
                display: none;
                position: fixed;
                inset: 0;
                background-color: rgba(15, 23, 42, 0.45);
                backdrop-filter: blur(4px);
                z-index: 1000;
            }

            .filter-modal {
                background-color: #fff;
                padding: 22px 22px 18px;
                border-radius: 16px;
                width: 42%;
                max-width: 640px;
                margin: 5% auto;
                box-shadow: 0 20px 60px rgba(15, 23, 42, 0.45);
                animation: modalFade 0.2s ease-out;
            }

            @keyframes modalFade {
                from { opacity: 0; transform: translateY(10px); }
                to   { opacity: 1; transform: translateY(0); }
            }

            .filter-modal-header {
                display: flex;
                justify-content: space-between;
                align-items: center;
                margin-bottom: 12px;
            }

            .filter-modal-header h3 {
                margin: 0;
                font-size: 18px;
                font-weight: 700;
            }

            .filter-modal-header button {
                border: none;
                background: transparent;
                cursor: pointer;
                font-size: 20px;
                color: #6b7280;
            }

            .filter-modal-header button:hover {
                color: #111827;
            }

            .section-title {
                font-size: 14px;
                font-weight: 600;
                margin: 12px 0 6px;
                color: #111827;
            }

            /* Brand trong modal */
            .brand-list-modal {
                display: flex;
                flex-wrap: wrap;
                gap: 10px;
                margin-top: 6px;
            }

            .brand-item-modal {
                width: 100px;
                height: 60px;
                display: flex;
                justify-content: center;
                align-items: center;
                border-radius: 10px;
                padding: 5px;
                cursor: pointer;
                position: relative;
                border: 1px solid #e5e7eb;
                background-color: #f9fafb;
                transition: 0.2s ease;
            }

            .brand-item-modal:hover {
                background-color: #eef4ff;
                box-shadow: 0 4px 12px rgba(15, 23, 42, 0.15);
            }

            .brand-item-modal input[type="radio"] {
                opacity: 0;
                position: absolute;
            }

            .brand-item-modal img {
                max-width: 100%;
                max-height: 100%;
                object-fit: contain;
                border-radius: 8px;
                transition: 0.2s ease;
            }

            .brand-item-modal input[type="radio"]:checked + img {
                border: 2px solid #2a83e9;
                box-shadow: 0 0 5px rgba(42, 131, 233, 0.6);
                padding: 2px;
                background-color: #e8f1fd;
            }

            /* Price pill */
            .price-pill {
                display: inline-flex;
                align-items: center;
                justify-content: center;
                border: 2px solid #d1d5db;
                border-radius: 999px;
                padding: 6px 14px;
                cursor: pointer;
                transition: all 0.18s ease;
                background-color: #f9fafb;
                font-size: 13px;
                color: #374151;
                white-space: nowrap;
            }

            .price-pill input[type="radio"] {
                display: none;
            }

            .price-pill.checked {
                background-color: #e6f1ff;
                border-color: #2a83e9;
                color: #1d4ed8;
                box-shadow: 0 3px 10px rgba(37, 99, 235, 0.3);
            }

            .modal-footer {
                margin-top: 18px;
                display: flex;
                justify-content: flex-end;
                gap: 8px;
            }

            .btn-close {
                border-radius: 999px;
                border: 1px solid #d0d5dd;
                background: #f3f4f6;
                padding: 7px 14px;
                font-size: 13px;
                cursor: pointer;
            }

            .btn-apply {
                border-radius: 999px;
                border: 1px solid #2563eb;
                background: #2563eb;
                color: #ffffff;
                padding: 7px 16px;
                font-size: 13px;
                cursor: pointer;
                font-weight: 500;
            }

            .btn-apply:hover {
                background: #1d4ed8;
            }

            @media (max-width: 992px) {
                .filter-modal {
                    width: 80%;
                }
            }

            @media (max-width: 576px) {
                .filter-modal {
                    width: 92%;
                }
                .filter-bar {
                    flex-direction: column;
                    align-items: flex-start;
                }
            }
        </style>
    </head>
    <body>
        <div class="filter-bar">
            <!-- Filter Button -->
            <button class="filter-btn" type="button" onclick="openModal()">
                <i class="fas fa-filter"></i>
                <span>Filter</span>
            </button>
        </div>

        <!-- Modal -->
        <div id="filterModal">
            <div class="filter-modal">
                <div class="filter-modal-header">
                    <h3>Choose brand &amp; price</h3>
                    <button type="button" onclick="closeModal()">&times;</button>
                </div>

                <form action="SortProduct" method="get" onsubmit="return validateFilter()">
                    <!-- Brand Section -->
                    <p class="section-title">Brand</p>
                    <div class="brand-list-modal">
                        <%
                            if (brandList != null && !brandList.isEmpty()) {
                                for (Brand br : brandList) {
                        %>
                        <label class="brand-item-modal">
                            <input type="radio"
                                   name="brandcategory"
                                   value="<%=br.getBrandId()%>-<%=br.getCategoryID()%>-<%=(brandIdOld != 0) ? brandIdOld : 1%>">
                            <img src="<%=br.getImgUrlLogo()%>" alt="<%=br.getBrandName()%>">
                        </label>
                        <%
                                }
                            } else {
                        %>
                        <span style="font-size: 13px; color: #9ca3af;">No brand data</span>
                        <%
                            }
                        %>
                    </div>

                    <!-- Price Section -->
                    <p class="section-title" style="margin-top: 14px;">Price range</p>
                    <div style="display: flex; flex-wrap: wrap; gap: 8px; margin-top: 6px;">
                        <label class="price-pill" onclick="selectRadio(this)">
                            <input type="radio" name="priceRangeCategory" value="under7-<%=categoryId%>">
                            <span>Less than 7 million</span>
                        </label>

                        <label class="price-pill" onclick="selectRadio(this)">
                            <input type="radio" name="priceRangeCategory" value="7to9-<%=categoryId%>">
                            <span>7 - 9 million</span>
                        </label>

                        <label class="price-pill" onclick="selectRadio(this)">
                            <input type="radio" name="priceRangeCategory" value="9to12-<%=categoryId%>">
                            <span>9 - 12 million</span>
                        </label>

                        <label class="price-pill" onclick="selectRadio(this)">
                            <input type="radio" name="priceRangeCategory" value="12to15-<%=categoryId%>">
                            <span>12 - 15 million</span>
                        </label>

                        <label class="price-pill" onclick="selectRadio(this)">
                            <input type="radio" name="priceRangeCategory" value="15to20-<%=categoryId%>">
                            <span>15 - 20 million</span>
                        </label>

                        <label class="price-pill" onclick="selectRadio(this)">
                            <input type="radio" name="priceRangeCategory" value="above20-<%=categoryId%>">
                            <span>Above 20 million</span>
                        </label>
                    </div>

                    <!-- Buttons -->
                    <div class="modal-footer">
                        <button type="button" class="btn-close" onclick="closeModal()">Close</button>
                        <button type="submit" class="btn-apply">Apply</button>
                    </div>
                </form>
            </div>
        </div>

        <!-- JavaScript -->
        <script>
            function openModal() {
                document.getElementById('filterModal').style.display = 'block';
            }

            function closeModal() {
                document.getElementById('filterModal').style.display = 'none';
            }

            window.onclick = function (event) {
                const modal = document.getElementById('filterModal');
                if (event.target === modal) {
                    modal.style.display = "none";
                }
            };

            function selectRadio(label) {
                const all = document.querySelectorAll('input[name="priceRangeCategory"]');
                all.forEach(input => {
                    const parent = input.closest('label');
                    if (parent) {
                        parent.classList.remove('checked');
                        input.checked = false;
                    }
                });

                const input = label.querySelector('input');
                if (input) {
                    input.checked = true;
                    label.classList.add('checked');
                }
            }

            function validateFilter() {
                const hasBrand = document.querySelector('input[name="brandcategory"]:checked') !== null;
                const hasPrice = document.querySelector('input[name="priceRangeCategory"]:checked') !== null;

                if (!hasBrand && !hasPrice) {
                    alert("Please select at least a brand or a price range.");
                    return false;
                }
                return true;
            }
        </script>
    </body>
</html>
