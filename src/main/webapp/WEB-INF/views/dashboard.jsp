<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard - Store Admin</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { font-family: Arial, sans-serif; background: #f5f5f5; }
        .container { max-width: 1200px; margin: 0 auto; padding: 20px; }
        .header { background: #fff; padding: 20px; border-radius: 8px; margin-bottom: 20px; display: flex; justify-content: space-between; align-items: center; }
        .header h1 { font-size: 24px; color: #2c3e50; }
        .nav { display: flex; gap: 15px; align-items: center; }
        .nav-link { text-decoration: none; color: #666; padding: 8px 16px; border-radius: 4px; }
        .nav-link:hover, .nav-link.active { background: #3498db; color: #fff; }
        .btn-logout { padding: 8px 16px; background: #e74c3c; color: #fff; border: none; border-radius: 4px; cursor: pointer; text-decoration: none; }
        .dashboard-cards { display: grid; grid-template-columns: repeat(auto-fit, minmax(280px, 1fr)); gap: 20px; margin-top: 20px; }
        .dashboard-card { background: #fff; border-radius: 8px; padding: 25px; text-decoration: none; color: inherit; box-shadow: 0 2px 4px rgba(0,0,0,0.1); }
        .dashboard-card:hover { transform: translateY(-5px); box-shadow: 0 8px 16px rgba(0,0,0,0.15); }
        .dashboard-card-icon { font-size: 48px; margin-bottom: 15px; }
        .dashboard-card-title { font-size: 24px; font-weight: bold; margin-bottom: 10px; color: #2c3e50; }
        .dashboard-card-count { font-size: 36px; font-weight: bold; margin-bottom: 10px; color: #3498db; }
        .dashboard-card-desc { color: #666; }
    </style>
</head>
<body>
    <div class="container">
        <header class="header">
            <h1>🏪 Store Admin Dashboard</h1>
            <nav class="nav">
                <a href="${pageContext.request.contextPath}/dashboard" class="nav-link active">Dashboard</a>
                <a href="${pageContext.request.contextPath}/store/category" class="nav-link">Category</a>
                <a href="${pageContext.request.contextPath}/store/product" class="nav-link">Product</a>
                <a href="${pageContext.request.contextPath}/" class="nav-link">Users</a>
                <a href="${pageContext.request.contextPath}/auth/logout" class="btn btn-danger btn-logout">Logout</a>
            </nav>
        </header>

        <main class="main main-dashboard">
            <div class="page-header dashboard-header">
                <div class="page-title">
                    <h2>Welcome to Store Admin</h2>
                    <p class="page-hint">Quick access to products, categories, and users.</p>
                </div>
            </div>

            <div class="dashboard-cards">
                <a href="${pageContext.request.contextPath}/store/category" class="dashboard-card">
                    <div class="dashboard-card-icon">📁</div>
                    <div class="dashboard-card-title">Categories</div>
                    <div class="dashboard-card-count" id="categoryCount">-</div>
                    <div class="dashboard-card-desc">Manage product categories</div>
                </a>

                <a href="${pageContext.request.contextPath}/store/product" class="dashboard-card">
                    <div class="dashboard-card-icon">📦</div>
                    <div class="dashboard-card-title">Products</div>
                    <div class="dashboard-card-count" id="productCount">-</div>
                    <div class="dashboard-card-desc">Manage store products</div>
                </a>

                <a href="${pageContext.request.contextPath}/" class="dashboard-card">
                    <div class="dashboard-card-icon">👥</div>
                    <div class="dashboard-card-title">Users</div>
                    <div class="dashboard-card-count" id="userCount">-</div>
                    <div class="dashboard-card-desc">Manage users</div>
                </a>
            </div>
        </main>
    </div>

    <script>
        // Fetch counts from API - API returns { status: {...}, data: [...] }
        fetch('/api/categories')
            .then(r => r.json())
            .then(response => {
                const data = response.data || response;
                document.getElementById('categoryCount').textContent = Array.isArray(data) ? data.length : '-';
            })
            .catch(() => document.getElementById('categoryCount').textContent = '0');

        fetch('/api/products')
            .then(r => r.json())
            .then(response => {
                const data = response.data || response;
                document.getElementById('productCount').textContent = Array.isArray(data) ? data.length : '-';
            })
            .catch(() => document.getElementById('productCount').textContent = '0');

        fetch('/users')
            .then(r => r.json())
            .then(response => {
                const data = response.data || response;
                document.getElementById('userCount').textContent = Array.isArray(data) ? data.length : '-';
            })
            .catch(() => document.getElementById('userCount').textContent = '0');
    </script>
</body>
</html>
