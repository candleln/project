<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Q&A</title>
<link href="../../../../css/qna.css" rel="stylesheet">
</head>
<body>
<%@include file="../MAIN/topmenu.jsp"%>
	<div id="container">
		<div>
		<h1><a onclick="location.href='qnaList'" style="cursor:pointer">Q&A</a></h1>
		</div>
		<div>
			<form action="qnaUpdate" name="qnaUpd" id="form" method="post" enctype="multipart/form-data">
				<input type="hidden" value="${vo.qna_no }" name="qna_no" id="qna_no">
				<div class="private">
				<c:choose>
					<c:when test="${vo.private_key eq '1'}">
						<label><input name="private" type="radio" value="0">공개</label>
						<label><input name="private" type="radio" value="1" checked="checked">비공개</label>
					</c:when>
					<c:otherwise>
						<label><input name="private" type="radio" value="0" checked="checked">공개</label>
						<label><input name="private" type="radio" value="1">비공개</label>
					</c:otherwise>
				</c:choose>
				</div>
				<table>
					<tr>
						<th class="th">제목</th>
						<td colspan="3"><input type="text" name="title" id="title" value="${vo.title }" ></td>
					</tr>
					<tr>
						<th class="th">내용</th>
						<td colspan="3"><textarea id="content" name="content">${vo.content }</textarea>
						</td>
					</tr>
					<tr>
						<th>첨부파일</th>
						<td colspan="3"><input type="file" id="file" name="file" value="${vo.file1 }"></td>
					</tr>
				</table>
				<div class="bottom">
					<button type="button" onclick="Check()">수정</button>
					<button type="button" onclick="location.href='qnaDetail?no=${vo.qna_no}'">취소</button>
				</div>
			</form>
		</div>
	</div>
	<%@include file="../MAIN/footer.jsp"%>
</body>
<script type="text/javascript">
function Check() {
	if(confirm('수정하시겠습니까?')){
		document.getElementById("form").submit();
	}
}
</script>
</html>