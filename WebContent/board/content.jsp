<%@page import="java.net.URLEncoder"%>
<%@page import="java.io.FileInputStream"%>
<%@page import="com.movie.board.BoardDAO"%>
<%@page import="com.movie.board.BoardBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시물</title>
<link href="../css/default.css" rel="stylesheet" type="text/css">
<link href="../css/content.css" rel="stylesheet" type="text/css">
<script src="../js/logoutCheck.js"></script>
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
	
	
	// ** 쿠키 설정 해주기 ** //
	Cookie[] cookies = request.getCookies();
	Cookie viewCookie = null;
	
	if(cookies != null && cookies.length > 0){
		for(int i=0; i<cookies.length; i++){
			if(cookies[i].getName().equals(user_id + "_cookie"+board_num)){
				System.out.println("처음 쿠키 생성한 뒤 들어옴");
				viewCookie = cookies[i];
			}
		}
	}
	
	if(viewCookie == null){
		Cookie newCookie = new Cookie(user_id + "_cookie" + board_num, "|"+board_num+"|");
		response.addCookie(newCookie);
		int result = bdao.updateReadCount(board_num);
		if(result == 1 ){
			System.out.println("조회수증가 : "+ result);
		} else {
			System.out.println("조회수 증가 에러 ");
		}
	} else {
		System.out.println("쿠키 있음 ");
		System.out.println("쿠키값은 : " + viewCookie.getValue());
	}
	
	
	
	// bdao.updateReadCount(num);
	
	BoardBean boardBean = bdao.getBoard(board_num);
	System.out.println(boardBean.toString());
	String movieData = boardBean.getMovieData().replace("\n", "<br>");
	String content = boardBean.getContent().replace("\n", "<br>");
%>
<div><a href="../member/logout.jsp" id="logout" onclick="return logoutCheck()">로그아웃</a> | <a href="../member/beforeMyInfo.jsp">회원정보 조회</a></div>
<nav>
	<ul>
		<li><a href="../member/main.jsp">HOME</a></li>
		<li><a href="boardList.jsp">리뷰게시판</a></li>
		<li><a href="theatherMap.html">영화관 검색</a></li>
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
		<td colspan="3">
		<%
			if(boardBean.getFileName()==null){
				%>
				-
				<%
			} else {
				%>
				<a href="fileDown.jsp?fileName=<%=boardBean.getFileName()%>"><%=boardBean.getFileName() %></a>
				<%
			}
		%></td>
	</tr>
	<tr>
		<th>제목</th>
		<td colspan="3"><%=boardBean.getTitle() %></td>
	</tr>
	<tr>
		<th>영화정보</th>
		<td><img src="<%=boardBean.getImgLink()%>" onerror="this.src='../img/unnamed.png'"></td>
		<td><%=movieData %></td>
		<td><a href="<%=boardBean.getMovieLink()%>"  target="_blank">more</a>
	</tr>
	<tr>
		<td colspan="4" height="300px"><%=content %></td>
	</tr>
	

</table>

 <div class="content-btn"><input type="button" value="목록으로" onclick="location.href='boardList.jsp?pageNum=<%=pageNum%>'">
 
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
 			</div>
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