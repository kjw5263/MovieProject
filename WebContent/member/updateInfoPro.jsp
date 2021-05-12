<%@page import="com.movie.member.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원정보 변경</title>
</head>
<body>

<%
	request.setCharacterEncoding("UTF-8");
	String user_id = (String)session.getAttribute("user_id");

	if(user_id == null){
		System.out.println("[updateInfoPro.jsp] 로그인 세션 만료");
		response.sendRedirect("loginForm.jsp");
	}
	//우편번호는 별개 항목으로 두고,
	// 주소 + 일반주소 합치기
	String addr = request.getParameter("addr");
	String addr_detail = request.getParameter("addr_detail");
	addr = addr + "+" + addr_detail;
	

%>

	<jsp:useBean id="memberBean" class="com.movie.member.MemberBean"></jsp:useBean>
	<jsp:setProperty property="*" name="memberBean"/>
	
<%
	memberBean.setAddr(addr);
	MemberDAO mdao = new MemberDAO();
	int result = mdao.updateInfo(memberBean);
	
	if(result == 1){
		%>
			<script type="text/javascript">
				alert("성공적으로 변경되었습니다. ");
				location.href="beforeMyInfo.jsp";
			</script>
		<%
	} else if(result == 0){
		%>
		<script type="text/javascript">
			alert("비밀번호가 일치하지 않습니다.");
			location.href="beforeMyInfo.jsp";
		 </script>
	   <%
	} else if(result == -1){
		%>
		<script type="text/javascript">
			alert("일치하는 정보가 없습니다. 고객센터(055-111-0100)으로 문의해주세요.");
			location.href="beforeMyInfo.jsp";
		 </script>
	   <%
	}


%>

</body>
</html>