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
<link href="../css/writeForm.css" rel="stylesheet" type="text/css">
<script src="../js/logoutCheck.js"></script>

</head>
<body>
<header>
	<div class="logo"><a href="../member/main.jsp"><img src="../img/movie.png"><h1>마무다</h1></a></div>
	
	</header>
	<div><a href="../member/logout.jsp" id="logout" onclick="return logoutCheck()">로그아웃</a> | <a href="../member/beforeMyInfo.jsp">회원정보 조회</a></div>
	<nav>
	<ul>
		<li><a href="../member/main.jsp">HOME</a></li>
		<li><a href="boardList.jsp">리뷰게시판</a></li>
		<li><a href="theatherMap.html">영화관 검색</a></li>
		<li><a href="../mail/mailForm.jsp">Contact Us</a></li>
	</ul>
</nav>
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
	String movieData = boardBean.getMovieData().replace("\n", "<br>");
	String content = boardBean.getContent().replace("\n", "<br>");


%>
<div class="writeForm">
	<form action="updatePro.jsp?pageNum=<%=pageNum %>" name="fr" method="post" enctype="multipart/form-data">
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
			<div id="movieData-div"><%=movieData %></div>
			
		</div>
		<textarea rows="20" cols="50" name="content" placeholder="무방비한 비난 및 욕설은 사전고지 없이 삭제될 수 있습니다. "><%=boardBean.getContent() %></textarea> <br>
		<input type="file" name="fileName" value="<%=boardBean.getFileName() %>">
		
		
		<input type="submit" value="수정하기">
	</form>
	</div>
	
<!-- footer 시작 -->
 		<jsp:include page="../common/footer.jsp" />
	<!-- footer 끝 -->
</body>
</html>