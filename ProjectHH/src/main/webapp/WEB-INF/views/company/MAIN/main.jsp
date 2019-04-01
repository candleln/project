<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>HH</title>
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<link rel="stylesheet" type="text/css" href="../../../../../css/main.css">
</head>
<body>
<%@include file="topmenu.jsp"%>

	<div class="slideshow-container">

	<div class="slides fade">
	  <img src="../../../../img/main1.jpg">
	</div>
	
	<div class="slides fade">
	  <img src="../../../../img/main2.jpg">
	</div>
	
	</div>
	<br>
	
	<div style="text-align:center">
	  <span class="control_btn"></span> 
	  <span class="control_btn"></span> 
	</div>
	<div id="container">
		<div id="list">
			<div id="notice">
				<div>
					<h1>
						<a href="nlist">공지사항</a>
					</h1>
				</div>
				<table>
					<tr>
						<th>번호</th>
						<th class="title">제목</th>
						<th>일시</th>
					</tr>
					<c:forEach items="${notice}" var="nvo">
						<tr class="row" onclick="location.href='ndetail?notice_no=${nvo.notice_no }'">
							<td>${nvo.notice_no }</td>
							<td><small>[공지]</small> ${nvo.title }</td>
							<td>${nvo.notice_date }</td>
						</tr>
					</c:forEach>
				</table>
			</div>

			<div id="qna">
				<div>
					<h1>
						<a href="qnaList">Q&A</a>
					</h1>
				</div>
				<table>
					<tr>
						<th>번호</th>
						<th class="title">제목</th>
						<th>일시</th>
					</tr>
					<c:forEach items="${qna}" var="qvo">
						<tr class="row" onclick="location.href='qnaDetail?no=${qvo.qna_no }'">
							<td>${qvo.qna_no }</td>
							<td>${qvo.title }</td>
							<td>${qvo.qna_date }</td>
						</tr>
					</c:forEach>
				</table>
			</div>
		</div>
	</div>
	<%@include file="footer.jsp"%>
</body>
<style type="text/css">
footer {bottom: auto;} hr {display: none;}
</style>
<script type="text/javascript">
$(function() {
    var slideIndex = 0;
    showSlides();

    function showSlides() {
    	var i;
	   	var slides = document.getElementsByClassName("slides");
	   	var btns = document.getElementsByClassName("control_btn");
	   	for (i = 0; i < slides.length; i++) {
	   		slides[i].style.display = "none";  
	   	}
	   	    slideIndex++;
	   	    
	  	if (slideIndex > slides.length) {slideIndex = 1}
	  	
  	    for (i = 0; i < btns.length; i++) {
  	    	btns[i].className = btns[i].className.replace(" active", "");
  	    }
  	    slides[slideIndex-1].style.display = "block";  
  	  	btns[slideIndex-1].className += " active";
  	    setTimeout(showSlides, 3000);
    };

})
</script>
</html>