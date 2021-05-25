<%@page import="java.net.URLEncoder"%>
<%@page import="java.io.FileInputStream"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
	String fileName = request.getParameter("fileName");
	String savePath = "upload";
	ServletContext ctx = getServletContext();
	String sDownloadPath = ctx.getRealPath(savePath);
	
	System.out.println("upload 폴더의 실제 주소 (서버 안에 있는 실제 주소)" +sDownloadPath);
	
	String sFilePath = sDownloadPath + "/" + fileName;
	System.out.println("다운로드할 파일 주소 : " + sFilePath);
	
	byte[] b = new byte[4096];
	
	FileInputStream fis = new FileInputStream(sFilePath);
	String sMimeType = getServletContext().getMimeType(sFilePath);
	
	System.out.println("sMimeType => " + sMimeType);
	
	if(sMimeType == null){
		sMimeType = "application/octet-stream";
	}
	
	
	response.setContentType(sMimeType);
	
	String agent = request.getHeader("User-Agent");
	System.out.println("사용자 정보 : " + agent);
	
	boolean ieBrowser = (agent.indexOf("MSIE")>-1 || agent.indexOf("Trident")>-1);
	
	if(ieBrowser){
		fileName = URLEncoder.encode(fileName,"UTF-8").replaceAll("/+","%20");
	}else {
		fileName = new String(fileName.getBytes("UTF-8"), "iso-8859-1");
	}
	
	
	response.setHeader("Content-Disposition", "attachment; fileName= "+fileName);
	ServletOutputStream out2 = response.getOutputStream();
	
	int numRead;
	
	
	while((numRead= fis.read(b,0,b.length)) != -1){
		out2.write(b,0,numRead);
	}
	
	out2.flush();
	out2.close();
	fis.close();




%>
</body>
</html>