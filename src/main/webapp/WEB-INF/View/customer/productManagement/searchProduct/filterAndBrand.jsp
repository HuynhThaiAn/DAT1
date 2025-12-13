<%@page import="model.Brand"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    List<Brand> brandList = (List<Brand>) request.getAttribute("brandList");
    int brandId = 0;
    int categoryId = 0;
    if (brandList != null && !brandList.isEmpty()) {
        brandId = brandList.get(0).getBrandId();
        categoryId = brandList.get(0).getCategoryID();
    }
%>

<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">

<style>
    .filter-brand-bar {
        display: flex;
        gap: 10px;
        width: 100%;
        align-items: center;
    }

    /* 🔹 Nút Filter */
    .filter-btn {
        border-radius: 999px;
        padding: 8px 18px;
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

    /* 🔹 Modal overlay */
    .filter-modal-overlay {
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
        to { opacity: 1; transform: translateY(0); }
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

    .filter-section-title {
        font-size: 14px;
        font-weight: 600;
        margin: 12px 0 6px;
        color: #111827;
    }

    /* 🔹 Brand trong modal */
    .modal-brand-list {
        display: flex;
        flex-wrap: wrap;
        gap: 10px;
        margin-top: 6px;
    }

    .modal-brand-item {
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

    .modal-brand-item:hover {
        background-color: #eef4ff;
        box-shadow: 0 4px 12px rgba(15, 23, 42, 0.15);
    }

    .modal-brand-item input[type="radio"] {
        opacity: 0;
        position: absolute;
    }

    .modal-brand-item img {
        max-width: 100%;
        max-height: 100%;
        object-fit: contain;
        border-radius: 8px;
        transition: 0.2s ease;
    }

    .modal-brand-item input[type="radio"]:checked + img {
        border: 2px solid #2a83e9;
        box-shadow: 0 0 5px rgba(42, 131, 233, 0.6);
        padding: 2px;
        background-color: #e8f1fd;
    }

    /* 🔹 Price pill */
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

    .filter-modal-footer {
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

    /* 🔹 Brand strip ngoài modal */
    .brand-strip {
        display: flex;
        align-items: center;
        gap: 8px;
        width: 100%;
        overflow-x: auto;
        padding: 4px 0;
    }

    .brand-strip::-webkit-scrollbar {
        height: 6px;
    }

    .brand-strip::-webkit-scrollbar-track {
        background: transparent;
    }

    .brand-strip::-webkit-scrollbar-thumb {
        background: #d4d4d8;
        border-radius: 999px;
    }

    .brand-chip {
        flex: 0 0 auto;
        min-width: 68px;
        max-width: 88px;
        border-radius: 12px;
        background-color: #f2f4f7;
        border: 1px solid #e5e7eb;
        padding: 6px 8px;
        display: flex;
        align-items: center;
        justify-content: center;
        transition: 0.18s ease;
    }

    .brand-chip:hover {
        background-color: #e0edff;
        border-color: #c4d3ff;
        box-shadow: 0 4px 10px rgba(15, 23, 42, 0.16);
        transform: translateY(-1px);
    }

    .brand-chip img {
        width: 100%;
        max-height: 34px;
        object-fit: contain;
        border-radius: 8px;
        display: block;
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
        .filter-brand-bar {
            flex-direction: column;
            align-items: flex-start;
        }
    }
</style>

<div class="filter-brand-bar">
    <!-- Nút Filter -->
    <button class="filter-btn" type="button" onclick="openFilterModal()">
        <i class="fas fa-filter"></i>
        <span>Filter</span>
    </button>

    <!-- Dải thương hiệu ngoài modal -->
    <div class="brand-strip">
        <%
            if (brandList != null && !brandList.isEmpty()) {
                for (Brand br : brandList) {
        %>
        <div class="brand-chip">
            <a href="FilterProduct?categoryId=<%= br.getCategoryID() %>&brandId=<%= br.getBrandId() %>">
                <img src="<%= br.getImgUrlLogo() %>" alt="<%= br.getBrandName() %>">
            </a>
        </div>
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

<!-- Modal -->
<div id="filterModal" class="filter-modal-overlay">
    <div class="filter-modal">
        <div class="filter-modal-header">
            <h3>Choose &amp; Price</h3>
            <button type="button" onclick="closeFilterModal()">&times;</button>
        </div>

        <form action="SortProduct?categoryId=<%= categoryId %>&brandId=<%= brandId %>" method="get">

            <!-- Brand Section -->
            <p class="filter-section-title">Hãng</p>
            <div class="modal-brand-list">
                <%
                    if (brandList != null && !brandList.isEmpty()) {
                        for (Brand br : brandList) {
                %>
                <label class="modal-brand-item">
                    <input type="radio"
                           name="brandcategory"
                           value="<%= br.getBrandId() %>-<%= br.getCategoryID() %>">
                    <img src="<%= br.getImgUrlLogo() %>" alt="<%= br.getBrandName() %>">
                </label>
                <%
                        }
                    } else {
                %>
                <span style="font-size: 13px; color: #9ca3af;">Không có dữ liệu hãng</span>
                <%
                    }
                %>
            </div>

            <!-- Price Section -->
            <p class="filter-section-title" style="margin-top: 14px;">Khoảng giá</p>
            <div style="display: flex; flex-wrap: wrap; gap: 8px; margin-top: 6px;">
                <label class="price-pill" onclick="selectPrice(this)">
                    <input type="radio" name="priceRange" value="under7">
                    <span>Dưới 7 triệu</span>
                </label>

                <label class="price-pill" onclick="selectPrice(this)">
                    <input type="radio" name="priceRange" value="7to9">
                    <span>7 - 9 triệu</span>
                </label>

                <label class="price-pill" onclick="selectPrice(this)">
                    <input type="radio" name="priceRange" value="9to12">
                    <span>9 - 12 triệu</span>
                </label>

                <label class="price-pill" onclick="selectPrice(this)">
                    <input type="radio" name="priceRange" value="12to15">
                    <span>12 - 15 triệu</span>
                </label>

                <label class="price-pill" onclick="selectPrice(this)">
                    <input type="radio" name="priceRange" value="15to20">
                    <span>15 - 20 triệu</span>
                </label>

                <label class="price-pill" onclick="selectPrice(this)">
                    <input type="radio" name="priceRange" value="above20">
                    <span>Trên 20 triệu</span>
                </label>
            </div>

            <div class="filter-modal-footer">
                <button type="button" class="btn-close" onclick="closeFilterModal()">Đóng</button>
                <button type="submit" class="btn-apply">Áp dụng</button>
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

    function selectPrice(label) {
        const all = document.querySelectorAll('.price-pill');
        all.forEach(l => {
            l.classList.remove('checked');
            const input = l.querySelector('input[type="radio"]');
            if (input) input.checked = false;
        });

        const input = label.querySelector('input[type="radio"]');
        if (input) {
            input.checked = true;
            label.classList.add('checked');
        }
    }
</script>
