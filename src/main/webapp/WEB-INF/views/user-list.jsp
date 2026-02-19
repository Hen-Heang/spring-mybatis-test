<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>All Users - Store Admin</title>

    <!-- External CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin.css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css"/>

    <!-- jQuery CDN (Required for AJAX) -->
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
</head>
<body>

<div class="container">
    <!-- Header with Navigation -->
    <header class="header">
        <h1>🏪 Store Admin</h1>
        <nav class="nav">
            <a href="${pageContext.request.contextPath}/dashboard" class="nav-link">Dashboard</a>
            <a href="${pageContext.request.contextPath}/store/category" class="nav-link">Category</a>
            <a href="${pageContext.request.contextPath}/store/product" class="nav-link">Product</a>
            <a href="${pageContext.request.contextPath}/" class="nav-link active">Users</a>

        </nav>
    </header>

    <!-- Main Content -->
    <main class="main">
        <div class="page-header">
            <h2>All Users (사용자 목록)</h2>
            <a href="${pageContext.request.contextPath}/" class="btn btn-primary">+ Create New User</a>
        </div>

        <!-- Statistics Cards (통계 카드) -->
        <div class="stats">
            <div class="stat-card">
                <div class="stat-number" id="totalUsers">-</div>
                <div class="stat-label">Total Users</div>
            </div>
            <div class="stat-card">
                <div class="stat-number" id="activeUsers">-</div>
                <div class="stat-label">Active</div>
            </div>
            <div class="stat-card">
                <div class="stat-number" id="inactiveUsers">-</div>
                <div class="stat-label">Inactive</div>
            </div>
            <div class="stat-card">
                <div class="stat-number" id="pendingUsers">-</div>
                <div class="stat-label">Pending</div>
            </div>
        </div>

        <!-- Search Box (검색 박스) -->
        <div class="search-box">
            <div class="search-box-title">
                🔍 Search Users (사용자 검색)
            </div>
            <div class="search-row">
                <!-- Search Type Dropdown -->
                <label for="searchType"></label><select id="searchType" class="search-select">
                <option value="all">All Fields (전체)</option>
                <option value="username">Username (이름)</option>
                <option value="email">Email (이메일)</option>
            </select>

                <!-- Search Input -->
                <label for="searchKeyword"></label><input type="text" id="searchKeyword" class="search-input"
                                                          placeholder="Enter search keyword... (검색어를 입력하세요)"/>

                <!-- Search Button -->
                <button type="button" class="btn-search" onclick="searchUsers()">
                    Search (검색)
                </button>

                <!-- Reset Button -->
                <button type="button" class="btn-reset" onclick="resetSearch()">
                    Reset (초기화)
                </button>
            </div>
        </div>

        <!-- Users Table (사용자 테이블) -->
        <div id="usersTableContainer">
            <div class="loading">Loading users...</div>
        </div>
        <div id="pagination" class="pagination"></div>

        <!-- View User Modal (사용자 상세 보기 모달) -->
        <div id="viewModal" class="modal-overlay">
            <div class="modal">
                <h2>User Details (사용자 정보)</h2>
                <div class="modal-body">
                    <div class="user-detail">
                        <div class="user-detail-row">
                            <span class="user-detail-label">ID:</span>
                            <span class="user-detail-value" id="viewId"></span>
                        </div>
                        <div class="user-detail-row">
                            <span class="user-detail-label">Username:</span>
                            <span class="user-detail-value" id="viewUsername"></span>
                        </div>
                        <div class="user-detail-row">
                            <span class="user-detail-label">Email:</span>
                            <span class="user-detail-value" id="viewEmail"></span>
                        </div>
                        <div class="user-detail-row">
                            <span class="user-detail-label">Status:</span>
                            <span class="user-detail-value" id="viewStatus"></span>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button class="btn" onclick="closeViewModal()">Close</button>
                </div>
            </div>
        </div>

        <!-- Edit User Modal (사용자 수정 모달) -->
        <div id="editModal" class="modal-overlay">
            <div class="modal">
                <h2>Edit User (사용자 수정)</h2>
                <div class="modal-body">
                    <input type="hidden" id="editId"/>
                    <div class="form-group">
                        <label for="editUsername">Username *</label>
                        <input type="text" id="editUsername" required maxlength="100"/>
                    </div>
                    <div class="form-group">
                        <label for="editEmail">Email *</label>
                        <input type="email" id="editEmail" required maxlength="150"/>
                    </div>
                    <div class="form-group">
                        <label for="editStatus">Status</label>
                        <select id="editStatus">
                            <option value="">-- Select Status --</option>
                            <option value="ACTIVE">Active</option>
                            <option value="INACTIVE">Inactive</option>
                            <option value="PENDING">Pending</option>
                        </select>
                    </div>
                </div>
                <div class="modal-footer">
                    <button class="btn btn-secondary" onclick="closeEditModal()">Cancel</button>
                    <button class="btn btn-success" onclick="saveUser()">Save Changes</button>
                </div>
            </div>
        </div>

        <script>
            window.APP_CONTEXT = '${pageContext.request.contextPath}';
        </script>
        <!-- External JavaScript -->
        <script src="${pageContext.request.contextPath}/js/user-api.js?v=20260219"></script>

        <!-- Page-specific JavaScript using jQuery -->
        <script>
            // Store all users data (사용자 데이터 저장)
            let allUsers = [];
            let currentPage = 1;
            let pageSize = 10;
            let totalCount = 0;
            let currentQuery = {};

            /* ============================================
               DOCUMENT READY - 페이지 로드 시 실행
               ============================================ */
            $(document).ready(function () {
                // Load users when the page loads
                loadUsers();

                // Set up modal close on the outside click
                setupModalCloseOnOutsideClick('viewModal');
                setupModalCloseOnOutsideClick('editModal');
            });

            /* ============================================
               LOAD & DISPLAY USERS (사용자 조회 및 표시)
               ============================================ */
            function loadUsers(page) {
                currentPage = page || 1;

                const params = Object.assign({}, currentQuery, {
                    page: currentPage,
                    size: pageSize
                });
                // Call API using jQuery AJAX
                UserAPI.getAll(
                    params,
                    // Success callback (성공 시 콜백)
                    function (result) {
                        const data = result.data;
                        const users = Array.isArray(data)
                            ? data
                            : (data && data.users) ? data.users : [];
                        allUsers = users;
                        totalCount = (data && data.total != null) ? data.total : users.length;

                        renderUsersTable(users);
                        updateStats(users, totalCount);
                        renderPagination(
                            totalCount,
                            (data && data.page) || currentPage,
                            (data && data.size) || pageSize
                        );
                    },
                    // Error callback (에러 시 콜백)
                    function (xhr, status, error) {
                        $('#usersTableContainer').html(
                            '<p class="muted">Error loading users. Please try again.</p>'
                        );
                    }
                );
            }

            // Update statistics (통계 업데이트)
            function updateStats(users, total) {
                $('#totalUsers').text(total);
                $('#activeUsers').text(users.filter(function (u) {
                    return u.status === 'ACTIVE';
                }).length);
                $('#inactiveUsers').text(users.filter(function (u) {
                    return u.status === 'INACTIVE';
                }).length);
                $('#pendingUsers').text(users.filter(function (u) {
                    return u.status === 'PENDING';
                }).length);
            }

            // Render users table (사용자 테이블 렌더링)
            function renderUsersTable(users) {
                const $container = $('#usersTableContainer');

                // Build table HTML
                let html = '<table>';
                html += '<thead><tr><th>ID</th><th>Username</th><th>Email</th><th>Status</th><th>Actions</th></tr></thead>';
                html += '<tbody>';

                // Check if users array is empty (데이터 없음 체크)
                if (!users || users.length === 0) {
                    html += '<tr><td colspan="5" class="no-data">No Data (데이터가 없습니다)</td></tr>';
                } else {
                    // Loop through each user using jQuery.each
                    $.each(users, function (index, user) {
                        html += '<tr>';
                        html += '<td>' + user.id + '</td>';
                        html += '<td>' + UIHelper.escapeHtml(user.username) + '</td>';
                        html += '<td>' + UIHelper.escapeHtml(user.email) + '</td>';
                        html += '<td>' + UIHelper.getStatusBadge(user.status) + '</td>';
                        html += '<td class="actions">';
                        html += '<button class="btn btn-sm" onclick="viewUser(' + user.id + ')">View</button>';
                        html += '<button class="btn btn-sm btn-warning" onclick="editUser(' + user.id + ')">Edit</button>';
                        html += '<button class="btn btn-sm btn-danger" onclick="deleteUser(' + user.id + ')">Delete</button>';
                        html += '</td>';
                        html += '</tr>';
                    });
                }

                html += '</tbody></table>';
                $container.html(html);
            }

            /* ============================================
               VIEW USER (사용자 상세 보기)
               ============================================ */
            function viewUser(id) {
                // Find user from stored data
                let user = null;
                $.each(allUsers, function (index, u) {
                    if (u.id === id) {
                        user = u;
                        return false; // break loop
                    }
                });

                if (user) {
                    $('#viewId').text(user.id);
                    $('#viewUsername').text(user.username || '');
                    $('#viewEmail').text(user.email || '');
                    $('#viewStatus').html(UIHelper.getStatusBadge(user.status));
                    UIHelper.showModal('viewModal');
                }
            }

            function closeViewModal() {
                UIHelper.closeModal('viewModal');
            }

            /* ============================================
               EDIT USER (사용자 수정)
               ============================================ */
            function editUser(id) {
                // Find user from stored data
                let user = null;
                $.each(allUsers, function (index, u) {
                    if (u.id === id) {
                        user = u;
                        return false; // break loop
                    }
                });

                if (user) {
                    $('#editId').val(user.id);
                    $('#editUsername').val(user.username || '');
                    $('#editEmail').val(user.email || '');
                    $('#editStatus').val(user.status || '');
                    UIHelper.showModal('editModal');
                }
            }

            function closeEditModal() {
                UIHelper.closeModal('editModal');
            }

            // Save user changes (사용자 정보 저장)
            function saveUser() {
                const id = $('#editId').val();
                const userData = {
                    username: $('#editUsername').val(),
                    email: $('#editEmail').val(),
                    status: $('#editStatus').val() || null
                };

                // Call API using jQuery AJAX
                UserAPI.update(id, userData,
                    // Success callback
                    function (result) {
                        alert('User updated successfully!');
                        closeEditModal();
                        loadUsers(currentPage); // Reload table
                    },
                    // Error callback
                    function (xhr, status, error) {
                        alert('Failed to update user: ' + error);
                    }
                );
            }

            /* ============================================
               DELETE USER (사용자 삭제)
               ============================================ */
            function deleteUser(id) {
                if (!confirm('Are you sure you want to delete this user?')) {
                    return;
                }

                // Call API using jQuery AJAX
                UserAPI.delete(id,
                    // Success callback
                    function (result) {
                        alert('User deleted successfully!');
                        loadUsers(currentPage); // Reload table
                    },
                    // Error callback
                    function (xhr, status, error) {
                        alert('Failed to delete user: ' + error);
                    }
                );
            }

            /* ============================================
               SEARCH USERS (사용자 검색)
               ============================================ */
            function searchUsers() {
                const searchType = $('#searchType').val();
                const keyword = $('#searchKeyword').val().trim();

                currentQuery = {};
                if (keyword) {
                    if (searchType === 'username') {
                        currentQuery.username = keyword;
                    } else if (searchType === 'email') {
                        currentQuery.email = keyword;
                    } else {
                        currentQuery.keyword = keyword;
                    }
                }

                loadUsers(1);
            }

            // Reset search (reset filters)
            function resetSearch() {
                $('#searchKeyword').val('');
                $('#searchType').val('all');
                currentQuery = {};
                loadUsers(1);
            }

            function renderPagination(total, page, size) {
                const $pagination = $('#pagination');
                const totalPages = Math.ceil(total / size);

                if (!totalPages || totalPages <= 1) {
                    $pagination.html('');
                    return;
                }

                const prevDisabled = page <= 1 ? 'disabled' : '';
                const nextDisabled = page >= totalPages ? 'disabled' : '';

                let html = '';
                html += '<button class="btn btn-sm btn-secondary" ' + prevDisabled + ' onclick="goToPage(' + (page - 1) + ')">Prev</button>';
                html += '<span class="page-info">Page ' + page + '/ ' + totalPages + '</span>';
                html += '<button class="btn btn-sm btn-secondary" ' + nextDisabled + ' onclick="goToPage(' + (page + 1) + ')">Next</button>';

                $pagination.html(html);
            }

            function goToPage(page) {
                if (page < 1) return;
                loadUsers(page);
            }

            // Search on Enter key (엔터키로 검색)
            $(document).ready(function () {
                $('#searchKeyword').on('keypress', function (e) {
                    if (e.which === 13) { // Enter key
                        searchUsers();
                    }
                });
            });
        </script>

    </main>
</div>
</body>
</html>
