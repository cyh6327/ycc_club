package com.youngtvjobs.ycc.course;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Objects;

import org.springframework.format.annotation.DateTimeFormat;

/*
 * course_id    Integer NOT NULL,
    course_nm    character varying(255) NOT NULL,
    course_image    character varying(255),
    course_reg_start_date    date NOT NULL,
    course_reg_end_date    date NOT NULL,
    course_start_date    date NOT NULL,
    course_end_date    date NOT NULL,
    course_day    character(30) NOT NULL,
    course_time    character(14) NOT NULL,
    course_target    character(10) NOT NULL,
    course_cost    Integer NOT NULL,
    course_info    character varying(5000) NOT NULL,
    user_id    character(16) NOT NULL,
    croom_id    character(10) NOT NULL
 */

public class CourseDto {
	// FROM tb_course
	private Integer course_id; // 강좌번호
	private String course_nm; // 강좌이름
	
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date course_reg_start_date; // 접수시작일
	
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date course_reg_end_date; // 접수마감일
	
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date course_start_date; // 수강시작일
	
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date course_end_date; // 수강종료일
	private String course_day; // 수강요일
	private String course_time; // 수강시간
	private String course_target; // 수강대상
	private int course_cost; // 수강비
	private String course_info; // 수강상세내용
	private String user_id; // 강사아이디
	private String croom_id; // 강의실 아이디
	private String course_cate_cd; // 강좌 카테고리
	private int course_applicants; // 신청인원
	private double course_rating; // 강의평점
	private int review_cnt; // 강좌리뷰개수
	private int count; // 강좌의 개수를 리스트에 일괄적으로 저장해서 list[index]어디에서든 전부 강좌의 개수가 찍혀서 나옴 
	
	// JOIN tb_user
	private String user_name; // 강사명
	
	// JOIN course_type
	private String course_cate_name; // 강좌 카테고리 이름
	
	//JOIN classroom
	private String croom_name; // 강의실이름
	private int croom_mpop; // 강의실 수용인원 (총원)
	
	// JOIN course_image
	private List<CourseImageDto> imageList;
	
	public CourseDto() {
		// TODO Auto-generated constructor stub
	}
	
	public CourseDto(Integer course_id, String course_nm, Date course_reg_start_date, Date course_reg_end_date,
			Date course_start_date, Date course_end_date, String course_day, String course_time, String course_target,
			int course_cost, String course_info, String user_id, String croom_id, String course_cate_cd,
			int course_applicants, double course_rating, int review_cnt, int count, String user_name,
			String course_cate_name, String croom_name, int croom_mpop, List<CourseImageDto> imageList) {
		// super();
		this.course_id = course_id;
		this.course_nm = course_nm;
		this.course_reg_start_date = course_reg_start_date;
		this.course_reg_end_date = course_reg_end_date;
		this.course_start_date = course_start_date;
		this.course_end_date = course_end_date;
		this.course_day = course_day;
		this.course_time = course_time;
		this.course_target = course_target;
		this.course_cost = course_cost;
		this.course_info = course_info;
		this.user_id = user_id;
		this.croom_id = croom_id;
		this.course_cate_cd = course_cate_cd;
		this.course_applicants = course_applicants;
		this.course_rating = course_rating;
		this.review_cnt = review_cnt;
		this.count = count;
		this.user_name = user_name;
		this.course_cate_name = course_cate_name;
		this.croom_name = croom_name;
		this.croom_mpop = croom_mpop;
		this.imageList = imageList;
	}
	
	@Override
	public String toString() {
		return "CourseDto [course_id=" + course_id + ", course_nm=" + course_nm + ", course_reg_start_date="
				+ course_reg_start_date + ", course_reg_end_date=" + course_reg_end_date + ", course_start_date="
				+ course_start_date + ", course_end_date=" + course_end_date + ", course_day=" + course_day
				+ ", course_time=" + course_time + ", course_target=" + course_target + ", course_cost=" + course_cost
				+ ", course_info=" + course_info + ", user_id=" + user_id + ", croom_id=" + croom_id
				+ ", course_cate_cd=" + course_cate_cd + ", course_applicants=" + course_applicants + ", course_rating="
				+ course_rating + ", review_cnt=" + review_cnt + ", count=" + count + ", user_name=" + user_name
				+ ", course_cate_name=" + course_cate_name + ", croom_name=" + croom_name + ", croom_mpop=" + croom_mpop
				+ ", imageList=" + imageList + "]";
	}

