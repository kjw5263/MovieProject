<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%

	Class.forName("com.mysql.jdbc.Driver");
	// 2. DB 연결
	Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/jspdb", "root", "1234");
	// 3, sql
	String sql = "select id, name, email from itwill_member";

	PreparedStatement pstmt = conn.prepareStatement(sql);

	// 4. sql 실행
	ResultSet rs = pstmt.executeQuery();

%>