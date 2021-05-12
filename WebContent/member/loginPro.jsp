<%@page import="java.util.ArrayList"%>
<%@page import="com.movie.member.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE>
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
		System.out.println(user_id + "/ "+user_pw);
		
		
	%>
	
	
	<jsp:useBean id="memberBean" class="com.movie.member.MemberBean"/>
	<jsp:setProperty property="*" name="memberBean"/>
	
	
	<%
		
		MemberDAO mdao = new MemberDAO();
		ArrayList<Object> result = new ArrayList<Object>();
		result = mdao.loginCheck(memberBean);
		if(result != null){
			for(int i=0; i<result.size(); i++){
				System.out.println(result.get(i));
			}
		}
		System.out.println(memberBean.toString());
		System.out.println(memberBean.getUser_id());
		
		if (result.size() != 0){
			if((int)result.get(0) == 1){
				// 로그인 성공했을 시
				
				// 세션값 저장하기
				session.setAttribute("user_id", memberBean.getUser_id());
				session.setAttribute("user_nickname", (String)result.get(1));
				
				%>
					<!-- 메인 홈페이지로 이동하기 -->
				  	<script type="text/javascript">
						location.href="main.jsp";
				 	</script>
				
				<%
			} else if((int)result.get(0) == 0){
				%>
					<script type="text/javascript">
					 	alert("비밀번호가 일치하지 않습니다.");
					 	history.back();
					</script>
				<%
			} else {
				%>
					<script type="text/javascript">
						var answer = confirm("존재하지 않는 아이디입니다. 회원가입 하시겠습니까?");
						if(answer){
							location.href = "joinForm.jsp";
						} else {
							history.back();	
						}
						
					</script>
				<%
			}
		}
		
		
		
	
	%>

</body>
</html>