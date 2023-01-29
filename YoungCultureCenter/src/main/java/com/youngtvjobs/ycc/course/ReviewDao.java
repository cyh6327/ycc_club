package com.youngtvjobs.ycc.course;

import java.util.List;

public interface ReviewDao {

	List<ReviewDto> selectAll(Integer course_id) throws Exception;

	int insert(ReviewDto reviewDto) throws Exception;

	int delete(Integer review_id) throws Exception;

	int update(ReviewDto reviewDto) throws Exception;

	int courseReviewCnt(CourseSearchItem sc) throws Exception;

}
