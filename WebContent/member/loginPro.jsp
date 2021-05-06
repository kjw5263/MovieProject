
<%@page import="com.movie.member.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>login...</title>
</head>
<body>

	<%
		request.setCharacterEncoding("UTF-8");
	
		String user_id = request.getParameter("user_id");
		String user_pw = request.getParameter("user_pw");
		
		
	%>
	
	
	<jsp:useBean id="memberBean" class="com.movie.member.MemberBean"/>
	<jsp:setProperty property="*" name="memberBean"/>
	
	
	<%
		memberBean.setUser_id(user_id);
		memberBean.setUser_pw(user_pw);
	
		MemberDAO mdao = new MemberDAO();
		int result = mdao.loginCheck(memberBean);
		
		
		if(result == 1){
			// 로그인 성공했을 시
			session.setAttribute("user_id", user_id);
			%>
			  	<script type="text/javascript">
					location.href="main.jsp";
			 	</script>
			
			<%
		}
		
		
	
	%>

</body>
</html>