<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>마무다 메인</title>

<link href="https://fonts.googleapis.com/css2?family=Nanum+Gothic:wght@400;700;800&display=swap" rel="stylesheet">
<link href="../css/default.css" rel="stylesheet" type="text/css">
</head>
<body>

<%
	request.setCharacterEncoding("UTF-8");
	String user_id = (String)session.getAttribute("user_id");
	String user_nickname = (String)session.getAttribute("user_nickname");
	System.out.println("[Main] 아이디/닉넴 세션 : " +user_id + "/" + user_nickname);
		
	if(user_id == null || user_nickname == null){
		System.out.println("[Main.jsp] 로그인 세션 만료 ");
		response.sendRedirect("loginForm.jsp");
		session.invalidate();
	}

	
%>



<a href="logout.jsp">로그아웃</a>

<a href="beforeMyInfo.jsp">회원정보 조회</a>
<h5><%=user_nickname %>님, 환영합니다.</h5>
<nav>
	<ul>
		<li><a href="main.jsp">HOME</a></li>
		<li><a href="../board/boardList.jsp">리뷰게시판</a></li>
		<li><a href="#">무슨게시판</a></li>
		<li><a href="#">Contact Us</a></li>
	</ul>
</nav>





</body>
</html>