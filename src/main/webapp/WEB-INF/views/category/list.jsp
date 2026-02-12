<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${pageTitle} - Store Admin</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin.css">
</head>
<body>
<div class="container">
    <!-- Header -->
    <header class="header">
        <h1>🏪 Store Admin</h1>
        <nav class="nav">
            <a href="${pageContext.request.contextPath}/dashboard" class="nav-link">Dashboard</a>
            <a href="${pageContext.request.contextPath}/store/category" class="nav-link active">Category</a>
            <a href="${pageContext.request.contextPath}/store/product" class="nav-link">Product</a>
            <a href="${pageContext.request.contextPath}/" class="nav-link">Users</a>
        </nav>
    </header>

    <!-- Main Content -->
    <main class="main">
        <div class="page-header">
            <div class="page-title">
                <h2>${pageTitle}</h2>
                <p class="page-hint">Create and organize categories for your catalog.</p>
            </div>
            <button type="button" id="btnAdd" class="btn btn-primary">+ Add Category</button>
        </div>

        <!-- Category List Table -->
        <div class="table-container">
            <table class="table">
                <thead>
                <tr>
                    <th>ID</th>
                    <th>Category Name</th>
                    <th>Created At</th>
                    <th>Actions</th>
                </tr>
                </thead>
                <tbody id="categoryTableBody">
                <!-- Data loaded via AJAX -->
                <tr>
                    <td colspan="4" class="text-center">Loading data...</td>
                </tr>
                </tbody>
            </table>
        </div>
    </main>
</div>

<!-- Category Create/Edit Modal -->
<div id="categoryModal" class="modal">
    <div class="modal-content">
        <div class="modal-header">
            <h3 id="modalTitle">Add Category</h3>
            <button type="button" class="close-btn" onclick="closeModal()">&times;</button>
        </div>
        <form id="categoryForm">
            <input type="hidden" id="categoryId">
            <div class="form-group">
                <label for="categoryName">Category Name <span class="required">*</span></label>
                <input type="text" id="categoryName" name="name" class="form-control"
                       placeholder="Enter category name" required>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" onclick="closeModal()">Cancel</button>
                <button type="submit" class="btn btn-primary">Save</button>
            </div>
        </form>
    </div>
</div>

<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script src="${pageContext.request.contextPath}/js/category.js"></script>
</body>
</html>
