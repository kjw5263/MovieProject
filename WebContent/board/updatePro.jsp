<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="com.movie.board.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로딩 중...</title>
</head>
<body>
<%
	request.setCharacterEncoding("UTF-8");
	String pageNum = request.getParameter("pageNum");
	String user_id = (String)session.getAttribute("user_id");
	
	String realPath = request.getRealPath("/upload");
	String ip = request.getRemoteAddr();
	System.out.println("실제 저장위치 : " + realPath);
	
	int maxSize = 10*1024*1024;
	
	// 파일 업로드 
	MultipartRequest multi = new MultipartRequest(request, realPath, maxSize, "UTF-8", new DefaultFileRenamePolicy());
	
	System.out.println("파일 시스템에 파일 업로드 완료 !");
%>

 <jsp:useBean id="boardBean" class="com.movie.board.BoardBean"/>
   <jsp:setProperty property="*" name="boardBean"/>
   
   <%
   
   boardBean.setIp(request.getRemoteAddr());
   boardBean.setBoard_num(Integer.parseInt(multi.getParameter("board_num")));
	boardBean.setUser_id(multi.getParameter("user_id"));
	boardBean.setTitle(multi.getParameter("title"));
	boardBean.setSelectType(multi.getParameter("selectType"));
	boardBean.setPubDate(multi.getParameter("pubDate"));
	boardBean.setImgLink(multi.getParameter("imgLink"));
	boardBean.setMovieLink(multi.getParameter("movieLink"));
	boardBean.setMovieData(multi.getParameter("movieData"));
	boardBean.setContent(multi.getParameter("content"));
	boardBean.setFileName(multi.getFilesystemName("fileName"));
	
	System.out.println("글쓰기 정보 :" + boardBean.toString());
   	
   //boardBean.setUser_id(user_id);
   System.out.println("수정할 때 보드빈은? == "+boardBean.toString());
	// DB 처리 객체 BoardDAO 생성
		BoardDAO bdao = new BoardDAO();
		// 해당 글 정보를 사용해서 글 내용 수정
		int check = bdao.updateContent(boardBean); // bb안에 수정할 내용들이 있으니까 bb 넘겨주기!
		
		if(check == 1){
			%>
				<script type="text/javascript">
					alert("정상적으로 수정되었습니다.");
					location.href="boardList.jsp?pageNum=<%=pageNum%>";
				</script>
				
			<%
			
		} else if(check == 0){
			%>
				<script type="text/javascript">
					alert("권한이 없습니다.");
					location.href="boardList.jsp?pageNum=<%=pageNum%>";
				</script>
			<% 
		} else if(check == -1){
			%>
				<script type="text/javascript">
					alert("존재하지 않는 회원입니다.");
					location.href="boardList.jsp?pageNum=<%=pageNum%>";
				</script>
			
			<%
		}
   
   %>
   
</body>
</html>