<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <title>Customer Feedback</title>
    <meta name="viewport" content="width=device-width, initial-scale=1" />

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">

    <style>
        :root{
            --sidebar-w: 260px;
            --header-h: 78px;

            --bg:#f4f6fb;
            --card:#fff;
            --text:#111827;
            --muted:#6b7280;
            --border:rgba(15, 23, 42, 0.10);
            --shadow:0 12px 28px rgba(0,0,0,.08);
        }

        body{ margin:0; background:var(--bg); font-family:"Segoe UI",system-ui,-apple-system,Arial,sans-serif; }
        .app{ min-height:100vh; }

        main.main-content{
            margin-left: var(--sidebar-w);
            width: calc(100% - var(--sidebar-w));
            padding: 24px;
            padding-top: calc(var(--header-h) + 18px);
            min-height: 100vh;
        }
        .page{ max-width: 1200px; margin: 0 auto; }

        .page-head{
            display:flex;
            justify-content: space-between;
            align-items:flex-end;
            gap: 14px;
            margin-bottom: 14px;
        }
        .page-title{ margin:0; font-weight: 900; color:var(--text); }
        .page-sub{ color:var(--muted); font-size: 13px; margin-top: 4px; }

        .card-table{
            background: var(--card);
            border: 1px solid var(--border);
            border-radius: 18px;
            box-shadow: var(--shadow);
            overflow:hidden;
        }

        .table thead th{
            background:#f8fafc;
            border-bottom: 1px solid var(--border);
            color:#475569;
            font-weight: 900;
            font-size: 13px;
            padding: 14px;
            white-space: nowrap;
        }
        .table tbody td{
            padding: 14px;
            color:#0f172a;
            font-size: 14px;
            vertical-align: middle;
        }

        .badge-status{
            padding: 6px 12px;
            border-radius: 999px;
            font-weight: 900;
            font-size: 12px;
            display:inline-flex;
            align-items:center;
            gap: 8px;
            border: 1px solid rgba(15,23,42,.08);
        }
        .badge-new{ background:#ecfdf5; color:#065f46; }
        .badge-seen{ background:#f1f5f9; color:#334155; }

        .row-new{
            background: linear-gradient(0deg, rgba(34,197,94,.08), rgba(34,197,94,.08));
        }

        .star-rating{
            display:inline-flex;
            gap: 3px;
            align-items:center;
        }
        .star-rating i{ color:#fbbf24; }
        .star-rating .far{ color:#cbd5e1; }

        .btn-view{
            border-radius: 12px !important;
            font-weight: 900 !important;
            padding: 8px 12px !important;
        }

        .empty-state{
            padding: 40px 18px;
            text-align:center;
            color: var(--muted);
        }
        .empty-state .icon{
            font-size: 34px;
            margin-bottom: 10px;
            opacity: .8;
        }

        @media (max-width: 992px){
            main.main-content{ margin-left:0; width:100%; }
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
                    <h1 class="page-title">Customer Feedback</h1>
                    <div class="page-sub">Review new ratings and view detail</div>
                </div>
            </div>

            <div class="card-table">
                <c:if test="${empty ProductRating}">
                    <div class="empty-state">
                        <div class="icon"><i class="fa-regular fa-comment-dots"></i></div>
                        <div class="fw-bold text-dark">No feedback available</div>
                        <div class="small">New customer ratings will appear here.</div>
                    </div>
                </c:if>

                <c:if test="${not empty ProductRating}">
                    <div class="table-responsive">
                        <table class="table table-hover align-middle mb-0">
                            <thead>
                                <tr>
                                    <th style="width:80px;">#</th>
                                    <th>Customer Name</th>
                                    <th style="width:140px;">Status</th>
                                    <th style="width:180px;">Star</th>
                                    <th class="text-end" style="width:180px;">Action</th>
                                </tr>
                            </thead>

                            <tbody>
                                <c:forEach items="${ProductRating}" var="rate" varStatus="loop">
                                    <tr class="${!rate.isRead ? 'row-new' : ''}">
                                        <td class="fw-bold">${loop.index + 1}</td>

                                        <td class="fw-bold">${rate.fullName}</td>

                                        <td>
                                            <span class="badge-status ${!rate.isRead ? 'badge-new' : 'badge-seen'}">
                                                <i class="fa-solid ${!rate.isRead ? 'fa-circle-check' : 'fa-eye'}"></i>
                                                ${!rate.isRead ? 'New' : 'Seen'}
                                            </span>
                                        </td>

                                        <td>
                                            <div class="star-rating" aria-label="rating">
                                                <c:forEach begin="1" end="${rate.star}" var="i">
                                                    <i class="fas fa-star"></i>
                                                </c:forEach>
                                                <c:forEach begin="${rate.star + 1}" end="5" var="i">
                                                    <i class="far fa-star"></i>
                                                </c:forEach>
                                            </div>
                                        </td>

                                        <td class="text-end">
                                            <a href="ViewFeedBackForStaff?rateID=${rate.rateID}" class="btn btn-primary btn-view">
                                                <i class="fas fa-eye me-1"></i> View Details
                                            </a>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </c:if>
            </div>
        </div>
    </main>
</div>
</body>
</html>
