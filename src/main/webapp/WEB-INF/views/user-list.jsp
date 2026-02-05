<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>All Users - Store Admin</title>

    <!-- External CSS -->
    <link rel="stylesheet" href="/css/admin.css" />
    <link rel="stylesheet" href="/css/style.css" />

    <!-- jQuery CDN (Required for AJAX) -->
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
</head>
<body>

<div class="container">
    <!-- Header with Navigation -->
    <header class="header">
        <h1>🏪 Store Admin</h1>
        <nav class="nav">
            <a href="/dashboard" class="nav-link">Dashboard</a>
            <a href="/store/category" class="nav-link">Category</a>
            <a href="/store/product" class="nav-link">Product</a>
            <a href="/" class="nav-link active">Users</a>
            <a href="/auth/logout" style="padding: 8px 16px; background: #e74c3c; color: #fff; border: none; border-radius: 4px; text-decoration: none;">로그아웃</a>
        </nav>
    </header>

    <!-- Main Content -->
    <main class="main">
        <div class="page-header">
            <h2>All Users (사용자 목록)</h2>
            <a href="/" class="btn btn-primary">+ Create New User</a>
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
            <select id="searchType" class="search-select">
                <option value="all">All Fields (전체)</option>
                <option value="username">Username (이름)</option>
                <option value="email">Email (이메일)</option>
            </select>

            <!-- Search Input -->
            <input type="text" id="searchKeyword" class="search-input"
                   placeholder="Enter search keyword... (검색어를 입력하세요)" />

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
</div>

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
            <input type="hidden" id="editId" />
            <div class="form-group">
                <label for="editUsername">Username *</label>
                <input type="text" id="editUsername" required maxlength="100" />
            </div>
            <div class="form-group">
                <label for="editEmail">Email *</label>
                <input type="email" id="editEmail" required maxlength="150" />
            </div>
            <div class="form-group">
                <label for="editStatus">Status</label>
                <select id="editStatus">
                    <option value="">-- Select Status --</option>
                    <option value="active">Active</option>
                    <option value="inactive">Inactive</option>
                    <option value="pending">Pending</option>
                </select>
            </div>
        </div>
        <div class="modal-footer">
            <button class="btn btn-secondary" onclick="closeEditModal()">Cancel</button>
            <button class="btn btn-success" onclick="saveUser()">Save Changes</button>
        </div>
    </div>
</div>

<!-- External JavaScript -->
<script src="/js/user-api.js"></script>

<!-- Page-specific JavaScript using jQuery -->
<script>
    // Store all users data (사용자 데이터 저장)
    var allUsers = [];

    /* ============================================
       DOCUMENT READY - 페이지 로드 시 실행
       ============================================ */
    $(document).ready(function() {
        // Load users when page loads
        loadUsers();

        // Setup modal close on outside click
        setupModalCloseOnOutsideClick('viewModal');
        setupModalCloseOnOutsideClick('editModal');
    });

    /* ============================================
       LOAD & DISPLAY USERS (사용자 조회 및 표시)
       ============================================ */
    function loadUsers() {
        // Call API using jQuery AJAX
        UserAPI.getAll(
            // Success callback (성공 시 콜백)
            function(result) {
                if (result.data && result.data.length > 0) {
                    allUsers = result.data;
                    renderUsersTable(allUsers);
                    updateStats(allUsers);
                } else {
                    allUsers = [];
                    renderUsersTable([]);  // Show table with "No Data" message
                    updateStats([]);
                }
            },
            // Error callback (에러 시 콜백)
            function(xhr, status, error) {
                $('#usersTableContainer').html(
                    '<p class="muted">Error loading users. Please try again.</p>'
                );
            }
        );
    }

    // Update statistics (통계 업데이트)
    function updateStats(users) {
        $('#totalUsers').text(users.length);
        $('#activeUsers').text(users.filter(function(u) { return u.status === 'active'; }).length);
        $('#inactiveUsers').text(users.filter(function(u) { return u.status === 'inactive'; }).length);
        $('#pendingUsers').text(users.filter(function(u) { return u.status === 'pending'; }).length);
    }

    // Render users table (사용자 테이블 렌더링)
    function renderUsersTable(users) {
        var $container = $('#usersTableContainer');

        // Build table HTML
        var html = '<table>';
        html += '<thead><tr><th>ID</th><th>Username</th><th>Email</th><th>Status</th><th>Actions</th></tr></thead>';
        html += '<tbody>';

        // Check if users array is empty (데이터 없음 체크)
        if (!users || users.length === 0) {
            html += '<tr><td colspan="5" class="no-data">No Data (데이터가 없습니다)</td></tr>';
        } else {
            // Loop through each user using jQuery.each
            $.each(users, function(index, user) {
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
        var user = null;
        $.each(allUsers, function(index, u) {
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
        var user = null;
        $.each(allUsers, function(index, u) {
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
        var id = $('#editId').val();
        var userData = {
            username: $('#editUsername').val(),
            email: $('#editEmail').val(),
            status: $('#editStatus').val() || null
        };

        // Call API using jQuery AJAX
        UserAPI.update(id, userData,
            // Success callback
            function(result) {
                alert('User updated successfully!');
                closeEditModal();
                loadUsers(); // Reload table
            },
            // Error callback
            function(xhr, status, error) {
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
            function(result) {
                alert('User deleted successfully!');
                loadUsers(); // Reload table
            },
            // Error callback
            function(xhr, status, error) {
                alert('Failed to delete user: ' + error);
            }
        );
    }

    /* ============================================
       SEARCH USERS (사용자 검색)
       ============================================ */
    function searchUsers() {
        var searchType = $('#searchType').val();
        var keyword = $('#searchKeyword').val().trim().toLowerCase();

        // If no keyword, show all users
        if (!keyword) {
            renderUsersTable(allUsers);
            updateStats(allUsers);
            return;
        }

        // Filter users based on search type
        var filteredUsers = allUsers.filter(function(user) {
            if (searchType === 'username') {
                // Search by username only (이름으로만 검색)
                return user.username && user.username.toLowerCase().indexOf(keyword) !== -1;
            } else if (searchType === 'email') {
                // Search by email only (이메일로만 검색)
                return user.email && user.email.toLowerCase().indexOf(keyword) !== -1;
            } else {
                // Search by all (전체 검색) - username OR email
                var matchUsername = user.username && user.username.toLowerCase().indexOf(keyword) !== -1;
                var matchEmail = user.email && user.email.toLowerCase().indexOf(keyword) !== -1;
                return matchUsername || matchEmail;
            }
        });

        // Display filtered results
        renderUsersTable(filteredUsers);

        // Update stats with filtered count
        updateSearchStats(filteredUsers.length, allUsers.length);
    }

    // Update stats to show search results count (검색 결과 카운트 표시)
    function updateSearchStats(filteredCount, totalCount) {
        $('#totalUsers').html(filteredCount + ' <small style="font-size:0.5em; color:#666;">/ ' + totalCount + '</small>');
    }

    // Reset search (검색 초기화)
    function resetSearch() {
        $('#searchKeyword').val('');
        $('#searchType').val('all');
        renderUsersTable(allUsers);
        updateStats(allUsers);
    }

    // Search on Enter key (엔터키로 검색)
    $(document).ready(function() {
        $('#searchKeyword').on('keypress', function(e) {
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
