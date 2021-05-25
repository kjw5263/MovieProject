<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<html>
<head>
<title>마무다 Contact Us</title>
<style>
	table{
		width : 600px;
		margin : auto;
	}
	h1{
		text-align: center;
	}
	td{
		border : 1px dotted gray;
	}
</style>
</head>
<body>
<form action="mailSend" method="post">
<h1>Contact Us</h1>
<table>
	<tr><td>보내는 사람 메일 : </td><td><input type="text" name="sender"></td></tr>
	<tr><td>받는 사람 메일 : </td><td><input type="text" name="receiver" value="kjw5263@naver.com" readonly></td></tr>
	<tr><td>제목 : </td><td><input type="text" name="subject"></td></tr>
	<tr>
		<td>내용 : </td>
		<td><textarea name="content" cols=40 rows=20></textarea></td>
	</tr>
	<tr><td align=center colspan=2><input type="submit" value="보내기"></td></tr>
</table>
</form>


<jsp:include page="../inc/footer.jsp" />
</body>
</html>
