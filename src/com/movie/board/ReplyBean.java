package com.movie.board;

public class ReplyBean {
	private int reply_num;
	private int board_num;
	private String user_id;
	private String reply_date;
	private String replyTextArea;
	public int getReply_num() {
		return reply_num;
	}
	public void setReply_num(int re_num) {
		this.reply_num = re_num;
	}
	public int getBoard_num() {
		return board_num;
	}
	public void setBoard_num(int board_num) {
		this.board_num = board_num;
	}
	public String getUser_id() {
		return user_id;
	}
	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	public String getReply_date() {
		return reply_date;
	}
	public void setReply_date(String reply_date) {
		this.reply_date = reply_date;
	}
	public String getReplyTextArea() {
		return replyTextArea;
	}
	public void setReplyTextArea(String replyTextArea) {
		this.replyTextArea = replyTextArea;
	}
	

	@Override
	public String toString() {
		return "ReplyBean [reply_num=" + reply_num + ", board_num=" + board_num + ", user_id=" + user_id + ", reply_date=" + reply_date + ", replyTextArea=" + replyTextArea + "]";
	}
	
	
	
}
