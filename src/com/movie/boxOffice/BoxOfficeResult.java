package com.movie.boxOffice;


import java.util.List;
import javax.annotation.Generated;
import com.google.gson.annotations.Expose;
import com.google.gson.annotations.SerializedName;

@Generated("jsonschema2pojo")
public class BoxOfficeResult {

@SerializedName("boxofficeType")
@Expose
private String boxofficeType;
@SerializedName("showRange")
@Expose
private String showRange;
@SerializedName("dailyBoxOfficeList")
@Expose
private List<DailyBoxOfficeBean> dailyBoxOfficeList = null;

public String getBoxofficeType() {
return boxofficeType;
}

public void setBoxofficeType(String boxofficeType) {
this.boxofficeType = boxofficeType;
}

public String getShowRange() {
return showRange;
}

public void setShowRange(String showRange) {
this.showRange = showRange;
}

public List<DailyBoxOfficeBean> getDailyBoxOfficeList() {
return dailyBoxOfficeList;
}

public void setDailyBoxOfficeList(List<DailyBoxOfficeBean> dailyBoxOfficeList) {
this.dailyBoxOfficeList = dailyBoxOfficeList;
}

}