	@Override
	public int hashCode() {
		return Objects.hash(count, course_applicants, course_cate_cd, course_cate_name, course_cost, course_day,
				course_end_date, course_id, course_info, course_nm, course_rating, course_reg_end_date,
				course_reg_start_date, course_start_date, course_target, course_time, croom_id, croom_mpop, croom_name,
				imageList, review_cnt, user_id, user_name);
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		CourseDto other = (CourseDto) obj;
		return count == other.count && course_applicants == other.course_applicants
				&& Objects.equals(course_cate_cd, other.course_cate_cd)
				&& Objects.equals(course_cate_name, other.course_cate_name) && course_cost == other.course_cost
				&& Objects.equals(course_day, other.course_day)
				&& Objects.equals(course_end_date, other.course_end_date) && Objects.equals(course_id, other.course_id)
				&& Objects.equals(course_info, other.course_info) && Objects.equals(course_nm, other.course_nm)
				&& Double.doubleToLongBits(course_rating) == Double.doubleToLongBits(other.course_rating)
				&& Objects.equals(course_reg_end_date, other.course_reg_end_date)
				&& Objects.equals(course_reg_start_date, other.course_reg_start_date)
				&& Objects.equals(course_start_date, other.course_start_date)
				&& Objects.equals(course_target, other.course_target) && Objects.equals(course_time, other.course_time)
				&& Objects.equals(croom_id, other.croom_id) && croom_mpop == other.croom_mpop
				&& Objects.equals(croom_name, other.croom_name) && Objects.equals(imageList, other.imageList)
				&& review_cnt == other.review_cnt && Objects.equals(user_id, other.user_id)
				&& Objects.equals(user_name, other.user_name);
	}
	// 수강 상태 (수강예정, 수강중, 수강완료)
	public String reg_stat() {
		final Date today = new Date(); // 현재 날짜
		String stat = null;
			// 오늘날짜가 강좌시작일 이전일 때 "수강예정"
			if (today.before(course_start_date)) {
				stat="수강예정";
			}
			// 오늘날짜가 강좌시작일 이후이고, 강좌종료일 이전일 때 "수강중"
			else if (course_start_date.before(today)&& today.before(course_end_date)) {
				stat = "수강중";
			}
			else if (course_end_date.before(today)) {
				stat = "수강완료";
			}
		
		return stat;
	}
	// 상태(오픈예정, 접수가능, 정원마감, 접수마감)
	public String course_stat() {
        final Date todayDate = new Date(); // 현재 날짜
		String stat = null;
        long rsd_now = course_reg_start_date.getTime() - todayDate.getTime(); // d-day 계산
        long now_rsd = todayDate.getTime() - course_reg_start_date.getTime(); // 오늘-접수시작일 
        long now_red = todayDate.getTime() - course_reg_end_date.getTime(); // 오늘-접수마감일

		// nowdate는 접수시작일 이전 
		if (now_rsd < 0) {
			stat ="오픈예정<br/>"+"[D-"+(rsd_now / (24 * 60 * 60 * 1000) + 1)+"]"; // 하루(86400000초)를 '초'로 나타낸 값을 '일'로 변환
		}
		
		// nowdate는 접수시작일과 접수마감일 사이
		else if(now_rsd >= 0 && now_red < 86400000) { 
			if(croom_mpop > course_applicants) {
				stat = "접수가능";
			} else {
				System.out.println(croom_mpop);
				System.out.println(course_applicants);
				stat = "정원마감";
			}
		}
		
		// nowdate는 접수마감일 이후
		else { stat = "접수마감"; }
		
		return stat;
	}

	// Date -> String으로 형변환(course_reg_start_date, course_reg_end_date, course_start_date, course_end_date)
	public String reg_sd() {
		DateFormat sdFormat = new SimpleDateFormat("yyyy-MM-dd");
		String reg_start_date = sdFormat.format(course_reg_start_date);
		
		return reg_start_date;
	}
	
