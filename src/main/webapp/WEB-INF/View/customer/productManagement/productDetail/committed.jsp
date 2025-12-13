<%@page import="model.Product"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    Product product = (Product) request.getAttribute("product");
%>

<style>
    .commit-box {
        padding: 20px 18px 24px;
        position: relative;
        overflow: hidden;
    }

    /* ===== TITLE ===== */
    .commit-title {
        font-size: 18px;
        font-weight: 750;
        display: flex;
        align-items: center;
        gap: 10px;
        margin-bottom: 8px;
        color: #111827;
    }

    .commit-title i {
        background: #e0f2ff;
        color: #2563eb;
        padding: 7px 8px;
        border-radius: 10px;
        box-shadow: 0 2px 6px rgba(37, 99, 235, 0.25);
        font-size: 13px;
    }

    .commit-sub {
        font-size: 13px;
        color: #6b7280;
        margin-top: -2px;
        margin-bottom: 14px;
    }

    /* ===== GRID ===== */
    .commit-grid {
        display: grid;
        grid-template-columns: repeat(2, 1fr);
        gap: 10px 12px;
    }

    /* ===== ITEM ===== */
    .commit-item {
        display: flex;
        align-items: flex-start;
        gap: 10px;
        padding: 10px 12px;
        border-radius: 14px;
        background: linear-gradient(to bottom, #ffffff, #f7f9fc);
        border: 1px solid #e9edf3;
        transition: 0.2s ease;
    }

    .commit-item:hover {
        background: #ffffff;
        box-shadow: 0 8px 20px rgba(15, 23, 42, 0.09);
        transform: translateY(-2px);
    }

    .commit-icon-wrap {
        width: 44px;
        height: 44px;
        flex-shrink: 0;
        display: flex;
        align-items: center;
        justify-content: center;
        background: linear-gradient(135deg, #eef5ff, #dbeafe);
        border-radius: 12px;
        transition: transform 0.2s ease;
    }

    .commit-item:hover .commit-icon-wrap {
        transform: scale(1.06);
    }

    .commit-icon {
        width: 26px;
        height: 26px;
        object-fit: contain;
    }

    .commit-text {
        font-size: 13.3px;
        color: #374151;
        line-height: 1.45;
        font-weight: 450;
        margin: 0;
    }

    @media (max-width: 768px) {
        .commit-grid {
            grid-template-columns: 1fr;
        }
    }
</style>

<div class="commit-box">
    <div class="commit-title">
        <i class="fa fa-shield-alt"></i>
        <span>DAT Commitment</span>
    </div>
    <p class="commit-sub">Warranty • exchange • installation • included accessories</p>

    <%
        if (product != null) {
            String t1 = "", t2 = "", t3 = "", t4 = "", t5 = "";
            String l1 = "", l2 = "", l3 = "", l4 = "", l5 = "";

            switch (product.getCategoryId()) {
                case 1:
                    l1 = "https://cdnv2.tgdd.vn/pim/cdn/images/202501/icon%20bao%20hanh170435.png";
                    t1 = "1-year remote warranty, 12-year compressor warranty.";

                    l2 = "https://cdnv2.tgdd.vn/pim/cdn/images/202411/stroke104155.png";
                    t2 = "Additional material fees may apply during installation.";

                    l3 = "https://cdnv2.tgdd.vn/pim/cdn/images/202410/Exchange232102.png";
                    t3 = "1-to-1 exchange within 12 months at home (first 30 days free).";

                    l4 = "https://cdnv2.tgdd.vn/pim/cdn/images/202410/icon%20bao%20hanh170837.png";
                    t4 = "Official 1-year warranty, on-site support.";

                    l5 = "https://cdnv2.tgdd.vn/pim/cdn/images/202410/icon%20sp%20kem%20theo142836.png";
                    t5 = "Box includes: Remote, remote holder.";
                    break;

                case 2:
                    l1 = "https://cdnv2.tgdd.vn/pim/cdn/images/202411/icon%20bao%20hanh173451.png";
                    t1 = "For business usage, warranty is limited to 12 months.";

                    l2 = "https://cdnv2.tgdd.vn/pim/cdn/images/202410/Exchange150303.png";
                    t2 = "1-to-1 exchange within 12 months at home (free in first month).";

                    l3 = "https://cdnv2.tgdd.vn/pim/cdn/images/202411/icon%20bao%20hanh173451.png";
                    t3 = "Official 2-year warranty, on-site service.";

                    l4 = "https://cdnv2.tgdd.vn/pim/cdn/images/202410/icon%20sp%20kem%20theo142836.png";
                    t4 = "Includes warranty card and user manual.";

                    l5 = "https://cdnv2.tgdd.vn/pim/cdn/images/202410/icon%20lap%20dat140848.png";
                    t5 = "Free installation on delivery.";
                    break;

                case 3:
                    l1 = "https://cdnv2.tgdd.vn/pim/cdn/images/202410/icon%20bao%20hanh170837.png";
                    t1 = "12-month remote warranty.";

                    l2 = "https://cdnv2.tgdd.vn/pim/cdn/images/202410/Exchange150303.png";
                    t2 = "1-to-1 exchange within 12 months at home (free in first month).";

                    l3 = "https://cdnv2.tgdd.vn/pim/cdn/images/202410/icon%20bao%20hanh170837.png";
                    t3 = "Official 2-year warranty, on-site support.";

                    l4 = "https://cdnv2.tgdd.vn/pim/cdn/images/202410/icon%20sp%20kem%20theo142836.png";
                    t4 = "TV box includes: Remote and stand.";

                    l5 = "https://cdnv2.tgdd.vn/pim/cdn/images/202411/icon%20lap%20dat134827.png";
                    t5 = "Free installation on delivery.";
                    break;

                case 4:
                    l1 = "https://cdnv2.tgdd.vn/pim/cdn/images/202411/stroke132943.png";
                    t1 = "Factory/hotel/laundry business use is not covered by warranty.";

                    l2 = "https://cdnv2.tgdd.vn/pim/cdn/images/202410/icon%20bao%20hanh170837.png";
                    t2 = "10-year compressor warranty.";

                    l3 = "https://cdnv2.tgdd.vn/pim/cdn/images/202410/Exchange150303.png";
                    t3 = "1-to-1 exchange within 12 months at home (free in first month).";

                    l4 = "https://cdnv2.tgdd.vn/pim/cdn/images/202410/icon%20bao%20hanh170837.png";
                    t4 = "Official 2-year warranty, on-site support.";

                    l5 = "https://cdnv2.tgdd.vn/pim/cdn/images/202410/icon%20lap%20dat140848.png";
                    t5 = "Free installation on delivery.";
                    break;

                case 5:
                    l1 = "https://cdnv2.tgdd.vn/pim/cdn/images/202411/Delivery101707.png";
                    t1 = "Fast home delivery.";

                    l2 = "https://cdnv2.tgdd.vn/pim/cdn/images/202410/Exchange232102.png";
                    t2 = "Official 2-year warranty at service centers.";

                    l3 = "https://cdnv2.tgdd.vn/pim/cdn/images/202410/icon%20bao%20hanh170837.png";
                    t3 = "1-to-1 exchange within 12 months at home (free in first month).";
                    break;
            }
    %>

    <div class="commit-grid">
        <!-- item 1 -->
        <div class="commit-item">
            <div class="commit-icon-wrap">
                <img class="commit-icon" src="<%= l1 %>" alt="commitment">
            </div>
            <p class="commit-text"><%= t1 %></p>
        </div>

        <!-- item 2 -->
        <div class="commit-item">
            <div class="commit-icon-wrap">
                <img class="commit-icon" src="<%= l2 %>" alt="commitment">
            </div>
            <p class="commit-text"><%= t2 %></p>
        </div>

        <!-- item 3 -->
        <div class="commit-item">
            <div class="commit-icon-wrap">
                <img class="commit-icon" src="<%= l3 %>" alt="commitment">
            </div>
            <p class="commit-text"><%= t3 %></p>
        </div>

        <% if (product.getCategoryId() != 5) { %>
        <!-- item 4 -->
        <div class="commit-item">
            <div class="commit-icon-wrap">
                <img class="commit-icon" src="<%= l4 %>" alt="commitment">
            </div>
            <p class="commit-text"><%= t4 %></p>
        </div>

        <!-- item 5 -->
        <div class="commit-item">
            <div class="commit-icon-wrap">
                <img class="commit-icon" src="<%= l5 %>" alt="commitment">
            </div>
            <p class="commit-text"><%= t5 %></p>
        </div>
        <% } %>
    </div>

    <%
        } // end if product != null
    %>
</div>
