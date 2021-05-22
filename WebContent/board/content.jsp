<%@page import="com.movie.board.BoardDAO"%>
<%@page import="com.movie.board.BoardBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="../css/default.css" rel="stylesheet" type="text/css">
<link href="../css/content.css" rel="stylesheet" type="text/css">
</head>
<body>

<header>
	<div class="logo"><a href="../member/main.jsp"><img src="../img/movie.png"></a></div>
	
	</header>
<%


	request.setCharacterEncoding("UTF-8");
	String user_id = (String)session.getAttribute("user_id");
	if(user_id == null){
		System.out.println("게시물 수정 세션 없음 ");
	}
	System.out.println("게시물 세션 : " + user_id);

	int board_num = Integer.parseInt(request.getParameter("board_num"));
	String pageNum = request.getParameter("pageNum");
	
	
	BoardDAO bdao = new BoardDAO();
	
	// bdao.updateReadCount(num);
	
	BoardBean boardBean = bdao.getBoard(board_num);
	System.out.println(boardBean.toString());


%>

<nav>
	<ul>
		<li><a href="../member/main.jsp">HOME</a></li>
		<li><a href="boardList.jsp">리뷰게시판</a></li>
		<li><a href="#">무슨게시판</a></li>
		<li><a href="#">Contact Us</a></li>
	</ul>
</nav>

<table border="1">
	
	<tr class="table-title">
		<th>번호</th>
		<th>글쓴이</th>
		<th>작성날짜</th>
		<th>조회수</th>
	</tr>
	<tr>
		<td><%=boardBean.getBoard_num() %></td>
		<td><%=boardBean.getUser_id() %></td>
		<td><%=boardBean.getDate() %>
		<td><%=boardBean.getReadcount() %></td>
	</tr>
	<tr>
		<th>첨부파일</th>
		<td colspan="3"><%=boardBean.getFileName() %></td>
	</tr>
	<tr>
		<th>제목</th>
		<td colspan="3"><%=boardBean.getTitle() %></td>
	</tr>
	<tr>
		<th>영화정보</th>
		<td><img src="<%=boardBean.getImgLink()%>" onerror="this.src='../img/unnamed.png'"></td>
		<td><%=boardBean.getMovieData() %></td>
		<td><a href="<%=boardBean.getMovieLink()%>"  target="_blank">more</a>
	</tr>
	<tr>
		<td colspan="4"><%=boardBean.getContent() %></td>
	</tr>
	

</table>

 <input type="button" value="목록으로" onclick="location.href='boardList.jsp?pageNum=<%=pageNum%>'">
 
 <%
 	if(user_id.equals(boardBean.getUser_id())){
 		%>
 			<script type="text/javascript">
 				function onupdate() {
 					var check = confirm("게시물을 수정하시겠습니까?");
 					if(check == true){
 						location.href='updateForm.jsp?board_num=<%=boardBean.getBoard_num()%>&pageNum=<%=pageNum%>';
 					}
 				}
 				
 				function ondelete() {
 					var check = confirm("게시물을 삭제하시겠습니까? '확인'을 누르면 게시물이 삭제되며, 다시 되돌릴 수 없습니다.");
 					if(check == true){
 						location.href='deletePro.jsp?board_num=<%=boardBean.getBoard_num()%>&pageNum=<%=pageNum%>';
 					}
 				}
 			
 			</script>
 			<input type="button" value="수정" onclick="onupdate()">
 			<input type="button" value="삭제" onclick="ondelete()">
 		<%
 	}
 
 %>
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