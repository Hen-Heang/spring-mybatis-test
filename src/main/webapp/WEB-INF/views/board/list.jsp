<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c"   uri="jakarta.tags.core" %>
<%@ taglib prefix="fn"  uri="jakarta.tags.functions" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>Board List (게시판 목록)</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 20px; }
        table { width: 100%; border-collapse: collapse; }
        th, td { border: 1px solid #ddd; padding: 8px; text-align: left; }
        th { background-color: #f4f4f4; }
        tr:hover { background-color: #f9f9f9; }
        .search-form { margin-bottom: 15px; }
        .btn { padding: 6px 12px; cursor: pointer; }
        .btn-primary { background: #007bff; color: white; border: none; }
        .btn-danger  { background: #dc3545; color: white; border: none; }
        .error-msg   { color: red; font-size: 12px; display: none; }
    </style>
</head>
<body>

<h2>Board List (게시판 목록)</h2>
<p>Total: ${totalCount} posts</p>

<%-- ====================================================
     Search Form (검색 폼)
     GET /board/list.do?keyword=hello
     ==================================================== --%>
<div class="search-form">
    <form id="searchForm" method="get" action="/board/list.do">
        <label for="keyword"></label><input type="text"
                                            id="keyword"
                                            name="keyword"
                                            value="<c:out value='${param.keyword}'/>"
                                            placeholder="Search title... (제목 검색)" />
        <button type="submit" class="btn btn-primary">Search</button>
        <button type="button" class="btn" onclick="clearSearch()">Clear</button>
        <span id="keywordError" class="error-msg">Please enter a keyword</span>
    </form>
</div>

<%-- Write button + Back to Dashboard --%>
<div style="margin-bottom:10px;">
    <button class="btn btn-primary"
            onclick="location.href='/board/insertForm.do'">
        Write (등록)
    </button>
    <button class="btn"
            onclick="location.href='/dashboard'">
        ← Dashboard
    </button>
</div>

<%-- ====================================================
     Board Table (게시글 목록 테이블)
     boards → from ModelMap: model.addAttribute("boards", list)

     React equivalent:
     boards.map((board, index) => <tr key={board.boardSn}>...</tr>)
     ==================================================== --%>
<table>
    <thead>
        <tr>
            <th>No</th>
            <th>Title (제목)</th>
            <th>Status (상태)</th>
            <th>Date (날짜)</th>
            <th>Action</th>
        </tr>
    </thead>
    <tbody>
        <%-- c:forEach = React's array.map() --%>
        <c:forEach var="board" items="${boards}" varStatus="status">
            <tr>
                <%-- status.count = row number starting from 1 --%>
                <td>${status.count}</td>

                <%-- c:out = safe output, prevents XSS --%>
                <td>
                    <a href="/board/detail.do?boardSn=${board.boardSn}">
                        <c:out value="${board.boardTitle}" />
                    </a>
                </td>

                <%-- c:choose = if/else --%>
                <td>
                    <c:choose>
                        <c:when test="${board.useYn == 'Y'}">
                            <span style="color:green">Active</span>
                        </c:when>
                        <c:otherwise>
                            <span style="color:red">Inactive</span>
                        </c:otherwise>
                    </c:choose>
                </td>

                <%-- LocalDateTime → toString gives "2026-03-10T10:28:50" → show first 16 chars --%>
                <td>${fn:substring(board.dataRegDt, 0, 16)}</td>

                <td>
                    <button class="btn"
                            onclick="location.href='/board/detail.do?boardSn=${board.boardSn}'">
                        View
                    </button>
                    <button class="btn btn-danger"
                            onclick="deleteBoard(${board.boardSn})">
                        Delete
                    </button>
                </td>
            </tr>
        </c:forEach>

        <%-- Show message if no boards — like React: {boards.length === 0 && <tr>...</tr>} --%>
        <c:if test="${empty boards}">
            <tr>
                <td colspan="5" style="text-align:center">
                    No boards found (게시글이 없습니다)
                </td>
            </tr>
        </c:if>
    </tbody>
</table>

<%-- Hidden form for DELETE (HTML forms only support GET and POST) --%>
<form id="deleteForm" method="post" action="/board/delete.do">
    <input type="hidden" id="deleteBoardSn" name="boardSn" value="" />
</form>

<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script>
    // Delete with confirmation (삭제 확인)
    function deleteBoard(boardSn) {
        if (!confirm('Delete this board? (삭제하시겠습니까?)')) {
            return; // user clicked Cancel → stop
        }
        $('#deleteBoardSn').val(boardSn);
        $('#deleteForm').submit();
    }

    // Clear search (검색 초기화)
    function clearSearch() {
        $('#keyword').val('');
        $('#searchForm').submit();
    }

    // Validate search before submit
    $('#searchForm').on('submit', function() {
        const keyword = $('#keyword').val().trim();
        if (keyword === '') {
            $('#keywordError').show();
            setTimeout(function() { $('#keywordError').hide(); }, 2000);
        }
    });
</script>

</body>
</html>