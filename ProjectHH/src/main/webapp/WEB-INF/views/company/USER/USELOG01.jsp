<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인</title>
<link href="../../../../css/signIn.css" rel="stylesheet">
<script type="text/javascript">
function check() {
	var id = document.getElementById('id');
	var pw = document.getElementById('pw');
	if (pw.value == null || pw.value == '') {
		alert('비밀번호를 입력해 주세요.');
		return false;
	}
	if (id.value == null || id.value == '') {
		alert('아이디를 입력해 주세요.');
		return false;
	}

}
</script>
</head>
<body>
	<%@include file="../MAIN/topmenu.jsp"%>
	<div id="container">
		<h2>로그인</h2>
		<hr>
		<form action="ulogin" method="post" id="check">
			<table>
				<tr>
					<th>아이디</th> <td><input type="email" name="id"></td>
				</tr>
				<tr>
					<th>비밀번호</th> <td><input type="password" name="pw"></td>
				</tr>
			</table>
			<!-- user_type 개인 : P, 비회원 : G -->
			<p>
			<input type="radio" value="P" checked="checked" name="user_type" />
			개인&nbsp; <input type="radio" value="G" name="user_type" /> 비회원
			</p>
			<hr>
			<p>
			<a href="userfind">ID/PW 찾기</a><br>
			</p>
			<button type="submit" onclick="check()" class="btn">로그인</button>
			<button type="button" onclick="location.href='/'" class="btn">취소</button>
		</form>
	</div>
	<%@include file="../MAIN/footer.jsp"%>
</body>
</html>