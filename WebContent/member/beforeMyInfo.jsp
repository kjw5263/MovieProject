<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원정보 조회 본인확인</title>
<link href="../css/default.css" rel="stylesheet" type="text/css">
</head>
<body>


	<header>
	<div class="logo"><a href="main.jsp"><img src="../img/movie.png"></a></div>
	
	</header>
	
	
	
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
	
	
	
	<h2>회원정보 조회 본인확인</h2>
	<form action="MyInfo.jsp" method="post">
		<input type="hidden" name="user_id" placeholder="아이디" value="<%=user_id %>"> <br>
		<label>비밀번호 <input type="password" name="user_pw" placeholder="비밀번호"></label>
		
		<br><br>
		
		<input type="submit" value="확인">
		<input type="button" value="취소" onclick="history.back()">
		
	</form>
	
	
	
	
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