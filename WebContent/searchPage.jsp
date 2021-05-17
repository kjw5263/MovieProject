<%@page import="com.google.gson.JsonObject"%>
<%@page import="com.google.gson.JsonElement"%>
<%@page import="com.google.gson.JsonParser"%>
<%@page import="com.movie.movieSearch.MovieSearch"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>영화 검색 페이지</title>
<script type="text/javascript">
	function insertKeyword() {
		var keyword = document.getElementById("query").value;
		if(keyword == ""){
			alert("검색어를 입력하세요.");
			return false;
		}
	}
</script>
</head>
<body>


	<%
		String query = "";
	%>
	
	<form action="searchPage.jsp?query="+<%=query%> method="get" onsubmit="return insertKeyword()">
	<input type="text" name="query" id="query" placeholder="영화 제목을 검색해보세요.">
	<input type="submit" >
	
	</form>
	
	
	<% 
	
		if(request.getParameter("query") != null){
			query = request.getParameter("query");
			
			MovieSearch mSearch = new MovieSearch();
			String result = mSearch.searchMovie(query);
			
			JsonParser parser = new JsonParser();
	        JsonElement element = parser.parse(result);
	        JsonObject jobj = element.getAsJsonObject();
	        if(jobj.isJsonNull()) {
	        	
	        	%>
	        		null입니다.
	        		
	        	<%
	        }
	        if(jobj.has("items")) {
	        	if(jobj.getAsJsonArray("items").size() == 0){
	        		%>
	        			검색결과가 없습니다. 
	        		<%
	        	} 
	        	
	        	else {
	        		String str = "";
	        		String img ="";
	        		String pubDate="";
	        		String director="";
	        		String actor="";
	        		%>
	        			<table border="1">
							<tr>
							  <td>번호</td>
							  <td>제작연도</td>
							  <td>포스터 이미지</td>
							  <td>영화 정보</td>
							</tr>
	        		
	        		<%
	        		for(int i=0; i<jobj.getAsJsonArray("items").size(); i++){
	        			str = jobj.getAsJsonArray("items").get(i).getAsJsonObject().get("title").getAsString();
	        			img = jobj.getAsJsonArray("items").get(i).getAsJsonObject().get("image").getAsString();
	        			pubDate = jobj.getAsJsonArray("items").get(i).getAsJsonObject().get("pubDate").getAsString();
	        			director = jobj.getAsJsonArray("items").get(i).getAsJsonObject().get("director").getAsString();
	        			actor= jobj.getAsJsonArray("items").get(i).getAsJsonObject().get("actor").getAsString();
	        			if(img == ""){
	        				img = "../img/unnamed.png";
	        			}
	        			%>
	        			<tr>
							  <td rowspan="3"><%=(i+1) %></td>
							  <td rowspan="3"><%=pubDate %></td>
							  <td rowspan="3"><img src="<%=img%>"></td>
							  <td><%=str %></td>
							</tr>
							<tr>
							  <td><%=director %></td>
							</tr>
							<tr>
							  <td><%=actor%></td>
						</tr>
	        			
	        			
	        			  <%
	        		}
	        		
	        		%>

		
						</table>

					<% 		        		
	        	}
	        } else if (jobj.has("errorCode")){
	        	String errCode = jobj.get("errorCode").getAsString();
	        	String errMsg = jobj.get("errorMessage").getAsString();
	        	%>
	        		검색결과가 없습니다.<br>
	        	<%
	        }
			
		} 
		
	%>

	

	
</body>
</html>