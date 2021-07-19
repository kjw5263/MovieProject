<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>마무다(MAMUDA) 로그인</title>
<link href="../css/default.css" rel="stylesheet">
<link href="../css/login.css" rel="stylesheet">
<link rel="preconnect" href="https://fonts.gstatic.com">
<link href="https://fonts.googleapis.com/css2?family=Nanum+Gothic:wght@400;700;800&display=swap" rel="stylesheet">

<script type="text/javascript">

/* 아이디, 비밀번호 공백 불가 */
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

<!--------- 헤더 ---------------->
<header>
	<div class="logo"><a href="../index.jsp"><img src="../img/movie.png"></a></div>
</header>


<div class="loginAll">
<div class="loginTitle"><h1> 로그인 </h1></div>
 <div class="login-Form">
   <form action="loginPro.jsp" method="post" name="login_fr" onsubmit="return login_Check()">
   	<input type="text" name="user_id"  placeholder="아이디" >			<br>
   	<input type="password" name="user_pw"  placeholder="비밀번호" >		<br>
   	<div class="loginButton"><input type="submit" value="로그인">	</div>
   	<div class="join-p-tag"><p>처음 방문하셨나요? <a href="joinForm.jsp">회원가입</a></p></div>
   </form>
 </div>
</div>
   
   


<!--------- 푸터 ---------------->
<!-- footer 시작 -->
 		<jsp:include page="../common/footer.jsp" />
	<!-- footer 끝 -->
	
	
	
	
</body>
</html>