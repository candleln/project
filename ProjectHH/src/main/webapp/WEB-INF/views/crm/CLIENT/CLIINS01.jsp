<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>고객 정보입력</title>
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<link href="../../../../css/client.css" rel="stylesheet">
</head>
<body>
<c:if test="${sessionScope.employee_code ne null}">
<%@include file="../empMenu.jsp"%>
	<section>
		<p><b>Client Insert</b></p>
		<form action="/clientInsert" method="post" class="form">
			<div>
				<input id="no" name="client_no" type="hidden">
				업체명 <input name="business_name" type="text">
			</div>
			<div>
				<div class="half">
				사업자번호 <input id="bnoCheck" name="business_no" type="text" placeholder="'-'제외">
				</div>
				<div class="half">
				<small><span id="checkHtml"></span></small>
				</div>
			</div>
			<div>
				<div class="half">
					대표 전화번호 <input name="business_tel" type="text" placeholder="'-'제외">
				</div>
				<div class="half">
					팩스 <input name="fax_no" type="text" placeholder="'-'제외">
				</div>
			</div>
			<div>
				주소 <input name="business_addr" type="text">
			</div>
			<hr>
			<div><span class="span">담당자</span></div>
			<div>
				<div class="half">
					이름<input name="manager_name" type="text">
				</div>
				<div class="half">
					이메일 <input name="manager_email" type="text">
				</div>
			</div>
			<div>
				<div class="half">
					부서 <input name="manager_department" type="text">
				</div>
				<div class="half">
					직급 <input name="manager_position" type="text">
				</div>
			</div>
			<div>
				<div class="half">
					연락처 <input name="manager_tel" type="text" placeholder="'-'제외">
				</div>
				<div class="half">
					휴대폰 <input name="manager_mobile" type="text" placeholder="'-'제외">
				</div>
			</div>
			<hr>
			<div>
				비고 <textarea name="note" rows="" cols="" style="size: auto;"></textarea>
			</div>
			<div class="bottom">
				<button type="button" onclick="location.href='/clientList'">취소</button>
				<button type="submit">등록</button>
			</div>
		</form>
	</section>
<script type="text/javascript">
$(function() {
	var bnoCheck = false;
	$('#bnoCheck').change(function() {
		bnoCheck = false;
		$.ajax({ 
			url: "businessNoSearch", 
			contentType: 'application/x-www-form-urlencoded; charset=UTF-8', 
	        dataType: 'JSON',
			data: $('#bnoCheck'),
	        success: function (data) {
	        	if (data.no != null && data.no != '') {
					$('#checkHtml').html('이미 등록된 사업자번호입니다. <a href="/clientDetail?no='+data.no+'">이동</a>').css("color","red");	
				} 
			}
		});
	
		if ($("#bnoCheck").val() == "") {
			$('#checkHtml').html("사업자번호를 입력해주세요.");
			return false; 
		} else if(!(/[0-9]/).test($("#bnoCheck").val())) {
			$('#checkHtml').html("사업자번호는 숫자로만 입력해주세요.").css("color","red"); 
			return false; 
		} else if($("#bnoCheck").val().length != 10) {
			$('#checkHtml').html("사업자번호는 10자리로 입력해주세요.").css("color","red"); 
			return false; 
		} else { $('#checkHtml').remove(); bnoCheck = true; }
	});	
		
	$('form').submit(function() { 
		if(!bnoCheck) {
			alert("사업자 번호를 확인해주세요.");	
			$('#bnoCheck').focus();
			return false;
		} else { return true; } 
	});
		
});
</script>
</c:if>
</body>
</html>