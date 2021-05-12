
// 작업창을 제외한 화면 크기 구하기 : screen.availWidth
		// 중앙에 띄우기 위해 2로 나눈다
		var ScreenWidth = screen.availWidth/2;
		var ScreenHeight = screen.availHeight/2;
		var width=500;
		var height=300;
		ScreenWidth = ScreenWidth - width/2;
		ScreenHeight = ScreenHeight - height/2;


function IDdup_check() {
		if(document.joinfr.user_id.value == ""){
			alert("아이디를 입력하세요");
			document.joinfr.user_id.focus();
			return false;
		}
		
		
		var id = document.joinfr.user_id.value;
		// 팝업창 화면 가운데에 띄우기
		window.open('IDdup_check.jsp?user_id='+id, '아이디 중복체크', 'width='+width+', height='+ height + ', left='+ ScreenWidth+', top=' + ScreenHeight);
		
	}
	
function EMdup_check() {
		var email = document.joinfr.user_email.value;
		if(email ==""){
			alert("이메일을 입력하세요.");
			document.joinfr.user_email.focus();
			return false;
		} else {
		    if(email.indexOf("@") == -1 || email.indexOf(".") == -1 ||email.indexOf("@") < 5 || email.indexOf("@")>email.indexOf(".")){
			  alert(" 이메일 형식이 잘못되었습니다. example@mamuda.com 형식으로 입력하세요.");
		  	  return false;
		    }
		}
		
		// 팝업창 화면 가운데에 띄우기
		window.open('EMdup_check.jsp?user_email='+email, '이메일 중복체크', 'width='+width+', height='+ height + ', left='+ ScreenWidth+', top=' + ScreenHeight);
}
	

