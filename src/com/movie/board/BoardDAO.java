package com.movie.board;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

public class BoardDAO {

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
			//e.printStackTrace();
		} catch (SQLException e) {
			System.out.println("[MemberDAO] getConn() : " + e.getMessage());
			//e.printStackTrace();
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
	
	
	
	
	/* insertBoard() : 게시판 글쓰기 메소드 */
	public void insertBoard(BoardBean boardBean) {
		int board_num = 0;
		try {
			conn = getConnection();
			sql = "select user_id from user_info where user_id=?";
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, boardBean.getUser_id());
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				sql = "select max(board_num) from board_list";
				pstmt = conn.prepareStatement(sql);
				rs = pstmt.executeQuery();
				
				if(rs.next()) {
					board_num = rs.getInt(1)+1;
				}
				System.out.println("글 번호 : "+ board_num);
				//글번호,유형,제목,내용,사용자아이디,날짜now(),조회수,글ref,lev,seq,ip,file
				sql = "insert into board_list values(?,?,?,?,?,now(),?,?,?,?,?,?,?,?,?)";
				pstmt = conn.prepareStatement(sql);
				
				pstmt.setInt(1, board_num);
				pstmt.setString(2, boardBean.getSelectType());
				pstmt.setString(3, boardBean.getTitle());
				pstmt.setString(4, boardBean.getContent());
				pstmt.setString(5, boardBean.getUser_id());
				pstmt.setInt(6, boardBean.getReadcount());
				pstmt.setInt(7, board_num);
				pstmt.setInt(8, boardBean.getRe_lev());
				pstmt.setInt(9, boardBean.getRe_seq());
				pstmt.setString(10, boardBean.getIp());
				pstmt.setString(11, boardBean.getFileName());
				pstmt.setString(12, boardBean.getPubDate());
				pstmt.setString(13, boardBean.getImgLink());
				pstmt.setString(14, boardBean.getMovieData());
				
				pstmt.executeUpdate();
				System.out.println("SQL 실행 완료 : 글쓰기 완료 ");
				
			}
		} catch (SQLException e) {
			System.out.println("SQL 실행 실패 : 글쓰기 실패 " + e.getMessage());
			//e.printStackTrace();
		}finally {
			closeDB();
		}
		
		
		
	}
	
	
	
	public int getBoardCount() {
		int cnt = 0;
		
		try {
			conn = getConnection();
			sql = "select count(*) from board_list";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				cnt = rs.getInt(1);
			}
			
			System.out.println("SQL 구문 실행완료");
			System.out.println("글 개수 : " + cnt + "개");
		} catch (SQLException e) {
			System.out.println("[게시판 글 개수]_에러발생");
			System.out.println(e.getMessage());
		} finally {
			closeDB();
		}
		return cnt;
	}
	
	public ArrayList getBoardList() {
		ArrayList arrList = new ArrayList();
		BoardBean boardBean = null;
		
		
		try {
			conn = getConnection();
			sql = "select * from board_list";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				boardBean = new BoardBean();
				
				boardBean.setBoard_num(rs.getInt("board_num"));
				boardBean.setSelectType(rs.getString("selectType"));
				boardBean.setTitle(rs.getString("title"));
				boardBean.setContent(rs.getString("content"));
				boardBean.setUser_id(rs.getString("user_id"));
				boardBean.setDate(rs.getString("date"));
				boardBean.setReadcount(rs.getInt("readCount"));
				boardBean.setRe_ref(rs.getInt("re_ref"));
				boardBean.setRe_lev(rs.getInt("re_lev"));
				boardBean.setRe_seq(rs.getInt("re_seq"));
				boardBean.setIp(rs.getString("ip"));
				boardBean.setFileName(rs.getString("file"));
				boardBean.setPubDate(rs.getString("pubDate"));
				boardBean.setImgLink(rs.getString("imgLink"));
				boardBean.setMovieData(rs.getString("movieData"));
				
				arrList.add(boardBean);
			}
			System.out.println("게시판 모든 정보 저장 완료 ");
			System.out.println("총 " + arrList.size() + "개");
		} catch (SQLException e) {
			System.out.println("개수 가져오기 에러 : "+e.getMessage());
		} finally {
			closeDB();
		}
		return arrList;
		
	}
	
	
	
	public ArrayList getBoardList(int startRow, int pageSize) {
		ArrayList arrList = new ArrayList();
		BoardBean boardBean = null;
		
		
		try {
			conn = getConnection();
			sql = "select * from board_list order by board_num desc, re_ref desc, re_seq asc limit ?, ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, startRow-1);
			pstmt.setInt(2, pageSize);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				boardBean = new BoardBean();
				
				boardBean.setBoard_num(rs.getInt("board_num"));
				boardBean.setSelectType(rs.getString("selectType"));
				boardBean.setTitle(rs.getString("title"));
				boardBean.setContent(rs.getString("content"));
				boardBean.setUser_id(rs.getString("user_id"));
				boardBean.setDate(rs.getString("date"));
				boardBean.setReadcount(rs.getInt("readCount"));
				boardBean.setRe_ref(rs.getInt("re_ref"));
				boardBean.setRe_lev(rs.getInt("re_lev"));
				boardBean.setRe_seq(rs.getInt("re_seq"));
				boardBean.setIp(rs.getString("ip"));
				boardBean.setFileName(rs.getString("file"));
				boardBean.setPubDate(rs.getString("pubDate"));
				boardBean.setImgLink(rs.getString("imgLink"));
				boardBean.setMovieData(rs.getString("movieData"));
				
				arrList.add(boardBean);
			}
			System.out.println("게시판 모든 정보 저장 완료222 ");
			System.out.println("총 " + arrList.size() + "개");
		} catch (SQLException e) {
			System.out.println("개수 가져오기 에러 : "+e.getMessage());
		} finally {
			closeDB();
		}
		return arrList;
		
	}
	
	
}
