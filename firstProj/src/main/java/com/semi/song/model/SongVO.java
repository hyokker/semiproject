package com.semi.song.model;

import java.sql.Timestamp;

public class SongVO {
	private int sNo;/* 곡번호 */
	private String stitle; /* 곡명 */
	private int slike; /* 좋아요 */
	private String smp3; /* 음원 */
	private String smp3path; /* 음원 경로 */
	private int aNo; /* 앨범 번호 */
	
	
	public int getsNo() {
		return sNo;
	}
	public void setsNo(int sNo) {
		this.sNo = sNo;
	}
	public String getStitle() {
		return stitle;
	}
	public void setStitle(String stitle) {
		this.stitle = stitle;
	}
	public int getSlike() {
		return slike;
	}
	public void setSlike(int slike) {
		this.slike = slike;
	}
	public String getSmp3() {
		return smp3;
	}
	public void setSmp3(String smp3) {
		this.smp3 = smp3;
	}
	public String getSmp3path() {
		return smp3path;
	}
	public void setSmp3path(String smp3path) {
		this.smp3path = smp3path;
	}
	public int getaNo() {
		return aNo;
	}
	public void setaNo(int aNo) {
		this.aNo = aNo;
	}
	public SongVO(int sNo, String stitle, int slike, String smp3, String smp3path, int aNo) {
		super();
		this.sNo = sNo;
		this.stitle = stitle;
		this.slike = slike;
		this.smp3 = smp3;
		this.smp3path = smp3path;
		this.aNo = aNo;
	}
	public SongVO() {
		super();
		// TODO Auto-generated constructor stub
	}
	@Override
	public String toString() {
		return "SongVO [sNo=" + sNo + ", stitle=" + stitle + ", slike=" + slike + ", smp3=" + smp3 + ", smp3path="
				+ smp3path + ", aNo=" + aNo + "]";
	}
	
	
}
