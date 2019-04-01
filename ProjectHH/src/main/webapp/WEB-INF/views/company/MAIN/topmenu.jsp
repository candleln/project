<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<link rel="stylesheet" type="text/css" href="../../../../../css/menu.css">
</head>
<header>
	<section>
		<div id="loginarea">
			<c:if test="${sessionScope.id eq null}">
				<div>
				<a href="ulogin">로그인</a> |
				<a href="userSignIn">회원가입</a>
				</div>
			</c:if>
			<c:if test="${sessionScope.id ne null}">
				<div>
				<a href="userInfo?no=${sessionScope.set_id}">마이 페이지</a> |
				<a href="logout">로그아웃</a>
				</div>
			</c:if>
		</div>
		<div id="img"><a href="/"><img alt="" src="../../../../img/logo.PNG"></a></div>
	</section>
	<div id="menubar">
		<ul>
			<li>회사소개
				<ul>
					<li><a href="#">기업소개</a></li>
					<li><a href="#">연혁</a></li>
					<li><a href="#">오시는길 </a></li>
				</ul>
			</li>
			<li>제품소개
				<ul>
					<li><a href="#">제품1</a></li>
					<li><a href="#">제품2</a></li>
				</ul>
			</li>
			<li>자료실
				<ul>
					<li><a href="#">자료1</a></li> 
					<li><a href="#">자료2</a></li>
				</ul>
			</li>
			<li>고객서비스
				<ul>
					<li><a href="qnaList">Q&A</a></li> 
					<li><a href="noticeList">공지사항</a></li>
				</ul>
			</li>
		</ul>
	</div>
	<hr>
</header>