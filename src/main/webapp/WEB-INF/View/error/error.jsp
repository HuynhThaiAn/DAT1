<%-- 
    Document   : error
    Created on : Aug 3, 2025, 5:02:04 PM
    Author     : Tai
    Updated    : Modern TShop error page
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Error - Page Not Found</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <!-- Bootstrap & Icons (nếu header.jsp chưa có thì vẫn ổn, có rồi thì browser tự reuse) -->
    <link rel="stylesheet"
          href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <link rel="stylesheet"
          href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">

    <style>
        @import url('https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap');

        :root {
            --primary-500: #2563eb;
            --primary-400: #3b82f6;
            --primary-100: #dbeafe;
            --slate-900: #0f172a;
            --slate-700: #334155;
            --slate-500: #64748b;
            --slate-100: #f1f5f9;
            --white: #ffffff;
        }

        body {
            font-family: 'Inter', system-ui, -apple-system, BlinkMacSystemFont, sans-serif;
            background: linear-gradient(180deg, #f8fbff 0%, #eef2ff 100%);
            margin: 0;
            min-height: 100vh;
            display: flex;
            flex-direction: column;
        }

        /* Wrapper toàn trang (trừ header/footer) */
        .error-shell {
            flex: 1;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 32px 16px;
        }

        .error-card {
            width: 100%;
            max-width: 520px;
            background: rgba(255, 255, 255, 0.96);
            border-radius: 24px;
            padding: 32px 26px 28px;
            box-shadow: 0 24px 60px rgba(15, 23, 42, 0.12);
            border: 1px solid rgba(226, 232, 240, 0.9);
            text-align: center;
            position: relative;
            overflow: hidden;
        }

        .error-card::before {
            content: "";
            position: absolute;
            inset: 16px;
            border-radius: 20px;
            border: 1px dashed rgba(148, 163, 184, 0.35);
            pointer-events: none;
        }

        .error-icon-wrapper {
            width: 70px;
            height: 70px;
            border-radius: 999px;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 16px;
            background: radial-gradient(circle at 30% 0,
                        rgba(248, 113, 113, 0.2),
                        rgba(248, 250, 252, 1));
            box-shadow: 0 12px 30px rgba(248, 113, 113, 0.25);
        }

        .error-icon-wrapper i {
            font-size: 2rem;
            color: #ef4444;
        }

        .error-title {
            font-size: 1.65rem;
            font-weight: 700;
            color: var(--slate-900);
            margin-bottom: 8px;
        }

        .error-code {
            font-size: 0.9rem;
            font-weight: 600;
            letter-spacing: 0.08em;
            text-transform: uppercase;
            color: #ef4444;
            margin-bottom: 12px;
        }

        .error-subtitle {
            font-size: 0.98rem;
            color: var(--slate-600, #475569);
            margin-bottom: 18px;
        }

        .error-hotline {
            font-size: 0.95rem;
            color: var(--slate-700);
            margin-bottom: 22px;
        }

        .error-hotline span {
            color: #ef4444;
            font-weight: 700;
        }

        .btn-back-home {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            gap: 8px;
            padding: 11px 26px;
            font-size: 0.98rem;
            background: linear-gradient(135deg, var(--primary-500), var(--primary-400));
            color: var(--white);
            border: none;
            border-radius: 999px;
            text-decoration: none;
            font-weight: 600;
            box-shadow: 0 16px 40px rgba(37, 99, 235, 0.45);
            transition: transform 0.18s ease, box-shadow 0.18s ease;
            margin-top: 6px;
        }

        .btn-back-home:hover {
            transform: translateY(-1px);
            box-shadow: 0 20px 50px rgba(37, 99, 235, 0.6);
            color: #fff;
        }

        .btn-back-home i {
            font-size: 1.1rem;
        }

        .error-hint {
            margin-top: 14px;
            font-size: 0.86rem;
            color: var(--slate-500);
        }

        @media (max-width: 576px) {
            .error-card {
                padding: 24px 18px 22px;
            }
            .error-title {
                font-size: 1.4rem;
            }
        }
    </style>
</head>
<body>
    <!-- Header dùng chung -->
    <jsp:include page="/WEB-INF/View/customer/homePage/header.jsp" />

    <!-- Main content -->
    <div class="error-shell">
        <div class="error-card">
            <div class="error-icon-wrapper">
                <i class="bi bi-exclamation-triangle-fill"></i>
            </div>
            <div class="error-code">Error</div>
            <div class="error-title">The link has expired or does not exist</div>
            <div class="error-subtitle">
                The page you’re looking for might have been removed, had its name changed,
                or is temporarily unavailable.
            </div>
            <div class="error-hotline">
                You can contact our free hotline
                <span>1800 6601</span>
                for support.
            </div>
            <a href="${pageContext.request.contextPath}/Home" class="btn-back-home">
                <i class="bi bi-arrow-left"></i>
                Back to Home
            </a>
            <div class="error-hint">
                Tip: Check the link again or go back to the homepage to continue shopping.
            </div>
        </div>
    </div>

    <!-- Footer dùng chung -->
    <jsp:include page="/WEB-INF/View/customer/homePage/footer.jsp" />
</body>
</html>
