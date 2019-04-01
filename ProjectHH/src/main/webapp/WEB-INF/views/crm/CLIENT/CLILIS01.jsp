<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>고객 관리 리스트</title>
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<link rel="stylesheet" href="http://code.jquery.com/ui/1.8.18/themes/base/jquery-ui.css" type="text/css" />
<link href="../../../../css/client.css" rel="stylesheet">
</head>
<body>
<c:if test="${sessionScope.employee_code ne null}">
<%@include file="../empMenu.jsp"%>
	<div id="container">
		<div id="top">
			<h1>Client</h1>
		</div>
		<hr>
		<div class="right">
			<!-- 검색 -->
			<form method="post">
				기간 <input type="text" name="fromDate" id="fromDate"> ~ <input type="text" name="toDate" id="toDate">
				<select name="category">
					<option value="0">업체 + 번호</option>
					<option value="1">업체명</option>
					<option value="2">사업자번호</option>
				</select>
				<input type="text" name="search">
				<button id="btn">검색</button>
				<input type="hidden" id="page" name="page" value="1" />
			</form>
		</div>
			<table>
				<tr>
					<th>번호</th>
					<th class="title">업체명</th>
					<th class="title">사업자등록번호</th>
					<th>날짜</th>
				</tr>
				<tr id="exampleRow" style="display: none;">
					<td>client_no</td>
					<td>business_name</td>
					<td>business_no</td>
					<td>regist_date</td>
				</tr>
			</table>
			<div class="right">
				<button onclick="location.href='/clientInsertForm';">고객정보 입력</button>
			</div>
		<div id="pagiNation"></div>
	</div>
	
<script>
$(function() {
    $("#fromDate, #toDate").datepicker({
        dateFormat: 'yy-mm-dd',
        changeMonth: true, 
        changeYear: true,
        showMonthAfterYear: true,
        showButtonPanel: true,
        dayNames: ['월요일', '화요일', '수요일', '목요일', '금요일', '토요일', '일요일'],
        dayNamesMin: ['월', '화', '수', '목', '금', '토', '일'], 
        monthNamesShort: ['1','2','3','4','5','6','7','8','9','10','11','12'],
        monthNames: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],

    });

	$("#btn").click(function() {
	    $.ajax({
	        url: 'clientSearch',
	        data: $('form').serialize(),
	        contentType: 'application/x-www-form-urlencoded; charset=UTF-8', 
	        dataType: 'JSON',
	        success: function (data) {
	        	$(".deleteTarget").remove();
	        	if(data.searchList != null && data.searchList.length > 0 ) {
		        	$.each(data.searchList, function(index, element) {
		    			var newRow = $("#exampleRow").clone().attr('class', 'deleteTarget');
		    			
		    			$("td:eq(0)", newRow).text(element.client_no);
		    			$("td:eq(1)", newRow).text(element.business_name);
		    			$("td:eq(2)", newRow).text(element.business_no);
		    			$("td:eq(3)", newRow).text(element.regist_date);
		    			
		    			function moveDetailView(event) {
		    				var clientNo = $(this).parents("tr").find("td:eq(0)").text();
		    				location.href = "/clientDetail?no=" + clientNo;	
		    				return false;
		    			}
		    			
		    			$("td:eq(1)", newRow).click(moveDetailView).css("cursor","pointer");
		    			$("td:eq(2)", newRow).click(moveDetailView).css("cursor","pointer");
		    			newRow.show();
		    			$("#exampleRow").after(newRow);
					});   
	        	}
	        	if (data.page != null) {
	        		pagination(data.page);
	        	}
	        }
	    });
		
	    return false;
	});
	$("#btn").trigger("click");
	
	function pagination(pageOption) {
		var currentPage = pageOption.currIndex;
		$("#pagiNation").empty();
		var gofistPage, goBackPage, goNextPage, goLastPage;
		var pagiNation = $("#pagiNation");
		 
		gofistPage = $("<a class=\"goFirstPage\"> 처음 </a>").appendTo(pagiNation);
		
		if ( pageOption.prev ) {
			goBackPage = $("<a class=\"goBackPage\"> < </a>").appendTo(pagiNation);
		}
		for ( var i = pageOption.startPage ; i <= pageOption.endPage ; i++ ) {
			if ( currentPage == i ) {
				$("#pagiNation").append("<a class=\"disabled active\"> <b>"+i+"</b> </a>");
			}
			else {
				$("#pagiNation").append("<a class=\"goPage\" data-page=\""+i+"\"> "+i+" </a>");
			}
		}
		if ( pageOption.next ) {
			goNextPage = $("<a class=\"goNextPage\"> > </a>").appendTo(pagiNation);
		}

		goLastPage = $("<a class=\"goLastPage\"> 끝 </a>").appendTo(pagiNation);
		
		if ( gofistPage ) {
			gofistPage.click(function(event) {
				$("#page").val(1);
				$("#btn").trigger("click");
			});
		}
		
		if ( goBackPage ) {
			goBackPage.click(function(event) {
				$("#page").val(Number(pageOption.startPage) - 1);
				$("#btn").trigger("click");
			});
		}
		
		if ( goLastPage ) {
			goLastPage.click(function(event) {
				$("#page").val(Number(pageOption.totalPage));
				$("#btn").trigger("click");
			});
		}
		
		if ( goNextPage ) {
			goNextPage.click(function(event) {
				$("#page").val(Number(pageOption.endPage) + 1);
				$("#btn").trigger("click");
			});
		}
		
		$("a.goPage").click(function(event) {
			$("#page").val($(this).attr("data-page"));
			$("#btn").trigger("click");
		});
	}
});
</script>
</c:if>
<c:if test="${sessionScope.employee_code eq null}"><a href="elogin">로그인</a></c:if>
</body>
</html>