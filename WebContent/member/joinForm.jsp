<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>마무다(MAMUDA) 회원가입</title>
<link href="../css/default.css" rel="stylesheet" type="text/css">
<link href="../css/login.css" rel="stylesheet" type="text/css">

<!--  다음 우편번호 API -->
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<script src="../js/jquery-3.6.0.js"></script>
<script src="../js/address.js"></script>

<!-- 팝업 : 아이디 중복체크, 이메일 중복체크, 비밀번호 확인 여부 체크 -->
<script src="../js/joinCheck.js"></script>


<script type="text/javascript">

<!-- 비밀번호 일치여부 -->
$(function(){
	$('input[type=password]').keyup(function(){
		var p1 = $("#user_pw").val();
		var p2 = $("#user_pw_check").val();
		if(p1 != "" || p2 != "" ){
			if(p1.length < 8){
				$("#alert-passcheck").html("비밀번호는 8~16자리로 입력해야 합니다.");
				$("#alert-passcheck").css('color', 'red');
			} else if (p1 == p2){
				$("#alert-passcheck").html("비밀번호가 일치합니다.");
				$("#alert-passcheck").css('color', 'green');
			} else if (p1 != p2){
				$("#alert-passcheck").html("비밀번호가 일치하지 않습니다.");
				$("#alert-passcheck").css('color', 'red');
			} 
		}
		
	});
	
});

<!-- 회원가입 항목 입력 여부 체크 -->
function submitCheck() {
	var pw1 = document.joinfr.user_pw.value;
	var pw2 = document.joinfr.user_pw_check.value;
	if(document.joinfr.user_id.value == ""){
		alert("아이디는 필수입력 항목입니다.");
		return false;
	}
	if(document.getElementById("user_id").readOnly == false){
		alert("아이디 중복체크를 해주세요.");
		return false;
	}
	
	if(pw1== "" || pw2==""){
		alert("비밀번호는 필수입력 항목입니다.");
		return false;
	}
	if(pw1 != pw2){
		alert("비밀번호가 일치하지 않습니다.");
		return false;
	}
	if(pw1.length < 8 || pw2.length < 8){
		alert("비밀번호는 최소 8자 이상 입력해야 합니다.");
		return false;
	}
	if (pw1.indexOf(" ") != -1){
		alert("비밀번호에 공백을 포함할 수 없습니다.");
		pw1.trim();
		return false;
	}
	
	if(document.joinfr.user_name.value == ""){
		alert("이름은 필수입력 항목입니다.");
		return false;
	}
	
	if(document.joinfr.user_email.value == ""){
		alert("이메일은 필수입력 항목입니다.");
		return false;
	} else {
		var email = document.joinfr.user_email.value;
		  
	    if(email.indexOf("@") == -1 || email.indexOf(".") == -1 ||email.indexOf("@") < 5 || email.indexOf("@")>email.indexOf(".")){
		  alert("이메일 형식이 잘못되었습니다. example@mamuda.com 형식으로 입력하세요.");
	  	  return false;
	    }
	}
	
	if(document.getElementById("user_email").readOnly == false){
		alert("이메일 중복체크를 해주세요.");
		return false;
	}
	
	
	if(document.getElementById("user_nickname").value == ""){
		alert("닉네임은 필수입력 항목 입니다.");
		return false;
	}
	
	if(document.joinfr.zonecode.value == "" || document.joinfr.addr.value== ""|| document.joinfr.addr_detail.value == "" ){
		alert("주소는 필수입력 항목입니다.");
		return false;
	}
}

</script>

	
</head>
<body>
	
	<header>
	<div class="logo"><a href="loginForm.jsp"><img src="../img/movie.png"></a></div>
	
</header>
	
	
	<div class="joinForm">
	<div class="joinFormTitle"><h2> 회원가입 </h2></div>
	<form action="joinPro.jsp" method="post" name="joinfr" onsubmit="return submitCheck()">
<!-- 	<input type="hidden" name="privacy_agree" value="1"> -->
	<input type="text" name="user_id"  id="user_id" placeholder="아이디" >
	<input type="button" value="중복확인" onclick="return IDdup_check()"><br>
	<input type="text" name="user_email" id="user_email" placeholder="이메일">
	<input type="button" value="중복확인" onclick="return EMdup_check()"><br><br>
	<input type="text" name="user_name" id="user_name" placeholder="성명"><br>
	<input type="password" name="user_pw" id="user_pw" placeholder="비밀번호"><br>
	<input type="password" name="user_pw_check" id="user_pw_check" placeholder="비밀번호 확인">
	<div id="alert-passcheck"></div>
	<input type="text" name="user_nickname" id="user_nickname" placeholder="닉네임"><br>
	
	
	<!-- 다음 우편번호 api -->
	<input type="text" id="zonecode" name="zonecode" placeholder="우편번호" readonly>
	<input type="button" id="addr_btn" value="주소 찾기" onclick="openAddrPop()"> <br>
	<input type="text" id="addr" name="addr" placeholder="주소" readonly> <br>
	<input type="text" id="addr_detail" name="addr_detail" placeholder="상세주소"> <br><br>
	
	
	
	
	
	<!-- 나중에 주의할 사항 : 로그인창에서 바로 회원가입 창으로 진입한경우 back() 하면 어떻게 되나? 
		-> 로그인  페이지로 이동 됨  -->
	<div class="joinFormBtn"><input type="button" value="취소" onclick="history.back()"> 
	<input type="submit" value="가입하기"></div>
	
	
	</form>
	</div>
	
	
	<!-- footer 시작 -->
 		<jsp:include page="../common/footer.jsp" />
	<!-- footer 끝 -->
	
</body>
</html>