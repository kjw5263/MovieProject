function logoutCheck() {
		var check = confirm("정말 로그아웃 하시겠습니까?");
		if(check == true){
			location.href="../member/logout.jsp";
		} else {
			return false;
		}
	}
	/**
 * 
 */