<%@page import="com.movie.board.BoardBean"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.movie.board.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="../js/jquery-3.6.0.js"></script>
<script type="text/javascript">

</script>
</head>
<body>
	<%
		request.setCharacterEncoding("UTF-8");
		String user_id = (String)session.getAttribute("user_id");
		System.out.println("[boardList.jsp] 아이디 세션 : " + user_id);
// 		if(user_id == null){
// 			System.out.println("[boardList.jsp] 로그인 세션 만료");
// 			response.sendRedirect("loginForm.jsp");
// 			session.invalidate();
// 		}
		
//		else if(user_id != null){
			System.out.println("[boardList.jsp] 로그인 세션 있음");
			%>
				<input type="button" value="글쓰기" onclick="location.href='writeForm.jsp'">
			<%
//		}


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
		<table border="1">
			<tr>
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
					<td><%=bb.getSelectType() %></td>
					<td>
						<%
							int wid = 0;
							if(bb.getRe_lev() > 0){
								wid = 15 * bb.getRe_lev();
						%>
						<img src="level.gif" height="15" width="<%=wid %>">
						<img src="re.gif">
						<%
						
							}
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
	
	<hr>
	
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
			int pageBlock = 2;
			
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
					<a href="boardList.jsp?pageNum=<%=i %>"
						style="text-decoration:none;">[ <%=i %> ] </a>
				<%
			}
			
			// 다음 (기존의 페이지 블럭보다 페이지의 수가 많을 때)
			if(endPage <  pageCount) {
				%>
				<a href="BoardList.jsp?pageNum=<%=startPage + pageBlock%>">[다음]</a>
				<%
				
			}
			
		}
	%>
	
</body>
</html>