<%@page import="com.movie.member.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>이메일 중복체크</title>
<link href="../css/default.css" rel="stylesheet" type="text/css">
<script type="text/javascript">
	function emailFix() {
		opener.document.joinfr.user_email.value = document.ofr.user_email.value;
		opener.document.getElementById("user_email").readOnly = true;
		
		window.close();
	}
	
</script>
<style type="text/css">

div {
	display: table; margin-left: auto; margin-right: auto;
}
</style>
</head>
<body>



<%
	request.setCharacterEncoding("UTF-8");
	// joinForm.jsp에서 받아온 아이디 값 받기
	String user_email = request.getParameter("user_email");

	MemberDAO mdao = new MemberDAO();
	int result = mdao.EMdup_Check(user_email);
	
	// result = 1이면, 이미 아이디가 존재함
	if(result == 1 ){
		%>
			<div><h3><%=user_email %>은 이미 존재하는 이메일 입니다.</h3></div>
		<%
	} else {
		%>
			<div><h3><%=user_email %>은 사용가능한 이메일 입니다.</h3></div>
			<div><br><input type="button" value="이메일 사용하기" onclick="emailFix()"></div>
		<%
	}
%>


<div id="haveTocheck"></div>
<form action="EMdup_check.jsp" method="post" name="ofr">

	<div><input type="text" name="user_email" value="<%=user_email %>">
	<input type="submit" value="중복확인"></div>

</form>
<hr>



</body>
</html>