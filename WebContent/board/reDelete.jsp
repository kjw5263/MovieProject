<%@page import="com.movie.board.BoardDAO"%>
<%@page import="com.movie.board.ReplyBean"%>
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
	int reply_num = Integer.parseInt(request.getParameter("reply_num"));
	int board_num = Integer.parseInt(request.getParameter("board_num"));
	String pageNum = request.getParameter("pageNum");
	
	BoardDAO bdao = new BoardDAO();
	System.out.println("e댓글 번호 :"+reply_num);
	int result = bdao.replyDelete(reply_num);
	
	
	if(result == 1){
		%>
		<script>
			alert("정상적으로 삭제되었습니다.");
			location.href="content.jsp?pageNum=<%=pageNum%>&board_num=<%=board_num%>";
		</script>
	<%
	} else {
		%>
		<script>
			alert("문제가 발생했습니다. 잠시 후 다시 시도해주세요.");
			history.back();
		</script>
	
	<%
	}

%>
</body>
</html>