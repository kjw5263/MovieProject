package com.movie.movieSearch;

public class MovieItem {
	private String title;
	private String subtitle;
	private String pubDate;
	private String director;
	private String actor;
	private String userRating;
	private String link;
	private String image;
	private int total;
	private int start;
	private int display;
	
	
	
	
	public MovieItem(String title, String subtitle, String pubDate, String director, String actor, String userRating,
			String link, String image, int total, int start, int display) {
		super();
		this.title = title;
		this.subtitle = subtitle;
		this.pubDate = pubDate;
		this.director = director;
		this.actor = actor;
		this.userRating = userRating;
		this.link = link;
		this.image = image;
		this.total = total;
		this.start = start;
		this.display = display;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getSubtitle() {
		return subtitle;
	}
	public void setSubtitle(String subtitle) {
		this.subtitle = subtitle;
	}
	public String getPubDate() {
		return pubDate;
	}
	public void setPubDate(String pubDate) {
		this.pubDate = pubDate;
	}
	public String getDirector() {
		return director;
	}
	public void setDirector(String director) {
		this.director = director;
	}
	public String getActor() {
		return actor;
	}
	public void setActor(String actor) {
		this.actor = actor;
	}
	public String getUserRating() {
		return userRating;
	}
	public void setUserRating(String userRating) {
		this.userRating = userRating;
	}
	public String getLink() {
		return link;
	}
	public void setLink(String link) {
		this.link = link;
	}
	public String getImage() {
		return image;
	}
	public void setImage(String image) {
		this.image = image;
	}
	public int getTotal() {
		return total;
	}
	public void setTotal(int total) {
		this.total = total;
	}
	public int getStart() {
		return start;
	}
	public void setStart(int start) {
		this.start = start;
	}
	public int getDisplay() {
		return display;
	}
	public void setDisplay(int display) {
		this.display = display;
	}
	
	
	
}
