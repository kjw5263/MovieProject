<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script src="http://code.jquery.com/jquery-1.11.2.min.js"></script>
<script src="http://code.jquery.com/jquery-migrate-1.2.1.min.js"></script>
 
<script type="text/javascript" language="javascript">
 
    $(document).ready(function(){
         
         
        $.ajax({
             
            type : "GET",
            url : "https://openapi.naver.com/v1/search/movie.json?query=%EC%A3%BC%EC%8B%9D&display=10&start=1&genre=1",
            dataType : "json",
            beforeSend : function(xhr){
                xhr.setRequestHeader("X-Naver-Client-Id", "Kyfh22pzlli_1dQYrgkl");
                xhr.setRequestHeader("X-Naver-Client-Secret","rWZw6ljF9q");
                xhr.setRequestHeader("Access-Control-Allow-Origin" , "*");
            },
            error : function(){
                alert('통신실패!!');
            },
            success : function(data){
                alert("통신데이터 값 : " + data) ;
                $("#dataArea").html(data) ;
            }
             
        });
         
 
    });
 
</script>


</head>
<body>

안녕
<div id="dataArea">
</div>
</body>
</html>