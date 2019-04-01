<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공지사항</title>
<link rel="stylesheet" type="text/css" href="../../../../../css/notice.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script type="text/javascript" src="../../../../../ckeditor/ckeditor.js"></script>
</head>
<body>
	<%@include file="../MAIN/topmenu.jsp"%>
	<div id="container">
		<div id="ncontainer">
			<div id="nTitle">
				<h1><a onclick="location.href='noticeList'" style="cursor:pointer">공지사항</a></h1>
			</div>
			<div id="nListTable">
				<form id="ninsert" action="noticeInsert" method="post">
					<table>
						<tr>
							<th>제목</th>
							<td colspan="3"><input id="title" type="text" name="title"></td>
						</tr>
						<tr>
							<th>내용</th>
							<td colspan="3"><textarea rows="" cols="" name="content" id="editor"></textarea></td>
						</tr>
					</table>
					<div id="button">
						<button style="cursor:pointer" type="button" onclick="Check()">등록</button>
						<button style="cursor:pointer" type="button" onclick="location.href='noticeList'">취소</button>
					</div>
				</form>
			</div>
		</div>
	</div>
	<%@include file="../MAIN/footer.jsp"%>
</body>
<script type="text/javascript">
	function Check() {
		var title = document.getElementById('title');
		var special_pattern = /[\/<>]/gi;

		if (title.value == null || title.value == '') {
			alert('제목을 입력해 주세요.');
			return false;
		} else if (special_pattern.test(title.value) == true) {
			alert('특수문자는 사용할 수 없습니다.');
			return false;
		}

		var content = document.getElementById('editor');

		if (content.value == null || content.value == '') {
			alert('내용을 입력해 주세요.');
			return false;
		} else if (special_pattern.test(content.value) == true) {
			alert('특수문자는 사용할 수 없습니다.');
			return false;
		}

		if(confirm('등록하시겠습니까?')){
			document.getElementById("ninsert").submit();
		}
	}
</script>
</html>