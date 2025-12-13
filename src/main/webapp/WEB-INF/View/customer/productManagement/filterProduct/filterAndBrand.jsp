<%@page import="model.Product"%>
<%@page import="model.Brand"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    List<Brand> brandList = (List<Brand>) request.getAttribute("brandList");
    int brandIdOld = 0, categoryId = 0;
    if (request.getAttribute("brandIdOld") != null) {
        brandIdOld = (int) request.getAttribute("brandIdOld");
    }
    if (brandList != null && !brandList.isEmpty()) {
        categoryId = brandList.get(0).getCategoryID();
    }
%>

<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">

<style>
    .filter-bar {
        display: flex;
        gap: 8px;
        width: 100%;
        align-items: center;
        margin-bottom: 10px;
    }

    .filter-btn {
        border: 1px solid #2a83e9;
        border-radius: 999px;
        cursor: pointer;
        padding: 8px 14px;
        background: #ffffff;
        color: #2563eb;
        display: inline-flex;
        align-items: center;
        gap: 6px;
        font-size: 14px;
        font-weight: 500;
        box-shadow: 0 2px 6px rgba(37, 99, 235, 0.12);
        transition: 0.15s ease;
    }

    .filter-btn i {
        font-size: 14px;
        color: #1f2937;
    }

    .filter-btn:hover {
        background: #eff6ff;
        transform: translateY(-1px);
        box-shadow: 0 4px 10px rgba(37, 99, 235, 0.2);
    }

    /* Modal overlay */
    .filter-modal-overlay {
        display: none;
        position: fixed;
        inset: 0;
        background-color: rgba(15, 23, 42, 0.45);
        z-index: 1000;
    }

    .filter-modal {
        background-color: #ffffff;
        padding: 18px 20px 18px;
        border-radius: 14px;
        width: 40%;
        max-width: 640px;
        margin: 5% auto;
        box-shadow: 0 18px 45px rgba(15, 23, 42, 0.4);
        animation: modalFade 0.2s ease-out;
    }

    @keyframes modalFade {
        from {opacity: 0; transform: translateY(-8px);}
        to {opacity: 1; transform: translateY(0);}
    }

    .filter-modal-header {
        display: flex;
        justify-content: space-between;
        align-items: center;
        margin-bottom: 10px;
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
        font-size: 18px;
        color: #6b7280;
    }

    .filter-modal-header button:hover {
        color: #111827;
    }

    .filter-section-title {
        font-size: 14px;
        font-weight: 600;
        margin: 12px 0 6px;
        color: #111827;
    }

    /* Brand list trong modal */
    .filter-brand-list {
        display: flex;
        flex-wrap: wrap;
        gap: 10px;
        margin-top: 6px;
    }

    .filter-brand-item {
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
        transition: 0.18s ease;
    }

    .filter-brand-item:hover {
        background-color: #eef2ff;
        box-shadow: 0 4px 12px rgba(15, 23, 42, 0.12);
    }

    .filter-brand-item input[type="radio"] {
        opacity: 0;
        position: absolute;
    }

    .filter-brand-item img {
        max-width: 100%;
        max-height: 100%;
        object-fit: contain;
        border-radius: 8px;
        transition: 0.18s ease;
    }

    /* Brand selected radio effect */
    .filter-brand-item input[type="radio"]:checked + img {
        border: 2px solid #2a83e9;
        border-radius: 8px;
        box-shadow: 0 0 5px rgba(42, 131, 233, 0.6);
        padding: 2px;
        background-color: #e8f1fd;
    }

    /* Price pills */
    .price-pill {
        display: inline-flex;
        align-items: center;
        justify-content: center;
        border: 2px solid #d1d5db;
        border-radius: 999px;
        padding: 6px 14px;
        cursor: pointer;
        transition: all 0.16s ease;
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
        box-shadow: 0 3px 8px rgba(37, 99, 235, 0.2);
    }

    .filter-modal-footer {
        margin-top: 18px;
        display: flex;
        justify-content: flex-end;
        gap: 10px;
    }

    .filter-modal-footer .btn-secondary {
        border-radius: 999px;
        border: 1px solid #d1d5db;
        background: #f9fafb;
        padding: 7px 14px;
        font-size: 13px;
        cursor: pointer;
    }

    .filter-modal-footer .btn-primary {
        border-radius: 999px;
        border: 1px solid #2563eb;
        background: #2563eb;
        color: #ffffff;
        padding: 7px 16px;
        font-size: 13px;
        cursor: pointer;
        font-weight: 500;
    }

    .filter-modal-footer .btn-primary:hover {
        background: #1d4ed8;
    }

    @media (max-width: 992px) {
        .filter-modal {
            width: 80%;
            margin-top: 10%;
        }
    }

    @media (max-width: 576px) {
        .filter-modal {
            width: 92%;
        }
    }
