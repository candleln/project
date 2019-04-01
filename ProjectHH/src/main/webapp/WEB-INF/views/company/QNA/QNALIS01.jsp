<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>QNA</title>
<link href="../../../../css/qna.css" rel="stylesheet">
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<link rel="stylesheet" href="http://code.jquery.com/ui/1.8.18/themes/base/jquery-ui.css" type="text/css" />
</head>
<body>
<%@include file="../MAIN/topmenu.jsp"%>
<div id="container">
	<div>
		<h1><a onclick="location.href='qnaList'" style="cursor:pointer">Q&A</a></h1>
	</div>
	
	<div id="searching">
		<form action="qnaList" method="get">
			기간 <input type="text" name="fromDate" id="fromDate"> ~ <input type="text" name="toDate" id="toDate">
			<select name="category">
				<option value="1">제목</option>
				<option value="2">글쓴이</option>
			</select> 
			<input type="text" name="search">
			<button type="submit">검색</button>
		</form>
	</div>
	
	<div id="contents">
		<table>
			<tr>
				<th>번호</th> 
				<th class="title">제목</th>
				<th>글쓴이</th>
				<th>일시</th>
				<th>상태</th>
			</tr>
			<c:forEach var="vo" items="${qnalist }" begin="0" end="19">
				<tr class="row">
					<td id="no">${vo.qna_no }</td>
					<c:choose>
						<c:when test="${vo.private_key eq '1' && sessionScope.manager eq null}">
							<c:if test="${sessionScope.id ne null && vo.upw == vo.pass }">
								<td onclick="location.href='/qnaDetail?no=${vo.qna_no }';">${vo.title }							
							</c:if>
							<td id="title">${vo.title }
							<c:if test="${'1' eq vo.answer_state }">
								<span><small>답변완료</small></span>
							</c:if>
							<c:if test="${'1' ne vo.answer_state }">
								<span><small>답변대기</small></span>
							</c:if>
							</td>
						</c:when>
						<c:otherwise>
							<td onclick="location.href='/qnaDetail?no=${vo.qna_no }';">${vo.title }
							<c:if test="${'1' eq vo.answer_state }">
								<span><small>답변완료</small></span>
							</c:if>
							<c:if test="${'1' ne vo.answer_state }">
								<span><small>답변대기</small></span>
							</c:if>
							</td>
						</c:otherwise>		
					</c:choose>
					<c:choose>
						<c:when test="${vo.user_no ne null}">
							<td>${vo.user_no } </td>
						</c:when>
						<c:otherwise>							
							<td>${vo.name } </td>
						</c:otherwise>
					</c:choose>
					<td>${vo.qna_date }</td>
					<td>
						<c:choose>
							<c:when test="${'1' eq vo.private_key }">비공개</c:when>
							<c:otherwise>공개</c:otherwise>
						</c:choose>
					</td>
			</c:forEach>
		</table>
	</div>
	<div>
		<button onclick="location.href='/qnaInsert';">글작성</button>
	</div>		
		
	<div id="paging">
		<c:choose>
		<c:when test="${empty map}">
			<div>
				<a href="qnaList">처음</a>
				<c:if test="${page.prev}">
					<a href="qnaList?page=${page.startPage - 1}">이전</a>
				</c:if>
				<c:forEach begin="${page.startPage}" end="${page.endPage }" var="i" step="1">
					<c:if test="${i != page.currIndex }">
						<a href="qnaList?page=${i}">${i}</a>
					</c:if>
					<c:if test="${i == page.currIndex }">
						<b><a href="qnaList?page=${i}">${i}</a></b>
					</c:if>
				</c:forEach>
				<c:if test="${page.next}">
					<a href="qnaList?page=${page.endPage + 1}">다음</a>
				</c:if>
				<a href="qnaList?page=${page.totalPage }">끝</a>
			</div>
		</c:when>
		<c:otherwise>
			<div>
				<a href="qnaList?fromDate=${map.fromDate}&toDate=${map.toDate}&category=${map.category}&search=${map.search }">처음</a>
				<c:if test="${page.prev}">
					<a href="qnaList?fromDate=${map.fromDate}&toDate=${map.toDate}&category=${map.category}&search=${map.search }&page=${page.startPage - 1}">이전</a>
				</c:if>
				<c:forEach begin="${page.startPage}" end="${page.endPage }" var="i" step="1">
					<c:if test="${i != page.currIndex }">
						<a href="qnaList?fromDate=${map.fromDate}&toDate=${map.toDate}&category=${map.category}&search=${map.search }&page=${i}">${i}</a>
					</c:if>
					<c:if test="${i == page.currIndex }">
						<b><a href="qnaList?fromDate=${map.fromDate}&toDate=${map.toDate}&category=${map.category}&search=${map.search }&page=${i}">${i}</a></b>
					</c:if>
				</c:forEach>
				<c:if test="${page.next}">
					<a href="qnaList?fromDate=${map.fromDate}&toDate=${map.toDate}&category=${map.category}&search=${map.search }&page=${page.endPage + 1}">다음</a>
				</c:if>
				<a href="qnaList?fromDate=${map.fromDate}&toDate=${map.toDate}&category=${map.category}&search=${map.search }&page=${page.totalPage }">끝</a>
			</div>
		</c:otherwise>
		</c:choose>
	</div>
</div>
<%@include file="../MAIN/footer.jsp"%>
</body>
<script>
$(function() {
	$("#fromDate, #toDate").datepicker({
		dateFormat : 'yy-mm-dd',
		changeMonth : true,
		changeYear : true,
		showMonthAfterYear : true,
		showButtonPanel : true,
		dayNames : [ '월요일', '화요일', '수요일', '목요일', '금요일', '토요일',
				'일요일' ],
		dayNamesMin : [ '월', '화', '수', '목', '금', '토', '일' ],
		monthNamesShort : [ '1', '2', '3', '4', '5', '6', '7',
				'8', '9', '10', '11', '12' ],
		monthNames : [ '1월', '2월', '3월', '4월', '5월', '6월',
				'7월', '8월', '9월', '10월', '11월', '12월' ]

	});
	
	var windowObj;
	$("#title").click(function(){
		var w = 500, h = 500;
		LeftPosition = (screen.width) ? (screen.width-w)/2 : 0;
		TopPosition = (screen.height) ? (screen.height-h)/2 : 0;
		var settings = 'height='+h+',width='+w+',top='+TopPosition+',left='+LeftPosition+',scrollbars='+scroll+', resizable'
		windowObj = window.open("qnaPass?type=detail&no="+$("#no").html(), "qnaPass", settings);
	});

});
</script>
</html>