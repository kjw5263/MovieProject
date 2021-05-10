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

	if(user_id == null){
		System.out.println("[Main.jsp] 로그인 세션 만료 ");
		response.sendRedirect("loginForm.jsp");
	}

	
%>

<h3><%=user_nickname %>님, 환영합니다.</h3>

<a href="logout.jsp">로그아웃</a>

<a href="checkMyInfo.jsp">내정보 조회</a>





</body>
</html>