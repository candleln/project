<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입</title>
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<link href="../../../../css/signIn.css" rel="stylesheet">
</head>
<body>
<%@include file="../MAIN/topmenu.jsp"%>

	<div id="container">
		<div>
			<c:choose>
			<c:when test="${user.authKey eq null}">
				<h2>${user.id } 메일을 인증해주세요.</h2><br>
				<button onclick="location.href='/reSignInConfirm?id=${user.id}'">인증 메일 다시 받기</button>
				<button onclick="location.href='/main'">확인</button>
			</c:when>
			<c:when test="${checkExpr == 0}">
				<h2>인증 기간이 만료되었습니다.</h2><br>
				<button onclick="location.href='/reSignInConfirm?id=${user.id}'">인증 메일 다시 받기</button>
				<button onclick="location.href='/main'">확인</button>
			</c:when>
			<c:otherwise>
				<h2>${user.id }님 정상적으로 로그인 가능합니다.</h2><br>
				<button onclick="location.href='/ulogin'">로그인</button>
				<button onclick="location.href='/main'">확인</button>
			</c:otherwise>
			</c:choose>
		</div>
	</div>
	
<%@include file="../MAIN/footer.jsp"%>
</body>
</html>