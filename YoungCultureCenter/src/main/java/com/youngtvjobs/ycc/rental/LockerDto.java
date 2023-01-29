package com.youngtvjobs.ycc.rental;

import java.util.Objects;

public class LockerDto {
	// FROM tb_locker
	private Integer locker_id;
	private Integer locker_no;
	private String user_id;
	private int locker_location_id;
	private int locker_cost;
	private String locker_start_date;
	private String locker_end_date;
	
	// JOIN locker_location
	private String location_name;
	
	public LockerDto() { }

	public LockerDto(Integer locker_id, Integer locker_no, String user_id, int locker_location_id, int locker_cost,
			String locker_start_date, String locker_end_date, String location_name) {
		// super();
		this.locker_id = locker_id;
		this.locker_no = locker_no;
		this.user_id = user_id;
		this.locker_location_id = locker_location_id;
		this.locker_cost = locker_cost;
		this.locker_start_date = locker_start_date;
		this.locker_end_date = locker_end_date;
		this.location_name = location_name;
	}

	@Override
	public int hashCode() {
		return Objects.hash(location_name, locker_cost, locker_end_date, locker_id, locker_location_id, locker_no,
				locker_start_date, user_id);
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		LockerDto other = (LockerDto) obj;
		return Objects.equals(location_name, other.location_name) && locker_cost == other.locker_cost
				&& Objects.equals(locker_end_date, other.locker_end_date) && Objects.equals(locker_id, other.locker_id)
				&& locker_location_id == other.locker_location_id && Objects.equals(locker_no, other.locker_no)
				&& Objects.equals(locker_start_date, other.locker_start_date) && Objects.equals(user_id, other.user_id);
	}

	@Override
	public String toString() {
		return "LockerDto [locker_id=" + locker_id + ", locker_no=" + locker_no + ", user_id=" + user_id
				+ ", locker_location_id=" + locker_location_id + ", locker_cost=" + locker_cost + ", locker_start_date="
				+ locker_start_date + ", locker_end_date=" + locker_end_date + ", location_name=" + location_name + "]";
	}

	public Integer getLocker_id() {
		return locker_id;
	}

	public void setLocker_id(Integer locker_id) {
		this.locker_id = locker_id;
	}

	public Integer getLocker_no() {
		return locker_no;
	}

	public void setLocker_no(Integer locker_no) {
		this.locker_no = locker_no;
	}

	public String getUser_id() {
		return user_id;
	}

	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}

	public int getLocker_location_id() {
		return locker_location_id;
	}

	public void setLocker_location_id(int locker_location_id) {
		this.locker_location_id = locker_location_id;
	}

	public int getLocker_cost() {
		return locker_cost;
	}

	public void setLocker_cost(int locker_cost) {
		this.locker_cost = locker_cost;
	}

	public String getLocker_start_date() {
		return locker_start_date;
	}

	public void setLocker_start_date(String locker_start_date) {
		this.locker_start_date = locker_start_date;
	}

	public String getLocker_end_date() {
		return locker_end_date;
	}

	public void setLocker_end_date(String locker_end_date) {
		this.locker_end_date = locker_end_date;
	}

	public String getLocation_name() {
		return location_name;
	}

	public void setLocation_name(String location_name) {
		this.location_name = location_name;
	}

}
