<%@page import="com.movie.board.BoardBean"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.movie.board.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>리뷰 게시판</title>
<link href="../css/default.css" rel="stylesheet" type="text/css">
<link href="../css/boardList.css" rel="stylesheet" type="text/css">
<script src="../js/jquery-3.6.0.js"></script>
<script src="../js/logoutCheck.js"></script>
<script type="text/javascript">

</script>
</head>
<body>

<header>
	<div class="logo"><a href="../member/main.jsp"><img src="../img/movie.png"></a></div>
	
	</header>
	<div><a href="../member/logout.jsp" id="logout" onclick="return logoutCheck()">로그아웃</a> | <a href="../member/beforeMyInfo.jsp">회원정보 조회</a></div>
	<nav>
	<ul>
		<li><a href="../member/main.jsp">HOME</a></li>
		<li><a href="boardList.jsp">리뷰게시판</a></li>
		<li><a href="theatherMap.html">영화관 검색</a></li>
		<li><a href="#">Contact Us</a></li>
	</ul>
</nav>

<div id="left">
	<%
		request.setCharacterEncoding("UTF-8");
		String user_id = (String)session.getAttribute("user_id");
		System.out.println("[boardList.jsp] 아이디 세션 : " + user_id);
		if(user_id == null){
			System.out.println("[boardList.jsp] 로그인 세션 만료");
			response.sendRedirect("../member/loginForm.jsp");
			session.invalidate();
		}
		
		else if(user_id != null){
			System.out.println("[boardList.jsp] 로그인 세션 있음");
	%> 
				<input type="button" value="글쓰기" onclick="location.href='writeForm.jsp'">
			<%
		}


		BoardDAO bdao = new BoardDAO();
		int cnt  = bdao.getBoardCount();

		int pageSize = 5;
		
		String pageNum = request.getParameter("pageNum");
		if(pageNum == null){
			pageNum = "1";
		}
		
		
		int currentPage = Integer.parseInt(pageNum);
		int startRow = (currentPage-1)*pageSize+1;
		int endRow = currentPage * pageSize;
		
		ArrayList boardList = bdao.getBoardList(startRow, pageSize);

	%>
		<table>
			<tr class="table-title">
				<td>번호</td>
				<td>유형</td>
				<td>제목</td>
				<td>작성자</td>
				<td>작성일</td>
				<td>조회수</td>
			</tr>
		
	<%
		for(int i=0; i<boardList.size() ; i++) {
			BoardBean bb = (BoardBean)boardList.get(i);
			%>
				<tr>
					<td><%=bb.getBoard_num() %></td>
					<td>
						<%if(bb.getSelectType().equals("1")) {%> <span style="color:green">추천해요</span>
						<%} else if(bb.getSelectType().equals("0")){ %><span style="color:grey">그저그래요</span>
						<%} else if(bb.getSelectType().equals("-1")) {%> <span style="color:orange">별로예요</span>
						<% }%></td>
					<td>
						<%
							//int wid = 0;
							//if(bb.getRe_lev() > 0){
								//wid = 15 * bb.getRe_lev();
						%>
<%-- 						<img src="level.gif" height="15" width="<%=wid %>"> --%>
<!-- 						<img src="re.gif"> -->
						<%
						
							//}
						%>
						<a href="content.jsp?board_num=<%=bb.getBoard_num() %>&pageNum=<%=pageNum %>"><%=bb.getTitle() %></a>
						
					</td>
					<td><%=bb.getUser_id() %></td>
					<td><%=bb.getDate() %></td>
					<td><%=bb.getReadcount() %>
				</tr>
			<%
		}
		
	
	%>
	</table>
	<br><br>
	<div class="pageNumber">
	<%
		////////////////////////////////////////////////////
		// 페이징 처리 - 하단부 페이지 링크
		// cnt : 글 개수
		if(cnt != 0){	// 글이 있을 때 표시
			// 전체 페이지 수 계산
			// ex) 총 50개 -> 한페이지당 10개 출력, 5개
			// 		총 57개 -> 한 페이지당 10개, 6개
			int pageCount = cnt/pageSize + (cnt % pageSize == 0? 0:1);
			
			// 한 화면에 보여줄 페이지 번호의 개수 (페이지 블록 )
			int pageBlock = 5;
			
			// 페이지 블럭의 시작페이지 번호
			// ex) 1~10 페이지 : 1, 11~20페이지 : 11, 21~20 패이지 : 21
			int startPage = ((currentPage-1)/pageBlock) * pageBlock + 1;
			// ex) 1~5 페이지 : 1, 6~11 페이지
			// 페이지 블럭의 끝 페이지 번호
			int endPage = startPage+pageBlock-1;
			if(endPage > pageCount ){
				endPage = pageCount;
			}
			
			
			
			// 이전
			if(startPage > pageBlock){
				%>
				
				<a href="boardList.jsp?pageNum=<%=startPage - pageBlock%>">[이전]</a>
				
				<%
			}
			
			
			// 숫자 1...10
			for(int i=startPage; i<=endPage; i++){
				%>
					<span class="spanNum"><a href="boardList.jsp?pageNum=<%=i %>" style="text-decoration:none;">[ <%=i %> ] </a></span>	
				<%
			}

			
			// 다음 (기존의 페이지 블럭보다 페이지의 수가 많을 때)
			if(endPage <  pageCount) {
				%>
				<a href="boardList.jsp?pageNum=<%=startPage + pageBlock%>">[다음]</a>
				<%
				
			}
			
		}
	%>
	</div>
	</div>
	
	
	<div id="right">
	
	
	
	</div>
	
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