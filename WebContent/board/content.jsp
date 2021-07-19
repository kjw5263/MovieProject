<%@page import="java.util.ArrayList"%>
<%@page import="com.movie.board.ReplyBean"%>
<%@page import="java.net.URLEncoder"%>
<%@page import="java.io.FileInputStream"%>
<%@page import="com.movie.board.BoardDAO"%>
<%@page import="com.movie.board.BoardBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시물</title>
<link href="../css/default.css" rel="stylesheet" type="text/css">
<link href="../css/content.css" rel="stylesheet" type="text/css">
<script src="../js/logoutCheck.js"></script>
<script type="text/javascript">
	function onSubmitReply() {
		var replyTextArea = document.getElementById("replyTextArea").value;
		if(replyTextArea == ""){
			alert("댓글을 입력하세요.");
			return false;
		}
	}
</script>
</head>
<body>

<header>
	<div class="logo"><a href="../member/main.jsp"><img src="../img/movie.png"></a></div>
	
	</header>
<%


	request.setCharacterEncoding("UTF-8");
	String user_id = (String)session.getAttribute("user_id");
	if(user_id == null){
		System.out.println("게시물 수정 세션 없음 ");
		response.sendRedirect("../member/main.jsp");
	}
	System.out.println("게시물 세션 : " + user_id);

	int board_num = Integer.parseInt(request.getParameter("board_num"));
	String pageNum = request.getParameter("pageNum");
	
	BoardDAO bdao = new BoardDAO();
	
	
	// ** 쿠키 설정 해주기 ** //
	Cookie[] cookies = request.getCookies();
	Cookie viewCookie = null;
	
	if(cookies != null && cookies.length > 0){
		for(int i=0; i<cookies.length; i++){
			if(cookies[i].getName().equals(user_id + "_cookie"+board_num)){
				System.out.println("처음 쿠키 생성한 뒤 들어옴");
				viewCookie = cookies[i];
			}
		}
	}
	
	if(viewCookie == null){
		Cookie newCookie = new Cookie(user_id + "_cookie" + board_num, "|"+board_num+"|");
		response.addCookie(newCookie);
		int result = bdao.updateReadCount(board_num);
		if(result == 1 ){
			System.out.println("조회수증가 : "+ result);
		} else {
			System.out.println("조회수 증가 에러 ");
		}
	} else {
		System.out.println("쿠키 있음 ");
		System.out.println("쿠키값은 : " + viewCookie.getValue());
	}
	
	
	
	// bdao.updateReadCount(num);
	
	BoardBean boardBean = bdao.getBoard(board_num);
	System.out.println(boardBean.toString());
	String movieData = boardBean.getMovieData().replace("\n", "<br>");
	String content = boardBean.getContent().replace("\n", "<br>");
	String user_id2 = boardBean.getUser_id();
	if(user_id2 == null){
		user_id2 = "(알 수 없는 사용자)";
	}
	
	ArrayList<ReplyBean> reArr = bdao.getReply(board_num);
	
%>
<div><a href="../member/logout.jsp" id="logout" onclick="return logoutCheck()">로그아웃</a> | <a href="../member/beforeMyInfo.jsp">회원정보 조회</a></div>
<nav>
	<ul>
		<li><a href="../member/main.jsp">HOME</a></li>
		<li><a href="boardList.jsp">리뷰게시판</a></li>
		<li><a href="theatherMap.html">영화관 검색</a></li>
		<li><a href="../mail/mailForm.jsp">Contact Us</a></li>
	</ul>
</nav>

