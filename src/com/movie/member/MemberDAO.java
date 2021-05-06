package com.movie.member;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;


public class MemberDAO {
	
	private Connection conn = null;
	private PreparedStatement pstmt = null;
	private ResultSet rs = null;
	private String sql = null;
	
	
	//-----------DB 드라이버 정보--------------------
/*	final String DRIVER = "com.mysql.jdbc.Driver";
	final String DBURL = "jdbc:mysql://localhost:3306/jspdb";
	final String DBID = "root";
	final String DBPW = "1234";    */
	
	
	
	/* (공통) getConnection() : 연결 자원 할당 메소드 */
	private Connection getConnection() {
		
		// 커넥션 풀 생성하기 : 미리 연결정보 생성해서 저장 후 사용 -> 사용 후 반납 
		
		try {
			Context initCTX = new InitialContext();		// 업캐스팅, 예외 발생 가능
			
			// Context.xml에서 DB 연결 정보 가져오기
			DataSource ds = (DataSource)initCTX.lookup("java:comp/env/jdbc/movieDB"); // 다운캐스팅
			
			conn = ds.getConnection();
			
			System.out.println("[MemberDAO] getConn() : 드라이버 로드, DB연결 성공 ");
			System.out.println("[MemberDAO] conn : " + conn);
		} catch (NamingException e) {
			System.out.println("[MemberDAO] getConn() : " + e.getMessage());
			e.printStackTrace();
		} catch (SQLException e) {
			System.out.println("[MemberDAO] getConn() : " + e.getMessage());
			e.printStackTrace();
		}
		
		return conn;
	}
	
	
	
	
	/* (공통) closeDB() : 자원 해제 메소드 */
	private void closeDB() {
		try {
			if(rs != null) rs.close();
			if(pstmt != null) pstmt.close();
			if(conn != null) conn.close();
		} catch (SQLException e) {
			System.out.println("[MemberDAO] closeDB() : "+ e.getMessage());
		}
	}
	
	
	
	
	/* loginCheck() : 로그인 체크 메소드 */
	public int loginCheck(MemberBean memberBean) {
		int result = -1;
		
		try {
			conn = getConnection();
			sql = "select pw from user_info where id=?";
			pstmt = conn.prepareStatement(sql);		// 예외 발생 가능
			
			pstmt.setString(1, memberBean.getUser_id());
			
			rs = pstmt.executeQuery();
			
			
			// rs.next() : 일치하는 아이디가 있을 때
			if(rs.next()) {
				
				// 입력받은 비번과 DB저장 비번이 같을 때 >> 로그인 성공 (1)
				if(memberBean.getUser_pw().equals(rs.getString("user_pw"))) {
					result = 1;
				}
				// 입력받은 비번과 DB저장비번이 다를 때 >> 비번 틀림 (0)
				else {
					result = 0;
				}
			}
			// rs.next() 없을 때 : 비회원 (-1)
			else {
				result = -1;
			}
			
			
		} catch (SQLException e) {
			System.out.println("[MemberDAO] loginCheck() : " + e.getMessage());
			e.printStackTrace();
		}
		
		
		
		return result;
	}

}
