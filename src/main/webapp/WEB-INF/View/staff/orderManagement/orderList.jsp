<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.Locale" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <title>Order Management</title>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1" />

        <!-- Bootstrap & FontAwesome -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" />
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet" />
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

        <link rel="stylesheet" href="${pageContext.request.contextPath}/Css/supplierList5.css" />

        <%
            NumberFormat currencyVN = NumberFormat.getCurrencyInstance(new Locale("vi", "VN"));
        %>
        <style>
:root{
  --sidebar-w: 260px;
  --header-h: 78px;

  --bg: #f4f6fb;
  --card: #ffffff;
  --text: #111827;
  --muted: #6b7280;
  --border: rgba(15, 23, 42, 0.10);
  --shadow: 0 12px 28px rgba(0,0,0,.08);
}

html, body{ height:100%; }
body{
  background: var(--bg);
  font-family: "Segoe UI", system-ui, -apple-system, Arial, sans-serif;
}

/* Layout đồng bộ với sidebar/header fixed */
.app{ min-height: 100vh; }

main.main-content{
  margin-left: var(--sidebar-w);
  width: calc(100% - var(--sidebar-w));
  padding: 24px;
  padding-top: calc(var(--header-h) + 18px);
}

.page{
  max-width: 1200px;
  margin: 0 auto;
}

.page-head{
  display:flex;
  align-items:flex-end;
  justify-content: space-between;
  gap: 14px;
  margin-bottom: 14px;
}

.page-title{
  margin: 0;
  font-weight: 900;
  color: var(--text);
  letter-spacing: .2px;
}

.page-sub{
  color: var(--muted);
  font-size: 13px;
  margin-top: 4px;
}

