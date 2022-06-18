package com.semi.freeboard.model;

import java.sql.Timestamp;

public class FreeBoardVO {
	private int no; 	/* 번호 */
	private String	name;//이름    
	private String   pwd;//비밀번호
	private String title;//제목
	private String email;//이메일
	private Timestamp   regdate;//작성일    
	private int   readcount;//조회수
	private String   content;//내용
	
	
	
	//답변형 추가
	private int   groupNo;//그룹번호
	private int   step;//글의 단계 
	private int sortNo;//글의 정렬순서
	private String delFlag;//삭제 /Flag
	
	//자료실 추가
	private String fileName;//업로드파일명
	private long fileSize;//파일사이즈 
	private int  downCount;//다운수
	private String  originalFileName;    
	

	public int getNo() {
		return no;
	}

	public void setNo(int no) {
		this.no = no;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getPwd() {
		return pwd;
	}

	public void setPwd(String pwd) {
		this.pwd = pwd;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public Timestamp getRegdate() {
		return regdate;
	}

	public void setRegdate(Timestamp regdate) {
		this.regdate = regdate;
	}

	public int getReadcount() {
		return readcount;
	}

	public void setReadcount(int readcount) {
		this.readcount = readcount;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public int getGroupNo() {
		return groupNo;
	}

	public void setGroupNo(int groupNo) {
		this.groupNo = groupNo;
	}

	public int getStep() {
		return step;
	}

	public void setStep(int step) {
		this.step = step;
	}

	public int getSortNo() {
		return sortNo;
	}

	public void setSortNo(int sortNo) {
		this.sortNo = sortNo;
	}

	public String getDelFlag() {
		return delFlag;
	}

	public void setDelFlag(String delFlag) {
		this.delFlag = delFlag;
	}

	public String getFileName() {
		return fileName;
	}

	public void setFileName(String fileName) {
		this.fileName = fileName;
	}

	public long getFileSize() {
		return fileSize;
	}

	public void setFileSize(long fileSize) {
		this.fileSize = fileSize;
	}

	public int getDownCount() {
		return downCount;
	}

	public void setDownCount(int downCount) {
		this.downCount = downCount;
	}

	public String getOriginalFileName() {
		return originalFileName;
	}

	public void setOriginalFileName(String originalFileName) {
		this.originalFileName = originalFileName;
	}



	public FreeBoardVO(int no, String name, String pwd, String title, String email, Timestamp regdate, int readcount,
			String content, int groupNo, int step, int sortNo, String delFlag, String fileName, long fileSize,
			int downCount, String originalFileName) {
		super();
		this.no = no;
		this.name = name;
		this.pwd = pwd;
		this.title = title;
		this.email = email;
		this.regdate = regdate;
		this.readcount = readcount;
		this.content = content;
		this.groupNo = groupNo;
		this.step = step;
		this.sortNo = sortNo;
		this.delFlag = delFlag;
		this.fileName = fileName;
		this.fileSize = fileSize;
		this.downCount = downCount;
		this.originalFileName = originalFileName;

	}
	
	public FreeBoardVO(int no, String name, String pwd, String title, String email, Timestamp regdate, int readcount,
			String content, int groupNo, int step, int sortNo, String delFlag) {
		super();
		this.no = no;
		this.name = name;
		this.pwd = pwd;
		this.title = title;
		this.email = email;
		this.regdate = regdate;
		this.readcount = readcount;
		this.content = content;
		this.groupNo = groupNo;
		this.step = step;
		this.sortNo = sortNo;
		this.delFlag = delFlag;

	}

	public FreeBoardVO() {
		super();
		// TODO Auto-generated constructor stub
	}

	@Override
	public String toString() {
		return "FreeBoardVO [no=" + no + ", name=" + name + ", pwd=" + pwd + ", title=" + title + ", email=" + email
				+ ", regdate=" + regdate + ", readcount=" + readcount + ", content=" + content + ", groupNo=" + groupNo
				+ ", step=" + step + ", sortNo=" + sortNo + ", delFlag=" + delFlag + ", fileName=" + fileName
				+ ", fileSize=" + fileSize + ", downCount=" + downCount + ", originalFileName=" + originalFileName
				+"]";
	}

	
}
