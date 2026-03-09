<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c"   uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"  %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>Board Detail (게시글 상세)</title>
    <style>
        body  { font-family: Arial, sans-serif; margin: 20px; }
        table { width: 100%; border-collapse: collapse; margin-bottom: 15px; }
        th, td { border: 1px solid #ddd; padding: 10px; }
        th    { background: #f4f4f4; width: 150px; }
        .btn  { padding: 6px 12px; cursor: pointer; margin-right: 5px; }
        .btn-primary { background: #007bff; color: white; border: none; }
        .btn-success { background: #28a745; color: white; border: none; }
        .btn-danger  { background: #dc3545; color: white; border: none; }
        .error-msg   { color: red; font-size: 12px; display: none; }
    </style>
</head>
<body>

<h2>Board Detail (게시글 상세)</h2>

<%-- ====================================================
     Detail View (상세 보기)
     board → from ModelMap: model.addAttribute("board", board)
     ==================================================== --%>
<table>
    <tr>
        <th>No (번호)</th>
        <td>${board.boardSn}</td>
    </tr>
    <tr>
        <th>Title (제목)</th>
        <td><c:out value="${board.boardTitle}" /></td>
    </tr>
    <tr>
        <th>Content (내용)</th>
        <td><c:out value="${board.boardCn}" /></td>
    </tr>
    <tr>
        <th>Status (상태)</th>
        <td>
            <c:choose>
                <c:when test="${board.useYn == 'Y'}">
                    <span style="color:green">Active (활성)</span>
                </c:when>
                <c:otherwise>
                    <span style="color:red">Inactive (비활성)</span>
                </c:otherwise>
            </c:choose>
        </td>
    </tr>
    <tr>
        <th>Date (등록일시)</th>
        <td>
            <fmt:formatDate value="${board.dataRegDt}"
                            pattern="yyyy-MM-dd HH:mm:ss"/>
        </td>
    </tr>
</table>

<%-- ====================================================
     Edit Form (수정 폼)
     @ModelAttribute in Controller maps these fields → BoardVO automatically
     ==================================================== --%>
<h3>Edit (수정)</h3>

<form id="updateForm" method="post" action="/board/update.do">
    <%-- Hidden field: boardSn must be sent so controller knows WHICH record to update --%>
    <input type="hidden" name="boardSn" value="${board.boardSn}" />

    <table>
        <tr>
            <th>Title (제목) *</th>
            <td>
                <%-- pre-filled with existing value (c:out prevents XSS in value attr) --%>
                <input type="text"
                       id="boardTitle"
                       name="boardTitle"
                       value="<c:out value='${board.boardTitle}'/>"
                       style="width:100%" />
                <span id="titleError" class="error-msg">
                    Title is required (제목을 입력하세요)
                </span>
            </td>
        </tr>
        <tr>
            <th>Content (내용)</th>
            <td>
                <textarea id="boardCn"
                          name="boardCn"
                          rows="5"
                          style="width:100%"><c:out value="${board.boardCn}"/></textarea>
            </td>
        </tr>
    </table>

    <div style="margin-top:10px;">
        <button type="button" class="btn btn-success" onclick="submitUpdate()">
            Save (저장)
        </button>
        <button type="button" class="btn btn-danger" onclick="deleteBoard(${board.boardSn})">
            Delete (삭제)
        </button>
        <button type="button" class="btn" onclick="location.href='/board/list.do'">
            Back (목록)
        </button>
    </div>
</form>

<%-- Hidden delete form (HTML only supports GET/POST — no DELETE method) --%>
<form id="deleteForm" method="post" action="/board/delete.do">
    <input type="hidden" id="deleteBoardSn" name="boardSn" value="" />
</form>

<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script>
    // Validate then submit update form
    function submitUpdate() {
        const title = $('#boardTitle').val().trim();

        if (title === '') {
            $('#titleError').show();   // show error
            $('#boardTitle').focus();  // focus the field
            return;                    // stop — do not submit
        }

        $('#titleError').hide();
        $('#updateForm').submit();     // all good — submit
    }

    // Delete it with confirmation
    function deleteBoard(boardSn) {
        if (!confirm('Delete this board? (삭제하시겠습니까?)')) {
            return;
        }
        $('#deleteBoardSn').val(boardSn);
        $('#deleteForm').submit();
    }

    // Hide error as user types
    $('#boardTitle').on('input', function() {
        if ($(this).val().trim() !== '') {
            $('#titleError').hide();
        }
    });
</script>

</body>
</html>