<%@page import="com.movie.member.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 탈퇴</title>
</head>
<body>
	<%
		request.setCharacterEncoding("UTF-8");
		String user_id = request.getParameter("user_id3");
		String user_pw = request.getParameter("user_pw3");
	%>
	
	<jsp:useBean id="memberBean" class="com.movie.member.MemberBean"></jsp:useBean>
	<jsp:setProperty property="*" name="memberBean"/>
	
	
	<%
		memberBean.setUser_id(user_id);
		memberBean.setUser_pw(user_pw);
		MemberDAO mdao = new MemberDAO();
		int result = mdao.deleteInfo(memberBean);
		
		if(result == 1){
			%>
				<script type="text/javascript">
					alert("탈퇴되었습니다. 이용해주셔서 감사합니다. ");
					location.href = "../index.jsp";
				</script>
			<%
		} else if(result == 0){
			%>
			<script type="text/javascript">
				alert("비밀번호를 확인하세요.");
				location.href="beforeMyInfo.jsp";
			</script>
		<%
		} else {
			%>
			<script type="text/javascript">
				alert("사용자를 확인할 수 없습니다. 잠시 후 다시 시도해주세요.");
				location.href="beforeMyInfo.jsp";
			</script>
		<%
		}
		
	
	
	%>
	
	
</body>
</html>