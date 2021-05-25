<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="com.movie.board.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>loading...</title>
</head>
<body>
	<%
		request.setCharacterEncoding("UTF-8");
		//String selectType = request.getParameter("selectType");
		//String pubDate = request.getParameter("pubDate");
		//String imgLink = request.getParameter("imgLink");
		//String movieLink = request.getParameter("movieLink");
		//String movieData = request.getParameter("movieData");
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
		
		BoardDAO bdao = new BoardDAO();
		int result = bdao.insertBoard(boardBean);
		
		if (result == 1){
			response.sendRedirect("boardList.jsp");
		} else {
			%>
				<script type="text/javascript">
					alert("글쓰기 실패 입니다.");
					history.back();
				</script>
			<%
		}
		
	%>
	
</body>
</html>