
<%@page import="com.movie.board.BoardDAO"%>
<%@page import="com.movie.board.ReplyBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>댓글 입력중</title>
</head>
<body>
	<%
		request.setCharacterEncoding("UTF-8");
	
		String user_id = request.getParameter("user_id");
		int board_num = Integer.parseInt(request.getParameter("board_num"));
		String pageNum = request.getParameter("pageNum");
		String replyTextArea = request.getParameter("replyTextArea");
		
		ReplyBean reBean = new ReplyBean();
		reBean.setUser_id(user_id);
		reBean.setReplyTextArea(replyTextArea);
		reBean.setBoard_num(board_num);
		
		BoardDAO boardBean = new BoardDAO();
		int result = boardBean.insertReply(reBean);
		
		if(result == 1){
			%>
				<script type="text/javascript">
					location.href='content.jsp?board_num=<%=board_num%>&pageNum=<%=pageNum%>';
				</script>
			<%
		} else {
			%>
			<script type="text/javascript">
				alert("문제가 발생했습니다. 잠시 후 다시 시도해 주세요.");
				history.beack();
			</script>
		<%
		}
	%>
	
	
	
	
</body>
</html>