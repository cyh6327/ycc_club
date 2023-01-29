package com.youngtvjobs.ycc.club;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Objects;

import org.springframework.format.annotation.DateTimeFormat;

import com.fasterxml.jackson.annotation.JsonFormat;

public class ClubDto {

	//club
	private Integer club_id;
	private String club_title;
	@JsonFormat(pattern = "yyyy-MM-dd")
	private Date club_create_time;
	private String club_info;
	private String club_master_id;
	private int count;
	
	//club_board
	private Integer club_article_id;
	private String club_article_title;
	private String club_article_content;
	private Date club_board_upload_time;
	private Integer club_article_viewcnt;
	private String user_id;
	
	//club_board_comment
	private Integer club_comment_id;
	private String club_comment;
	private Date club_comment_time;
	
	public ClubDto() {
		// TODO Auto-generated constructor stub
	}
	
	

	public ClubDto(Integer club_id, String club_title, Date club_create_time, String club_info, String club_master_id,
			int count, Integer club_article_id, String club_article_title, String club_article_content,
			Date club_board_upload_time, Integer club_article_viewcnt, String user_id, Integer club_comment_id,
			String club_comment, Date club_comment_time) {
		super();
		this.club_id = club_id;
		this.club_title = club_title;
		this.club_create_time = club_create_time;
		this.club_info = club_info;
		this.club_master_id = club_master_id;
		this.count = count;
		this.club_article_id = club_article_id;
		this.club_article_title = club_article_title;
		this.club_article_content = club_article_content;
		this.club_board_upload_time = club_board_upload_time;
		this.club_article_viewcnt = club_article_viewcnt;
		this.user_id = user_id;
		this.club_comment_id = club_comment_id;
		this.club_comment = club_comment;
		this.club_comment_time = club_comment_time;
	}

	public Integer getClub_id() {
		return club_id;
	}

	public void setClub_id(Integer club_id) {
		this.club_id = club_id;
	}

	public String getClub_title() {
		return club_title;
	}

	public void setClub_title(String club_title) {
		this.club_title = club_title;
	}

	public Date getClub_create_time() {
		return club_create_time;
	}

	public void setClub_create_time(Date club_create_time) {
		this.club_create_time = club_create_time;
	}

	public String getClub_info() {
		return club_info;
	}

	public void setClub_info(String club_info) {
		this.club_info = club_info;
	}

	public String getClub_master_id() {
		return club_master_id;
	}

	public void setClub_master_id(String club_master_id) {
		this.club_master_id = club_master_id;
	}

	public Integer getClub_article_id() {
		return club_article_id;
	}

	public void setClub_article_id(Integer club_article_id) {
		this.club_article_id = club_article_id;
	}

	public String getClub_article_title() {
		return club_article_title;
	}

	public void setClub_article_title(String club_article_title) {
		this.club_article_title = club_article_title;
	}

	public Date getClub_board_upload_time() {
		return club_board_upload_time;
	}

	public void setClub_board_upload_time(Date club_board_upload_time) {
		this.club_board_upload_time = club_board_upload_time;
	}

	public Integer getClub_article_viewcnt() {
		return club_article_viewcnt;
	}

	public void setClub_article_viewcnt(Integer club_article_viewcnt) {
		this.club_article_viewcnt = club_article_viewcnt;
	}

	public String getUser_id() {
		return user_id;
	}

	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	
	public int getCount() {
		return count;
	}

	public void setCount(int count) {
		this.count = count;
	}

	
	public Integer getClub_comment_id() {
		return club_comment_id;
	}

	public void setClub_comment_id(Integer club_comment_id) {
		this.club_comment_id = club_comment_id;
	}

	public String getClub_comment() {
		return club_comment;
	}

	public void setClub_comment(String club_comment) {
		this.club_comment = club_comment;
	}

	public Date getClub_comment_time() {
		return club_comment_time;
	}

	public void setClub_comment_time(Date club_comment_time) {
		this.club_comment_time = club_comment_time;
	}
	
	
	public String getClub_article_content() {
		return club_article_content;
	}

	public void setClub_article_content(String club_article_content) {
		this.club_article_content = club_article_content;
	}

	@Override
	public int hashCode() {
		return Objects.hash(club_article_content, club_article_id, club_article_title, club_article_viewcnt,
				club_board_upload_time, club_comment, club_comment_id, club_comment_time, club_create_time, club_id,
				club_info, club_master_id, club_title, count, user_id);
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		ClubDto other = (ClubDto) obj;
		return Objects.equals(club_article_content, other.club_article_content)
				&& Objects.equals(club_article_id, other.club_article_id)
				&& Objects.equals(club_article_title, other.club_article_title)
				&& Objects.equals(club_article_viewcnt, other.club_article_viewcnt)
				&& Objects.equals(club_board_upload_time, other.club_board_upload_time)
				&& Objects.equals(club_comment, other.club_comment)
				&& Objects.equals(club_comment_id, other.club_comment_id)
				&& Objects.equals(club_comment_time, other.club_comment_time)
				&& Objects.equals(club_create_time, other.club_create_time) && Objects.equals(club_id, other.club_id)
				&& Objects.equals(club_info, other.club_info) && Objects.equals(club_master_id, other.club_master_id)
				&& Objects.equals(club_title, other.club_title) && count == other.count
				&& Objects.equals(user_id, other.user_id);
	}

	@Override
	public String toString() {
		return "ClubDto [club_id=" + club_id + ", club_title=" + club_title + ", club_create_time=" + club_create_time
				+ ", club_info=" + club_info + ", club_master_id=" + club_master_id + ", count=" + count
				+ ", club_article_id=" + club_article_id + ", club_article_title=" + club_article_title
				+ ", club_article_content=" + club_article_content + ", club_board_upload_time="
				+ club_board_upload_time + ", club_article_viewcnt=" + club_article_viewcnt + ", user_id=" + user_id
				+ ", club_comment_id=" + club_comment_id + ", club_comment=" + club_comment + ", club_comment_time="
				+ club_comment_time + "]";
	}
	
}
