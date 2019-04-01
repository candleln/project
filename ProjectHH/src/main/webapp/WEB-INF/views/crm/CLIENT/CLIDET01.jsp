<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>고객 정보</title>
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<link href="../../../../css/client.css" rel="stylesheet">
</head>
<body>
<c:if test="${sessionScope.employee_code ne null}">
<%@include file="../empMenu.jsp"%>
	<section>
		<p><b>Client Detail / Update</b></p>
		<form action="/clientUpdate" method="post" class="form">
			<div>
				<input id="no" name="client_no" type="hidden" value="${vo.client_no }">
				업체명 <input name="business_name" type="text" value="${vo.business_name }">
			</div>
			<div>
				<div class="half">
					사업자번호 <input name="business_no" type="text" value="${vo.business_no }" disabled="disabled">
				</div>
			</div>
			<div>
				<div class="half">
					대표 전화번호 <input name="business_tel" type="text" value="${vo.business_tel }">
				</div>
				<div class="half">
					팩스 <input name="fax_no" type="text" value="${vo.fax_no }">
				</div>
			</div>
			<div>
				주소 <input name="business_addr" type="text" value="${vo.business_addr }">
			</div>
			<hr>
			<div><span class="span">담당자</span></div>
			<div>
				<div class="half">
					이름<input name="manager_name" type="text" value="${vo.manager_name }">
				</div>
				<div class="half">
					이메일 <input name="manager_email" type="text" value="${vo.manager_email }">
				</div>
			</div>
			<div>
				<div class="half">
					부서 <input name="manager_department" type="text" value="${vo.manager_department }">
				</div>
				<div class="half">
					직급 <input name="manager_position" type="text" value="${vo.manager_position }">
				</div>
			</div>
			<div>
				<div class="half">
					연락처 <input name="manager_tel" type="text" value="${vo.manager_tel }">
				</div>
				<div class="half">
					휴대폰 <input name="manager_mobile" type="text" value="${vo.manager_mobile }">
				</div>
			</div>
			<hr>
			<div>
				비고 <textarea name="note" >${vo.note }</textarea>
			</div>
			<div>
				<span class="span">등록일시</span> <span class="span"> ${vo.regist_date } ${vo.regist_time }</span>
			</div>
		
		<div class="bottom">
			<button id="del" type="button">삭제</button>
			<button type="submit">수정</button>
		</div>
		</form>	
	</section>
<script type="text/javascript">
$(function() {
	$('form').submit(function() {
		return confirm('수정하시겠습니까?');
	});
	
	$('#del').click(function() {
		if (confirm('삭제하시겠습니까?')) {
			location.href = "/clientDelete?no=" + $('#no').val();
		};
	});
});
</script>
</c:if>
</body>
</html>