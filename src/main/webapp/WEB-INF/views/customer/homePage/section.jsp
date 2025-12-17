
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<section class="hero-section">
    <div class="hero-content">
        <div class="hero-eyebrow">
            <i class="bi bi-stars"></i>
            Premium products – Fast delivery within 2 hours
        </div>
        <h1 class="hero-title">Top-tier tech devices for every lifestyle</h1>
        <p class="hero-description">
            DAT Shop brings you a curated selection of smartphones, laptops, and accessories 
            from leading global brands. Enjoy daily deals, 0% installment plans, and nationwide warranty support.
        </p>
        <div class="hero-cta">
            <a class="btn-primary" href="${pageContext.request.contextPath}/FilterProduct?categoryId=1">Discover Products</a>
<!--            <a class="btn-secondary" href="${pageContext.request.contextPath}/VoucherServlet">View Current Offers</a>-->
        </div>
        <div class="hero-stats">
            <div class="stat-pill">
                <span>500+</span>
                <p>Items in Stock</p>
            </div>
            <div class="stat-pill">
                <span>4.9/5</span>
                <p>Customer Rating</p>
            </div>
            <div class="stat-pill">
                <span>12</span>
                <p>Service Centers</p>
            </div>
        </div>
    </div>
    <div class="hero-media">
        <img class="hero-device" src="${pageContext.request.contextPath}/Image/sanpham.png" alt="Tech Devices">
        <div class="floating-card">
            <strong>Save up to 30%</strong>
            <span>On accessory orders this week</span>
        </div>
    </div>
</section>
