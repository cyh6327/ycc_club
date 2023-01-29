package com.youngtvjobs.ycc.course;

import java.util.Date;
import java.util.Objects;

public class ReviewDto {
	
	private Integer review_id; // 리뷰NO.
	private String review_content; // 리뷰내용
	private String review_datetime; // 리뷰 등록 시간
	private String review_updated_datetime; // 리뷰 수정 시간
	private Integer review_rating; // 평점
	private Integer course_id; // 강좌번호
	private String user_id; // commenter
	
	public ReviewDto() {
		// TODO Auto-generated constructor stub
	}

	public ReviewDto(Integer review_id, String review_content, Integer review_rating, Integer course_id,
			String user_id) {
		// super();
		this.review_id = review_id;
		this.review_content = review_content;
		this.review_rating = review_rating;
		this.course_id = course_id;
		this.user_id = user_id;
	}

	@Override
	public int hashCode() {
		return Objects.hash(course_id, review_content, review_datetime, review_id, review_rating,
				review_updated_datetime, user_id);
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		ReviewDto other = (ReviewDto) obj;
		return Objects.equals(course_id, other.course_id) && Objects.equals(review_content, other.review_content)
				&& Objects.equals(review_datetime, other.review_datetime) && Objects.equals(review_id, other.review_id)
				&& Objects.equals(review_rating, other.review_rating)
				&& Objects.equals(review_updated_datetime, other.review_updated_datetime)
				&& Objects.equals(user_id, other.user_id);
	}
	
	public Integer getReview_id() {
		return review_id;
	}

	public void setReview_id(Integer review_id) {
		this.review_id = review_id;
	}

	public String getReview_content() {
		return review_content;
	}

	public void setReview_content(String review_content) {
		this.review_content = review_content;
	}

	public String getReview_datetime() {
		return review_datetime;
	}

	public void setReview_datetime(String review_datetime) {
		this.review_datetime = review_datetime;
	}

	public String getReview_updated_datetime() {
		return review_updated_datetime;
	}

	public void setReview_updated_datetime(String review_updated_datetime) {
		this.review_updated_datetime = review_updated_datetime;
	}

	public Integer getReview_rating() {
		return review_rating;
	}

	public void setReview_rating(Integer review_rating) {
		this.review_rating = review_rating;
	}

	public Integer getCourse_id() {
		return course_id;
	}

	public void setCourse_id(Integer course_id) {
		this.course_id = course_id;
	}

	public String getUser_id() {
		return user_id;
	}

	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}

	@Override
	public String toString() {
		return "ReviewDto [review_id=" + review_id + ", review_content=" + review_content + ", review_datetime="
				+ review_datetime + ", review_updated_datetime=" + review_updated_datetime + ", review_rating="
				+ review_rating + ", course_id=" + course_id + ", user_id=" + user_id + "]";
	}
	
}
