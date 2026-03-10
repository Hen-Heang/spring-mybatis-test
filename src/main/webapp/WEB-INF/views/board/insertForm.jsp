<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>Write Board (게시글 등록)</title>
    <style>
        body  { font-family: Arial, sans-serif; margin: 20px; }
        table { width: 100%; border-collapse: collapse; margin-bottom: 15px; }
        th, td { border: 1px solid #ddd; padding: 10px; }
        th    { background: #f4f4f4; width: 150px; }
        .btn  { padding: 6px 12px; cursor: pointer; margin-right: 5px; }
        .btn-primary { background: #007bff; color: white; border: none; }
        .btn-danger  { background: #dc3545; color: white; border: none; }
        .error-msg   { color: red; font-size: 12px; display: none; }
    </style>
</head>
<body>

<h2>Write Board (게시글 등록)</h2>

<%-- POST /board/insert.do — @ModelAttribute maps fields → BoardVO --%>
<form id="insertForm" method="post" action="/board/insert.do">

    <table>
        <tr>
            <th>Title (제목) *</th>
            <td>
                <input type="text"
                       id="boardTitle"
                       name="boardTitle"
                       placeholder="Enter title (제목 입력)"
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
                          rows="6"
                          placeholder="Enter content (내용 입력)"
                          style="width:100%"></textarea>
            </td>
        </tr>
    </table>

    <%-- useYn default Y — hidden field --%>
    <input type="hidden" name="useYn" value="Y" />

    <div>
        <button type="button" class="btn btn-primary" onclick="submitInsert()">
            Save (저장)
        </button>
        <button type="button" class="btn" onclick="location.href='/board/list.do'">
            Cancel (취소)
        </button>
    </div>
</form>

<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script>
    function submitInsert() {
        const title = $('#boardTitle').val().trim();

        if (title === '') {
            $('#titleError').show();
            $('#boardTitle').focus();
            return;
        }

        $('#titleError').hide();
        $('#insertForm').submit();
    }

    $('#boardTitle').on('input', function() {
        if ($(this).val().trim() !== '') {
            $('#titleError').hide();
        }
    });
</script>

</body>
</html>