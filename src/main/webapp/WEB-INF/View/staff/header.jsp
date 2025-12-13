<%@ page import="model.Account" %>
<%@ page import="model.Staff" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%
    Account acc = (Account) session.getAttribute("user");
    Staff staff = (Staff) session.getAttribute("staff");
    if (acc == null || acc.getRoleID() != 2 || staff == null) {
        response.sendRedirect("LoginStaff");
        return;
    }
%>

<style>
  :root{
    --sidebar-w: 260px;               
    --header-h: 78px;

    --bg: #f6f8fc;
    --card: #ffffff;
    --text: #111827;
    --muted: #6b7280;
    --border: rgba(15, 23, 42, 0.10);
    --shadow: 0 10px 24px rgba(0,0,0,.08);
    --shadow-soft: 0 2px 10px rgba(0,0,0,.06);
  }

  /* Header container fixed + ??p h?n */
  .header-container{
    position: fixed;
    top: 0;
    left: var(--sidebar-w);
    width: calc(100% - var(--sidebar-w));
    height: var(--header-h);
    background: rgba(255,255,255,.92);
    backdrop-filter: blur(10px);
    -webkit-backdrop-filter: blur(10px);
    border-bottom: 1px solid var(--border);
    z-index: 1200;
    display:flex;
    align-items:center;
  }

  .header-content{
    width: 100%;
    max-width: 1200px;
    margin: 0 auto;
    padding: 14px 22px;
    display:flex;
    justify-content: space-between;
    align-items:center;
    gap: 16px;
  }

  .user-info{
    display:flex;
    align-items:center;
    gap: 12px;
    min-width: 0;
  }

  .user-avatar{
    width: 44px;
    height: 44px;
    border-radius: 14px; /* vuông bo m?m nhìn modern h?n circle */
    background: linear-gradient(135deg, #60a5fa, #1d4ed8);
    color: #fff;
    display:flex;
    align-items:center;
    justify-content:center;
    font-size: 16px;
    font-weight: 800;
    box-shadow: 0 10px 20px rgba(29,78,216,.25);
    flex: 0 0 44px;
    text-transform: uppercase;
  }

  .user-details{
    min-width: 0;
  }

  .user-details h5{
    margin: 0;
    font-size: 16px;
    font-weight: 800;
    color: var(--text);
    line-height: 1.2;
    white-space: nowrap;
    overflow: hidden;
    text-overflow: ellipsis;
    max-width: 420px;
  }

  .user-details small{
    display:block;
    margin-top: 2px;
    color: var(--muted);
    font-size: 12.5px;
    white-space: nowrap;
    overflow: hidden;
    text-overflow: ellipsis;
    max-width: 420px;
  }

  .header-actions{
    display:flex;
    align-items:center;
    gap: 10px;
  }

  /* Logout button ??p h?n */
  .logout-btn{
    border: none;
    cursor: pointer;
    padding: 10px 14px;
    border-radius: 12px;
    font-size: 14px;
    font-weight: 700;
    display:flex;
    align-items:center;
    gap: 8px;
    color: #fff;
    background: linear-gradient(135deg, #ef4444, #b91c1c);
    box-shadow: 0 10px 20px rgba(239,68,68,.18);
    transition: transform .15s ease, box-shadow .15s ease, filter .15s ease;
  }
  .logout-btn:hover{
    transform: translateY(-1px);
    box-shadow: 0 14px 26px rgba(239,68,68,.24);
    filter: brightness(1.02);
  }
  .logout-btn:active{
    transform: translateY(0);
    box-shadow: 0 10px 20px rgba(239,68,68,.18);
  }

  /* Main content ??y xu?ng ?? không b? header che */
  main.main-content{
    margin-left: var(--sidebar-w);
    width: calc(100% - var(--sidebar-w));
    padding: 26px;
    padding-top: calc(var(--header-h) + 22px);
    background: var(--bg);
    min-height: 100vh;
  }

  
  @media (max-width: 992px){
    .header-container{
      left: 0;
      width: 100%;
    }
    main.main-content{
      margin-left: 0;
      width: 100%;
    }
    .user-details h5, .user-details small{
      max-width: 220px;
    }
  }

  @media (max-width: 480px){
    .header-content{
      padding: 12px 14px;
    }
    .logout-btn{
      padding: 9px 12px;
    }
  }
</style>

<div class="header-container">
  <div class="header-content">
    <div class="user-info">
      <div class="user-avatar">
        ${not empty staff.fullName ? fn:substring(staff.fullName, 0, 1) : 'S'}
      </div>
      <div class="user-details">
        <h5 title="${staff.fullName}">${staff.fullName}</h5>
        <small title="${staff.position}">${staff.position}</small>
      </div>
    </div>

    <div class="header-actions">
      <form action="${pageContext.request.contextPath}/Logout" method="get" style="margin:0;">
        <button type="submit" class="logout-btn">
          <i class="fas fa-sign-out-alt"></i>
          Logout
        </button>
      </form>
    </div>
  </div>
</div>
