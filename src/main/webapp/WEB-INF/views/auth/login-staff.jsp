<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Staff Login</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
<div class="container py-5" style="max-width:520px;">
  <h3 class="mb-3">Staff Login</h3>
  <div class="text-danger mb-2">${error}</div>

  <form method="post" action="${pageContext.request.contextPath}/LoginStaff">
    <div class="mb-3">
      <label class="form-label">Email (@datshop.com)</label>
      <input class="form-control" name="email" required
             pattern="^[A-Za-z0-9._%+-]+@datshop\\.com$"
             placeholder="staff@datshop.com">
    </div>
    <div class="mb-3">
      <label class="form-label">Password</label>
      <input class="form-control" type="password" name="password" required minlength="6">
    </div>
    <button class="btn btn-primary w-100" type="submit">Login</button>
  </form>

  <div class="mt-3">
    <a href="${pageContext.request.contextPath}/LoginAdmin">Login as Admin</a>
  </div>
</div>
</body>
</html>
