<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>notice</title>
<link rel="stylesheet" type="text/css" href="../../../../../css/notice.css">
</head>
<body>
	<%@include file="../MAIN/topmenu.jsp"%>
	<div id="container">
		<div>
			<h1><a onclick="location.href='noticeList'" style="cursor:pointer">공지사항</a></h1>
		</div>
		
		<div id="searching">
			<!-- 검색 -->
			<form action="noticeList" method="get">
				<input style="width: 200px;" type="text" name="search" placeholder="제목">
				<button type="submit">검색</button>
			</form>
		</div>

		<div id="contents">
			<c:choose>
				<c:when test="${!empty list}">
					<table>
						<tr>
							<th>번호</th>
							<th class="title">제목</th>
							<th>날짜</th>
						</tr>

						<c:forEach items="${list}" var="vo">
							<tr class="row" onclick="location.href='noticeDetail?notice_no=${vo.notice_no }'">
								<td>${vo.notice_no }</td>
								<td><small>[공지]</small> ${vo.title }</td>
								<td>${vo.notice_date }</td>
							</tr>
						</c:forEach>
					</table>
					<div>
					<c:if test="${sessionScope.manager ne null}">
						<button style="cursor:pointer" onclick="location.href='noticeInsert'">글작성</button>
					</c:if>
					</div>
				</c:when>
				<c:when test="${empty list}">
					<h1 style="color: RED">글이 없습니다.</h1>
					<br>
					<div>
					<c:if test="${sessionScope.manager ne null}">
						<button style="cursor:pointer" onclick="location.href='noticeInsert'">글작성</button>
					</c:if>
					</div>
				</c:when>
			</c:choose>
		</div>
		
		<div id="paging">
			<c:choose>
			<c:when test="${empty search}">
				<div>
					<a href="noticeList">처음</a>
					<c:if test="${page.prev}">
						<a href="noticeList?page=${page.startPage - 1}">이전</a>
					</c:if>
					<c:forEach begin="${page.startPage}" end="${page.endPage }" var="i" step="1">
						<c:if test="${i != page.currIndex }">
							<a href="noticeList?page=${i}">${i}</a>
						</c:if>
						<c:if test="${i == page.currIndex }">
							<b><a href="noticeList?page=${i}">${i}</a></b>
						</c:if>
					</c:forEach>
					<c:if test="${page.next}">
						<a href="noticeList?page=${page.endPage + 1}">다음</a>
					</c:if>
					<a href="noticeList?page=${page.totalPage }">끝</a>
				</div>
			</c:when>
			<c:otherwise>
				<div>
					<a href="noticeList?search=${search }">처음</a>
					<c:if test="${page.prev}">
						<a href="noticeList?search=${search }&page=${page.startPage - 1}">이전</a>
					</c:if>
					<c:forEach begin="${page.startPage}" end="${page.endPage }" var="i" step="1">
						<c:if test="${i != page.currIndex }">
							<a href="noticeList?search=${search }&page=${i}">${i}</a>
						</c:if>
						<c:if test="${i == page.currIndex }">
							<b><a href="noticeList?search=${search }&page=${i}">${i}</a></b>
						</c:if>
					</c:forEach>
					<c:if test="${page.next}">
						<a href="noticeList?search=${search }&page=${page.endPage + 1}">다음</a>
					</c:if>
					<a href="noticeList?search=${search }&page=${page.totalPage }">끝</a>
				</div>
			</c:otherwise>
			</c:choose>
		</div>
	</div>
	<%@include file="../MAIN/footer.jsp"%>
</body>
</html>