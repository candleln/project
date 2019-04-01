<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공지사항</title>
<link rel="stylesheet" type="text/css" href="../../../../../css/notice.css">
</head>
<body>
	<%@include file="../MAIN/topmenu.jsp"%>
	<div id="container">
		<div id="ncontainer">
			<div id="nTitle">
				<h1><a onclick="location.href='noticeList'" style="cursor:pointer">공지사항</a></h1>
			</div>
			<div id="nListTable">
				<form id="edit" action="noticeUpdate" method="post">
					<table>
						<c:choose>
							<c:when test="${!empty edit }">
								<input type="hidden" value="${edit.notice_no }" name="notice_no">
								<tr>
									<th>제목</th>
									<td colspan="3"><input id="title" type="text" value="${edit.title}" name="title"></td>
								</tr>
								<tr>
									<th>내용</th>
									<td colspan="3"><textarea id="content" rows="" cols="" name="content">${edit.content}</textarea></td>
								</tr>
							</c:when>
						</c:choose>
					</table>
					<div>
						<button style="cursor:pointer" type="button" onclick="Check()">수정</button>
						<button style="cursor:pointer" type="button" onclick="location.href='noticeDetail?notice_no=${edit.notice_no}'">취소</button>
					</div>
				</form>
			</div>
		</div>
	</div>
	<%@include file="../MAIN/footer.jsp"%>
</body>
<script type="text/javascript">
	function Check() {
		var title = document.getElementById('title');
		var special_pattern = /[\/<>]/gi;

		if (title.value == null || title.value == '') {
			alert('제목을 입력해 주세요.');
			return false;
		} else if (special_pattern.test(title.value) == true) {
			alert('특수문자는 사용할 수 없습니다.');
			return false;
		}

		var content = document.getElementById('content');

		if (special_pattern.test(content.value) == true) {
			alert('특수문자는 사용할 수 없습니다.');
			return false;
		}
		
		if(confirm('수정하시겠습니까?')){
			document.getElementById("edit").submit();
		};
	}
</script>
</html>