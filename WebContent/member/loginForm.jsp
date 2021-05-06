<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>마무다 로그인</title>
<link href="css/font.css" rel="stylesheet">
<link rel="preconnect" href="https://fonts.gstatic.com">
<link href="https://fonts.googleapis.com/css2?family=Nanum+Gothic:wght@400;700;800&display=swap" rel="stylesheet">
</head>
<body>
<h1> 로그인 </h1>

   <form action="loginPro.jsp" method="post">
   
   	<input type="text" name="user_id" placeholder="아이디" required>			<br>
   	<input type="password" name="user_pw" placeholder="비밀번호" required>		<br>
   	
   	<input type="submit" value="로그인">		<br>
   	
   	<p>처음 방문하셨나요? <a href="joinForm.jsp">회원가입</a></p>
   	
   	
   
   </form>
</body>
</html>