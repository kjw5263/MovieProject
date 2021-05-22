<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="js/jquery-3.6.0.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	$(".result-table tr").click(function(){
	    var str ="";
	    var tdArr = new Array();
	    
	    var tr = $(this);
	    var td = tr.children();
	    
	    console.log("클릭한행의 데이터 =" +tr.text());
	    td.each(function(i){
	    	tdArr.push(td.eq(i).text());
	    });
	    
	    console.log("배열에 담긴 값 : " + tdArr);
	    var title = td.eq(0).text();
	    var row = td.eq(1).text();
	    var row = td.eq(1).text();
	    console.log("eq(0)에 담긴 값 : " + title);
	    console.log("eq(1)에 담긴 값 : " + row);
	});
	
	
});


</script>
</head>
<body>



<table border="1" class="result-table">
	<tr>
		<td>제목</td>
		<td>글</td>
	</tr>
	<tr>
		<td rowspan=3 id="rere">로스팬한곳</td>
		<td id="11"> 111 </td>
	</tr>
	<tr>
		<td id="22"> 222 </td>
	</tr>
	<tr>
		<td id="33"> 333 </td>
	</tr>
	
	


</table>

<button id="button">btn</button>

</body>
</html>