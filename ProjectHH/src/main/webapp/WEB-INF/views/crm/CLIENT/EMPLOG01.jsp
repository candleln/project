<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인</title>
<link href="../../../../css/signIn.css" rel="stylesheet">
</head>
<body>
	<div id="container">
		<form action="employlogin" method="post">
			<h1>로그인</h1>
			<hr>
			<table>
				<tr>
					<th>아이디</th> <td><input type="text" id="id" name="id" placeholder="아이디를 입력하세요."></td>
				</tr>
				<tr>
					<th>비밀번호</th> <td><input type="password" id="pw" name="pw" placeholder="비밀번호를 입력하세요."></td>
				</tr>
			</table>
			<button type="submit" class="btn">로그인</button>
		</form>
	</div>
</body>
</html>