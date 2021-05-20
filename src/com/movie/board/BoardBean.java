package com.movie.board;

public class BoardBean {
	private int board_num;
	private String selectType;
	private String title;
	private String content;
	private String user_id;
	private String date;
	private int readcount;
	private int re_ref;
	private int re_lev;
	private int re_seq;
	private String ip;
	private String fileName;
	
	private String pubDate;
	private String imgLink;
	private String movieData;
	
	public int getBoard_num() {
		return board_num;
	}
	public void setBoard_num(int board_num) {
		this.board_num = board_num;
	}
	
	public String getSelectType() {
		return selectType;
	}
	public void setSelectType(String selectType) {
		this.selectType = selectType;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getUser_id() {
		return user_id;
	}
	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	public String getDate() {
		return date;
	}
	public void setDate(String date) {
		this.date = date;
	}
	public int getReadcount() {
		return readcount;
	}
	public void setReadcount(int readcount) {
		this.readcount = readcount;
	}
	public int getRe_ref() {
		return re_ref;
	}
	public void setRe_ref(int re_ref) {
		this.re_ref = re_ref;
	}
	public int getRe_lev() {
		return re_lev;
	}
	public void setRe_lev(int re_lev) {
		this.re_lev = re_lev;
	}
	public int getRe_seq() {
		return re_seq;
	}
	public void setRe_seq(int re_seq) {
		this.re_seq = re_seq;
	}
	public String getIp() {
		return ip;
	}
	public void setIp(String ip) {
		this.ip = ip;
	}
	public String getFileName() {
		return fileName;
	}
	public void setFileName(String file) {
		this.fileName = file;
	}
	
	
	
	public String getPubDate() {
		return pubDate;
	}
	public void setPubDate(String pubDate) {
		this.pubDate = pubDate;
	}
	public String getImgLink() {
		return imgLink;
	}
	public void setImgLink(String imgLink) {
		this.imgLink = imgLink;
	}
	public String getMovieData() {
		return movieData;
	}
	public void setMovieData(String movieData) {
		this.movieData = movieData;
	}

	@Override
	public String toString() {
		return "BoardBean [board_num=" + board_num + ", selectType=" + selectType + ", title=" + title + ", content="
				+ content + ", user_id=" + user_id + ", date=" + date + ", readcount=" + readcount + ", re_ref="
				+ re_ref + ", re_lev=" + re_lev + ", re_seq=" + re_seq + ", ip=" + ip + ", fileName=" + fileName
				+ ", pubDate=" + pubDate + ", imgLink=" + imgLink + ", movieData="
				+ movieData + "]";
	}
	
	
	
	
	
	
	
}
