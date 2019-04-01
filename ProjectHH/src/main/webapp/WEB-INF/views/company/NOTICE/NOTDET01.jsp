<%@page import="javax.mail.Session"%>
<%@page import="org.springframework.web.bind.support.SessionAttributeStore"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공지사항</title>
<link rel="stylesheet" type="text/css" href="../../../../../css/notice.css">
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
</head>
<body>
	<%@include file="../MAIN/topmenu.jsp"%>
	<div id="container">
		<div id="ncontainer">
			<div id="nTitle">
				<h1><a onclick="location.href='noticeList'" style="cursor:pointer">공지사항</a></h1>
			</div>
			<div id="nListTable">
				<table>
					<c:choose>
						<c:when test="${!empty detail }">
							<tr>
								<th>제목</th>
								<td colspan="3"><small>[공지]</small> ${detail.title }</td>
							</tr>
							<tr>
								<th>일시</th>
								<td>${detail.notice_date } ${detail.notice_time }</td>
							</tr>
							<tr>
								<th>내용</th>
								<td id="content" colspan="3" height="450px">${detail.content }</td>
							</tr>
							<tr>
							</tr>
						</c:when>
					</c:choose>
				</table>
				<br>
				<div>
				<!-- 관리자 -->
					<c:if test="${sessionScope.manager ne null}">
						<button id="del" type="button">삭제</button>
						<button type="button" onclick="location.href='noticeEdit?notice_no='+${detail.notice_no }">수정</button>
						<input type="hidden" value="${detail.notice_no }" id="no">
					</c:if>
					<!-- 일반 사용자 -->
					<button style="cursor:pointer" onclick="location.href='noticeList'">리스트</button>
				</div>
			</div>
		</div>
	</div>
	<%@include file="../MAIN/footer.jsp"%>
</body>
<script type="text/javascript">
$(function() {
	$('#del').click(function() {
		if (confirm('삭제하시겠습니까?')) {
			location.href = "/noticeDelete?notice_no=" + $('#no').val();
		};
	});
});
</script>
</html>