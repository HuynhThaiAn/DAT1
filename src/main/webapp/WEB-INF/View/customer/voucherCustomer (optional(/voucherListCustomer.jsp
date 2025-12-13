<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page import="model.Customer" %>
<%
    Customer customer = (Customer) session.getAttribute("customer");
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>My Vouchers</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/Css/profile.css">
<style>
/* Layout tổng thể */
.main-account {
    min-height: 75vh;
}

/* Danh sách Voucher — 1 cột */
.voucher-list {
    display: flex;
    flex-direction: column;      /* 🔥 chuyển sang 1 cột */
    gap: 18px;
    padding: 0 5px;
    width: 100%;
}

/* Card voucher mới — đẹp hơn, nổi bật hơn */
.voucher-card {
    display: flex;
    border-radius: 14px;
    background: #fff;
    overflow: hidden;
    min-height: 120px;
    box-shadow: 0 4px 18px rgba(0,0,0,.08);
    border: 1px solid rgba(0,0,0,0.05);
    transition: .25s ease;
}
.voucher-card:hover {
    transform: translateY(-3px);
    box-shadow: 0 8px 26px rgba(0,0,0,.12);
}

/* Badge trái */
.voucher-badge {
    width: 105px;
    background: linear-gradient(145deg,#1d4ed8,#3b82f6);
    color: #fff;
    font-size: 1.15rem;
    font-weight: 700;
    padding: 22px 10px;
    text-align: center;
    display: flex;
    justify-content: center;
    align-items: center;
    flex-direction: column;
}

/* Nội dung chi tiết */
.voucher-content {
    flex: 1;
    padding: 18px 18px 16px 20px;
    position: relative;
    min-width: 0;
}

/* Badge số lượng */
.voucher-qty-badge {
    position: absolute;
    top: 10px;
    right: 14px;
    background:#ff4757;
    padding: 4px 10px;
    border-radius: 10px;
    color:#fff;
    font-size: .85rem;
    font-weight:600;
}

/* Mã voucher */
.voucher-title {
    font-size: 1.3rem;
    font-weight: 700;
    color:#1e40af;
    margin-bottom: 6px;
    word-break: break-word;
}

/* Mô tả voucher */
.voucher-desc {
    font-size: 0.95rem;
    color:#333;
    line-height:1.45;
    margin-bottom: 8px;
}

/* Hạn sử dụng */
.voucher-expiry {
    font-size:.95rem;
    color:#444;
    font-weight:600;
}

/* Scroll container cho dài đẹp */
.voucher-scroll-container {
    max-height: 520px;
    overflow-y:auto;
    padding-right:6px;
    margin-top:10px;
}
.voucher-scroll-container::-webkit-scrollbar{width:6px;}
.voucher-scroll-container::-webkit-scrollbar-thumb{
    background:#b8c0cc;
    border-radius:6px;
}

/* Mobile tối ưu */
@media(max-width:600px){
    .voucher-card { flex-direction:column; }
    .voucher-badge{
        width:100%;
        padding:18px 0;
        font-size:1.2rem;
    }
}
</style>

</head>
<body>
<jsp:include page="/WEB-INF/View/customer/homePage/header.jsp" />

<div class="main-account container-fluid" style="margin-bottom: 20px">
    <jsp:include page="/WEB-INF/View/customer/sideBar.jsp" />

    <div class="profile-card">
        <div class="profile-header">
            <h4>
                <i class="bi bi-ticket-perforated me-2"></i>
                My Vouchers
            </h4>
        </div>
        <div class="profile-body">
            
            <c:choose>
                <c:when test="${empty voucherList}">
                    <div class="alert alert-info text-center">
                        <i class="bi bi-ticket-perforated me-2"></i>
                        You don't have any vouchers yet.
                    </div>
                </c:when>
                <c:otherwise>
                    <!-- Bọc voucher list trong scroll container -->
                    <div class="voucher-scroll-container">
                        <div class="voucher-list">
                            <c:forEach var="cv" items="${voucherList}">
                                <c:set var="v" value="${cv.voucher}" />
                                <div class="voucher-card">
                                    <div class="voucher-badge">
                                        <strong>
                                            <c:choose>
                                                <c:when test="${v.discountPercent > 0}">
                                                    ${v.discountPercent}% SALE<br/>OFF
                                                </c:when>
                                                <c:when test="${fn:containsIgnoreCase(v.code, 'ship') or fn:containsIgnoreCase(v.description, 'shipping')}">
                                                    <fmt:formatNumber value="${v.maxDiscountAmount}" pattern="#,###"/> Đ<br/>SALE OFF
                                                </c:when>
                                                <c:when test="${v.maxDiscountAmount > 0}">
                                                    <fmt:formatNumber value="${v.maxDiscountAmount}" pattern="#,###"/> đ<br/>SALE OFF
                                                </c:when>
                                                <c:otherwise>
                                                    SALE<br/>OFF
                                                </c:otherwise>
                                            </c:choose>
                                        </strong>
                                    </div>
                                    <div class="voucher-content">
                                        <c:if test="${cv.quantity > 0}">
                                            <span class="voucher-qty-badge">x${cv.quantity}</span>
                                        </c:if>
                                        <div class="voucher-title">${v.code}</div>
                                        <div class="voucher-desc">${v.description}</div>
                                        <div class="voucher-expiry">
                                            Expiration Date:
                                            <fmt:formatDate value="${v.expiryDate}" pattern="dd/MM/yyyy"/>
                                        </div>
                                        <c:if test="${cv.expirationDate != null}">
                                            <div style="font-size:0.96rem;color:#666;">
                                                (Personal voucher valid until:
                                                <fmt:formatDate value="${cv.expirationDate}" pattern="dd/MM/yyyy"/>
                                                )
                                            </div>
                                        </c:if>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
</div>

<jsp:include page="/WEB-INF/View/customer/homePage/footer.jsp" />
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
