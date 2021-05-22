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
	
</script>



</head>
<body>

<header>
	<div class="logo"><a href="../member/main.jsp"><img src="../img/movie.png"></a></div>
	
	</header>

<%
	String user_id = (String)session.getAttribute("user_id");
	if(user_id == null){
		response.sendRedirect("../member/loginForm.jsp");
		session.invalidate();
	}


%>
	<form action="writePro.jsp" name="fr" method="post">
		<input type="hidden" name="user_id" value="<%=user_id%>">
		<select name="selectType">
		    <option value="1">추천해요</option>
		    <option value="0">그저그래요</option>
		    <option value="-1">별로예요</option>
		</select>
		<input type="text" name="title" placeholder="제목을 입력하세요">
		<input type="button" value="영화검색" onclick="openSearchMoviePop()">
		<div id="div2">
			
			<input type="hidden" id="pubDate" name="pubDate" value=""><br>
			<input type="hidden" id="movieLink" name="movieLink" value=""><br>
			<input type="hidden" id="movieData" name="movieData" value="" >
			<input type="hidden" id="imgLink" name="imgLink" value="">
			<img id="img" src="">
			<div id="pubDate-div"></div>
			<div id="movieData-div"></div>
			
		</div>
		<textarea rows="20" cols="150" name="content" placeholder="무방비한 비난 및 욕설은 사전고지 없이 삭제될 수 있습니다. "></textarea> <br>
		<input type="file" name="fileName">
		
		
		<input type="submit" value="작성하기">
	</form>
	
	
		<footer>
	
	<hr>
	<div id="copy">
	Contact  Mail kjw5263@naver.com | Tel 010-9989-5263 | FAX 051-123-456 <br>
	 Copyright (c) 2021. Ma Movie Diary. All rights reserved <br>
	 </div>
	<div id="social">
	<a href="https://www.instagram.com/ddi5niii/"><img src="../img/instagram-2.png" alt="instagram" ></a>
	<a href="https://www.facebook.com/"><img src="../img/facebook.png" alt="facebook"></a>
	</div>
	</footer>
</body>
</html>