/* Search */
.search-form{
  display:flex;
  gap: 10px;
  align-items:center;
  margin: 0;
}
.search-wrap{
  display:flex;
  align-items:center;
  gap: 10px;
  background: #fff;
  border: 1px solid var(--border);
  border-radius: 14px;
  padding: 10px 12px;
  box-shadow: 0 6px 18px rgba(0,0,0,.06);
  min-width: 320px;
}
.search-wrap i{ color: #94a3b8; }
.search-wrap input{
  border: none;
  outline: none;
  width: 100%;
  font-size: 14px;
}
.btn-search{
  border: none;
  padding: 10px 14px;
  border-radius: 14px;
  font-weight: 800;
  color: #fff;
  background: linear-gradient(135deg, #1d4ed8, #2563eb);
  box-shadow: 0 12px 22px rgba(37,99,235,.18);
  transition: transform .15s ease, box-shadow .15s ease;
}
.btn-search:hover{
  transform: translateY(-1px);
  box-shadow: 0 16px 28px rgba(37,99,235,.24);
}

/* Card table */
.card-table{
  background: var(--card);
  border: 1px solid var(--border);
  border-radius: 18px;
  box-shadow: var(--shadow);
  overflow: hidden;
}

.table thead th{
  background: #f8fafc;
  border-bottom: 1px solid var(--border);
  color: #475569;
  font-weight: 800;
  font-size: 13px;
  padding: 14px 14px;
  white-space: nowrap;
}
.table tbody td{
  padding: 14px 14px;
  font-size: 14px;
  color: #0f172a;
}
.col-address{
  max-width: 340px;
  white-space: nowrap;
  overflow: hidden;
  text-overflow: ellipsis;
}

/* Button detail */
.btn-detail{
  display:inline-flex;
  align-items:center;
  gap: 8px;
  padding: 9px 12px;
  border-radius: 12px;
  font-weight: 800;
  text-decoration: none;
  color: #0f172a;
  background: #eef2ff;
  border: 1px solid rgba(99,102,241,.20);
  transition: transform .15s ease, box-shadow .15s ease;
}
.btn-detail:hover{
  transform: translateY(-1px);
  box-shadow: 0 10px 20px rgba(99,102,241,.15);
}

/* Status badge đẹp hơn */
.badge{
  padding: 6px 12px;
  border-radius: 999px;
  font-weight: 800;
  color: #fff;
  font-size: 12.5px;
  letter-spacing: .2px;
}
.status-1 { background: #f59e0b; } /* Waiting */
.status-2 { background: #0d6efd; } /* Packaging */
.status-3 { background: #6366f1; } /* Awaiting Delivery */
.status-4 { background: #22c55e; } /* Delivered */
.status-5 { background: #ef4444; } /* Cancelled */

/* Empty */
.empty-state{
  padding: 44px 18px;
  text-align:center;
}
.empty-icon{
  font-size: 34px;
  color: #94a3b8;
  margin-bottom: 10px;
}
.empty-title{
  font-weight: 900;
  color: var(--text);
}
.empty-sub{
  color: var(--muted);
  font-size: 13px;
  margin-top: 4px;
}

/* Responsive */
@media (max-width: 992px){
  main.main-content{
    margin-left: 0;
    width: 100%;
  }
  .page-head{
    flex-direction: column;
    align-items: stretch;
  }
  .search-wrap{ min-width: 100%; }
}

        </style>

    </head>
<body>

    <div class="app">
        <jsp:include page="../sideBar.jsp" />

        <main class="main-content">
            <jsp:include page="../header.jsp" />

            <div class="page">
                <div class="page-head">
                    <div>
                        <h1 class="page-title">Orders</h1>
                        <div class="page-sub">Manage and view customer orders</div>
                    </div>

                    <form class="search-form" method="get" action="ViewOrderList">
                        <div class="search-wrap">
                            <i class="fa-solid fa-magnifying-glass"></i>
                            <input type="text" name="search" placeholder="Search by Name, Phone..."
                                   value="${searchQuery}" />
                        </div>
                        <button type="submit" class="btn-search">
                            Search
                        </button>
                    </form>
                </div>

                <div class="card-table">
                    <c:if test="${not empty orderList}">
                        <div class="table-responsive">
                            <table class="table table-hover align-middle mb-0">
                                <thead>
                                    <tr>
                                        <th>Order ID</th>
                                        <th>Customer</th>
                                        <th>Phone</th>
                                        <th class="col-address">Address</th>
                                        <th>Total</th>
                                        <th>Order Date</th>
                                        <th>Updated</th>
                                        <th>Status</th>
                                        <th class="text-center">Action</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="order" items="${orderList}">
                                        <tr>
                                            <td class="fw-bold">#${order.orderID}</td>
                                            <td>${order.fullName}</td>
                                            <td>${order.phone}</td>
                                            <td class="col-address">${order.addressSnapshot}</td>
                                            <td class="fw-bold">
                                                <fmt:formatNumber value="${order.totalAmount}" type="currency" currencySymbol="₫" />
                                            </td>
                                            <td>${order.orderDate}</td>
                                            <td>${order.updatedDate}</td>
                                            <td>
                                                <span class="badge status-${order.status}">
                                                    <c:choose>
                                                        <c:when test="${order.status == 1}">Waiting</c:when>
                                                        <c:when test="${order.status == 2}">Packaging</c:when>
                                                        <c:when test="${order.status == 3}">Awaiting Delivery</c:when>
                                                        <c:when test="${order.status == 4}">Delivered</c:when>
                                                        <c:otherwise>Cancelled</c:otherwise>
                                                    </c:choose>
                                                </span>
                                            </td>
                                            <td class="text-center">
                                                <a href="ViewOrderDetail?orderID=${order.orderID}" class="btn btn-detail">
                                                    <i class="fa-regular fa-eye"></i> Detail
                                                </a>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </c:if>

                    <c:if test="${empty orderList}">
                        <div class="empty-state">
                            <div class="empty-icon"><i class="fa-regular fa-rectangle-list"></i></div>
                            <div class="empty-title">No orders found</div>
                            <div class="empty-sub">Try a different keyword.</div>
                        </div>
                    </c:if>
                </div>
            </div>
        </main>
    </div>

    <%
        String success = request.getParameter("success");
        String error = request.getParameter("error");
    %>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <script>
        window.onload = function () {
        <% if ("update".equals(success)) { %>
            Swal.fire({
                icon: 'success',
                title: 'Updated successfully!',
                text: 'Order status has been updated.',
                timer: 3000,
                confirmButtonText: 'OK'
            });
        <% } else if ("1".equals(error)) { %>
            Swal.fire({
                icon: 'error',
                title: 'Error!',
                text: 'Unable to update order status.',
                timer: 3000,
                confirmButtonText: 'Retry'
            });
        <% }%>

            if (window.history.replaceState) {
                const url = new URL(window.location);
                url.searchParams.delete('success');
                url.searchParams.delete('error');
                window.history.replaceState({}, document.title, url.pathname + (url.searchParams.toString() ? ("?" + url.searchParams.toString()) : ""));
            }
        };
    </script>

</body>

</html>