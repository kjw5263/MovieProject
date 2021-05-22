<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>마무다(MAMUDA) 로그인</title>
<link href="../css/default.css" rel="stylesheet">
<link rel="preconnect" href="https://fonts.gstatic.com">
<link href="https://fonts.googleapis.com/css2?family=Nanum+Gothic:wght@400;700;800&display=swap" rel="stylesheet">

<script type="text/javascript">

<!--  처음 들어왔을 때나, 회원가입 취소를 통해 들어왔을 때 자동으로 포커스 주는 방법? -->

function login_Check() {
	var idCheck = document.login_fr.user_id.value;
	var pwCheck = document.login_fr.user_pw.value;
	if(idCheck == ""){
		alert("아이디를 입력하세요.");
		document.login_fr.user_id.focus();
		return false;
	}
	if(pwCheck== ""){
		alert("비밀번호를 입력하세요.");
		document.login_fr.user_id.focus();
		return false;
	}
}
	

</script>
</head>
<body>


<header>
	<div class="logo"><img src="../img/movie.png"></div>
	
</header>

<h1> 로그인 </h1>

   <form action="loginPro.jsp" method="post" name="login_fr" onsubmit="return login_Check()">
   
   	<input type="text" name="user_id"  placeholder="아이디" >			<br>
   	<input type="password" name="user_pw"  placeholder="비밀번호" >		<br>
   	
   	<input type="submit" value="로그인">		<br>
   	
   	<p>처음 방문하셨나요? <a href="joinForm.jsp">회원가입</a></p>
   	
   	
   
   </form>
   
   
   
   
   
   
   
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