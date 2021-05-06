<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>마뮤다 회원가입</title>
<link href="/css/font.css" rel="stylesheet">
<link rel="preconnect" href="https://fonts.gstatic.com">
<link href="https://fonts.googleapis.com/css2?family=Nanum+Gothic:wght@400;700;800&display=swap" rel="stylesheet">

<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
	
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

	
</head>
<body>
	
	
	
	
	<h2> 회원가입 </h2>
	<form action="joinPro.jsp" method="post">
	
	<input type="text" name="user_id" placeholder="아이디"><br>
	<input type="text" name="user_name" placeholder="성명"><br>
	<input type="password" name="user_pw" placeholder="비밀번호"><br>
	<input type="password" name="user_pw_check" placeholder="비밀번호 확인"><br>
	<input type="text" name="user_email" placeholder="이메일"><br><br>
	
	<!-- 다음 우편번호 api -->
	<input type="text" id="zonecode" name="zonecode" placeholder="우편번호" readonly>
	<input type="button" id="addr_btn" value="주소 찾기" onclick="openAddrPop()"> <br>
	<input type="text" id="addr" name="addr" placeholder="주소" readonly> <br>
	<input type="text" id="addr_detail" name="addr_detail" placeholder="상세주소"> <br><br>
	
	<hr>
	
	
	
	
	
	<input type="button" value="취소" onclick="location.href='loginForm.jsp'"> 
	<input type="submit" value="가입하기">
	
	
	</form>
	
</body>
</html>