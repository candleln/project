<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Q&A</title>
<link href="../../../../css/qna.css" rel="stylesheet">
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
</head>
<body>
<%@include file="../MAIN/topmenu.jsp"%>
<div id="container">
	<div id="top">
			<h1>Q&A</h1>
		</div>
	<div>
		<form action="qnaIns" name="qnaIns" method="post" enctype="multipart/form-data">
			<div class="private">
				<label><input name="private" type="radio" value="0" checked="checked"> 공개</label> 
				<label><input name="private" type="radio" value="1"> 비공개</label>
			</div>
			<table>
				<tr>
					<th>제목</th>
					<td colspan="3"><input type="text" id="title" name="title"></td>
				</tr>		
				<tr>
					<th>작성자</th>
					<c:if test="${sessionScope.id ne null }">
						<td colspan="3">${sessionScope.id}</td>
					</c:if>
					<c:if test="${sessionScope.id eq null }">
						<td colspan="3"><input type="text" id="name" name="name"></td>
					</c:if>
				</tr>
				<c:if test="${sessionScope.id eq null }">
					<tr>
						<th>비밀번호</th>
						<td><input type="password" id="pass" name="pass"></td>
						<th>비밀번호 확인</th>
						<td><input type="password" id="pass2" name="pass2"><br>
					</tr>
				</c:if>
				<tr>
					<th>문의 내용</th>
					<td colspan="3"><textarea rows="" cols="" id="content" name="content"></textarea></td>
				</tr>
				<tr>
					<th>첨부파일</th>
					<td colspan="3"><input type="file" id="file" name="file"></td>
				</tr>
			</table>
			<div class="bottom">
				<button type="submit">등록</button>
				<button type="button" onclick="location.href='qnaList'">취소</button>
			</div>
		</form>
	</div>
</div>
<%@include file="../MAIN/footer.jsp"%>
</body>
<script type="text/javascript">
$(function() {
	$("form").submit(function() { 
		if ($("#title").val() == "") {
			alert('제목을 입력해 주십시오.');
			$("#title").focus();
			return false; 
		} else if($("#name").val() == "" || <%=(String)session.getAttribute("id")%> == null ) {
			alert('작성자를 입력해 주십시오.');
			$("#name").focus();
			return false; 
		} else if($("#pass").val() == "") {
			alert('비밀번호를 입력해 주십시오.');
			$("#pass").focus();
			return false; 
		} else if($("#pass").val() == $("#pass2").val()) {
			alert('비밀번호를 확인해 주십시오.');
			$("#pass").focus();
			return false; 
		} else if($("#content").val() == "") {
			alert('내용을 입력해 주십시오.');
			$("content").focus();
			return false; 
		} else { return confirm('등록하시겠습니까?') }
	});	
		
});
</script>
</html>