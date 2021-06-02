<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원정보 조회 본인확인</title>
<link href="../css/default.css" rel="stylesheet" type="text/css">
<link href="../css/info.css" rel="stylesheet" type="text/css">
<script src="../js/logoutCheck.js"></script>
</head>
<body>

<!-------------------------------헤더 ------------------------------------->
<header>
<div class="logo"><a href="main.jsp"><img src="../img/movie.png"></a></div>
</header>
	
<!--*********************************세션 처리************************************-->
	<%
		request.setCharacterEncoding("UTF-8");
		String user_id = (String)session.getAttribute("user_id");
		String user_nickname = (String)session.getAttribute("user_nickname");
		System.out.println("[beforeMyInfo.jsp] 아이디/닉넴 세션 : " +user_id + "/" + user_nickname);
		if(user_id == null || user_nickname == null){
			System.out.println("id/nickname : " +user_id +"/"+user_nickname);
			System.out.println("[beforeMyInfo.jsp] 로그인 세션 만료");
			session.invalidate();
			response.sendRedirect("loginForm.jsp");
		}
		
	%>
	
	
	
<a id="logout" href="logout.jsp" onclick="return logoutCheck()">로그아웃</a> | <a id="memberJoin" href="beforeMyInfo.jsp">회원정보 조회</a>
<h4><%=user_nickname %>님, 환영합니다.</h4>

<!--*********************************메뉴 바***********************************-->
<nav>
	<ul>
		<li><a href="main.jsp">HOME</a></li>
		<li><a href="../board/boardList.jsp">리뷰게시판</a></li>
		<li><a href="../board/theatherMap.html">영화관 검색</a></li>
		<li><a href="../mail/mailForm.jsp">Contact Us</a></li>
	</ul>
</nav>



<!--*****************************정보 수정 본인확인 비밀번호 입력폼************************************-->
	<div class="checkPwForm">
	<div><h2>회원정보 조회 본인확인</h2></div>
	<div><form action="MyInfo.jsp" method="post">
		<input type="hidden" name="user_id" placeholder="아이디" value="<%=user_id %>"> <br>
		<label>비밀번호 <input type="password" name="user_pw" placeholder="비밀번호"></label><br><br>
		<div><input type="submit" value="확인"><input type="button" value="취소" onclick="history.back()"></div>
	</form>
	</div>
	</div>
	
	
	
	
	
<!--*********************************푸터************************************-->	
	<footer>
	<hr>
	<div id="copy">
	Contact  Mail kjw5263@naver.com | Tel 010-9989-5263 | FAX 051-123-456 <br>
	 Copyright (c) 2021. Ma Movie Diary. All rights reserved <br>
	 </div>
	<div id="social">
	<a href="https://www.instagram.com/ddi5niii/"><img src="../img/instagram-2.png" alt="instagram" ></a>
	<a href="https://www.facebook.com/"><img src="../img/facebook.png" alt="facebook"></a>
	</div>
	</footer>
</body>
</html>