<%@page import="com.movie.board.BoardDAO"%>
<%@page import="com.movie.board.BoardBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>리뷰 작성하기</title>
<link href="https://fonts.googleapis.com/css2?family=Nanum+Gothic:wght@400;700;800&display=swap" rel="stylesheet">
<link href="../css/default.css" rel="stylesheet" type="text/css">


</head>
<body>
<header>
	<div class="logo"><a href="../member/main.jsp"><img src="../img/movie.png"></a></div>
	
	</header>
<%
	String user_id = (String)session.getAttribute("user_id");
	int board_num = Integer.parseInt(request.getParameter("board_num"));
	String pageNum = request.getParameter("pageNum");
	
	if(user_id == null){
		response.sendRedirect("../member/loginForm.jsp");
		session.invalidate();
	}
	
	BoardDAO bdao = new BoardDAO();
	BoardBean boardBean = bdao.getBoard(board_num);
	


%>
	<form action="updatePro.jsp?pageNum=<%=pageNum %>" name="fr" method="post">
		<input type="hidden" name="board_num" value="<%=boardBean.getBoard_num() %>">
		<input type="hidden" name="user_id" value="<%=boardBean.getUser_id()%>">
		<select name="selectType">
		    <option value="1">추천해요</option>
		    <option value="0">그저그래요</option>
		    <option value="-1">별로예요</option>
		</select>
		<input type="text" name="title" placeholder="제목을 입력하세요" value="<%=boardBean.getTitle()%>">
		
		<div id="div2">
			
			<input type="hidden" id="pubDate" name="pubDate" value="<%=boardBean.getPubDate()%>"><br>
			<input type="hidden" id="movieLink" name="movieLink" value="<%=boardBean.getMovieLink()%>"><br>
			<input type="hidden" id="movieData" name="movieData" value="<%=boardBean.getMovieData() %>" >
			<input type="hidden" id="imgLink" name="imgLink" value="<%=boardBean.getImgLink()%>">
			<img id="img" src="<%=boardBean.getImgLink()%>">
			<div id="pubDate-div"><%=boardBean.getPubDate() %></div>
			<div id="movieData-div"><%=boardBean.getMovieData() %></div>
			
		</div>
		<textarea rows="20" cols="50" name="content" placeholder="무방비한 비난 및 욕설은 사전고지 없이 삭제될 수 있습니다. "><%=boardBean.getContent() %></textarea> <br>
		<input type="file" name="fileName" value="<%=boardBean.getFileName() %>">
		
		
		<input type="submit" value="수정하기">
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