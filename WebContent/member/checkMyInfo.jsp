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
		String user_nickname = (String)session.getAttribute("user_nickname");
		
		if(user_id == null || user_nickname == null){
			System.out.println("id/nickname : " +user_id +"/"+user_nickname);
			session.invalidate();
			System.out.println("[checkMyInfo.jsp] 로그인 세션 만료");
			response.sendRedirect("loginForm.jsp");
		}
		
		
	%>
	
	
	
	<form>
		<input type=""
	
	
	</form>
</body>
</html>