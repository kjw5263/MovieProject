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
	// 영화 검색 팝업 여는 창
	function openSearchMoviePop() {
		window.open('searchPage.jsp','','width=600, height=800');
	}
	
	function fun(JsonObject) {
		var json = JsonObject;
		console.log(json);
	}
	
	

</script>

</head>
<body>


	<form action="writePro.jsp" name="fr" method="post">
		<input type="hidden" name="user_id" value="kjw5263">
		<select name="selectType">
		    <option value="1">추천해요</option>
		    <option value="0">그저그래요</option>
		    <option value="-1">별로예요</option>
		</select>
		<input type="text" name="title" placeholder="제목을 입력하세요">
		<input type="button" value="영화검색" onclick="openSearchMoviePop()">
		<div id="div2">
			<img id="imgLink" name="imgLink" src=""><br>
			<input type="text" id="pubDate" name="pubDate" value="" readonly><br>
			<textarea id="movieData" name="movieData" value="" readonly></textarea> <br>
		</div>
		<textarea rows="20" cols="50" name="content" placeholder="무방비한 비난 및 욕설은 사전고지 없이 삭제될 수 있습니다. "></textarea> <br>
		<input type="file" name="fileName">
		
		
		<input type="submit" value="작성하기">
	</form>
</body>
</html>