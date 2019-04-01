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
		<div>
		<h1><a onclick="location.href='qnaList'" style="cursor:pointer">Q&A</a></h1>
		</div>
		<div>
			<c:choose>
				<c:when test="${qnaDetail ne null}">
					<input type="hidden" value="${qnaDetail.qna_no }" id="no">
					<div class="private">
						<c:if test="${qnaDetail.private_key eq '1'}">비공개</c:if>
						<c:if test="${qnaDetail.private_key ne '1'}">공개</c:if>
					</div>
					<table>
						<tr>
							<th class="th">제목</th>
							<td colspan="3">${qnaDetail.title }</td>
						</tr>
						<tr>
							<th class="th">작성자</th>
							<td id="id">${qnaDetail.name }</td>
							<th class="th">일시</th>
							<td>${qnaDetail.qna_date } ${qnaDetail.qna_time }</td>
						</tr>
						<tr>
							<th class="th">문의 내용</th>
							<td colspan="3">${qnaDetail.content }</td>
						</tr>
						<c:if test="${qnaDetail.file1 ne 'null' }">
						<tr>
							<th class="th">첨부파일</th>
							<td colspan="3">${qnaDetail.file1 }</td>
						</tr>
						</c:if>
					</table>
	
					<div class="bottom">
						<c:choose>
							<c:when test="${sessionScope.manager ne null || sessionScope.id ne null}">
								<button type="button" onclick="location.href='/qnaEdit?no=${qnaDetail.qna_no}';">수정</button>
								<button type="button" id="check">삭제</button>
							</c:when>
							<c:otherwise>
								<button type="button" id="uBtn">수정</button>
								<button type="button" id="dBtn">삭제</button>
							</c:otherwise>
						</c:choose>
					</div>
				</c:when>
				<c:when test="${qnaDetail eq null}">
					<h3>존재하지 않는 게시글입니다.</h3>
				</c:when>
			</c:choose>
			<form action="qnacomment" method="post">
				<input type="hidden" id="no" name="no" value="${qnaDetail.qna_no }">
				<c:if test="${qnaDetail.answer_state eq '1'}">
					<table>
						<tr>
							<th class="th">답변</th>
							<td colspan="3">${qnaDetail.comment }</td>
						</tr>
					</table>
				</c:if>
				<c:if test="${sessionScope.manager != null}">
					<table>
						<tr>
							<th class="th">답변 </th>
							<td><textarea rows="" cols="" id="comment" name="comment">${qnaDetail.comment }</textarea></td>
						</tr>
					</table>
				<button type="submit" onclick="location.href='qnaList'">등록/수정</button>
				</c:if>
			</form>
		</div>
	</div>
	<%@include file="../MAIN/footer.jsp"%>
</body>
<script type="text/javascript">
$(function() {
	$("#id").html($("#id").html().split("@")[0]);
	
	var windowObj;
	function setting(e) {
		var w = 500, h = 500;
		LeftPosition = (screen.width) ? (screen.width-w)/2 : 0;
		TopPosition = (screen.height) ? (screen.height-h)/2 : 0;
		var settings = 'height='+h+',width='+w+',top='+TopPosition+',left='+LeftPosition+',scrollbars='+scroll+', resizable';
		windowObj = window.open("qnaPass?type="+e+"&no="+$("#no").val(), "qnaPass", settings);
	};
	
	$("#uBtn").click(function(){
		setting("update");
	});
	$("#dBtn").click(function(){
		setting("delete");
	});
	
	$("#check").click(function() {
		if (confirm("삭제하시겠습니까?")) {
			location.href='/qnaDelete?num='+$("#no").val();
		} else {
			location.href='/qnaList';
		}
	})
})
</script>
</html>