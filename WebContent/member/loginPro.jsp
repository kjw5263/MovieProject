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
		// loginForm.jsp에서 받은 아이디/비밀번호 값 저장
		request.setCharacterEncoding("UTF-8");
		String user_id = request.getParameter("user_id");
		String user_pw = request.getParameter("user_pw");
		System.out.println(user_id + "/ "+user_pw);
	%>
	
	<!---------------- MemberBean 객체 생성  ---------------->
	<jsp:useBean id="memberBean" class="com.movie.member.MemberBean"/>
	<jsp:setProperty property="*" name="memberBean"/>
	
	<%
		// 로그인 메소드로 보낼 memberBean 객체 데이터 확인하기 
		System.out.println("[loginPro.jsp] memberBean 객체속 데이터 : " + memberBean.toString());
	
		MemberDAO mdao = new MemberDAO();
		ArrayList<Object> result = new ArrayList<Object>();
		
		// 로그인 결과를 ArrayList배열로 받는다. [성공여부값-1,0,1][성공했을 시 닉네임]
		result = mdao.loginCheck(memberBean);
		
		
		if(result != null){
			for(int i=0; i<result.size(); i++){
				System.out.println("[loginPro.jsp] 로그인 성공 여부 " + result.get(i));
			}
		}
		
		
		if (result.size() != 0){
			if((int)result.get(0) == 1){
				// 로그인 성공했을 시
				
				// 세션값 저장하기
				session.setAttribute("user_id", memberBean.getUser_id());
				session.setAttribute("user_nickname", (String)result.get(1));
				
				// 메인 페이지로 이동
				response.sendRedirect("main.jsp");
				
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
						}
						history.back();	
					</script>
				<%
			}
		}
		
	%>

</body>
</html>