/* ============================================
   PRACTICE EXAMPLES (연습 예제)

   This file contains common jQuery patterns
   used in Korean enterprise projects.

   이 파일은 한국 기업 프로젝트에서 자주 사용되는
   jQuery 패턴을 담고 있습니다.
   ============================================ */


/* ============================================
   1. AJAX PATTERNS (AJAX 패턴)
   ============================================ */

// Basic GET request (기본 GET 요청)
function ajaxGet(url, successCallback, errorCallback) {
    $.ajax({
        url: url,
        type: 'GET',
        dataType: 'json',
        success: function(result) {
            if (successCallback) successCallback(result);
        },
        error: function(xhr, status, error) {
            console.error('AJAX Error:', error);
            if (errorCallback) errorCallback(xhr, status, error);
        }
    });
}

// POST with JSON body (JSON 바디로 POST 요청)
function ajaxPost(url, data, successCallback, errorCallback) {
    $.ajax({
        url: url,
        type: 'POST',
        contentType: 'application/json',  // 서버에 JSON 전송
        data: JSON.stringify(data),        // 객체를 JSON 문자열로 변환
        dataType: 'json',
        success: function(result) {
            if (successCallback) successCallback(result);
        },
        error: function(xhr, status, error) {
            console.error('AJAX Error:', error);
            if (errorCallback) errorCallback(xhr, status, error);
        }
    });
}

// AJAX with loading indicator (로딩 표시와 함께 AJAX)
function ajaxWithLoading(url, type, data, successCallback) {
    // Show loading
    $('#loading').show();

    $.ajax({
        url: url,
        type: type,
        contentType: 'application/json',
        data: data ? JSON.stringify(data) : null,
        dataType: 'json',
        success: function(result) {
            if (successCallback) successCallback(result);
        },
        error: function(xhr, status, error) {
            alert('오류가 발생했습니다: ' + error);
        },
        complete: function() {
            // Always hide loading (성공/실패 관계없이 항상 실행)
            $('#loading').hide();
        }
    });
}


/* ============================================
   2. FORM HANDLING (폼 처리)
   ============================================ */

// Serialize form to object (폼을 객체로 변환)
function formToObject(formId) {
    var formData = {};
    var formArray = $('#' + formId).serializeArray();

    $.each(formArray, function(index, field) {
        formData[field.name] = field.value;
    });

    return formData;
}

// Example usage:
// var userData = formToObject('createUserForm');
// Result: { username: 'john', email: 'john@test.com', status: 'active' }


// Form validation (폼 유효성 검사)
function validateForm(formId) {
    var isValid = true;
    var $form = $('#' + formId);

    // Check required fields (필수 필드 검사)
    $form.find('[required]').each(function() {
        var $field = $(this);
        var value = $field.val().trim();

        if (!value) {
            isValid = false;
            $field.addClass('error');

            // Show error message
            var fieldName = $field.prev('label').text();
            alert(fieldName + '을(를) 입력해주세요.');
            $field.focus();
            return false; // break loop
        } else {
            $field.removeClass('error');
        }
    });

    return isValid;
}


// Reset form (폼 초기화)
function resetForm(formId) {
    var $form = $('#' + formId);
    $form[0].reset();
    $form.find('.error').removeClass('error');
    $form.find('.error-message').remove();
}


/* ============================================
   3. TABLE HANDLING (테이블 처리)
   ============================================ */

// Build table from data (데이터로 테이블 생성)
function buildTable(containerId, columns, data) {
    var $container = $('#' + containerId);

    var html = '<table class="data-table">';

    // Header
    html += '<thead><tr>';
    $.each(columns, function(index, col) {
        html += '<th>' + col.title + '</th>';
    });
    html += '</tr></thead>';

    // Body
    html += '<tbody>';
    if (data.length === 0) {
        html += '<tr><td colspan="' + columns.length + '" class="no-data">데이터가 없습니다.</td></tr>';
    } else {
        $.each(data, function(index, row) {
            html += '<tr>';
            $.each(columns, function(i, col) {
                var value = row[col.data] || '';

                // Custom render function (커스텀 렌더링 함수)
                if (col.render) {
                    value = col.render(value, row);
                }

                html += '<td>' + value + '</td>';
            });
            html += '</tr>';
        });
    }
    html += '</tbody></table>';

    $container.html(html);
}

// Example usage:
/*
var columns = [
    { title: 'ID', data: 'id' },
    { title: '이름', data: 'username' },
    { title: '이메일', data: 'email' },
    {
        title: '상태',
        data: 'status',
        render: function(value, row) {
            return '<span class="badge-' + value + '">' + value + '</span>';
        }
    },
    {
        title: '액션',
        data: 'id',
        render: function(value, row) {
            return '<button onclick="editUser(' + value + ')">수정</button>' +
                   '<button onclick="deleteUser(' + value + ')">삭제</button>';
        }
    }
];

buildTable('userTableContainer', columns, users);
*/


/* ============================================
   4. PAGINATION (페이징 처리)
   ============================================ */

