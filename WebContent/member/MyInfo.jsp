<%@page import="com.movie.member.MemberBean"%>
<%@page import="com.movie.member.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원정보 조회</title>
<link href="../css/default.css" rel="stylesheet" type="text/css">
<!-- 다음 우편번호 조회 API -->
<script src="../js/jquery-3.6.0.js"></script>
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<script src="../js/address.js"></script>

<!-- 이메일 중복체크 팝업 -->
<!-- <script src="../js/joinCheck.js"></script> -->


<!-- 비밀번호 입력 체크 -->
<script type="text/javascript">
$(document).ready(function(){
	$('input[type=password]').keyup(function(){
		var p1 = $("#user_pw_check").val();
		var p2 = $("#user_pw_new").val();
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
	
	$("#field1").show();
	$("#field2").hide();
	$("#field3").hide();
	
	$('#list1').click(function(){
		$("#field1").show(400);
		$("#field2").hide(400);
		$("#field3").hide(400);

	});
	
	$('#list2').click(function(){

		$("#field2").show(400);
		$("#field3").hide(400);
		$("#field1").hide(400);
		


	});
	
	$('#list3').click(function(){
		$("#field3").show(400);
		$("#field1").hide(400);
		$("#field2").hide(400);
		

	});
	

	
});


function onUpdate() {
	var name = document.ufr.user_name.value;
	var nickname = document.ufr.user_nickname.value;
	var zonecode = document.ufr.zonecode.value;
	var addr = document.ufr.addr.value;
	var addr_detail = document.ufr.addr_detail.value;
	if(name == ""){
		alert("이름은 필수입력 항목입니다.");
		return false;
	}
	
	if(nickname ==""){
		alert("닉네임은 필수입력 항목입니다.");
		return false;
	}
	
	if(zonecode == "" || addr == null || addr_detail == null){
		alert("주소 정보를 모두 입력해주세요.");
		return false;
	}
	
	
}

function onPassUpdate() {
	var pw0 = document.ufr2.user_pw2.value;
	var pw1 = document.ufr2.user_pw_check.value;
	var pw2 = document.getElementById("user_pw_new").value;
	
	if(pw0.length =="" || pw1.length =="" || pw2.length==""){
		alert("비밀번호는 필수입력 항목입니다.")
		return false;
	} 
	if(pw1 != pw2){
		alert("비밀번호가 일치하지 않습니다.");
		
		return false;
	}
	if(pw0.length < 8 || pw1.length < 8 || pw2.length < 8){
		alert("비밀번호는 최소 8자 입력해야 합니다.");
		return false;
	}
	if (pw0.indexOf(" ") != -1 || pw1.indexOf(" ") != -1 || pw2.indexOf(" ") != -1)  {
		alert("비밀번호에 공백을 포함할 수 없습니다.");
		return false;
	}
	
}

function onDelete() {
	var id = document.ufr3.user_id3.value;
	var pw = document.ufr3.user_pw3.value;
	
	if(id == "" || pw.length  == ""){
		alert("아이디와 비밀번호는  필수입력 항목입니다.");
		return false;
	}
}

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
	String user_pw = request.getParameter("user_pw");
	System.out.println("[MyInfo] 아이디/닉넴 세션 : " +user_id + "/" + user_nickname);
	if(user_id == null || user_nickname == null){
		System.out.println("[MyInfo.jsp] 로그인 세션 만료");
		response.sendRedirect("loginForm.jsp");
		session.invalidate();
	}

%>
	
	<a href="logout.jsp">로그아웃</a>

<a href="beforeMyInfo.jsp">회원정보 조회</a>
<nav>
	<ul>
		<li><a href="main.jsp">HOME</a></li>
		<li><a href="../board/boardList.jsp">리뷰게시판</a></li>
		<li><a href="#">무슨게시판</a></li>
		<li><a href="#">Contact Us</a></li>
	</ul>
</nav>

<br><br>
	<nav>
		<ul>
		  <li id="list1"><span>회원정보 수정</span></li>
		  <li id="list2"><span>비밀번호 변경</span></li>
		  <li id="list3"><span>회원 탈퇴</span></li>
		</ul>
		</nav>
	



	<jsp:useBean id="memberBean" class="com.movie.member.MemberBean"/>
	<jsp:setProperty property="*" name="memberBean"/>
	

<%
	MemberDAO mdao = new MemberDAO();
	MemberBean mb = mdao.checkBeforeInfo(memberBean);
	System.out.println(mb);
	if(mb == null){
		%>
			<script type="text/javascript">
				alert("잘못된 접근입니다. 다시 시도해주세요.");
				location.href="main.jsp";
			</script>
		<%
	} else if(mb != null ){
		String addr = mb.getAddr();
		System.out.println(addr);
		int idx = addr.indexOf("+");
		String addr1 = addr.substring(0,idx);
		String addr2 = addr.substring(idx+1);
		System.out.println("[MyInfo22222] 아이디/닉넴 세션 : " +user_id + "/" + user_nickname);
		%>
		
		
		
		<br><br><br><br><br><br>
		
		
		
			<form action="updateInfoPro.jsp" method="post" name="ufr" onsubmit="return onUpdate()"  id="field1">
 				<label>아이디 <input type="text" name="user_id"  id="user_id" value="<%=mb.getUser_id() %>" readonly></label><br>
				<input type="hidden" name="user_pw" id="user_pw" value="<%=user_pw%>">
				<label>이메일 <input type="text" name="user_email" id="user_email" value="<%=mb.getUser_email() %>" readonly></label><br>
				<label>이름<input type="text" name="user_name" id="user_name" value="<%= mb.getUser_name()%>"></label>   <br>
				<label>닉네임<input type="text" name="user_nickname" id="user_nickname" value="<%=mb.getUser_nickname() %>"> </label><br>
				
				<!-- 다음 우편번호 api -->
				<label> 주소 <br>
				<input type="text" id="zonecode" name="zonecode" value="<%=mb.getZonecode() %>" readonly>
				<input type="button" id="addr_btn" value="주소 찾기" onclick="openAddrPop()"> <br>
				<input type="text" id="addr" name="addr" value="<%=addr1 %>" readonly> <br>
				<input type="text" id="addr_detail" name="addr_detail" value="<%=addr2 %>"> <br><br>
				</label>
				
				<input type="submit" value="수정하기">

			</form>
			
			
			
			<form action="updatePassPro.jsp" method="post" name="ufr2" onsubmit="return onPassUpdate()"  id="field2">
				<input type="hidden" name="user_id2" value="<%=user_id%>">
				<label>현재 비밀번호 <input type="password" name="user_pw2" id="user_pw2" placeholder="현재 비밀번호"></label><br>
				<label>새 비밀번호 <input type="password" name="user_pw_check" id="user_pw_check" placeholder="새 비밀번호"></label><br>
				<label>새 비밀번호 확인 <input type="password" id="user_pw_new" placeholder="새 비밀번호 확인"></label><br>
				<div id="alert-passcheck"></div>
				
				
				<input type="submit" value="변경하기">

			</form>



			<form action="deletePro.jsp" method="post" name="ufr3" onsubmit="return onDelete()"  id="field3">
				<h2> 정말 탈퇴하시겠어요? 	&#59;&#45;&#40; </h2>
<!-- 				<h5> 탈퇴 사유를 적어주세요. </h5> -->
<!-- 				<textarea></textarea> -->
				<label>아이디 <input type="text" name="user_id3" id="user_id3" placeholder="아이디"></label><br>
				<label>비밀번호 <input type="password" name="user_pw3" id="user_pw3" placeholder="비밀번호"></label><br>
				
				
				<input type="submit" value="회원탈퇴" >	

			</form>

	<%
		
	}
		
%>


<div class="goMain">
<input type="button" value="메인으로" onclick="location.href='main.jsp'">
</div>



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