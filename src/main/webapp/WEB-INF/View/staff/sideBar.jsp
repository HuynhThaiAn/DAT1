<head>
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
  <style>
    :root{
      --sb-bg1:#0f1b4d;
      --sb-bg2:#1d4ed8;
      --sb-text:rgba(255,255,255,.82);
      --sb-text-strong:#fff;
      --sb-hover:rgba(255,255,255,.10);
      --sb-active:rgba(255,255,255,.16);
      --sb-border:rgba(255,255,255,.12);
      --sb-shadow: 0 12px 28px rgba(0,0,0,.22);
    }

    /* Sidebar */
    .sidebar{
      position: fixed;
      top: 0; left: 0;
      height: 100vh;
      width: 260px;
      background: linear-gradient(180deg,var(--sb-bg1),var(--sb-bg2));
      z-index: 1000;
      box-shadow: var(--sb-shadow);
      overflow: hidden;
      display: flex;
      flex-direction: column;
    }

    /* Header */
    .sidebar-header{
      padding: 18px 18px 14px;
      border-bottom: 1px solid var(--sb-border);
      display:flex;
      align-items:center;
      gap: 12px;
    }
    .brand-badge{
      width: 42px; height: 42px;
      border-radius: 12px;
      background: rgba(255,255,255,.14);
      display:flex;
      align-items:center;
      justify-content:center;
      color: #fff;
      box-shadow: 0 10px 20px rgba(0,0,0,.15);
      flex: 0 0 42px;
    }
    .sidebar-header h4{
      color: #fff;
      margin: 0;
      font-weight: 800;
      letter-spacing: .3px;
      font-size: 18px;
      line-height: 1.2;
    }
    .sidebar-header small{
      display:block;
      margin-top: 2px;
      color: rgba(255,255,255,.7);
      font-size: 12px;
      letter-spacing: .2px;
    }

    /* Menu */
    .sidebar-menu{
      padding: 14px 10px 16px;
      display:flex;
      flex-direction:column;
      gap: 6px;
      flex: 1;
    }

    .sidebar-link{
      position: relative;
      display:flex;
      align-items:center;
      gap: 12px;
      padding: 12px 14px;
      color: var(--sb-text);
      text-decoration: none;
      border-radius: 12px;
      transition: .18s ease;
      user-select: none;
    }

    .sidebar-link i{
      width: 20px;
      text-align:center;
      font-size: 16px;
      opacity: .95;
    }

    .sidebar-link:hover{
      background: var(--sb-hover);
      color: var(--sb-text-strong);
      transform: translateX(2px);
    }

    /* Active state (d? nhìn h?n) */
    .sidebar-link.active{
      background: var(--sb-active);
      color: var(--sb-text-strong);
      font-weight: 700;
    }
    .sidebar-link.active::before{
      content:"";
      position:absolute;
      left: 0;
      top: 10px;
      bottom: 10px;
      width: 4px;
      border-radius: 6px;
      background: rgba(255,255,255,.92);
    }
    .sidebar-link.active::after{
      content:"";
      position:absolute;
      inset: 0;
      border-radius: 12px;
      box-shadow: inset 0 0 0 1px rgba(255,255,255,.10);
      pointer-events:none;
    }

    /* Optional footer */
    .sidebar-footer{
      padding: 12px 16px 16px;
      border-top: 1px solid var(--sb-border);
      color: rgba(255,255,255,.65);
      font-size: 12px;
    }

    /* N?u trang c?a anh có content bên ph?i thì thêm margin-left */
    /* .main-content { margin-left: 260px; } */
  </style>
</head>

<div class="sidebar" id="sidebar">
  <div class="sidebar-header">
    <div class="brand-badge">
      <i class="fas fa-store"></i>
    </div>
    <div>
      <h4>DAT Shop</h4>
      <small>Staff Panel</small>
    </div>
  </div>

  <div class="sidebar-menu">
    <a href="StaffDashboard" class="sidebar-link">
      <i class="fas fa-tachometer-alt"></i> Dashboard
    </a>

    <a href="ViewOrderList" class="sidebar-link">
      <i class="fas fa-shopping-cart"></i> Orders
    </a>

    <a href="ImportStatistic" class="sidebar-link">
      <i class="fas fa-warehouse"></i> Stock
    </a>

    <a href="CustomerList" class="sidebar-link">
      <i class="fas fa-users"></i> Customers
    </a>

    <a href="ViewListNewFeedback" class="sidebar-link">
      <i class="fas fa-comments"></i> Feedback
    </a>
  </div>

  <div class="sidebar-footer">
    © 2025 DAT Shop
  </div>
</div>

<script>
  document.addEventListener("DOMContentLoaded", function () {
    const path = window.location.pathname.toLowerCase();
    const links = document.querySelectorAll(".sidebar-link");

    let matched = false;
    links.forEach(a => {
      const href = (a.getAttribute("href") || "").toLowerCase();
      // match theo ?o?n cu?i URL (?? l?i includes b?y)
      if (href && path.includes(href.toLowerCase())) {
        a.classList.add("active");
        matched = true;
      } else {
        a.classList.remove("active");
      }
    });

    // fallback: n?u không match ???c thì active Dashboard
    if (!matched && links.length) links[0].classList.add("active");
  });
</script>
