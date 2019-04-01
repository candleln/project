<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<link href="../../../../css/qna.css" rel="stylesheet">
</head>
<body>
<div id="container" style="margin: 0 auto; width: 500px; text-align: center;">
	<b>비밀번호를 입력해주세요.</b> <br>
	<p><input type="password" id="pw" name="pw"></p>
	<button id="btn" type="button" style="float: none;">확인</button>
	<button type="button" onclick="window.close();" style="float: none;">취소</button>
</div>
</body>
<script type="text/javascript">
$(function() {
	var data=[];
	data.no ="${map.no}";
	data.pass ="${map.pass}";
	data.type ="${map.type}"
	$("#btn").click(function(){
	console.log(data.pass);
		if ($('#pw').val() == data.pass) {
			if (data.type == "update") {
				window.opener.top.location.href="/qnaUpdate?no="+data.no;
				window.close();
				return false;
			} else if (data.type == "detail") {
				window.opener.top.location.href="/qnaDetail?no="+data.no;
				window.close();
				return false;
			} else if (data.type == "delete") {
				window.opener.top.location.href="/qnaDelete?no="+data.no;
				window.close();
				return false;
			}
		} else {
			alert("비밀번호가 틀렸습니다.");
			return false;
		}
	});
})
</script>
</html>