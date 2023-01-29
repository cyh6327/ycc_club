package com.youngtvjobs.ycc.rental;

import java.util.Date;
import java.util.Objects;

import com.fasterxml.jackson.annotation.JsonFormat;

public class PlaceDto {

	private Integer prental_id; // 대여예약번호(pk)
	//@DateTimeFormat(pattern = "yyyy-MM-dd")
	@JsonFormat(pattern = "yyyy-MM-dd", timezone = "Asia/Seoul")
	private Date prental_de; // 대여날짜
	//private String prtime_schedule;// 대여시간  ====> 삭제 - time 컬럼으로 대체
	private String user_id; // 회원아이디 (fk)
	private String croom_id; // 강의실 코드 (fk) classroom의 pk
	private boolean time1;	// 예약시간 08:10 ~ 10:00
	private boolean time2;	// 10:10 ~ 12:00
	private boolean time3;
	private boolean time4;
	private boolean time5;
	private boolean time6;
	// end of tb_prental_info(대관현황)
	private String croom_location; // 강의실 위치
	private int croom_mpop; // 강의실 정원
	private String croom_name; // 강의실 이름
	// end of tb_classroom(강의실)

	public PlaceDto() {
		// TODO Auto-generated constructor stub
	}
	public PlaceDto(Integer prental_id, Date prental_de, String user_id, String croom_id, boolean time1, boolean time2,
			boolean time3, boolean time4, boolean time5, boolean time6, String croom_location, int croom_mpop,
			String croom_name) {
		super();
		this.prental_id = prental_id;
		this.prental_de = prental_de;
		this.user_id = user_id;
		this.croom_id = croom_id;
		this.time1 = time1;
		this.time2 = time2;
		this.time3 = time3;
		this.time4 = time4;
		this.time5 = time5;
		this.time6 = time6;
		this.croom_location = croom_location;
		this.croom_mpop = croom_mpop;
		this.croom_name = croom_name;
	}

	public Integer getPrental_id() {
		return prental_id;
	}
	public void setPrental_id(Integer prental_id) {
		this.prental_id = prental_id;
	}
	public Date getPrental_de() {
		return prental_de;
	}
	public void setPrental_de(Date prental_de) {
		this.prental_de = prental_de;
	}
	public String getUser_id() {
		return user_id;
	}
	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	public String getCroom_id() {
		return croom_id;
	}
	public void setCroom_id(String croom_id) {
		this.croom_id = croom_id;
	}
	
	public boolean isTime1() {
		return time1;
	}
	public void setTime1(boolean time1) {
		this.time1 = time1;
	}
	public boolean isTime2() {
		return time2;
	}
	public void setTime2(boolean time2) {
		this.time2 = time2;
	}
	public boolean isTime3() {
		return time3;
	}
	public void setTime3(boolean time3) {
		this.time3 = time3;
	}
	public boolean isTime4() {
		return time4;
	}
	public void setTime4(boolean time4) {
		this.time4 = time4;
	}
	public boolean isTime5() {
		return time5;
	}
	public void setTime5(boolean time5) {
		this.time5 = time5;
	}
	public boolean isTime6() {
		return time6;
	}
	public void setTime6(boolean time6) {
		this.time6 = time6;
	}
	public String getCroom_location() {
		return croom_location;
	}
	public void setCroom_location(String croom_location) {
		this.croom_location = croom_location;
	}
	public int getCroom_mpop() {
		return croom_mpop;
	}
	public void setCroom_mpop(int croom_mpop) {
		this.croom_mpop = croom_mpop;
	}
	public String getCroom_name() {
		return croom_name;
	}
	public void setCroom_name(String croom_name) {
		this.croom_name = croom_name;
	}
	
	@Override
	public int hashCode() {
		return Objects.hash(croom_id, croom_location, croom_mpop, croom_name, prental_de, prental_id, time1, time2,
				time3, time4, time5, time6, user_id);
	}
	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		PlaceDto other = (PlaceDto) obj;
		return Objects.equals(croom_id, other.croom_id) && Objects.equals(croom_location, other.croom_location)
				&& croom_mpop == other.croom_mpop && Objects.equals(croom_name, other.croom_name)
				&& Objects.equals(prental_de, other.prental_de) && Objects.equals(prental_id, other.prental_id)
				&& time1 == other.time1 && time2 == other.time2 && time3 == other.time3 && time4 == other.time4
				&& time5 == other.time5 && time6 == other.time6 && Objects.equals(user_id, other.user_id);
	}
	@Override
	public String toString() {
		return "RentalDto [prental_id=" + prental_id + ", prental_de=" + prental_de + ", user_id=" + user_id
				+ ", croom_id=" + croom_id + ", time1=" + time1 + ", time2=" + time2 + ", time3=" + time3 + ", time4="
				+ time4 + ", time5=" + time5 + ", time6=" + time6 + ", croom_location=" + croom_location
				+ ", croom_mpop=" + croom_mpop + ", croom_name=" + croom_name + "]";
	}
	
}