<table border="1">
	
	<tr class="table-title">
		<th class="title">번호</th>
		<td class="title-next"><%=boardBean.getBoard_num() %></td>
		<th rowspan="2" class="title">포스터</th>
		<td rowspan="2" class="poster"><a href="<%=boardBean.getMovieLink()%>" target="_blank"><img src="<%=boardBean.getImgLink()%>" title="영화 정보 페이지로 이동합니다." onerror="this.src='../img/unnamed.png'"></a></td>
	</tr>
	<tr>
		<th class="title">글쓴이</th>
		<td><%=user_id2 %></td>
		
	</tr>
	<tr>
		<th class="title">첨부파일</th>
		<td>
		<%
			if(boardBean.getFileName()==null){
				%>
				-
				<%
			} else {
				%>
				<a href="fileDown.jsp?fileName=<%=boardBean.getFileName()%>"><%=boardBean.getFileName() %></a>
				<%
			}
		%></td>
		<th class="title">상세정보</th>
		<td><%=movieData %><br>제작연도 - <%=boardBean.getPubDate() %></td>
	</tr>
	<tr>
		<th class="title">제목</th>
		<td colspan="3">
			<%if(boardBean.getSelectType().equals("1")) {%> <span style="color:#7de848; font-weight:bold" >[ 추천해요 ]</span>
			<%} else if(boardBean.getSelectType().equals("0")){ %><span style="color:grey; font-weight:bold">[ 그저그래요 ]</span>
			<%} else if(boardBean.getSelectType().equals("-1")) {%> <span style="color:orange; font-weight:bold">[ 별로예요 ]</span>
			<% }%>
		<%=boardBean.getTitle() %></td>
	</tr>
	<tr>
		<td colspan="4" height="300px" class="content-td"><%=content %></td>
	</tr>
	<tr>
		<th>작성날짜</th>
		<td><%=boardBean.getDate() %>
		<th>조회수</th>
		<td><%=boardBean.getReadcount() %></td>
	</tr>
	

</table>

 <div class="content-btn"><input type="button" value="목록으로" onclick="location.href='boardList.jsp?pageNum=<%=pageNum%>'">
 
 <%
 	if(user_id.equals(boardBean.getUser_id())){
 		%>
 			<script type="text/javascript">
 				function onupdate() {
 					var check = confirm("게시물을 수정하시겠습니까?");
 					if(check == true){
 						location.href='updateForm.jsp?board_num=<%=boardBean.getBoard_num()%>&pageNum=<%=pageNum%>';
 					}
 				}
 				
 				function ondelete() {
 					var check = confirm("게시물을 삭제하시겠습니까? '확인'을 누르면 게시물이 삭제되며, 다시 되돌릴 수 없습니다.");
 					if(check == true){
 						location.href='deletePro.jsp?board_num=<%=boardBean.getBoard_num()%>&pageNum=<%=pageNum%>';
 					}
 				}
 			
 			</script>
 			<input type="button" value="수정" onclick="onupdate()">
 			<input type="button" value="삭제" onclick="ondelete()">
 			
 		<%
 	}
 
 %>
 
 	</div>
 
 
 	<div>
 	<form action="replyPro.jsp" method="post" onsubmit="return onSubmitReply()">
 		
 		<table>
 			<tr >
 				<td class="Retitle">댓글번호 </td>
 				<td class="Retitle">작성자</td>
 				<td class="Retitle">댓글내용</td>
 				<td class="Retitle">댓글 작성 시간</td>
 				<td class="Retitle">삭제</td>
 			</tr>
 			<%
 				if(reArr.size() == 0){
 				%>
 					<tr>
 						<td colspan="5" id="noReply">댓글이 없습니다. 첫 댓글을 남겨주세요! </td>
 					</tr>
 				<%
 				} else {
 					for(int i=0; i<reArr.size(); i++){
 						%>
 							<tr>
 								<td class="replyContent"><%=(i+1) %></td>
 								<td class="replyContent"><%=reArr.get(i).getUser_id() %></td>
 								<td><%=reArr.get(i).getReplyTextArea() %></td>
 								<td class="replyContent"><%=reArr.get(i).getReply_date() %></td>
 								<td class="replyContent"><input type="button" value="삭제" onclick="location.href='reDelete.jsp?reply_num=<%=reArr.get(i).getReply_num()%>&board_num=<%=boardBean.getBoard_num()%>&pageNum=<%=pageNum%>'"></td>
 							</tr>
 						<%
 					}
 				}
 			%>
 			<tr >
 				<td>댓글 작성</td>
 				<td><%=user_id%></td>
 				<td colspan="2" class="replyContent">
 					<input type="hidden" name="user_id" value="<%=user_id%>">
 					<input type="hidden" name="pageNum" value="<%=pageNum%>">
 					<input type="hidden" name="board_num" value="<%=boardBean.getBoard_num() %>">
 					<textarea rows="5" cols="150" name="replyTextArea" id="replyTextArea"></textarea>
 				</td>
 				<td class="replyContent"><input type="submit" value="댓글 남기기" ></td>
 			</tr>
 		</table>
 		</form>
 		
 	
 	</div>
 	
 	
 	
 	
	<!-- footer 시작 -->
 		<jsp:include page="../common/footer.jsp" />
	<!-- footer 끝 -->

</body>
</html>