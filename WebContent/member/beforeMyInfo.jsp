<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원정보 조회 본인확인</title>
</head>
<body>
	<%
		request.setCharacterEncoding("UTF-8");
		String user_id = (String)session.getAttribute("user_id");
		String user_nickname = (String)session.getAttribute("user_nickname");
		System.out.println("[beforeMyInfo] 아이디/닉넴 세션 : " +user_id + "/" + user_nickname);
		if(user_id == null || user_nickname == null){
			System.out.println("id/nickname : " +user_id +"/"+user_nickname);
			session.invalidate();
			System.out.println("[checkMyInfo.jsp] 로그인 세션 만료");
			response.sendRedirect("loginForm.jsp");
		}
		
		
	%>
	
	
	<fieldset>
	<h2>회원정보 조회 본인확인</h2>
	<form action="MyInfo.jsp" method="post">
		<input type="hidden" name="user_id" placeholder="아이디" value="<%=user_id %>"> <br>
		<input type="password" name="user_pw" placeholder="비밀번호">
		
		<br><br>
		<hr><br>
		<input type="submit" value="확인">
		<input type="button" value="취소" onclick="history.back()">
		
	</form>
	
	</fieldset>
</body>
</html>