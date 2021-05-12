<%@page import="com.movie.member.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>아이디 중복체크</title>
<script type="text/javascript">
	function idFix() {
		opener.document.joinfr.user_id.value = document.ofr.user_id.value;
		opener.document.getElementById("user_id").readOnly = true;
		opener.document.getElementById("user_name").focus();
		window.close();
	}
	
</script>
</head>
<body>


<%
	request.setCharacterEncoding("UTF-8");	

// joinForm.jsp에서 받아온 아이디 값 받기
	String user_id = request.getParameter("user_id");

	MemberDAO mdao = new MemberDAO();
	int result = mdao.IDdup_Check(user_id);
	
	// result = 1이면, 이미 아이디가 존재함
	if(result == 1 ){
			out.println("이미 존재하는 아이디 입니다.");
	} else {
		out.println("사용 가능한 아이디 입니다.");
		%>
			<input type="button" value="아이디 사용하기" onclick="idFix()">
		<%
	}

%>
<div id="haveTocheck"></div>
<hr>
<form action="IDdup_check.jsp" method="post" name="ofr">

	<input type="text" name="user_id" value="<%=user_id %>">
	<input type="submit" value="중복확인">

</form>
<hr>



</body>
</html>