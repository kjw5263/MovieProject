<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.6.2/jquery.min.js"></script>
<script type="text/javascript">
function searchPage() {
	window.open('searchPage.jsp', '', 'width=400, height=300, left=500, top=400');
}

</script>
</head>
<body>



<input type="button" value="영화 찾기" onclick="searchPage()">
<div id="div"></div>


</body>
</html>