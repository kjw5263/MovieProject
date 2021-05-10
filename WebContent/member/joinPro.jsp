<%@page import="com.movie.member.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>joining...</title>
</head>
<body>

  <%
  	// 한글 데이터 문자셋 변경하기
    request.setCharacterEncoding("UTF-8");
  
  	// 우편번호는 별개 항목으로 두고,
  	// 주소 + 일반주소 합치기
  	String addr = request.getParameter("addr");
  	String addr_detail = request.getParameter("addr_detail");
  	addr = addr + " " + addr_detail;
  	
  
  %>
  
  <jsp:useBean id="memberBean" class="com.movie.member.MemberBean"></jsp:useBean>
  <jsp:setProperty property="*" name="memberBean"/>
  
  <%
  	// 합친 주소를 addr로 설정 
  	memberBean.setAddr(addr);
  	System.out.println(memberBean.toString());
    
  	MemberDAO mdao = new MemberDAO();
  	mdao.UserJoin(memberBean);
  	
  	
  	%>
  	
  	<script type="text/javascript">
		alert("회원가입이 완료되었습니다. 축하합니다!");
		location.href = "loginForm.jsp";
	</script>
</body>
</html>