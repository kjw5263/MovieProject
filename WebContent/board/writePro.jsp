<%@page import="com.movie.board.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>loading...</title>
</head>
<body>
	<%
		request.setCharacterEncoding("UTF-8");
		String selectType = request.getParameter("selectType");
		String pubDate = request.getParameter("pubDate");
		String imgLink = request.getParameter("imgLink");
		String movieLink = request.getParameter("movieLink");
		String movieData = request.getParameter("movieData");
	%>
	
	<jsp:useBean id="boardBean" class="com.movie.board.BoardBean"/>
	<jsp:setProperty property="*" name="boardBean"/>
	
	<%
		
		boardBean.setIp(request.getRemoteAddr());
		System.out.println("글쓰기 정보 :" + boardBean.toString());
		
		BoardDAO bdao = new BoardDAO();
		int result = bdao.insertBoard(boardBean);
		
		if (result == 1){
			response.sendRedirect("boardList.jsp");
		} else {
			%>
				<script type="text/javascript">
					alert("글쓰기 실패 입니다.");
					history.back();
				</script>
			<%
		}
		
	%>
	
</body>
</html>