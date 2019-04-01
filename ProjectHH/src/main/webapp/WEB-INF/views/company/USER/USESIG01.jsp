<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
		<h2>회원가입</h2>
		<hr>
		<form action="/signInAction" method="post" id="form">
			<div>
				아이디* <input name="id" id="id" type="text" placeholder="이메일 형식입니다.">
				<span></span>
				<div>
					<button type="button" id="idCheck">ID중복체크</button>
					<span></span>
					<input type="hidden" id="isIdCheck" value="N"/> 
				</div>
			</div>
			<div>
				이름* <input name="name" id="name" type="text">
			</div>
			<div>
				비밀번호* <input name="pw" id="pw" type="password">
			</div>
			<div>
				비밀번호 확인* <input id="pwCheck" type="password"><span></span>
			</div>
			<div>
				주소 <input name="address" type="text">
			</div>
			<div>
				전화번호 <input name="tel" id="number" type="text" placeholder="'-'제외">
			</div>
			<button type="submit" class="btn">회원가입</button>
			<button type="button" onclick="location.href='/main'" class="btn">취소</button>
		</form>
	</div>
<%@include file="../MAIN/footer.jsp"%>
<script type="text/javascript">
$(function() {
	var idCheck = false;
	var pwCheck = false;
	$('#id').change(function() {	
		if (!(/^[A-Za-z0-9_\.\-]+@[A-Za-z0-9\-]+\.[A-Za-z0-9\-]+/).test($('#id').val())) {
			$('#id').next('span').html('올바른 형식으로 입력해주세요.');
			return false;
		} else {
			$('#id').next('span').remove();
			idCheck = true;
		};
	});
	$('#pwCheck').change(function() {
		if ($('#pwCheck').val() != $('#pw').val()) {
			$('#pwCheck').next('span').html('비밀번호를 확인해주세요.');
			return false;
		} else {
			$('#pwCheck').next('span').remove();
			pwCheck = true;
		};
	});
	
	 $('#idCheck').click(function() {		 
        $.ajax({
            data : $("#id"),
            url : "/idCheck",
            dataType : "json",
            contentType: "application/json; charset=UTF-8",
            success : function(data) {
                if (data.idCheck > 0) {
                	$('#idCheck').next('span').html('이미 존재하는 아이디입니다.').css('color','red');
                    $("#id").focus();   
                    return false;
                } else {
                	$('#idCheck').next('span').html('사용 가능한 아이디입니다.').css('color','green');
                	$('#isIdCheck').val("");
                }
            }
        });
	 });
	 
	$('form').submit(function() {
		if(!idCheck || !pwCheck) {
			alert("항목을 확인해 주세요.");
			return false;
		} else if ($('#id').val() == "" || $('#name').val() == "" || $('#pw').val() == "" || $('#pwCheck').val() == "") {
			alert("'*'은 필수 항목입니다.");
			return false;
		} else if($('#isIdCheck').val() == "N"){
			alert("아이디 중복체크를 진행해주세요");
			return false;
		} else if($('#number').val() == '') {
			return confirm("전화번호가 없으면 아이디/비밀번호를 찾을 수 없습니다. 진행하시겠습니까?");
		} else { 
			return true;
		}
	})
});
</script>
</body>
</html>