<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>마무다 메인</title>

<link href="https://fonts.googleapis.com/css2?family=Nanum+Gothic:wght@400;700;800&display=swap" rel="stylesheet">
<link href="../css/default.css" rel="stylesheet" type="text/css">
<link href="../css/main.css" rel="stylesheet" type="text/css">
<script src="../js/logoutCheck.js"></script>
<script src="../js/jquery-3.6.0.js"></script>
<script src="../js/jquery.innerfade.js"></script>
<script type="text/javascript">
	/* 메인 화면의 이미지 받아오기 */
	$(function() {
		$.ajax({
			type:'get',
			url:'../json/recommandMovie.json',
			dataType:'json',
			success:function(data){
				$.each(data, function(){
					var t = "";
					t += '<li><img class="posterImg" src="' + this.imglink + '"></li>';
					$('.slidePage').append(t);
				});
				
				/* 이미지 애니매이션 주기 */
				$('.slidePage').innerfade({
					animationtype: "fade",
					speed:500,
					type:"random"
				});
			}
		});
	});
</script>
</head>
<body>

<header>
	<div class="logo"><a href="main.jsp"><img src="../img/movie.png"></a></div>
</header>

<%
	request.setCharacterEncoding("UTF-8");
	String user_id = (String)session.getAttribute("user_id");
	String user_nickname = (String)session.getAttribute("user_nickname");
	System.out.println("[Main] 아이디/닉넴 세션 : " +user_id + "/" + user_nickname);
		
	if(user_id == null || user_nickname == null){
		System.out.println("[Main.jsp] 로그인 세션 만료 ");
		response.sendRedirect("loginForm.jsp");
		session.invalidate();
	}

	
%>


<div class="infoTag"><a href="logout.jsp" id="logout" onclick="return logoutCheck()">로그아웃</a> | <a id="memberJoin" href="beforeMyInfo.jsp">회원정보 조회</a> </div>
<nav>
	<ul>
		<li><a href="main.jsp">HOME</a></li>
		<li><a href="../board/boardList.jsp">리뷰게시판</a></li>
		<li><a href="../board/theatherMap.html">영화관 검색</a></li>
		<li><a href="../mail/mailForm.jsp">Contact Us</a></li>
	</ul>
</nav>


<div class="welcome"><h1><%=user_nickname %>님, 환영합니다!</h1></div>
<div class="howabout"><h3>오늘은 이런 영화, 어떠세요?</h3></div>


<!---------------  위 script에서 ajax로 사진 받아와 뿌려주는 영역 ---------------->
<div class="divPage" >
	<ul class="slidePage"> 
	</ul>
</div>
	
	
<!------------------------------헤더------------------------------------->
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