</style>

<div class="filter-bar">
    <!-- Filter Button -->
    <button class="filter-btn" type="button" onclick="openFilterModal()">
        <i class="fas fa-filter"></i>
        <span>Filter</span>
    </button>
</div>

<!-- Modal -->
<div id="filterModal" class="filter-modal-overlay">
    <div class="filter-modal">
        <div class="filter-modal-header">
            <h3>Brand &amp; Price</h3>
            <button type="button" onclick="closeFilterModal()">&times;</button>
        </div>

        <form action="SortProduct" method="get" onsubmit="return validateFilter()">

            <!-- Brand Section -->
            <div>
                <p class="filter-section-title">Brand</p>
                <div class="filter-brand-list">
                    <%
                        if (brandList != null && !brandList.isEmpty()) {
                            for (Brand br : brandList) {
                    %>
                    <label class="filter-brand-item">
                        <input type="radio"
                               name="brandcategory"
                               value="<%= br.getBrandId() %>-<%= br.getCategoryID() %>-<%= (brandIdOld != 0) ? brandIdOld : 1 %>">
                        <img src="<%= br.getImgUrlLogo() %>" alt="<%= br.getBrandName() %>">
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
            </div>

            <!-- Price Section -->
            <div style="margin-top: 14px;">
                <p class="filter-section-title">Price range</p>
                <div style="display: flex; flex-wrap: wrap; gap: 8px;">
                    <label class="price-pill" onclick="selectPriceRadio(this)">
                        <input type="radio" name="priceRangeCategory" value="under7-<%= categoryId %>">
                        <span>Less than 7 million</span>
                    </label>

                    <label class="price-pill" onclick="selectPriceRadio(this)">
                        <input type="radio" name="priceRange" value="7to9">
                        <span>7 - 9 million</span>
                    </label>

                    <label class="price-pill" onclick="selectPriceRadio(this)">
                        <input type="radio" name="priceRange" value="9to12">
                        <span>9 - 12 million</span>
                    </label>

                    <label class="price-pill" onclick="selectPriceRadio(this)">
                        <input type="radio" name="priceRange" value="12to15">
                        <span>12 - 15 million</span>
                    </label>

                    <label class="price-pill" onclick="selectPriceRadio(this)">
                        <input type="radio" name="priceRange" value="15to20">
                        <span>15 - 20 million</span>
                    </label>

                    <label class="price-pill" onclick="selectPriceRadio(this)">
                        <input type="radio" name="priceRange" value="above20">
                        <span>Above 20 million</span>
                    </label>
                </div>
            </div>

            <!-- Buttons -->
            <div class="filter-modal-footer">
                <button type="button" class="btn-secondary" onclick="closeFilterModal()">Close</button>
                <button type="submit" class="btn-primary">Apply</button>
            </div>
        </form>
    </div>
</div>

<script>
    function openFilterModal() {
        document.getElementById('filterModal').style.display = 'block';
    }

    function closeFilterModal() {
        document.getElementById('filterModal').style.display = 'none';
    }

    window.onclick = function (event) {
        let modal = document.getElementById('filterModal');
        if (event.target === modal) {
            modal.style.display = "none";
        }
    };

    function selectPriceRadio(label) {
        
        const allInputs = document.querySelectorAll('input[name^="priceRange"]');
        allInputs.forEach(input => {
            const parent = input.closest('label.price-pill');
            if (parent) {
                parent.classList.remove('checked');
            }
            input.checked = false;
        });

        const input = label.querySelector('input[type="radio"]');
        if (input) {
            input.checked = true;
            label.classList.add('checked');
        }
    }

    function validateFilter() {
        const hasBrand = document.querySelector('input[name="brandcategory"]:checked') !== null;
        
        const hasPrice = document.querySelector('input[name^="priceRange"]:checked') !== null;

        if (!hasBrand && !hasPrice) {
            alert("Please select at least a brand or a price range.");
            return false;
        }
        return true;
    }
</script>
