<%@page import="com.movie.member.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>비밀번호 변경</title>
</head>
<body>
<%
	request.setCharacterEncoding("UTF-8");

	String user_id = request.getParameter("user_id2");
	String user_pw = request.getParameter("user_pw2");
	String user_pw_check = request.getParameter("user_pw_check");
	System.out.println("비번 바꾸는 곳 : " + user_id);
	
%>	

<jsp:useBean id="memberBean" class="com.movie.member.MemberBean"></jsp:useBean>
<jsp:setProperty property="*" name="memberBean"/>


<%
	memberBean.setUser_id(user_id);
	memberBean.setUser_pw(user_pw);
	memberBean.setUser_pw_check(user_pw_check);
	MemberDAO mdao = new MemberDAO();
	System.out.println("비번 바꾸는 곳에멤버빈 >>>>>>>>>" + memberBean);
	int result = mdao.updatePassInfo(memberBean);
	
	if(result == 1){
		%>
			<script type="text/javascript">
				alert("비밀번호가 정상적으로 변경되었습니다.");
				location.href="beforeMyInfo.jsp";
			</script>
		<%
	} else if (result == 0){
		%>
			<script type="text/javascript">
				alert("비밀번호를 확인하세요");
				location.href = "beforeMyInfo.jsp";
			</script>
		<%
	} else {
		%>
			<script type="text/javascript">
				alert("변경 실패했습니다. 현상이 지속되면 고객센터로 문의주십시오.");
				location.href = "beforeMyInfo.jsp";
			</script>
		<%		
	}




%>

</body>
</html>