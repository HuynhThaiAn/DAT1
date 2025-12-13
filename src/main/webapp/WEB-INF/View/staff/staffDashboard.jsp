<%@ page import="model.Account" %>
<%@ page import="model.Staff" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%
    Account acc = (Account) session.getAttribute("user");
    Staff staff = (Staff) session.getAttribute("staff");
    if (acc == null || acc.getRoleID() != 2 || staff == null) {
        response.sendRedirect("LoginStaff");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>Staff Dashboard - DAT</title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/Css/Staff.css">
    </head>
<body>

  <div class="app">
    <!-- Sidebar -->
    <jsp:include page="sideBar.jsp" />

    <!-- Main -->
    <main class="main-content">
      <jsp:include page="header.jsp" />

      <div class="page">
        <h1 class="page-title">Staff Dashboard</h1>

        <div class="stats-grid">
          <div class="stat-card stat-secondary">
            <div class="stat-title">Today's Orders</div>
            <div class="stat-value">${todayOrders != null ? todayOrders : 0}</div>
          </div>

          <div class="stat-card stat-success">
            <div class="stat-title">New Feedback</div>
            <div class="stat-value">${newFeedback != null ? newFeedback : 0}</div>
          </div>

          <div class="stat-card stat-warning">
            <div class="stat-title">Low Stock</div>
            <div class="stat-value">${lowStockAlerts != null ? lowStockAlerts : 0}</div>
          </div>

          <div class="stat-card stat-danger">
            <div class="stat-title">Total Customers</div>
            <div class="stat-value">${totalCustomers != null ? totalCustomers : 0}</div>
          </div>
        </div>
      </div>
    </main>
  </div>

</body>

</html>
