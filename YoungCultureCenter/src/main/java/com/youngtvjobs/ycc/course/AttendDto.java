package com.youngtvjobs.ycc.course;

import java.util.Objects;

/*
 *  attend_code    	serial NOT NULL,
    course_id    	integer NOT NULL,
    user_id    		varchar(16) NOT NULL,
    attend_datetime timestamp without time zone NOT NULL
 */
public class AttendDto {
	//From attend
	private Integer attend_code; // 수강신청 코드
	private int course_id; // 강좌serial
	private String user_id; // 수강생아이디
	private String attend_datetime; // 등록일(now())
	
	// JOIN tb_user
	private String user_name; // 수강생 이름
	
	public AttendDto() {
		// TODO Auto-generated constructor stub
	}
	
	public AttendDto(Integer attend_code, int course_id, String user_id, String user_name) {
		super();
		this.attend_code = attend_code;
		this.course_id = course_id;
		this.user_id = user_id;
		this.user_name = user_name;
	}


	@Override
	public int hashCode() {
		return Objects.hash(attend_code, attend_datetime, course_id, user_id, user_name);
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		AttendDto other = (AttendDto) obj;
		return attend_code == other.attend_code && Objects.equals(attend_datetime, other.attend_datetime)
				&& course_id == other.course_id && Objects.equals(user_id, other.user_id)
				&& Objects.equals(user_name, other.user_name);
	}

	@Override
	public String toString() {
		return "AttendDto [attend_code=" + attend_code + ", course_id=" + course_id + ", user_id=" + user_id
				+ ", attend_datetime=" + attend_datetime + ", user_name=" + user_name + "]";
	}

	public String getUser_name() {
		return user_name;
	}

	public void setUser_name(String user_name) {
		this.user_name = user_name;
	}

	public Integer getAttend_code() {
		return attend_code;
	}

	public void setAttend_code(Integer attend_code) {
		this.attend_code = attend_code;
	}

	public int getCourse_id() {
		return course_id;
	}

	public void setCourse_id(int course_id) {
		this.course_id = course_id;
	}

	public String getUser_id() {
		return user_id;
	}

	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}

	public String getAttend_datetime() {
		return attend_datetime;
	}

	public void setAttend_datetime(String attend_datetime) {
		this.attend_datetime = attend_datetime;
	}
	
}
