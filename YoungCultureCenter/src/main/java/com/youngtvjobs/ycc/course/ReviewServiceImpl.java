package com.youngtvjobs.ycc.course;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
public class ReviewServiceImpl implements ReviewService {
	
	ReviewDao reviewDao;
	CourseDao courseDao;
	
	public ReviewServiceImpl(ReviewDao reviewDao, CourseDao courseDao) {
		// super();
		this.reviewDao = reviewDao;
		this.courseDao = courseDao;
	}

	@Override
	public List<ReviewDto> selectReviewList(Integer course_id) throws Exception {
		// TODO Auto-generated method stub
		return reviewDao.selectAll(course_id);
	}

	@Override
	@Transactional(rollbackFor = Exception.class)
	public int reviewWrite(ReviewDto reviewDto) throws Exception {
		courseDao.updateReviewCnt(reviewDto.getCourse_id(), 1);
		return reviewDao.insert(reviewDto);
	}

	@Override
	@Transactional(rollbackFor = Exception.class)
	public int reviewDelete(Integer review_id, Integer course_id) throws Exception {
		
		int rowCnt = courseDao.updateReviewCnt(course_id, -1);
		System.out.println(rowCnt);
		
		rowCnt = reviewDao.delete(review_id);
		System.out.println(rowCnt);
		
		return rowCnt;
	
	}

	@Override
	public int modify(ReviewDto reviewDto) throws Exception {
		// TODO Auto-generated method stub
		return reviewDao.update(reviewDto);
	}

	@Override
	public int getCourseReviewCnt(CourseSearchItem sc) throws Exception {
		// TODO Auto-generated method stub
		return reviewDao.courseReviewCnt(sc);
	}

}
