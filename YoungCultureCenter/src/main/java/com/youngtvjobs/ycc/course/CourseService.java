package com.youngtvjobs.ycc.course;

import java.util.List;
import java.util.Map;

import org.springframework.util.MultiValueMap;

public interface CourseService {
	
	List<CourseDto> getPage(Map map) throws Exception;

	int getsearchResultCnt(CourseSearchItem sc) throws Exception;
	List<CourseDto> getsearchResultPage(CourseSearchItem sc) throws Exception;

	CourseDto readCourseDetail(Integer course_id) throws Exception;

	double avgReviewRating(Integer course_id) throws Exception;

	int attendDuplicateCheck(Integer course_id, String user_id) throws Exception;

	int attendInsert(AttendDto attendDto) throws Exception;

	int readAttendTable(Integer course_id, String user_id) throws Exception;

	void courseWrite(CourseDto courseDto) throws Exception;

	int courseRemove(Integer course_id) throws Exception;

	int coursemodify(CourseDto courseDto) throws Exception;

	List<CourseDto> getcroomId() throws Exception;
	List<CourseDto> getCourseType() throws Exception;

	List<CourseImageDto> getCourseImageList(int course_id) throws Exception;

	int courseimageDelete(Integer course_id) throws Exception;
	
	

}
