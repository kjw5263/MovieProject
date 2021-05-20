
<%@page import="org.json.simple.JSONArray"%>
<%@page import="org.json.simple.JSONObject"%>
<%@page import="org.json.simple.parser.JSONParser"%>
<%@page import="com.movie.movieSearch.MovieSearch"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>영화 검색 페이지</title>
<script src="../js/jquery-3.6.0.js"></script>
<script type="text/javascript">
	
	function insertKeyword() {
		var keyword = document.getElementById("query").value;
		if(keyword == ""){
			alert("검색어를 입력하세요.");
			return false;
		}
	}
	
	
	function selectMovie() {
		var chkRadio = document.getElementsByName('radioSelect');
		var table = document.getElementById("result-table"); // .getElementById("result_tbody").getElementsByTagName("tr");
		//console.log(rows.length);
		
		
		var chk_cnt = 0;
		for(var i=0; i<chkRadio.length;i++){
			if(chkRadio[i].checked == true){
				chk_cnt++;
				
				// 라디오 버튼 선택한 행의 영화 정보들
				var pubDate = table.rows[i+1].cells[1].innerText;	// 제작연도
				var imgLink = table.rows[i+1].cells[2].querySelector('img').src;	// 이미지 주소
				var movieLink = table.rows[i+1].cells[3].querySelector('a').href;	// 영화 정보 주소 
				var movieData = table.rows[i+1].cells[3].innerText;						// 영화 정보
				var okCheck = confirm("영화 정보 : "+ movieData +"\n"+
						"제작연도 : " + pubDate +"\n를 선택하시겠습니까?");
				if(okCheck == true){
					// 선택 했을 때, 창을 닫으면서 writeForm 페이지에 데이터 전달해주고 싶을 때
					opener.document.getElementById("pubDate").value = pubDate;
					//opener.document.getElemenyById("movieLink").value= movieLink;
					opener.document.getElementById("imgLink").src=imgLink;
					opener.document.getElementById("imgLink").value=imgLink;
					opener.document.getElementById("movieData").value = movieData;
					window.close();
				} else{
					
				} 
				
			}
		}
		
		// 영화 선택하지 않고 제출 눌렀을 때
		if(chk_cnt<1){
			alert("영화를 선택해주세요.");
			return false;
		}
		
	}


