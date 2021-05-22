<%@page import="com.movie.board.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%
		String user_id = (String)session.getAttribute("user_id");
		String pageNum = request.getParameter("pageNum");
		
		int board_num = Integer.parseInt(request.getParameter("board_num"));
		
	
	%>
	
	<jsp:useBean id="boardBean" class="com.movie.board.BoardBean"></jsp:useBean>
	<jsp:setProperty property="*" name="boardBean"/>
	
	<%
		BoardDAO bdao = new BoardDAO();
		boardBean.setUser_id(user_id);
		System.out.println("삭제 페이지 !! >>>> " + boardBean.toString());
	
		int result = bdao.deleteContent(boardBean);
	
		if(result == 1){
			%>
			<script type="text/javascript">
				alert('정상적으로 삭제되었습니다.');
				location.href='boardList.jsp?pageNum=<%=pageNum%>';
			</script>
			<%
		}else if (result == 0){
			%>
			<script type="text/javascript">
				alert('권한이 없습니다.');
				history.back();
			</script>
			<%
		} else if (result == -1){
			%>
			<script type="text/javascript">
				alert('잘못된 접근입니다.');
				history.back();
			</script>
			<%
		}
	%>
	
</body>
</html>