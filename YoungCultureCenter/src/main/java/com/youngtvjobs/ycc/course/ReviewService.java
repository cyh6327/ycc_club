package com.youngtvjobs.ycc.course;

import java.util.List;

public interface ReviewService {

	List<ReviewDto> selectReviewList(Integer course_id) throws Exception;

	int reviewWrite(ReviewDto reviewDto) throws Exception;

	int reviewDelete(Integer review_id, Integer course_id) throws Exception;

	int modify(ReviewDto reviewDto) throws Exception;

	int getCourseReviewCnt(CourseSearchItem sc) throws Exception;

}
