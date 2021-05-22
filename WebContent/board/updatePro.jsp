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
	request.setCharacterEncoding("UTF-8");
	String pageNum = request.getParameter("pageNum");
	String user_id = (String)session.getAttribute("user_id");
	
	
%>

 <jsp:useBean id="boardBean" class="com.movie.board.BoardBean"/>
   <jsp:setProperty property="*" name="boardBean"/>
   
   <%
   	
   boardBean.setUser_id(user_id);
   System.out.println("수정할 때 보드빈은? == "+boardBean.toString());
	// DB 처리 객체 BoardDAO 생성
		BoardDAO bdao = new BoardDAO();
		// 해당 글 정보를 사용해서 글 내용 수정
		int check = bdao.updateContent(boardBean); // bb안에 수정할 내용들이 있으니까 bb 넘겨주기!
		
		if(check == 1){
			%>
				<script type="text/javascript">
					alert("정상적으로 수정되었습니다.");
					location.href="boardList.jsp?pageNum=<%=pageNum%>";
				</script>
				
			<%
			
		} else if(check == 0){
			%>
				<script type="text/javascript">
					alert("권한이 없습니다.");
					location.href="boardList.jsp?pageNum=<%=pageNum%>";
				</script>
			<% 
		} else if(check == -1){
			%>
				<script type="text/javascript">
					alert("존재하지 않는 회원입니다.");
					location.href="boardList.jsp?pageNum=<%=pageNum%>";
				</script>
			
			<%
		}
   
   %>
   
</body>
</html>