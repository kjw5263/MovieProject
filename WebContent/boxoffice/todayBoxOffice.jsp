<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="../js/jquery-3.6.0.js"></script>
<script src="../js/jquery.innerfade.js"></script>
<link href="../css/main.css" rel="stylesheet" type="text/css">
<script type="text/javascript">
	$(function() {
		$.ajax({
			type:'get',
			url:'../json/recommandMovie.json',
			dataType:'json',
			success:function(data){
				$.each(data, function(){

					var t = "";
					t += '<li><img class="posterImg" src="' + this.imglink + '"></li>';
					
					$('.slidePage').append(t);
					
					

				});
				$('.slidePage').innerfade({
					animationtype: "fade",
					speed:500,
					type:"random"
				});
				
			}
		});
	});
	
</script>
</head>
<body>
<div class="slidePage-div">
	<ul class="slidePage"> 
	
	</ul>
</div>
 
</body>
</html>