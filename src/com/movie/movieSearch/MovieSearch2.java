package com.movie.movieSearch;
import java.io.*;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;


public class MovieSearch2 {


    public static void main(String[] args){
    	//MovieItem mItem = null;
    	//ArrayList<MovieItem> arr = new ArrayList<MovieItem>();
        String clientId = "Kyfh22pzlli_1dQYrgkl"; //애플리케이션 클라이언트 아이디값"
        String clientSecret = "rWZw6ljF9q"; //애플리케이션 클라이언트 시크릿값"


        String text = null;
        try {
            text = URLEncoder.encode("너의", "UTF-8");
        } catch (UnsupportedEncodingException e) {
            throw new RuntimeException("검색어 인코딩 실패",e);
        }


        String apiURL = "https://openapi.naver.com/v1/search/movie.json?query=" + text + "&start=5";    // json 결과
        //String apiURL = "https://openapi.naver.com/v1/search/blog.xml?query="+ text; // xml 결과


        Map<String, String> requestHeaders = new HashMap<>();
        requestHeaders.put("X-Naver-Client-Id", clientId);
        requestHeaders.put("X-Naver-Client-Secret", clientSecret);
        String responseBody = get(apiURL,requestHeaders);

        
        System.out.println(responseBody);
        
        /*
        JsonParser jsonParser = new JsonParser();
        JsonElement element = jsonParser.parse(responseBody);
        JsonObject jsonObject = element.getAsJsonObject();
        

        // 에러코드가 있을 때 -> 에러 발생 !
        if(jsonObject.has("errorCode") || jsonObject.has("erroMessage")) {
        	System.out.println(jsonObject.get("errorCode").getAsString() +"///" + jsonObject.get("errorMessage").getAsString());
        }
        // 에러코드가 없을 때 -> 검색은 성공!
        else if(responseBody.contains("lastBuildDate")){
        	JsonArray jArray = jsonObject.get("items").getAsJsonArray();
        	
        	// 검색 결과가 없을 때
        	if(jArray.size() == 0) {
        		System.out.println("검색에는 성공했지만, 검색 결과가 없어요.");
        	}else {
        		
        	}
        	
        }
       */
        //return responseBody;
        
        
    }


    private static String get(String apiUrl, Map<String, String> requestHeaders){
        HttpURLConnection con = connect(apiUrl);
        try {
            con.setRequestMethod("GET");
            for(Map.Entry<String, String> header :requestHeaders.entrySet()) {
                con.setRequestProperty(header.getKey(), header.getValue());
            }


            int responseCode = con.getResponseCode();
            if (responseCode == HttpURLConnection.HTTP_OK) { // 정상 호출
            	
            	return readBody(con.getInputStream());
            	
            } else { // 에러 발생
            	int argsss = con.getResponseCode();
            	System.out.println("code : " + argsss);
                return readBody(con.getErrorStream());
            }
        } catch (IOException e) {
        	String error = e.getMessage();
        	System.out.println("아앙? " + error);
            throw new RuntimeException("API 요청과 응답 실패", e);
        } finally {
            con.disconnect();
        }
    }


    private static HttpURLConnection connect(String apiUrl){
        try {
            URL url = new URL(apiUrl);
            return (HttpURLConnection)url.openConnection();
        } catch (MalformedURLException e) {
            throw new RuntimeException("API URL이 잘못되었습니다. : " + apiUrl, e);
        } catch (IOException e) {
            throw new RuntimeException("연결이 실패했습니다. : " + apiUrl, e);
        }
    }


    private static String readBody(InputStream body){
        InputStreamReader streamReader = new InputStreamReader(body);


        try (BufferedReader lineReader = new BufferedReader(streamReader)) {
            StringBuilder responseBody = new StringBuilder();


            String line;
            while ((line = lineReader.readLine()) != null) {
                responseBody.append(line);
            }


            return responseBody.toString();
        } catch (IOException e) {
            throw new RuntimeException("API 응답을 읽는데 실패했습니다.", e);
        }
    }
}