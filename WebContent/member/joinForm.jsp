<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>마무다(MAMUDA) 회원가입</title>
<link href="../css/font.css" rel="stylesheet">
<link rel="preconnect" href="https://fonts.gstatic.com">
<link href="https://fonts.googleapis.com/css2?family=Nanum+Gothic:wght@400;700;800&display=swap" rel="stylesheet">

<!--  다음 우편번호 API -->
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<script src="../js/jquery-3.6.0.js"></script>
<script>
function openAddrPop() {
    new daum.Postcode({
        oncomplete: function(data) {
            // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

            // 각 주소의 노출 규칙에 따라 주소를 조합한다.
            // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
            var fullAddr = ''; // 최종 주소 변수
            var extraAddr = ''; // 조합형 주소 변수

            // 사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
            if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                fullAddr = data.roadAddress;

            } else { // 사용자가 지번 주소를 선택했을 경우(J)
                fullAddr = data.jibunAddress;
            }

            // 사용자가 선택한 주소가 도로명 타입일때 조합한다.
            if(data.userSelectedType === 'R'){
                //법정동명이 있을 경우 추가한다.
                if(data.bname !== ''){
                    extraAddr += data.bname;
                }
                // 건물명이 있을 경우 추가한다.
                if(data.buildingName !== ''){
                    extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                }
                // 조합형주소의 유무에 따라 양쪽에 괄호를 추가하여 최종 주소를 만든다.
                fullAddr += (extraAddr !== '' ? ' ('+ extraAddr +')' : '');
            }

            // 우편번호와 주소 정보를 해당 필드에 넣는다.
            document.getElementById('zonecode').value = data.zonecode; //5자리 새우편번호 사용
            document.getElementById('addr').value = fullAddr;

            // 커서를 상세주소 필드로 이동한다.
            document.getElementById('addr_detail').focus();
        }
    }).open();
}
</script>

<!-- 아이디 중복체크, 이메일 중복체크, 비밀번호 확인 여부 체크 -->
<script src="../js/joinCheck.js"></script>

<!-- 회원가입 항목 입력 여부 체크 -->
<script type="text/javascript">

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
	}else if(pw1 != pw2){
		alert("비밀번호가 일치하지 않습니다.");
	} else if (pw1.indexOf(" ") != -1){
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
	
	
	
	
	<h2> 회원가입 </h2>
	<form action="joinPro.jsp" method="post" name="joinfr" onsubmit="return submitCheck()">
<!-- 	<input type="hidden" name="privacy_agree" value="1"> -->
	<input type="text" name="user_id"  id="user_id" placeholder="아이디" >
	<input type="button" value="중복확인" onclick="return IDdup_check()"><br>
	<input type="text" name="user_name" id="user_name" placeholder="성명"><br>
	<input type="password" name="user_pw" id="user_pw" placeholder="비밀번호"><br>
	<input type="password" name="user_pw_check" id="user_pw_check" placeholder="비밀번호 확인">
	<div id="alert-passcheck"></div>
	<input type="text" name="user_nickname" id="user_nickname" placeholder="닉네임"><br>
	<input type="text" name="user_email" id="user_email" placeholder="이메일">
	<input type="button" value="중복확인" onclick="return EMdup_check()"><br><br>
	
	<!-- 다음 우편번호 api -->
	<input type="text" id="zonecode" name="zonecode" placeholder="우편번호" readonly>
	<input type="button" id="addr_btn" value="주소 찾기" onclick="openAddrPop()"> <br>
	<input type="text" id="addr" name="addr" placeholder="주소" readonly> <br>
	<input type="text" id="addr_detail" name="addr_detail" placeholder="상세주소"> <br><br>
	
	<hr>
	
	
	
	
	<!-- 나중에 주의할 사항 : 로그인창에서 바로 회원가입 창으로 진입한경우 back() 하면 어떻게 되나? 
		-> 로그인  페이지로 이동 됨  -->
	<input type="button" value="취소" onclick="history.back()"> 
	<input type="submit" value="가입하기">
	
	
	</form>
	
</body>
</html>