	public String reg_ed() {
		DateFormat sdFormat = new SimpleDateFormat("yyyy-MM-dd");
		String reg_end_date = sdFormat.format(course_reg_end_date);
		
		return reg_end_date;
	}
	
	public String course_sd() {
		DateFormat sdFormat = new SimpleDateFormat("yyyy-MM-dd");
		String start_date = sdFormat.format(course_start_date);
		
		return start_date;
	}
	
	public String course_ed() {
		DateFormat sdFormat = new SimpleDateFormat("yyyy-MM-dd");
		String end_date = sdFormat.format(course_end_date);
		
		return end_date;
	}
	// END //Date -> String으로 형변환(course_reg_start_date, course_reg_end_date, course_start_date, course_end_date)//

	// getter setter
	public Integer getCourse_id() {
		return course_id;
	}

	public void setCourse_id(Integer course_id) {
		this.course_id = course_id;
	}

	public String getCourse_nm() {
		return course_nm;
	}

	public void setCourse_nm(String course_nm) {
		this.course_nm = course_nm;
	}

	public Date getCourse_reg_start_date() {
		return course_reg_start_date;
	}

	public void setCourse_reg_start_date(Date course_reg_start_date) {
		this.course_reg_start_date = course_reg_start_date;
	}

	public Date getCourse_reg_end_date() {
		return course_reg_end_date;
	}

	public void setCourse_reg_end_date(Date course_reg_end_date) {
		this.course_reg_end_date = course_reg_end_date;
	}

	public Date getCourse_start_date() {
		return course_start_date;
	}

	public void setCourse_start_date(Date course_start_date) {
		this.course_start_date = course_start_date;
	}

	public Date getCourse_end_date() {
		return course_end_date;
	}

	public void setCourse_end_date(Date course_end_date) {
		this.course_end_date = course_end_date;
	}

	public String getCourse_day() {
		return course_day;
	}

	public void setCourse_day(String course_day) {
		this.course_day = course_day;
	}

	public String getCourse_time() {
		return course_time;
	}

	public void setCourse_time(String course_time) {
		this.course_time = course_time;
	}

	public String getCourse_target() {
		return course_target;
	}

	public void setCourse_target(String course_target) {
		this.course_target = course_target;
	}

	public int getCourse_cost() {
		return course_cost;
	}

	public void setCourse_cost(int course_cost) {
		this.course_cost = course_cost;
	}

	public String getCourse_info() {
		return course_info;
	}

	public void setCourse_info(String course_info) {
		this.course_info = course_info;
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

	public String getCourse_cate_cd() {
		return course_cate_cd;
	}

	public void setCourse_cate_cd(String course_cate_cd) {
		this.course_cate_cd = course_cate_cd;
	}

	public int getCourse_applicants() {
		return course_applicants;
	}

	public void setCourse_applicants(int course_applicants) {
		this.course_applicants = course_applicants;
	}

	public double getCourse_rating() {
		return course_rating;
	}

	public void setCourse_rating(double course_rating) {
		this.course_rating = course_rating;
	}

	public int getReview_cnt() {
		return review_cnt;
	}

	public void setReview_cnt(int review_cnt) {
		this.review_cnt = review_cnt;
	}

	public int getCount() {
		return count;
	}

	public void setCount(int count) {
		this.count = count;
	}

	public String getUser_name() {
		return user_name;
	}

	public void setUser_name(String user_name) {
		this.user_name = user_name;
	}

	public String getCourse_cate_name() {
		return course_cate_name;
	}

	public void setCourse_cate_name(String course_cate_name) {
		this.course_cate_name = course_cate_name;
	}

	public String getCroom_name() {
		return croom_name;
	}

	public void setCroom_name(String croom_name) {
		this.croom_name = croom_name;
	}

	public int getCroom_mpop() {
		return croom_mpop;
	}

	public void setCroom_mpop(int croom_mpop) {
		this.croom_mpop = croom_mpop;
	}

	public List<CourseImageDto> getImageList() {
		return imageList;
	}

	public void setImageList(List<CourseImageDto> imageList) {
		this.imageList = imageList;
	}
}
