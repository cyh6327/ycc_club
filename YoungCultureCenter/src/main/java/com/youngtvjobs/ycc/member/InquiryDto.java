package com.youngtvjobs.ycc.member;

import java.util.Date;
import java.util.Objects;

import com.youngtvjobs.ycc.common.YccMethod;

public class InquiryDto {

	public final String DEFAULT_1YEAR = "1month";

	private Integer inq_id; // 문의 번호
	private String inq_cate; // 문의 분류
	private String inq_title; // 문의 제목
	private String inq_content; // 문의 내용
	private Date inq_date; // 문의 작성일
	private String inq_ans;	// 답변 내용
	
	private String user_id; // 문의 작성자

	private String settedInterval = DEFAULT_1YEAR; // 쿼리문에 넣어줄 기본 기간

	public InquiryDto() {
		// TODO Auto-generated constructor stub
	}


	public InquiryDto(Integer inq_id, String inq_cate, String inq_title, String inq_content, Date inq_date,
			String inq_ans, String user_id) {
		super();
		this.inq_id = inq_id;
		this.inq_cate = inq_cate;
		this.inq_title = inq_title;
		this.inq_content = inq_content;
		this.inq_date = inq_date;
		this.inq_ans = inq_ans;
		this.user_id = user_id;
	}


	public InquiryDto(Integer inq_id, String inq_cate, String inq_title, String inq_content, Date inq_date,
			 String inq_ans, String user_id, String settedInterval) {
		super();
		this.inq_id = inq_id;
		this.inq_cate = inq_cate;
		this.inq_title = inq_title;
		this.inq_content = inq_content;
		this.inq_date = inq_date;
		this.inq_ans = inq_ans;
		this.user_id = user_id;
		this.settedInterval = settedInterval;
	}





	@Override
	public int hashCode() {
		return Objects.hash(DEFAULT_1YEAR, inq_ans, inq_cate, inq_content, inq_date, inq_id, inq_title, 
				settedInterval, user_id);
	}


	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		InquiryDto other = (InquiryDto) obj;
		return Objects.equals(DEFAULT_1YEAR, other.DEFAULT_1YEAR) && Objects.equals(inq_ans, other.inq_ans)
				&& Objects.equals(inq_cate, other.inq_cate) && Objects.equals(inq_content, other.inq_content)
				&& Objects.equals(inq_date, other.inq_date) && Objects.equals(inq_id, other.inq_id)
				&& Objects.equals(inq_title, other.inq_title) 
				&& Objects.equals(settedInterval, other.settedInterval) && Objects.equals(user_id, other.user_id);
	}


	public String getInq_ans() {
		return inq_ans;
	}


	public void setInq_ans(String inq_ans) {
		this.inq_ans = inq_ans;
	}


	public Integer getInq_id() {
		return inq_id;
	}





	public void setInq_id(Integer inq_id) {
		this.inq_id = inq_id;
	}





	public String getInq_cate() {
		return inq_cate;
	}





	public void setInq_cate(String inq_cate) {
		this.inq_cate = inq_cate;
	}





	public String getInq_title() {
		return inq_title;
	}





	public void setInq_title(String inq_title) {
		this.inq_title = inq_title;
	}





	public String getInq_content() {
		return inq_content;
	}





	public void setInq_content(String inq_content) {
		this.inq_content = inq_content;
	}





	public Date getInq_date() {
		return inq_date;
	}





	public void setInq_date(Date inq_date) {
		this.inq_date = inq_date;
	}

	public String getUser_id() {
		return user_id;
	}





	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}





	public String getSettedInterval() {
		return settedInterval;
	}





	public void setSettedInterval(String settedInterval) {
		this.settedInterval = settedInterval;
	}





	// Date--> String 형변환
	public String inq_date() {
		
		return YccMethod.date_toString(inq_date);
	}

}
