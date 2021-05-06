package com.movie.boxOffice;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.Locale;

import com.google.gson.Gson;

import kr.or.kobis.kobisopenapi.consumer.rest.KobisOpenAPIRestService;
import kr.or.kobis.kobisopenapi.consumer.rest.exception.OpenAPIFault;

public class BoxOfficeDAO {
	// 일별 박스 오피스 구하기 
	String yesterday = "";
	
	

	// 일간 박스오피스 조회 날짜 구하기 (yyyyMMdd 형식, 익일)
	public String getToday() {
		
		try {
			SimpleDateFormat dateFormat = new SimpleDateFormat("yyyyMMdd");
			Date date = new Date();
			String today = dateFormat.format(date);
			Date setDate;
			setDate = dateFormat.parse(today);
			
			Calendar cal = new GregorianCalendar(Locale.KOREA);
			cal.setTime(setDate);
			
			cal.add(Calendar.DATE, -1);
			
			yesterday = dateFormat.format(cal.getTime());
			
		} catch (ParseException e) {
			e.printStackTrace();
		}
		
		return yesterday;
		
	}
	
	
	// 일별 Top 10을 받아오는 searchTop() 메소드
	public ArrayList<String> searchTop() {
	String targetDt = getToday();		// 조회 날짜 (필수)
	String itemPerPage = "10";		// 조회 결과 row 개수 (최대 10, 기본 10)
	String multiMovieYn = "";		// 다양성영화(Y), 상업영화(N, 기본)
	String repNationCd = "";		// 한국(k), 해외 (F, 기본)
	String wideAreaCd = "";			// 지역코드
	ArrayList<String> arr = new ArrayList<String>();


	
	try {
		
		// 영화 API 키 - 인증 
		String key = "7ff8dbacefec6686b5f297822ffc7c5b";
		KobisOpenAPIRestService service = new KobisOpenAPIRestService(key);
		
		
		String dailyResponse;
		dailyResponse = service.getDailyBoxOffice(true, targetDt, itemPerPage, multiMovieYn, repNationCd, wideAreaCd);
		
		Gson gsonDaily = new Gson();
		DailyTopTen dailytt = gsonDaily.fromJson(dailyResponse, DailyTopTen.class);
		
		for(int i=0; i<dailytt.getBoxOfficeResult().getDailyBoxOfficeList().size(); i++){
			//System.out.println(dailytt.getBoxOfficeResult().getDailyBoxOfficeList().get(i).getMovieNm());
			arr.add(dailytt.getBoxOfficeResult().getDailyBoxOfficeList().get(i).getMovieNm());
		}
		
		
	} catch (OpenAPIFault e) {
		System.out.println("API 불러오기 실패!");
		e.printStackTrace();
	} catch (Exception e) {
		System.out.println("결과 불러오기 실패! ");
		e.printStackTrace();
	}

	return arr;
	
	}
}