// Build pagination (페이징 UI 생성)
function buildPagination(containerId, currentPage, totalPages, onPageClick) {
    var $container = $('#' + containerId);
    var html = '<div class="pagination">';

    // Previous button (이전 버튼)
    if (currentPage > 1) {
        html += '<a href="#" class="page-link" data-page="' + (currentPage - 1) + '">&laquo; 이전</a>';
    }

    // Page numbers (페이지 번호)
    var startPage = Math.max(1, currentPage - 2);
    var endPage = Math.min(totalPages, currentPage + 2);

    for (var i = startPage; i <= endPage; i++) {
        if (i === currentPage) {
            html += '<span class="page-link current">' + i + '</span>';
        } else {
            html += '<a href="#" class="page-link" data-page="' + i + '">' + i + '</a>';
        }
    }

    // Next button (다음 버튼)
    if (currentPage < totalPages) {
        html += '<a href="#" class="page-link" data-page="' + (currentPage + 1) + '">다음 &raquo;</a>';
    }

    html += '</div>';
    $container.html(html);

    // Click handler (클릭 핸들러)
    $container.find('.page-link[data-page]').on('click', function(e) {
        e.preventDefault();
        var page = $(this).data('page');
        if (onPageClick) onPageClick(page);
    });
}


/* ============================================
   5. MODAL HANDLING (모달 처리)
   ============================================ */

// Show modal (모달 표시)
function showModal(modalId) {
    $('#' + modalId).css('display', 'flex').hide().fadeIn(200);
}

// Hide modal (모달 숨기기)
function hideModal(modalId) {
    $('#' + modalId).fadeOut(200);
}

// Setup modal (모달 설정 - 외부 클릭 시 닫기)
function setupModal(modalId) {
    var $modal = $('#' + modalId);

    // Close on outside click (외부 클릭 시 닫기)
    $modal.on('click', function(e) {
        if (e.target === this) {
            hideModal(modalId);
        }
    });

    // Close on ESC key (ESC 키로 닫기)
    $(document).on('keydown', function(e) {
        if (e.key === 'Escape' && $modal.is(':visible')) {
            hideModal(modalId);
        }
    });
}


/* ============================================
   6. UTILITY FUNCTIONS (유틸리티 함수)
   ============================================ */

// Format date (날짜 포맷)
function formatDate(dateString, format) {
    if (!dateString) return '';

    var date = new Date(dateString);
    var year = date.getFullYear();
    var month = ('0' + (date.getMonth() + 1)).slice(-2);
    var day = ('0' + date.getDate()).slice(-2);
    var hours = ('0' + date.getHours()).slice(-2);
    var minutes = ('0' + date.getMinutes()).slice(-2);

    if (format === 'date') {
        return year + '-' + month + '-' + day;
    } else if (format === 'datetime') {
        return year + '-' + month + '-' + day + ' ' + hours + ':' + minutes;
    }

    return year + '-' + month + '-' + day;
}

// Format number with commas (숫자에 콤마 추가)
function formatNumber(num) {
    if (!num) return '0';
    return num.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',');
}

// Example: formatNumber(1234567) => "1,234,567"


// Escape HTML (HTML 이스케이프 - XSS 방지)
function escapeHtml(text) {
    if (!text) return '';
    return $('<div>').text(text).html();
}


// Confirm dialog (확인 다이얼로그)
function confirmAction(message, onConfirm) {
    if (confirm(message)) {
        if (onConfirm) onConfirm();
    }
}

// Example: confirmAction('정말 삭제하시겠습니까?', function() { deleteUser(1); });


/* ============================================
   7. EVENT DELEGATION (이벤트 위임)
   ============================================ */

// Use event delegation for dynamically added elements
// 동적으로 추가된 요소에 이벤트 위임 사용

/*
// WRONG - 동적 요소에 작동 안 함
$('.delete-btn').on('click', function() {
    // This won't work for dynamically added buttons
});

// CORRECT - 이벤트 위임 사용
$(document).on('click', '.delete-btn', function() {
    var id = $(this).data('id');
    deleteUser(id);
});
*/


/* ============================================
   8. COMMON PATTERNS (자주 사용하는 패턴)
   ============================================ */

// Check/Uncheck all checkboxes (전체 선택/해제)
function setupCheckAll(checkAllId, checkboxClass) {
    // Check all click
    $('#' + checkAllId).on('change', function() {
        var isChecked = $(this).is(':checked');
        $('.' + checkboxClass).prop('checked', isChecked);
    });

    // Individual checkbox click
    $(document).on('change', '.' + checkboxClass, function() {
        var total = $('.' + checkboxClass).length;
        var checked = $('.' + checkboxClass + ':checked').length;
        $('#' + checkAllId).prop('checked', total === checked);
    });
}

// Get selected IDs (선택된 ID 목록 가져오기)
function getSelectedIds(checkboxClass) {
    var ids = [];
    $('.' + checkboxClass + ':checked').each(function() {
        ids.push($(this).val());
    });
    return ids;
}

// Example: var selectedIds = getSelectedIds('user-checkbox');
// Result: [1, 3, 5]
