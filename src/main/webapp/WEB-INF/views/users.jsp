<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Create User</title>

    <!-- External CSS -->
    <link rel="stylesheet" href="/css/style.css" />

    <!-- jQuery CDN (Required for AJAX) -->
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
</head>
<body>

<div class="container">
    <!-- Page Header -->
    <h1>
        Create User (사용자 생성)
        <div class="header-actions">
            <a href="/user-list" class="btn">View All Users</a>
        </div>
    </h1>

    <!-- Message Area (메시지 영역) -->
    <div id="message" class="message"></div>

    <!-- Create User Form (사용자 생성 폼) -->
    <div class="form-section">
        <h2>New User Information (새 사용자 정보)</h2>
        <form id="createUserForm">
            <div class="form-group">
                <label for="username">Username *</label>
                <input type="text" id="username" name="username" required maxlength="100" placeholder="Enter username" />
            </div>
            <div class="form-group">
                <label for="email">Email *</label>
                <input type="email" id="email" name="email" required maxlength="150" placeholder="Enter email" />
            </div>
            <div class="form-group">
                <label for="status">Status</label>
                <select id="status" name="status">
                    <option value="">-- Select Status --</option>
                    <option value="active">Active</option>
                    <option value="inactive">Inactive</option>
                    <option value="pending">Pending</option>
                </select>
            </div>
            <button type="submit" class="btn btn-success">Create User</button>
        </form>
    </div>

    <!-- Recent Users Table (최근 사용자 목록) -->
    <h2>Recent Users (최근 사용자)</h2>
    <div id="usersTableContainer">
        <div class="loading">Loading users...</div>
    </div>
</div>

<!-- Success Modal (성공 모달) -->
<div id="successModal" class="modal-overlay">
    <div class="modal">
        <h2>User Created Successfully! (사용자 생성 완료!)</h2>
        <div class="modal-body">
            <div class="user-detail">
                <div class="user-detail-row">
                    <span class="user-detail-label">Username:</span>
                    <span class="user-detail-value" id="modalUsername"></span>
                </div>
                <div class="user-detail-row">
                    <span class="user-detail-label">Email:</span>
                    <span class="user-detail-value" id="modalEmail"></span>
                </div>
                <div class="user-detail-row">
                    <span class="user-detail-label">Status:</span>
                    <span class="user-detail-value" id="modalStatus"></span>
                </div>
            </div>
        </div>
        <div class="modal-footer">
            <button class="btn btn-secondary" onclick="closeSuccessModal()">Close</button>
            <button class="btn btn-success" onclick="createAnother()">Create Another</button>
        </div>
    </div>
</div>

<!-- External JavaScript -->
<script src="/js/user-api.js"></script>

<!-- Page-specific JavaScript using jQuery -->
<script>
    /* ============================================
       DOCUMENT READY - 페이지 로드 시 실행
       ============================================ */
    $(document).ready(function() {
        // Load users when page loads
        loadUsers();

        // Setup modal close on outside click
        setupModalCloseOnOutsideClick('successModal');

        // Form submit handler using jQuery
        $('#createUserForm').on('submit', function(e) {
            e.preventDefault(); // Prevent default form submission
            createUser();
        });
    });

    /* ============================================
       CREATE USER (사용자 생성)
       ============================================ */
    function createUser() {
        // Get form data using jQuery
        var userData = {
            username: $('#username').val(),
            email: $('#email').val(),
            status: $('#status').val() || null
        };

        // Call API using jQuery AJAX
        UserAPI.create(userData,
            // Success callback (성공 시 콜백)
            function(result) {
                showSuccessModal(userData);
                $('#createUserForm')[0].reset(); // Reset form
                loadUsers(); // Reload table
            },
            // Error callback (에러 시 콜백)
            function(xhr, status, error) {
                var errorMsg = 'Failed to create user';
                if (xhr.responseJSON && xhr.responseJSON.resultMsg) {
                    errorMsg = xhr.responseJSON.resultMsg;
                }
                UIHelper.showMessage('message', errorMsg, false);
            }
        );
    }

    /* ============================================
       SUCCESS MODAL (성공 모달)
       ============================================ */
    function showSuccessModal(userData) {
        $('#modalUsername').text(userData.username);
        $('#modalEmail').text(userData.email);
        $('#modalStatus').text(userData.status || 'Not specified');
        UIHelper.showModal('successModal');
    }

    function closeSuccessModal() {
        UIHelper.closeModal('successModal');
    }

    function createAnother() {
        closeSuccessModal();
        $('#username').focus();
    }

    /* ============================================
       LOAD & DISPLAY RECENT USERS (최근 사용자 조회 및 표시)
       ============================================ */
    function loadUsers() {
        // Call API using jQuery AJAX
        UserAPI.getAll(
            // Success callback
            function(result) {
                if (result.data && result.data.length > 0) {
                    renderUsersTable(result.data);
                } else {
                    $('#usersTableContainer').html(
                        '<p class="muted">No users yet. Create your first user above!</p>'
                    );
                }
            },
            // Error callback
            function(xhr, status, error) {
                $('#usersTableContainer').html(
                    '<p class="muted">Error loading users.</p>'
                );
            }
        );
    }

    // Render users table (사용자 테이블 렌더링)
    function renderUsersTable(users) {
        var $container = $('#usersTableContainer');

        var html = '<table>';
        html += '<thead><tr><th>ID</th><th>Username</th><th>Email</th><th>Status</th></tr></thead>';
        html += '<tbody>';

        // Loop through each user using jQuery.each
        $.each(users, function(index, user) {
            html += '<tr>';
            html += '<td>' + user.id + '</td>';
            html += '<td>' + UIHelper.escapeHtml(user.username) + '</td>';
            html += '<td>' + UIHelper.escapeHtml(user.email) + '</td>';
            html += '<td>' + UIHelper.getStatusBadge(user.status) + '</td>';
            html += '</tr>';
        });

        html += '</tbody></table>';
        $container.html(html);
    }
</script>

</body>
</html>
