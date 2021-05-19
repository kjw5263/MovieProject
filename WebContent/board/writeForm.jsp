<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>리뷰 작성하기</title>
<link href="https://fonts.googleapis.com/css2?family=Nanum+Gothic:wght@400;700;800&display=swap" rel="stylesheet">
<link href="../css/default.css" rel="stylesheet" type="text/css">
<script>
	function openSearchMoviePop() {
		window.open('searchPage.jsp','','width=600, height=800');
	}

</script>

</head>
<body>

	<form action="#">
		<label>제목 : <input type="text" name="review_title"></label>
		<div>
			<input type="button" value="영화검색" onclick="openSearchMoviePop()">
		</div>
		<textarea rows="20" cols="50" name="review"></textarea> <br>
		
		
		<input type="submit" value="작성하기">
	</form>
</body>
</html>