</script>
</head>
<body>


	<%
		String query = "";
		int pageNum=1;
	%>
	
	<form action="searchPage.jsp?query=<%=query%>" method="get" onsubmit="return insertKeyword()">
	<input type="text" name="query" id="query" placeholder="영화 제목을 검색해보세요.">
	<input type="submit" >
	
	</form>
	
	<br><br><br>
	
	<table id="result-table" border="1">
		<thead>
			<tr>
			  <td>번호</td>
			  <td>제작연도</td>
			  <td>포스터 이미지</td>
			  <td>영화 정보</td>
			  <td>선택</td>
			</tr>
		</thead>
		<tbody id="result_tbody">
	<% 
	
		// 검색창에 검색어가 있을 때,
		if(request.getParameter("query") != null){
			query = request.getParameter("query");
			if(request.getParameter("pageNum")!=null){
				pageNum = Integer.parseInt(request.getParameter("pageNum"));
			}
			
			// 쿼리문과 페이지 정보를 넘겨준다 
			MovieSearch mSearch = new MovieSearch();
			String result = mSearch.searchMovie(query, pageNum);
			
			
			// String형태의 Json데이터를 파싱한다.
			JSONParser parser = new JSONParser();
	        JSONObject jsonObject = (JSONObject)parser.parse(result);
	        
	       
	        
	        if(jsonObject.isEmpty()) {
	        %> null입니다. <%
	        }
	        
	        
	        ////검색어에 이상없이 검색이 됐을 때
	        if(jsonObject.containsKey("lastBuildDate")) {
	        	// 전체 검색 결과 개수
	        	int total = Integer.parseInt(String.valueOf(jsonObject.get("total")));
	        	// 시작 행 
	        	int startRow = Integer.parseInt(String.valueOf(jsonObject.get("start")));
	        	// 출력 개수
	        	int display= Integer.parseInt(String.valueOf(jsonObject.get("display")));
	        	// 끝행
	        	int endRow = startRow*display;
	        	
	        	
	        	
	 	        // 영화 정보 객체 내부에 배열
		        JSONArray jsonArray = null;
	        	jsonArray = (JSONArray)jsonObject.get("items");
	        	
	        	// 검색어에 대한 결과가 없을 때
	        	if(jsonArray.size() == 0){
	        		%>
	        			<tr>
	        			  <td colspan="5">결과가 없습니다.</td>
	        			</tr>
	        			
	        		<%
	        	} 
	        	
	        	// 검색 결과가 있을 때
	        	else {
	        		JSONObject jsonItem = null;
	        		String title = "";
	        		String subtitle="";
	        		String img ="";
	        		String link ="";
	        		String pubDate="";
	        		String director="";
	        		String actor="";
	        		String userRating="";
	        		for(int i=0; i<jsonArray.size(); i++){
	        			jsonItem = (JSONObject)jsonArray.get(i);
	        			title = jsonItem.get("title").toString();
	        			subtitle = jsonItem.get("subtitle").toString();
	        			img = jsonItem.get("image").toString();
	        			link = jsonItem.get("link").toString();
	        			pubDate = jsonItem.get("pubDate").toString();
	        			director = jsonItem.get("director").toString();
	        			actor= jsonItem.get("actor").toString();
	        			userRating = jsonItem.get("userRating").toString();
	        			if(img == ""){
	        				img = "../img/unnamed.png";
	        			}
	        			if(subtitle == ""){
	        				subtitle = "부제 정보없음";
	        			}
	        			if(pubDate == ""){
	        				pubDate = "제작년도 정보없음";
	        			}
	        			if(director == ""){
	        				director ="감독 정보없음";
	        			}
	        			if(actor == ""){
	        				actor = "배우 정보없음";
	        			}
	        			if(userRating ==""){
	        				userRating = "평점 정보없음";
	        			}
	        			
	        			%>
	        			
	        			<tr id="result_tr">
							  <td id="startRow"><%=startRow+i %></td>
							  <td id="pubDate"><%=pubDate %></td>
							  <td id="img"><img id="imgLink" src="<%=img%>"></td>
							  <td id="title"><a id="movieLink" href="<%=link%>" target="_blank"><%=title %></a><br><%="("+subtitle+ ")<br>"+director + "<br>" + actor+"<br>" + userRating%></td>
							  <td><input type="radio"  value="" name="radioSelect" ></td>
						</tr>
						
						
	        			  <%
	        		}
	        		
	        		%>
						</tbody>
						</table>
						
					
					<% 		        		
	        	}
	        	
	        	

	        	
	        	/**************화면 페이지 계산*************/
	        	if(total!= 0){
	        		// 전체 페이지 개수 + 맨 뒤에 10개가 안되는 데이터들을 출력할지 여부
	        		int pageCount = total / 10 + (total % 10 == 0? 0:1);
	        		
	        		// 페이지 개수 5개
	        		int pageBlock = 5;
	        		
	        		// 다음이전 할 때, 시작 페이지 번호
	        		int startPage = ((pageNum-1)/pageBlock)*pageBlock+1;
	        		int endPage = startPage + pageBlock-1;
	        		//int startPage = ((start-1)/pageBlock) * pageBlock + 1;
	        		//int endPage = startPage + pageBlock-1;
	        		
	        		if(endPage > pageCount){
	        			endPage = pageCount;
	        		}
	        		
	        		if(startPage > pageBlock){
	        			%>
	        				<a href="searchPage.jsp?query=<%=query %>&pageNum=<%=startPage-pageBlock %>">[이전]</a> 
	        			<%
	        		}
	        		
	        		for(int i=startPage; i<=endPage; i++){
	        			%>
	        				<a href="searchPage.jsp?query=<%=query %>&pageNum=<%=i %>">[<%=i %>]</a>
	        			<% 
	        		}	
	        		
	        		// 다음 (기존의 페이지 블럭보다 페이지의 수가 많을 때)
	    			if(endPage <  pageCount) {
	    				%>
	    				<a href="searchPage.jsp?query=<%=query %>&pageNum=<%=startPage+pageBlock %>">[다음]</a>
	    				<%
	    				
	    			}
	        	}
	        	
	        %>
	        	<br><input type="button" value="선택" onclick="selectMovie()">
	        <% 	
	        } else if (jsonObject.containsKey("errorCode")){
	        	String errCode = jsonObject.get("errorCode").toString();
	        	String errMsg = jsonObject.get("errorMessage").toString();
	        	%>
	        		<%=errCode %> <br>
	        		<%=errMsg %> <br>
	        		검색결과가 없습니다.<br>
	        	<%
	        }
			
		} 
		
	%>
	<br><br>
	<input type="button" value="닫기" onclick="window.close()">
	<br><br>
	
</body>
</html>