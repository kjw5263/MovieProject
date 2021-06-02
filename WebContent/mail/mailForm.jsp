<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<html>
<head>
<title>마무다 Contact Us</title>
<link href="../css/default.css" rel="stylesheet" type="text/css">
<style>
	table{
		width : 800px;
		margin : auto;
	}
	h1{
		text-align: center;
	}
	td{
		border : 1px dotted gray;
	}
</style>
</head>
<body>


<header>
	<div class="logo"><a href="../member/main.jsp"><img src="../img/movie.png"></a></div>
	
	</header>
	<div><a href="../member/logout.jsp" id="logout" onclick="return logoutCheck()">로그아웃</a> | <a href="../member/beforeMyInfo.jsp">회원정보 조회</a></div>
	<nav>
	<ul>
		<li><a href="../member/main.jsp">HOME</a></li>
		<li><a href="../board/boardList.jsp">리뷰게시판</a></li>
		<li><a href="../board/theatherMap.html">영화관 검색</a></li>
		<li><a href="../mail/mailForm.jsp">Contact Us</a></li>
	</ul>
</nav>



<form action="mailSend.jsp" method="post">
<h1>Contact Us</h1>
<div>
<h2></h2>
</div>
<table>
	<tr><td>답변 받으실 메일 : </td><td><input type="text" name="sender" style="width:500px;"></td></tr>
	<tr><td>받는 사람 메일 : </td><td><input type="text" name="receiver" value="kjw5263@naver.com" readonly  style="width:500px;"></td></tr>
	<tr><td>제목 : </td><td><input type="text" name="subject" style="width:500px;"></td></tr>
	<tr>
		<td>내용 : </td>
		<td><textarea name="content" cols=60 rows=20></textarea></td>
	</tr>
	<tr><td align=center colspan=2><input type="submit" value="보내기"></td></tr>
</table>
</form>


<jsp:include page="../inc/footer.jsp" />
</body>
</html>
