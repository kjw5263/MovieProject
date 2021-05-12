package com.movie.member;

public class MemberBean {
	private int user_num;
	private String user_id;
	private String user_pw;
	private String user_pw_check;
	private String user_name;
	private String user_nickname;
	private String user_email;
	private String zonecode;
	private String addr;
	
	
	
	public int getUser_num() {
		return user_num;
	}
	public void setUser_num(int user_num) {
		this.user_num = user_num;
	}
	public String getUser_id() {
		return user_id;
	}
	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	public String getUser_pw() {
		return user_pw;
	}
	public void setUser_pw(String user_pw) {
		this.user_pw = user_pw;
	}
	public String getUser_name() {
		return user_name;
	}
	public void setUser_name(String user_name) {
		this.user_name = user_name;
	}
	public String getUser_nickname() {
		return user_nickname;
	}
	public void setUser_nickname(String user_nickname) {
		this.user_nickname = user_nickname;
	}
	public String getUser_email() {
		return user_email;
	}
	public void setUser_email(String user_email) {
		this.user_email = user_email;
	}
	public String getZonecode() {
		return zonecode;
	}
	public void setZonecode(String zonecode) {
		this.zonecode = zonecode;
	}
	public String getAddr() {
		return addr;
	}
	public void setAddr(String addr) {
		this.addr = addr;
	}
	
	
	public String getUser_pw_check() {
		return user_pw_check;
	}
	public void setUser_pw_check(String user_pw_check) {
		this.user_pw_check = user_pw_check;
	}
	@Override
	public String toString() {
		return "MemberBean [user_num=" + user_num + ", user_id=" + user_id + ", user_pw=" + user_pw + ", user_pw_check="
				+ user_pw_check + ", user_name=" + user_name + ", user_nickname=" + user_nickname + ", user_email="
				+ user_email + ", zonecode=" + zonecode + ", addr=" + addr + "]";
	}
	
	
	
	
	
	
	
	
}
