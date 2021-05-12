package com.movie.member;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

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
	
	
	
	
	/* loginCheck() : 로그인 체크 메소드 */
	public ArrayList<Object> loginCheck(MemberBean memberBean) {
		int result = -1;
		ArrayList<Object> arr = new ArrayList<Object>();
		
		try {
			conn = getConnection();
			sql = "select user_pw, user_nickname from user_info where user_id=?";
			pstmt = conn.prepareStatement(sql);		// 예외 발생 가능
			
			pstmt.setString(1, memberBean.getUser_id());
			
			rs = pstmt.executeQuery();
			
			
			// rs.next() : 일치하는 아이디가 있을 때
			if(rs.next()) {
				
				// 입력받은 비번과 DB저장 비번이 같을 때 >> 로그인 성공 (1)
				if(memberBean.getUser_pw().equals(rs.getString("user_pw"))) {
					
					result = 1;
					arr.add(result);
					arr.add(rs.getString("user_nickname"));
					
				}
				// 입력받은 비번과 DB저장비번이 다를 때 >> 비번 틀림 (0)
				else {
					result = 0;
					arr.add(result);
				}
			}
			// rs.next() 없을 때 : 비회원 (-1)
			else {
				result = -1;
				arr.add(result);
			}
		} catch (SQLException e) {
			System.out.println("[MemberDAO] loginCheck() : " + e.getMessage());
			//e.printStackTrace();
		} finally {
			closeDB();
		}
		
		return arr;
	}
	
	
	
	/* IDdup_Check() : 회원가입 중 아이디 중복 체크 */
	public int IDdup_Check(String user_id) {
		int result = 0;
		
		try {
			conn = getConnection();
			sql = "select * from user_info where user_id = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, user_id);
			rs = pstmt.executeQuery();
			
			
			if(rs.next()) {
				// 아이디가 존재할 때 
				result = 1;
			} else {
				// 아이디 존재하지 않을 때 -> 사용가능
				result = 0;
			}
		} catch (SQLException e) {
			System.out.println("[MemberDAO] IDdup_Check : " + e.getMessage());
			//e.printStackTrace();
		} finally {
			closeDB();
		}
		
		return result;
	}
	
	
	/* EMdup_Check() : 회원가입중 이메일 중복 체크 */
	public int EMdup_Check(String user_email){
		int result = 0;
		
		try {
			conn = getConnection();
			sql = "select * from user_info where user_email=?";
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, user_email);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				// 이메일 존재할 때
				result = 1;
			} else {
				// 이메일 존재하지 않을 때 -> 이메일 사용가능
				result = 0;
			}
		} catch (SQLException e) {
			System.out.println("[MemberDAO] EMdup_check : " + e.getMessage());;
			e.printStackTrace();
		} finally {
			closeDB();
		}
		return result;
	}
	
	
	/* UserJoin() : 회원가입 메소드 */
	public void UserJoin(MemberBean memberBean) {
		int num = 1;
		
		try {
			conn = getConnection();
			sql = "select max(user_num) from user_info";
			pstmt = conn.prepareStatement(sql);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				num = rs.getInt(1)+1;
			}
			
			System.out.println("user_num 값 : " + num);
			
			sql = "insert into user_info values (?,?,?,?,?,?,?,?)";
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setInt(1, num);
			pstmt.setString(2, memberBean.getUser_id());
			pstmt.setString(3, memberBean.getUser_pw());
			pstmt.setString(4, memberBean.getUser_name());
			pstmt.setString(5, memberBean.getUser_nickname());
			pstmt.setString(6, memberBean.getUser_email());
			pstmt.setString(7, memberBean.getZonecode());
			pstmt.setString(8, memberBean.getAddr());
			
			pstmt.executeUpdate();
			System.out.println("[MemberDAO] UserJoin() 회원등록 성공! ");
			
			
		} catch (SQLException e) {
			System.out.println("[MemberDAO] UserJoin() : " + e.getMessage());
			//e.printStackTrace();
		} finally {
			closeDB();
		}
		
		
	}
	
	
	
	
	/* checkBeforeInfo() : 회원정보 조회 전, 본인확인으로 비밀번호 확인하기*/
	public MemberBean checkBeforeInfo(MemberBean memberBean) {
		MemberBean mb = null;
		
		try {
			conn = getConnection();
			sql = "select * from user_info where user_id = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, memberBean.getUser_id());
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				// 아이디 일치한 계정이 있을 때,
				// 내가 입력한 비번과 비번이 같을 때-> 정상적으로 적었을 
				if(memberBean.getUser_pw().equals(rs.getString("user_pw"))) {
					mb = new MemberBean();
					mb.setUser_num(rs.getInt("user_num"));
					mb.setUser_id(rs.getString("user_id"));
					mb.setUser_name(rs.getString("user_name"));
					mb.setUser_nickname(rs.getString("user_nickname"));
					mb.setUser_email(rs.getString("user_email"));
					mb.setZonecode(rs.getString("zonecode"));
					mb.setAddr(rs.getString("addr"));
				
					System.out.println("[MemberDAO.java] checkBeforeInfo() : 회원정보 읽어오기 완료 ");
					System.out.println("[MemberDAO.java] checkBeforeInfo() : " + mb.toString());
						
				} else {
					// 아이디에 해당하는 정보는 있지만
					// 비밀번호 틀렸을 때 
					System.out.println("[MemberDAO.java] checkBeforeInfo() : 비밀번호 틀림 ");
				}
			} else {
				System.out.println("[MemberDAO.java] checkBeforeInfo() : 해당 정보 없음 ");
			}
			
		} catch (SQLException e) {
			System.out.println("[MemberDAO.java] checkBeforeInfo() : " + e.getMessage());
			//e.printStackTrace();
		} finally {
			closeDB();
		}
		
		return mb;
	}
	
	
	

	/* updateInfo() : 회원정보 수정 메소드 */
	public int updateInfo(MemberBean memberBean) {
		int result = -1;
			
		try {
			// 아이디값을 가지고 사용자 비교하기
			conn = getConnection();
			sql = "select * from user_info where user_id=?";
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, memberBean.getUser_id());
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				// 해당하는 아이디가 있을 때! 입력한 비번 맞는지 확인하기
				if(rs.getString("user_pw").equals(memberBean.getUser_pw())) {
					// 해당하는 아이디가 맞고, 비번이 맞을 때 -> 수정해주기
						sql = "update user_info set user_name=?, user_nickname=?, zonecode=?, addr=? where user_id=?";
						pstmt = conn.prepareStatement(sql);
						pstmt.setString(1, memberBean.getUser_name());
						pstmt.setString(2, memberBean.getUser_nickname());
						pstmt.setString(3, memberBean.getZonecode());
						pstmt.setString(4, memberBean.getAddr());
						pstmt.setString(5, memberBean.getUser_id());
						pstmt.executeUpdate();
						result = 1;
				} else {
					System.out.println("[MemberDAO.java] updateInfo() : 비밀번호 틀림");
					result = 0;			// 회원은 맞으나 비밀번호 틀린 경우 
				}
			} else {
				System.out.println("[MemberDAO.java] updateInfo() : 해당 정보 없음");
				result = -1;
			}
			
		} catch (SQLException e) {
			System.out.println("[MemberDAO] updateInfo() : " + e.getMessage());
		} finally {
			closeDB();
		}
		
		
		return result;
	}
	
	
	/*  updatePassInfo() : 비밀번호 변경 메소드 */
	public int updatePassInfo(MemberBean memberBean) {
		int result = -1;
		
		try {
			conn = getConnection();
			sql = "select * from user_info where user_id=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, memberBean.getUser_id());
			System.out.println("사용자 아이디느??  " + memberBean.getUser_id());
			rs = pstmt.executeQuery();
			if(rs.next()) {
				if(rs.getString("user_pw").equals(memberBean.getUser_pw())) {
					// 비밀번호 일치하기 때문에 변경해주기
					sql = "update user_info set user_pw=? where user_id=?";
					pstmt = conn.prepareStatement(sql);
					pstmt.setString(1, memberBean.getUser_pw_check());
					pstmt.setString(2, memberBean.getUser_id());
					pstmt.executeUpdate();
					System.out.println("[MemberDAO.java] updatePassInfo() : 비밀번호 수정완료 ");
					result = 1;
				} else {
					System.out.println("[MemberDAO.java] updatePassInfo() : 비밀번호 오류! 수정 실패 ");
					result = 0;
				}
			} else {
				System.out.println("[MemberDAO.java] updatePassInfo() : 회원 정보 없음 ");
				result = -1;
			}
			
		} catch (SQLException e) {
			System.out.println("[MemberDAO.java] updateInfo() : " + e.getMessage());
		} finally {
			closeDB();
		}
		
		return result;
	}

	
	/* deleteInfo() : 회원정보 삭제 메소드 */
	public int deleteInfo(MemberBean memberBean) {
		int result = -1;
		
		try {
			conn = getConnection();
			sql = "select * from user_info where user_id = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, memberBean.getUser_id());
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				// 아이디 일치한 계정이 있을 때,
				// 내가 입력한 비번과 비번이 같을 때-> 정상적으로 적었을 
				if(memberBean.getUser_pw().equals(rs.getString("user_pw"))) {
					sql = "delete from user_info where user_id=?";
					pstmt = conn.prepareStatement(sql);
					pstmt.setString(1, rs.getString("user_id"));
					pstmt.executeUpdate();
					result = 1;
				} else {
					// 아이디에 해당하는 정보는 있지만
					// 비밀번호 틀렸을 때 
					System.out.println("[MemberDAO.java] deleteInfo() : 비밀번호 틀림 ");
					result = 0;
				}
			} else {
				System.out.println("[MemberDAO.java] deleteInfo() : 해당 정보 없음 ");
				result = -1;
			}
			
		} catch (SQLException e) {
			System.out.println("[MemberDAO.java] deleteInfo() : " + e.getMessage());
			//e.printStackTrace();
		} finally {
			closeDB();
		}
		
		return result;
	}
}















