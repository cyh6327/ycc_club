package com.youngtvjobs.ycc.course;

import java.util.List;
import java.util.Map;

public interface CourseDao {

	int searchResultCnt(CourseSearchItem sc) throws Exception;
	
	List<CourseDto> selectPage(Map map) throws Exception;

	List<CourseDto> searchSelectPage(CourseSearchItem sc) throws Exception;

	int deleteAll() throws Exception;
	int insert(CourseDto courseDto) throws Exception;

	CourseDto courseDetail(Integer course_id) throws Exception;
	
	// 후기 작성&삭제 시 review_cnt 업데이트
	int updateReviewCnt(Integer course_id, int cnt) throws Exception;
	
	// 별점평균구하기
	double avgReviewRating(Integer course_id) throws Exception;
	
	// 수강신청
	int attendDuplicateCheck(Integer course_id, String user_id) throws Exception;
	int attendInsert(AttendDto attendDto) throws Exception;
	int updateApplicantCnt(Integer course_id, int cnt) throws Exception;
	int selectAttendTable(Integer course_id, String user_id) throws Exception;
	
	// 강좌제거
	int delete(Integer course_id) throws Exception;
	
	// 강좌수정
	int update(CourseDto courseDto) throws Exception;

	List<CourseDto> selectCroomId() throws Exception;

	List<CourseDto> selectCourseType() throws Exception;
	
	int courseImageInsert(CourseImageDto courseImageDto) throws Exception;
	
	List<CourseImageDto> getCourseImageList(int course_id) throws Exception;

	int courseImageDelete(int course_id) throws Exception;
	
}
