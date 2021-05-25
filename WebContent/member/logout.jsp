<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>마무다 로그아웃</title>
</head>
<body>



<%

	// 로그아웃 버튼 누를 시 세션 초기화 invalidate()
	session.invalidate();
	System.out.println("[logout.jsp] 세션 초기화 성공");

	
%>

<script type="text/javascript">
	alert("정상적으로 로그아웃 되었습니다.");
	location.href='main.jsp';
</script>	
	

</body>
</html>